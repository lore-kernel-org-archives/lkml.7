Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8960CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A9A2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC9Q03V6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDZJ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:29:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34943 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfDZJ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:29:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id w197so2427884oia.2;
        Fri, 26 Apr 2019 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsY5EmHdlAn0ywW1Ux75nexz4+HNB70NwRqQrN4RVkc=;
        b=CC9Q03V659ZKJXXkQNMFm8zddbExPDGz8vaOVoLs52urDHhOeJABtt8xExwMRIrYwd
         stf9ptfAa0GnFBPI7kC0vU9iOSI/GNzBg9shgp6i+w0rIBQjBglXlK2V0zzJuHpJHhv3
         f/sFH4obG+SHjEaaDUu1OiOChjxZWGa3TLFMfbogQB1CEJA5S17+HJWU8MhETVg2KgTK
         +kXyaH0OKxHOKZkfFTvekn7OFeU1cUuYFG/2dWrT92F7KlUWjh4v/d7XvW5343qNyabq
         cZKotQ1lOHpcYC1EBHGHl1bBxBCvh2580axwfAYK0pd4YiPjRwXaCpHH/VIqaNM3B8nN
         R/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsY5EmHdlAn0ywW1Ux75nexz4+HNB70NwRqQrN4RVkc=;
        b=EfUXXY9q2jQP+HRNB5QOu27yRp+6Sbt+4AOjMMohh+k06khA5WpvhTER40GFWhADBU
         wbc0fAqvQQSRzcd0cUcHnkX84U8yUW7MF2AxnUao/DBFgXP3d43QLTfV/Cz6WIUiugM7
         a2HfYfV+dbRoUYnR5APtGtRmXXQJOqRctLf2xm/GwTkys02mofpR0xcEJ899a7p4VnmQ
         cFj5Op6GQPizsUVo7ggPNwZ93k1A1ebQ4/oHwX1Uep1eVLrjxYEzLfDVlqW4R7ImIrcJ
         GAV7/lCAW60ZtWqcUNNbuLWoDcbaXTdVAjxIBLq3ReXap55KXkFPn8UrUR/BfMCU4kqv
         /KfQ==
X-Gm-Message-State: APjAAAVuwnJKcKnaWCC0uVCCLyar94XLQDjLAosEyXKJMB/rmvNwpmt6
        3J/cvE5g45xQckfaMsc9BbNLyEGdD1FAn8hbs5A=
X-Google-Smtp-Source: APXvYqyQlyzvwqQN5JndAC+hYrtPWX4/7rbPQJud7RXC05dGSFjLiKCT+Pd/wlHZxI7Q+wAW9mKwHUT8YTlUMbkQ9Bg=
X-Received: by 2002:aca:5bd7:: with SMTP id p206mr6372016oib.128.1556270963864;
 Fri, 26 Apr 2019 02:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
 <20190422210606.GA8805@kroah.com> <86ea407aaa891e50a3bdaf2c3653636a365076ee.camel@analog.com>
 <20190424133455.00002909@huawei.com> <20190425193736.GA11458@kroah.com>
In-Reply-To: <20190425193736.GA11458@kroah.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 26 Apr 2019 12:29:11 +0300
Message-ID: <CA+U=DsoyPQyNDX6CDx=xE73H9A=66BGKhTseEvZcZZPnpPAfQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:38 PM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 24, 2019 at 01:34:55PM +0100, Jonathan Cameron wrote:
> > On Tue, 23 Apr 2019 06:38:44 +0000
> > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >
> > > On Mon, 2019-04-22 at 23:06 +0200, Greg KH wrote:
> > > >
> > > >
> > > > On Mon, Apr 22, 2019 at 11:32:56AM +0300, Alexandru Ardelean wrote:
> > > > > This helper is similar to __sysfs_match_string() with the exception
> > > > > that it
> > > > > ignores NULL elements within the array.
> > > >
> > > > sysfs is "one value per file", why are you trying to write multiple
> > > > things on a single line to a single sysfs file?
> > > >
> > > > Is IIO really that messy?  :)
> > > >
> > >
> > > Hmm, I don't think I understood the comment/question, or maybe I did not
> > > formulate the comment properly.
> > >
> > > Maybe Jonathan can pitch-in here if I'm saying something wrong.
> > >
> > > So, in IIO there is `struct iio_enum` which is essentially a sysfs wrapper
> > > for exposing an "enum" type to userspace via sysfs (which takes only one
> > > value). This iio_enum type is basically a string-to-int mapping.
> >
> > >
> > > Some example in C:
> > >
> > > enum {
> > >     ENUM0,
> > >     ENUM1,
> > >     ENUM5 = 5,
> > >     ENUM6,
> > >     ENUM7
> > > };
> > >
> > >
> > > /* Notice the gaps in the elements */
> > > static const char * const item_strings[] = {
> > >         [ENUM0] = "mode0",
> > >         [ENUM1] = "mode1",
> > >         [ENUM5] = "mode5",
> > >         [ENUM6] = "mode6",
> > >         [ENUM7] = "mode7",
> > > };
> > >
> > > static const struct iio_enum iio_enum1 = {
> > >         .items = item_strings,
> > >         .num_items = ARRAY_SIZE(item_strings),
> > >         .set = iio_enum1_set,
> > >         .get = iio_enum1_get,
> > > };
> > >
> > >
> > > The signature of the iio_enum1_set / iio_enum1_get is below:
> > >
> > > static int iio_enum1_set(struct iio_dev *indio_dev,
> > >         const struct iio_chan_spec *chan, unsigned int val);
> > >
> > > static int iio_enum1_get(struct iio_dev *indio_dev,
> > >         const struct iio_chan_spec *chan)
> > >
> > >
> > > IIO core resolves the string-to-int mapping.
> > > It uses __sysfs_match_string() to do that, but it requires that the list of
> > > strings (and C enums) be contiguous.
> > > This change [and V2 of this patch] introduces a
> > > __sysfs_match_string_with_gaps() helper that ignores gaps (represented as
> > > NULLs).
> > >
> > > For reference, __sysfs_match_string() returns -EINVAL on the first NULL in
> > > the array of strings (regardless of the given array size).
> > >
> > > __sysfs_match_string_with_gaps() is typically helpful when C enums refer to
> > > bitfields, or have some equivalence in HW.
> > >
> >
> > You have described it well.
> > Perhaps the issue is in the naming? Or more description is needed for the original
> > patch.
> >
> > It's worth highlighting that the current help text for
> > __sysfs_match_string has a description that says:
> >
> > /**
> >  * __sysfs_match_string - matches given string in an array
> >  * @array: array of strings
> >  * @n: number of strings in the array or -1 for NULL terminated arrays
> >  * @str: string to match with
> >  *
> >  * Returns index of @str in the @array or -EINVAL, just like match_string().
> >  * Uses sysfs_streq instead of strcmp for matching.
> >  */
> >
> > so one could argue that if you pass a value of n which is not -1 the function
> > should not assume that any NULL terminates the array...
> >
> > So basically this new function is implementing what I would have assumed
> > __sysfs_match_string would do, but doesn't.
>
> Ok, yeah, I'm confused, I also thought this is what the original
> function did.
>
> Nevermind, no objection from me on this:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hmm, I actually did not give much thought to that -1.
I'll check into this and see about a V3.
It may make more sense to just fix the original
`__sysfs_match_string()`, but I'll need to go through the users of
this function and see.

Thanks
Alex
