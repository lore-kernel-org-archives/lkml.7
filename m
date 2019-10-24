Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12816CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EB5205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjCSSh2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393145AbfJXKAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:00:32 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:39801 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390289AbfJXKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:00:32 -0400
Received: by mail-pg1-f176.google.com with SMTP id p12so13932398pgn.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Un8dozXGi1hBwrcyMyk9H9EF84fhz0PhjEtVbAbr1g0=;
        b=kjCSSh2XWmvn8CMJsbBOFPWBAaUKWR6ru7vss61PnWeUShh2WEMVYstKENB7UQIP6n
         4JwL616OEigeu3r1FY2QMKFTVlu/abv7HIrYMnVAhB+5gnMk0qg8QZq5BhYss1FnNW/Z
         r8JXUrOrH7f8PCaZ+S7Rd3+zr9NgYjoZdhLouR0mifoBLWzrE72lkPeHppSoGN04hL4k
         JHY77XrfEkw1js5feDxR5f/P2ts/V0wMspJSos5JCXiycPtJBqMIA7akXdP0MkPbLtMs
         PDeTcD69ImKjnd+k9orHMyMHRlDPzLTUV+2nwICZwbh+vCLww8YFRET5/9+4CQa0W1vw
         dpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Un8dozXGi1hBwrcyMyk9H9EF84fhz0PhjEtVbAbr1g0=;
        b=gmWMhstX8xGXx6PkJ3hvB3Y7PDdBedLtNBHxz15cE3exbryJCLLY4/VkwY9N/FRTUq
         OPeSZwx/xfi3wiIoN7HE40baoG0TWQvyJq7Fknyix4MrL9GYlbZKRqDBkxynvB2p4F5P
         KsEDkWOVG01JVsJ0hAv0QsRYP3TkCW+pBi5QNZ+clv3xPPrIvnd2VMRWoZo2AQDLyrsO
         WeR8TOnNLuADR1X/OB8qFD2erBqwzYbb8hCg2q+sinDHyV9dqnPKBBvgAPiGvc842JWJ
         9CEklFNOs8KXdYfcxo1+E/eje7c9Zk9KJnJvtVZXEEyrKax1XGIbbx6ZHr83aemIvmOU
         gIvQ==
X-Gm-Message-State: APjAAAWHNnu2BwCq7GkUDLgAecFq4zZAUv/aFbJ+57BXYtLbiHM4arrD
        j1SszJd//riHaMq7D0BVDEQ=
X-Google-Smtp-Source: APXvYqxEyT4XClHCb2W6cq5qFcu+aP1RWWIfWj4rcME03pjh/52UE8YKoRPa0CqPdxayCPdhdMUdDg==
X-Received: by 2002:a63:934d:: with SMTP id w13mr12839626pgm.185.1571911230923;
        Thu, 24 Oct 2019 03:00:30 -0700 (PDT)
Received: from wambui ([197.254.95.38])
        by smtp.gmail.com with ESMTPSA id j63sm10564453pfb.162.2019.10.24.03.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 03:00:30 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:00:20 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     paulburton@kernel.org, gregkh@linuxfoundation.org,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v2 1/5] staging: octeon: remove
 typedef declaration for cvmx_wqe
Message-ID: <20191024100020.GA13343@wambui>
Reply-To: alpine.DEB.2.21.1910240722070.2771@hadrien
References: <cover.1570821661.git.wambui.karugax@gmail.com>
 <fa82104ea8d7ff54dc66bfbfedb6cca541701991.1570821661.git.wambui.karugax@gmail.com>
 <20191024050011.2ziewy6dkxkcxzvo@lantea.localdomain>
 <alpine.DEB.2.21.1910240722070.2771@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910240722070.2771@hadrien>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 07:26:59AM +0200, Julia Lawall wrote:
> > If you're making significant changes to this driver, please test them
> > using the MIPS cavium_octeon_defconfig which is where this driver is
> > actually used.
> >
> > This driver has broken builds a few times recently which makes me very
> > tempted to ask that we stop allowing it to be built with COMPILE_TEST.
> > The whole octeon-stubs.h thing is a horrible hack anyway...
> 
> Wambui,
> 
> Please figure out what went wrong here.  Are there two sets of typedefs
> that should have been updated?
>
I managed to reproduce these build errors and finally noticed that the
"octeon-stubs.h" header is only included when CONFIG_CAVIUM_OCTEON_SOC
is not defined, therefore compiling properly for COMPILE_TEST but will
actually fail when compiled with CONFIG_CAVIUM_OCTEON_SOC is set since
the functions will try to use the definitions in
arch/mips/include/asm/octeon/ that don't have the changes.

Paul, please tell me if this is correct?

Thanks,
wambui

> Others,
> 
> Would it be reasonable to put the information about how the driver should
> be compied in the TODO file?  git grep cavium_octeon_defconfig in the
> octeon directory turns up nothing.
> 
> thanks,
> julia
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.21.1910240722070.2771%40hadrien.
