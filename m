Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9601B20891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221062;
	bh=eLBbZerBN+RtIKclkIQT8+nwAnfad2bIAyh2Cgl1kLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xlWENb2PYHRgZOdSikHhzsNvmGaW4ohA+KSnYzy1skOv4mjeL4foBTplnLC97yx3l
	 9Awq9CHft2bt8aiv2DhNju3Y5FOG9il/EqDd0q+38MW1+jojuPEE8pcFPwP9pJcpTX
	 bj2J253afNHDkyqJprVTh6xqsv+4SN8aKuiiol3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfDYThl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfDYThl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:37:41 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E7A205ED;
        Thu, 25 Apr 2019 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221060;
        bh=eLBbZerBN+RtIKclkIQT8+nwAnfad2bIAyh2Cgl1kLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPaXduYyPYy2td/tpBquPEdoB7FzMYcFd1Rk7m3uYK8qxDNS3M1ele83Xp8APoJVm
         bT2njjjDiqjmyjw4kZanB8k08oZh5Rr4JF2fbpvyJDZkW+41eMTtyznP77StkJQ30q
         B1gTbZ1AgO9Zogssk8POmb2gXsb6MRakp1F8RzC0=
Date:   Thu, 25 Apr 2019 21:37:36 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Message-ID: <20190425193736.GA11458@kroah.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
 <20190422210606.GA8805@kroah.com>
 <86ea407aaa891e50a3bdaf2c3653636a365076ee.camel@analog.com>
 <20190424133455.00002909@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424133455.00002909@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 01:34:55PM +0100, Jonathan Cameron wrote:
> On Tue, 23 Apr 2019 06:38:44 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Mon, 2019-04-22 at 23:06 +0200, Greg KH wrote:
> > > 
> > > 
> > > On Mon, Apr 22, 2019 at 11:32:56AM +0300, Alexandru Ardelean wrote:  
> > > > This helper is similar to __sysfs_match_string() with the exception
> > > > that it
> > > > ignores NULL elements within the array.  
> > > 
> > > sysfs is "one value per file", why are you trying to write multiple
> > > things on a single line to a single sysfs file?
> > > 
> > > Is IIO really that messy?  :)
> > >   
> > 
> > Hmm, I don't think I understood the comment/question, or maybe I did not
> > formulate the comment properly.
> > 
> > Maybe Jonathan can pitch-in here if I'm saying something wrong.
> > 
> > So, in IIO there is `struct iio_enum` which is essentially a sysfs wrapper
> > for exposing an "enum" type to userspace via sysfs (which takes only one
> > value). This iio_enum type is basically a string-to-int mapping.
> 
> > 
> > Some example in C:
> > 
> > enum {
> >     ENUM0,
> >     ENUM1,
> >     ENUM5 = 5,
> >     ENUM6,
> >     ENUM7
> > };
> > 
> > 
> > /* Notice the gaps in the elements */
> > static const char * const item_strings[] = {
> >         [ENUM0] = "mode0",
> >         [ENUM1] = "mode1",
> >         [ENUM5] = "mode5",
> >         [ENUM6] = "mode6", 
> >         [ENUM7] = "mode7",
> > };
> >                          
> > static const struct iio_enum iio_enum1 = {
> >         .items = item_strings,
> >         .num_items = ARRAY_SIZE(item_strings),
> >         .set = iio_enum1_set,
> >         .get = iio_enum1_get,
> > };
> > 
> > 
> > The signature of the iio_enum1_set / iio_enum1_get is below:
> > 
> > static int iio_enum1_set(struct iio_dev *indio_dev,
> >         const struct iio_chan_spec *chan, unsigned int val);
> > 
> > static int iio_enum1_get(struct iio_dev *indio_dev,
> >         const struct iio_chan_spec *chan)
> > 
> > 
> > IIO core resolves the string-to-int mapping.
> > It uses __sysfs_match_string() to do that, but it requires that the list of
> > strings (and C enums) be contiguous.
> > This change [and V2 of this patch] introduces a
> > __sysfs_match_string_with_gaps() helper that ignores gaps (represented as
> > NULLs).
> > 
> > For reference, __sysfs_match_string() returns -EINVAL on the first NULL in
> > the array of strings (regardless of the given array size).
> > 
> > __sysfs_match_string_with_gaps() is typically helpful when C enums refer to
> > bitfields, or have some equivalence in HW.
> > 
> 
> You have described it well.
> Perhaps the issue is in the naming? Or more description is needed for the original
> patch.
> 
> It's worth highlighting that the current help text for
> __sysfs_match_string has a description that says:
> 
> /**
>  * __sysfs_match_string - matches given string in an array
>  * @array: array of strings
>  * @n: number of strings in the array or -1 for NULL terminated arrays
>  * @str: string to match with
>  *
>  * Returns index of @str in the @array or -EINVAL, just like match_string().
>  * Uses sysfs_streq instead of strcmp for matching.
>  */
> 
> so one could argue that if you pass a value of n which is not -1 the function
> should not assume that any NULL terminates the array...
> 
> So basically this new function is implementing what I would have assumed
> __sysfs_match_string would do, but doesn't.

Ok, yeah, I'm confused, I also thought this is what the original
function did.

Nevermind, no objection from me on this:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
