Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175E9C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E243C20679
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLYB1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 20:27:53 -0500
Received: from baldur.buserror.net ([165.227.176.147]:52680 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLYB1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 20:27:53 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1ijvOK-00050x-Hj; Tue, 24 Dec 2019 19:23:12 -0600
Message-ID: <9e680f3798f1a771cba4b41f7a5d7fda7f534522.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Yingjie Bai <byj.tea@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     yingjie_bai@126.com, Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Dec 2019 19:23:10 -0600
In-Reply-To: <CAFAt38F-YQUVNXEnLut0tMivYUy_OTK7G4wAHfddcmncsEpREQ@mail.gmail.com>
References: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
         <87pngglmxg.fsf@mpe.ellerman.id.au>
         <CAFAt38F-YQUVNXEnLut0tMivYUy_OTK7G4wAHfddcmncsEpREQ@mail.gmail.com>
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

On Tue, 2019-12-24 at 09:35 +0800, Yingjie Bai wrote:
> Hi Michael,
> Thanks for pointing out the issue. My mistake...
> This patch should indeed make sense only when
> CONFIG_PHYS_64BIT=y
> 
> I could not find corenet32_smp_defconfig, but I guess in your config,
> CONFIG_PHYS_64BIT=n ?
> I will update the patch later today

corenet32_smp_defconfig is a makefile rule that pulls in multiple config
fragments.  It has CONFIG_PHYS_64BIT=y, but __pa() returns an unsigned long
regardless (which obviously needs to be fixed if DDR starting beyond 4G is to
be supported).

What 32-bit config are you using where this actually builds?

-Scott


