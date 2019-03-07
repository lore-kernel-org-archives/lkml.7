Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8213520449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551983952;
	bh=JPuy77EjERH33exruoepUJffKYT/vTHQZikzE1y6eaI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=z1Kab9dyLXK942YH29mrhyS4G0DJnW6Ny8aoI3FtTDy6fX4Cn8NsE+EqeZJnBzsLK
	 +V4loeoqrKjEH7yMDCwmLvTd4BjYwC/XtzbVnU+SM7mQ3cZzJPyn6rZepvO4cMta0+
	 6furkqp2JeakNpq+XB/N7/dB7ZUla0Vp0WkbFrjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCGSjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:39:10 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35439 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGSjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:39:10 -0500
Received: by mail-wr1-f53.google.com with SMTP id t18so18674803wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3GoP+bTRfk/zvOLtPS8XXuofW2U6Zb7RmmWNY55b3kg=;
        b=YYYrhMeSZR8bFE31c6a1HVaCxNPIrQCB8X403vMu+Kl8i/3siAdCLSjHPO26yVVjif
         4hAf5N4ISlFAShV6BV3l5iU7TGC6VPFTSma4D/sWPuz2/eKGn6Q2CKiPEyIk2sBGWPt1
         LuoP/QxBogWzBJADj32qfj5kYuHiijTPaTspwoxSEyVMgV54NEaoiPNHuJD3VDj0sPPz
         CMaFyOoDkS6aCnixhypyn86fwbN3TiQnDsQpPnTsq8/yzFIYDQED/elqq8+FrOhWq7S5
         gy4eghIDMtIdtUv4JyJLh3TmE+WPvO1IXmuAxZg3utqyxQ9NFqvpfdw86RmeBDyzKlAf
         T8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3GoP+bTRfk/zvOLtPS8XXuofW2U6Zb7RmmWNY55b3kg=;
        b=mjOAA59LVLaxVJpCXVTNsH/2+W8aJIXsAqkzIH9Jo5TbPJh92yeZNkCP7pUJTboM69
         IqiGRLTqAD5bxT6fk8mlbrwfbUdt0qH/+lwZkaKZmrTJXjAGRfTv2Vvrr90ABPAb72Fy
         LSMnC0nnexspQYjKiIUZNmglDN9rkE+/n0S6vtBCMDfMFSREZPCDSAbD+tqlpeG4HlB1
         +j8hJYCVHwZZ7f4rfllX9/tv2OXZUEwKXpDe6PoPuBA/si7zUCkObeJ4vZ3QRI6katqo
         +spSMNtzya6McpjsUkAcFcXwtpan0SBI46Gxm3bzlYr8rZiBewMGySOnS1WXJ1ESRTHS
         83tg==
X-Gm-Message-State: APjAAAWfGmV2G8Jl9EYEpf+9dg08HWa9YgDZjPUNKaZf38GEK7RU8atA
        kSaskKPBNmXgLKKKj2HxLW4=
X-Google-Smtp-Source: APXvYqxxK7vdSt0BLiZq39CykgiolZWctsLfR6PpuuE7NOaM9i4gG7wh4CqCgDJn90U+IJYtQGtv5w==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr7657770wrn.21.1551983948670;
        Thu, 07 Mar 2019 10:39:08 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b197sm6969589wmd.23.2019.03.07.10.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 10:39:08 -0800 (PST)
Date:   Thu, 7 Mar 2019 19:39:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86/fpu changes for v5.1
Message-ID: <20190307183905.GA85249@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-fpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

   # HEAD: 2f7726f955572e587d5f50fbe9b2deed5334bd90 x86/fpu: Track AVX-512 usage of tasks

Three changes:

 - There's a preparatory patches for AVX state tracking that 
   computing-cluster folks would like to use for user-space batching - 
   but we are not happy about the related ABI yet so this is only the 
   kernel tracking side.

 - There's a cleanup for CR0 handling in do_device_not_available().

 - Plus we removed a workaround for an ancient binutils version.

 Thanks,

	Ingo

------------------>
Aubrey Li (1):
      x86/fpu: Track AVX-512 usage of tasks

Borislav Petkov (2):
      x86/traps: Have read_cr0() only once in the #NM handler
      x86/fpu: Get rid of CONFIG_AS_FXSAVEQ


 arch/x86/Makefile                   |  1 -
 arch/x86/include/asm/fpu/internal.h | 57 +++++++++----------------------------
 arch/x86/include/asm/fpu/types.h    |  7 +++++
 arch/x86/kernel/traps.c             |  5 ++--
 4 files changed, 22 insertions(+), 48 deletions(-)

