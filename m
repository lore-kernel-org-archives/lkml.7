Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC48C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C143217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SoIvfKdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgABWF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:05:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36344 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgABWF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:05:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so13646581oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cB5/TfS+9oh4EQGMYevcc+P8vQxKX09YhHxFSkP0EAw=;
        b=SoIvfKdmMGqdcPIIHUxkj+qmGvmf922xK7i/as2s4MZdgstK11XdL+NxHOnjodRfq8
         WELQWdpW1UQis9xdxb8QKsbUMvOSE/mD4sAHxRJ2VFUlbyEJAkye2eypjZO564oiz1We
         5rbnVOwCxC7jwxvm1X5PmNFpyeNCCSUD4Bs34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cB5/TfS+9oh4EQGMYevcc+P8vQxKX09YhHxFSkP0EAw=;
        b=oIF75XAL86XX9TwcWaaAO3f9kCkWFbLPW7117h5JlN+IijTwmV8yPi0KQyY3IRtyGX
         qRgI2RMBtIP8r/4+vEqqf3iTNGGXDVY2lMk5ObrgLxxxsW1tYm/qcg+g4PctIrEpkFpL
         ZyiOl1/mX+EWPgZC0GlSKamEpeM2FLYYyUjLeugw7kAMC4MITcBems+Frr8ttDKrD3qG
         4xLpWJk5VtheEwnJh40wPZ34VAf2D6wclGcXP5DncVos+cXGMoUrphlwIGH18H8tWlLL
         +EYnMAvkDyXpf+HrSQwKUPruEXddXms8MIxaMG/8CgInH8DH+lj54Y/+0HyuZVX5NsV2
         Uweg==
X-Gm-Message-State: APjAAAV3/jhmhv0vh8CT3zR1PijGLyOwObmzhuDbA7UtnBC3FEFkLGhD
        +LhGVsHZlI79nKQRGcDiWID3iQ==
X-Google-Smtp-Source: APXvYqy2wJQ6w5qrY2GWj4wLitQzqBVRz7s4vI4qGCXjHrYJ6k7BAB7N0GibJEPNj7V286n+kz8ucw==
X-Received: by 2002:aca:cc08:: with SMTP id c8mr2990525oig.42.1578002725586;
        Thu, 02 Jan 2020 14:05:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u33sm15182790otb.49.2020.01.02.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 14:05:24 -0800 (PST)
Date:   Thu, 2 Jan 2020 14:05:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Aleksandr Yashkin <a.yashkin@inango-systems.com>,
        Ariel Gilman <a.gilman@inango-systems.com>
Subject: Re: [PATCH] pstore/ram: fix for adding dumps to non-empty zone
Message-ID: <202001021403.535C210D@keescook>
References: <20191223133816.28155-1-n.merinov@inango-systems.com>
 <201912301227.47AE22C61@keescook>
 <1964542716.432661.1577779234764.JavaMail.zimbra@inango-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1964542716.432661.1577779234764.JavaMail.zimbra@inango-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 10:00:34AM +0200, Nikolai Merinov wrote:
> On Dec 31, 2019, at 1:37 AM, Kees Cook keescook@chromium.org wrote:
> > On Mon, Dec 23, 2019 at 06:38:16PM +0500, Nikolai Merinov wrote:
> >> From: Aleksandr Yashkin <a.yashkin@inango-systems.com>
> >> 
> >> The circle buffer in ramoops zones has a problem for adding a new
> >> oops dump to already an existing one.
> >> 
> >> The solution to this problem is to reset the circle buffer state before
> >> writing a new oops dump.
> > 
> > Ah, I see it now. When the crashes wrap around, the header is written at
> > the end of the (possibly incompletely filled) buffer, instead of at the
> > start, since it wasn't explicitly zapped.
> 
> Yes, you are right. We observed this issue when we got two consecutive
> reboots with a kernel panic: After the first reboot the pstore was able
> to parse the saved data, but after the second we got a part of the
> previous compressed message and the new compressed message with the
> ramoops message header at the middle of the file. 
> 
> According to our analysis the same issue can occur if we get more
> than (rampoops.mem_size/ramoops.record_size) kernel oops during work.

Yup, perfect. Thanks for confirming! I've tested the patches with this
in mind and everything seems to be working correctly.

> 
> > 
> > Yes, this is important; thank you for tracking this down! This bug has
> > existed for a very long time. I'll try to find the right Fixes tag for
> > it...
> 
> We would like to see this changes in the LTS kernel releases. Could you
> please point me the manual about propagation such fixes?

You don't need to do anything. :) I have already marked it for -stable,
and it'll end up there as it makes its way through the development
process.

-Kees

> 
> > 
> > -Kees
> > 
> >> Signed-off-by: Aleksandr Yashkin <a.yashkin@inango-systems.com>
> >> Signed-off-by: Nikolay Merinov <n.merinov@inango-systems.com>
> >> Signed-off-by: Ariel Gilman <a.gilman@inango-systems.com>
> >> 
> >> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> >> index 8caff834f002..33fceadbf515 100644
> >> --- a/fs/pstore/ram.c
> >> +++ b/fs/pstore/ram.c
> >> @@ -407,6 +407,13 @@ static int notrace ramoops_pstore_write(struct
> >> pstore_record *record)
> >>  
> >>  	prz = cxt->dprzs[cxt->dump_write_cnt];
> >>  
> >> +	/* Clean the buffer from old info.
> >> +	 * `ramoops_read_kmsg_hdr' expects to find a header in the beginning of
> >> +	 * buffer data, so we must to reset the buffer values, in order to
> >> +	 * ensure that the header will be written to the beginning of the buffer
> >> +	 */
> >> +	persistent_ram_zap(prz);
> >> +
> >>  	/* Build header and append record contents. */
> >>  	hlen = ramoops_write_kmsg_hdr(prz, record);
> >>  	if (!hlen)
> >> --
> >> 2.17.1
> >> 
> > 
> > --
> > Kees Cook
> --
> Nikolai Merinov

-- 
Kees Cook
