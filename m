Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837632072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFF5JZq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKOL3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:29:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40652 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfKOL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:29:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id i10so10596303wrs.7;
        Fri, 15 Nov 2019 03:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gv09yPrzH9Km/VHtyPM+5pteRY1/ENh1UjCDufA46kw=;
        b=eFF5JZq8cGUR+wkLyvLfm5RBwNc4PClMpg3Zx07phN/2fJ9ZrjNx3QLvrglqY4bl6q
         kusZE+0GC75CA2BBdSYKF9y2gYPN2qLltZdnivdlUb8sAmVjAMOYtu4+V6+9T65P/d/h
         MifDlymbC3b1HFYMplBYUIVixEe+6C4YvtMFcADrOwaGnNrZbxzBb1p5iiUBtSBRU/26
         zpRh2RMCyzfBXOXPdU3yH6gD1aAnauoVxGUK92QcAOmAmiW4pPRnNcgaKJeNmI5K1alL
         CrUYzhqX3/1Hvx4W3aR19aeq5lIdkLG1CR+82xDKlVsatooh4LRMA5Gv/KxtY+ULtv7y
         YfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gv09yPrzH9Km/VHtyPM+5pteRY1/ENh1UjCDufA46kw=;
        b=QR8AkwgKQT7RcAine6oemBkipNrGYMJl/ZUWZLLZq5QqDX78WqXowsKT3i8Hnr3GqI
         Mo3FtQowBtj0U3zkI6dcaJcSBrk15k7o290U9czSalFtNzFINB6XTOZjzhJ9mL30F9Nq
         Qnx0iX+8GfWvXBHQcu1IkUOqeZjOm4e0gRVtpXx/FJZfG8CXj8F2INE5iFDlPSLoiKd0
         VyVfkAuDkVbX03813zeWIKbjIQ7gGX19L/hhmeWxnxnZ7ltUnU4d29w9S07cRvedS5iP
         zxyiud2YKyq/GvOMFTykUO6BuJ5CPxW/lWZD3yFhfA+D15ebFMGD3WzkICchEbP2mXnZ
         At+Q==
X-Gm-Message-State: APjAAAXM7aEpAqPVtAwhc5H/xBJRnciTvdvICrsn2R5cBNT/g7Sjaesr
        t15Oglq9cMOH2N8ROf3ufkY=
X-Google-Smtp-Source: APXvYqxM/WaD2AB1r5JtcltUwdZSyktJnVsy6vyuHheifqthMLPQmObry96ybqnOu24s+1XgFrEhCA==
X-Received: by 2002:adf:eb8d:: with SMTP id t13mr14211252wrn.321.1573817344270;
        Fri, 15 Nov 2019 03:29:04 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a5sm10548085wrv.56.2019.11.15.03.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 03:29:03 -0800 (PST)
Date:   Fri, 15 Nov 2019 12:29:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
Message-ID: <20191115112902.yfaoqttsafmilijh@pali>
References: <20191114211408.22123-1-gio@debian.org>
 <20191114213901.GA28532@roeck-us.net>
 <20191114215154.hze2avicv7pwiksp@pali>
 <7ea74678-59e4-2c23-6744-6d0b2eff0a67@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ea74678-59e4-2c23-6744-6d0b2eff0a67@debian.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Friday 15 November 2019 10:51:48 Giovanni Mascellani wrote:
> Hi,
> 
> Il 14/11/19 22:51, Pali Rohár ha scritto:
> > This is model or BIOS specific. For example on E6440 are used 0x34a3 /
> > 0x35a3 SMM calls. Because of these platform specific problems we have
> > never incorporated this patch into mainline kernel.
> 
> Would it be sensible to use a dmi_system_id table to discriminate
> between the known models and choose the right commands? Of course we
> wouldn't know the complete table at the beginning, but it can be filled
> as unknown models are reported.

Yes, we can create a whitelist table with known models and correct SMM
commands.

> As a matter of facts, testing your patch I discovered that 0x34a3 /
> 0x35a3 work on my system as well (Dell Precision 5530). Do you know
> systems on which other codes only are known to work?

No. I have not tested that my patch on other models. You can look at
that my patch link, some people already reported that on some models it
does not work...

> > Also note that userspace can issue those SMM commands on its own (via
> > sys_iopl or sys_ioperm), fully bypassing such "protection" proposed in
> > this new patch.
> 
> Yes, I know, but this is incompatible with Secure Boot

What is incompatible with Secure Boot? sys_iopl nor sys_ioperm has
nothing to do with UEFI Secure Boot. They are just ordinary syscalls
like any other and are executed on kernel side. And IIRC it is up to the
kernel how it set privileges for I/O ports. Maybe bootloaders under
Secure Boot can set some other default values, but kernel can overwrite
them. I really do not see reason why it could be incompatible with UEFI
Secure Boot nor why it should not work. It just looks like improper
setup from userspace.

> so I believe
> that this feature should go in the kernel module, and userspace should
> eventually stop doing direct requests and rely on the module. Isn't
> userspace sidestepping the kernel in this way already assumed to take
> their own responsibilities, much like userspace writing random things to
> /dev/mem?

It makes sense to have implemented in kernel switching between automatic
and manual mode as kernel has API for it. But it depends on the fact
that we know which SMM API to call. And currently it is just some random
call which we somehow observed that is working on 2 machines and on some
more other does not. Until we have fully working implementation we
cannot put it into kernel.

What does not make sense for me is to have that "protection" in kernel.

-- 
Pali Rohár
pali.rohar@gmail.com
