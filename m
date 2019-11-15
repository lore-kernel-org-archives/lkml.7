Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52882C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227B0206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gurwc5k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKOOg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:36:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40718 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKOOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:36:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id i10so11236177wrs.7;
        Fri, 15 Nov 2019 06:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=riXh2msCHI0N6l6Oj7yCZHFf576tcR6CC2sHT+gb0hY=;
        b=gurwc5k4l4grk3796xTwvgXDgmfaBrJMiZ9HyDj3uHXBJEbj51TGC4nl/J4XONHLrv
         hEjy2BuqGxeIm+UPH1nPz44ZdAGPmKQJ5RhSItYUa9BBTt6Idz1IRQcGPCs6WJWWIuaQ
         lHjlw2fQJ8sHs7KV6VI3CyAz74Pv6WIvWNV6MOaW8U/09fmH+OmhWVZ2ci6KFe9x+GxS
         4TCC1l+QWzZMzeE8oC0ybx8Aaxbb7iH4vsIePo+WIPQE5YozwYim/DK329I36Mw+yNp7
         y78n7VEw51WdPO7JwePGN8u4uyPEXRB6MVaMM8FSuSFcTH9vapFmAFHzw/jR8LhDJVsK
         MlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=riXh2msCHI0N6l6Oj7yCZHFf576tcR6CC2sHT+gb0hY=;
        b=k2CnnR35CBIS0A6VSWI846FBzBq8FeMCAlvwXXELHQH7r6K6lSto0xbA+CYgI5WIo+
         2CUwFH4w4PnzgLBy9bppFydxg/TJ4j0TgVxrsbX1ehphDtMm6tOwUCWEx8VxT8xAYt1d
         BeQd5Vet4ZA0qZIu8vEj2geYBLNcM3NOYMmJUCL/5kEyYbVlbGpMn74tr1NuWftjl+hU
         F44EwMWCeQmV4kHuSAPwFwIPM2TEQFIcmBfEYz2cuWGWVK3XSRzMExDv3V/7xPxWoX7D
         Fb9deU+IWRSBFoElHgqwMxmOxH8PxIU0V2haH6jEwR0dGoPvgl1UPaRE6wUjogGIuMkp
         YghQ==
X-Gm-Message-State: APjAAAWCUk/KpOlrwrgnA0hs70xab1XAyCGdqgf4c5P9gdb/68LIUKns
        Pi7IWkDvyo+5x6H9ROWksLs=
X-Google-Smtp-Source: APXvYqwrGaASRwfRm6J8TKc8Jzr/digqHCbU/fSoBLIIS4OadvCQ7ZCfE8/K7du3OEqoVV6xdyRclQ==
X-Received: by 2002:adf:ea92:: with SMTP id s18mr1798332wrm.327.1573828616412;
        Fri, 15 Nov 2019 06:36:56 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u2sm13162520wrg.52.2019.11.15.06.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 06:36:55 -0800 (PST)
Date:   Fri, 15 Nov 2019 15:36:54 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
Message-ID: <20191115143654.xxpxd4xrrapvv5xu@pali>
References: <20191114211408.22123-1-gio@debian.org>
 <20191114213901.GA28532@roeck-us.net>
 <20191114215154.hze2avicv7pwiksp@pali>
 <7ea74678-59e4-2c23-6744-6d0b2eff0a67@debian.org>
 <20191115112902.yfaoqttsafmilijh@pali>
 <97d17b37-0267-ae32-803c-ce8f7a871ab4@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97d17b37-0267-ae32-803c-ce8f7a871ab4@debian.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 November 2019 14:44:59 Giovanni Mascellani wrote:
> Hi,
> 
> Il 15/11/19 12:29, Pali Rohár ha scritto:
> > No. I have not tested that my patch on other models. You can look at
> > that my patch link, some people already reported that on some models it
> > does not work...
> 
> Yes, I saw that. But they are also using other laptops, which could be
> excluded by the whitelist until we have a working command for them.
> 
> > What is incompatible with Secure Boot? sys_iopl nor sys_ioperm has
> > nothing to do with UEFI Secure Boot. They are just ordinary syscalls
> > like any other and are executed on kernel side. And IIRC it is up to the
> > kernel how it set privileges for I/O ports. Maybe bootloaders under
> > Secure Boot can set some other default values, but kernel can overwrite
> > them. I really do not see reason why it could be incompatible with UEFI
> > Secure Boot nor why it should not work. It just looks like improper
> > setup from userspace.
> 
> Ah, my fault here: there is a patch to lock down the kernel when it is
> started with Secure Boot[1], and I believed that was already in
> mainline, but apparently it is not.

Ok, so, this is not a problem.

I hope that such patch is not going to be part of mainline kernel as it
would break lot of things. UEFI Secure Boot and kernel lock down are two
different things. It would be really suspicious that for "workarounding"
broken functionality would be needed to turn of totally unrelated option
in firmware SETUP.

>  [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit?id=160a99536afc317b337212dd40eaba341702343e
> 
> > It makes sense to have implemented in kernel switching between automatic
> > and manual mode as kernel has API for it. But it depends on the fact
> > that we know which SMM API to call. And currently it is just some random
> > call which we somehow observed that is working on 2 machines and on some
> > more other does not. Until we have fully working implementation we
> > cannot put it into kernel.
> 
> Mmh, but then what is a plausible way forward to have this? Can't we
> start populating a whitelist for the machines we already have a solution
> for, and add more entries when they are discovered? This would already
> give a benefit to the users of supported laptops, without impacting
> users of unsupported laptops. My feeling is that if we pretend to have
> information for all possible models supported by dell-smm-hwmon, we will
> never benefit any user. Or can you suggest a plan?

The following question is up to the hwmon maintainers. Guenter, should
we start creating whilelist of machines which support those SMM calls
for enabling / disabling BIOS auto mode? And maintaining this whilelist
in kernel dell-smm-hwmon driver?

> > What does not make sense for me is to have that "protection" in kernel.
> 
> I am not really sure which "protection" you mean. I didn't mean to
> introduce any protection from userspace in my patch, I just wanted to
> make SET_FAN working. I think that the kernel module cannot (and should
> not) reliably protect itself from userspace sending random IO port
> reads/writes.

I mean protection to disallow calling SET_FAN operation when auto mode
is enabled.

-- 
Pali Rohár
pali.rohar@gmail.com
