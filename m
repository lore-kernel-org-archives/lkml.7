Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7181C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61EE2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389436AbfINOfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 10:35:47 -0400
Received: from baldur.buserror.net ([165.227.176.147]:58968 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbfINOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 10:35:47 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1i992n-0001qp-1p; Sat, 14 Sep 2019 09:28:57 -0500
Message-ID: <65f56bfd05152d744b032e7df9c34b5d9ef2bfb5.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Cc:     wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        jingxiangfeng@huawei.com, zhaohongjiang@huawei.com,
        thunder.leizhen@huawei.com, fanchengyang@huawei.com,
        yebin10@huawei.com
Date:   Sat, 14 Sep 2019 09:28:55 -0500
In-Reply-To: <e02c727a-5505-80d3-9ba2-9fbb9c8253fe@huawei.com>
References: <20190809100800.5426-1-yanaijie@huawei.com>
         <a39b81562bcdeda7ffe0c2c29a60ff08c77047a6.camel@buserror.net>
         <e02c727a-5505-80d3-9ba2-9fbb9c8253fe@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org, jingxiangfeng@huawei.com, zhaohongjiang@huawei.com, thunder.leizhen@huawei.com, fanchengyang@huawei.com, yebin10@huawei.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v6 00/12] implement KASLR for powerpc/fsl_booke/32
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-10 at 13:34 +0800, Jason Yan wrote:
> Hi Scott,
> 
> On 2019/8/28 12:05, Scott Wood wrote:
> > On Fri, 2019-08-09 at 18:07 +0800, Jason Yan wrote:
> > > This series implements KASLR for powerpc/fsl_booke/32, as a security
> > > feature that deters exploit attempts relying on knowledge of the
> > > location
> > > of kernel internals.
> > > 
> > > Since CONFIG_RELOCATABLE has already supported, what we need to do is
> > > map or copy kernel to a proper place and relocate.
> > 
> > Have you tested this with a kernel that was loaded at a non-zero
> > address?  I
> > tried loading a kernel at 0x04000000 (by changing the address in the
> > uImage,
> > and setting bootm_low to 04000000 in U-Boot), and it works without
> > CONFIG_RANDOMIZE and fails with.
> > 
> 
> How did you change the load address of the uImage, by changing the
> kernel config CONFIG_PHYSICAL_START or the "-a/-e" parameter of mkimage?
> I tried both, but it did not work with or without CONFIG_RANDOMIZE.

With mkimage.  Did you set bootm_low in U-Boot as described above?  Was
CONFIG_RELOCATABLE set in the non-CONFIG_RANDOMIZE kernel?

-Scott


