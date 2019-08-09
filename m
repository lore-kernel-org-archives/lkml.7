Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8BBC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CE520B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437330AbfHISOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:14:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40378 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfHISOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:14:49 -0400
Received: from 96-95-199-68-static.hfc.comcastbusiness.net ([96.95.199.68] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hw9PZ-0003Wb-Cz; Fri, 09 Aug 2019 18:14:45 +0000
Date:   Fri, 9 Aug 2019 20:14:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hridya Valsaraju <hridya@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/2] binder: Validate the default binderfs device
 names.
Message-ID: <20190809181439.qrs2k7l23ot4am4s@wittgenstein>
References: <20190808222727.132744-1-hridya@google.com>
 <20190808222727.132744-3-hridya@google.com>
 <20190809145508.GD16262@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190809145508.GD16262@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:55:08PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 08, 2019 at 03:27:26PM -0700, Hridya Valsaraju wrote:
> > Length of a binderfs device name cannot exceed BINDERFS_MAX_NAME.
> > This patch adds a check in binderfs_init() to ensure the same
> > for the default binder devices that will be created in every
> > binderfs instance.
> > 
> > Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > ---
> >  drivers/android/binderfs.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index aee46dd1be91..55c5adb87585 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -570,6 +570,18 @@ static struct file_system_type binder_fs_type = {
> >  int __init init_binderfs(void)
> >  {
> >  	int ret;
> > +	const char *name;
> > +	size_t len;
> > +
> > +	/* Verify that the default binderfs device names are valid. */
> 
> And by "valid" you only mean "not bigger than BINDERFS_MAX_NAME, right?
> 
> > +	name = binder_devices_param;
> > +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > +		if (len > BINDERFS_MAX_NAME)
> > +			return -E2BIG;
> > +		name += len;
> > +		if (*name == ',')
> > +			name++;
> > +	}
> 
> We already tokenize the binderfs device names in binder_init(), why not
> check this there instead?  Parsing the same string over and over isn't
> the nicest.

non-binderfs binder devices do not have their limit set to
BINDERFS_NAME_MAX. That's why the check has likely been made specific to
binderfs binder devices which do have that limit.

But, in practice, 255 is the standard path-part limit that no-one really
exceeds especially not for stuff such as device nodes which usually have
rather standard naming schemes (e.g. binder, vndbinder, hwbinder, etc.).
So yes, we can move that check before both the binderfs binder device
and non-binderfs binder device parsing code and treat it as a generic
check.
Then we can also backport that check as you requested in the other mail.
Unless Hridya or Todd have objections, of course.

Christian
