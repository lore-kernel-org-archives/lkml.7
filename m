Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A240C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4055214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfKHAEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:04:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48860 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKHAEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:04:34 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 4b51c36d0c6d2e90; Fri, 8 Nov 2019 01:04:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6 11/15] software node: move small properties inline when copying
Date:   Fri, 08 Nov 2019 01:04:31 +0100
Message-ID: <3310518.lfHdziMng4@kreacher>
In-Reply-To: <20191105235656.GW57214@dtor-ws>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com> <47671501.dVG71sAca0@kreacher> <20191105235656.GW57214@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 6, 2019 12:56:56 AM CET Dmitry Torokhov wrote:
> Hi Rafael,
> 
> On Wed, Nov 06, 2019 at 12:42:02AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, October 23, 2019 10:02:29 PM CET Dmitry Torokhov wrote:
> > > When copying/duplicating set of properties, move smaller properties that
> > > were stored separately directly inside property entry structures. We can
> > > move:
> > > 
> > > - up to 8 bytes from U8 arrays
> > > - up to 4 words
> > > - up to 2 double words
> > > - one U64 value
> > > - one or 2 strings.
> > 
> > Yes, we can do that, but how much of a difference does this really make?
> 
> Arguably not much I think, but it was pretty cheap to do.
> 
> > 
> > Also, how can one distinguish between a single-value property and an inline
> > array which this change?  By looking at the length?
> 
> We do not really need to distinguish between the 2. The device
> properties API is typically wrap single values around arrays (i.e. it is
> perfectly fine to use scalar API to fetch first element of array and use
> array API to fetch a scalar). So we have property of certain type with
> certain number of elements, and it can either be stored inside
> property_entry structure, or outside of it. They are 2 orthogonal
> concepts.
> 
> > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/base/swnode.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > > index 18a30fb3cc58..49e1108aa4b7 100644
> > > --- a/drivers/base/swnode.c
> > > +++ b/drivers/base/swnode.c
> > > @@ -280,6 +280,16 @@ static int property_entry_copy_data(struct property_entry *dst,
> > >  	if (!dst->name)
> > >  		goto out_free_data;
> > >  
> > > +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> > > +		/* We have an opportunity to move the data inline */
> > > +		const void *tmp = dst->pointer;
> > > +
> > > +		memcpy(&dst->value, tmp, dst->length);
> > > +		dst->is_inline = true;
> > > +
> > > +		kfree(tmp);
> > 
> > This would have been more useful if we had been able to avoid making the
> > allocation altogether.
> 
> OK, I can do that and re-send this patch and the one with the tests.

But if you do that, IMO it would be prudent to extend the definition of
struct property_entry like this:

 struct property_entry {
 	const char *name;
 	size_t length;
 	bool is_array;
 	enum dev_prop_type type;
 	union {
 		union {
 			const u8 *u8_data;
 			const u16 *u16_data;
 			const u32 *u32_data;
 			const u64 *u64_data;
 			const char * const *str;
 		} pointer;
 		union {
 			u8 u8_data;
 			u16 u16_data;
 			u32 u32_data;
 			u64 u64_data;
 			const char *str;
+			u8 u8_buf[sizeof(u64)];
+			u16 u16_buf[sizeof(u64)/sizeof(u16)];
+			u32 u32_buf[sizeof(u64)/sizeof(u32)];
+			char char_buf[sizeof(u64)];
 		} value;
 	};
 };

to make it clear that the value field is going to be used as an array in
some cases.

> In the mean time, can you please consider patches 12-14?

I cannot find drivers/platform/x86/intel_cht_int33fe_typec.c in the mainline,
so I cannot apply patch [13/15] now and I'm not sure how useful it would be
to apply patches [10,12/15] without the other two.



