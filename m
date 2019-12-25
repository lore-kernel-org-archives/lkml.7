Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B572C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6EA2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfLYGvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 01:51:38 -0500
Received: from baldur.buserror.net ([165.227.176.147]:53096 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLYGvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:51:38 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1ik0Vk-0005Ur-5z; Wed, 25 Dec 2019 00:51:12 -0600
Message-ID: <a37338283db548c58e6c36e4996a9474b1fe2038.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Yingjie Bai <byj.tea@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, yingjie_bai@126.com,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 25 Dec 2019 00:51:11 -0600
In-Reply-To: <CAFAt38FnH376ioDuvyNJW=iOxbcooRRsEeVEfDudRoV4gG98SQ@mail.gmail.com>
References: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
         <87pngglmxg.fsf@mpe.ellerman.id.au>
         <CAFAt38F-YQUVNXEnLut0tMivYUy_OTK7G4wAHfddcmncsEpREQ@mail.gmail.com>
         <9e680f3798f1a771cba4b41f7a5d7fda7f534522.camel@buserror.net>
         <CAFAt38FnH376ioDuvyNJW=iOxbcooRRsEeVEfDudRoV4gG98SQ@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: byj.tea@gmail.com, mpe@ellerman.id.au, yingjie_bai@126.com, galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc/mpc85xx: also write addr_h to spin table for
 64bit boot entry
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-25 at 11:24 +0800, Yingjie Bai wrote:
> Hi Scott,
> 
> __pa() returns 64bit in my setup.
> 
> in arch/powerpc/include/asm/page.h
> 
> #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) +
> VIRT_PHYS_OFFSET))
> #define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
> #else
> #ifdef CONFIG_PPC64
> ...
> 
> 
> 
> /* See Description below for VIRT_PHYS_OFFSET */
> #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
> #ifdef CONFIG_RELOCATABLE
> #define VIRT_PHYS_OFFSET virt_phys_offset
> #else
> #define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
> #endif
> #endif

OK, so it's the lack of CONFIG_RELOCATABLE causing the build to fail.  Ideally
we'd make __pa() consistently return phys_addr_t, even if the upper bits are
known to always be zero in a particular config.

-Scott


