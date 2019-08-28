Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FDAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8DB22CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfH1FAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:00:10 -0400
Received: from baldur.buserror.net ([165.227.176.147]:49230 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfH1FAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:00:10 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1i2q3p-0007Ry-Si; Tue, 27 Aug 2019 23:59:58 -0500
Message-ID: <143e5a85bc630d2bb0324114e78bedec8fbeb299.camel@buserror.net>
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
Date:   Tue, 27 Aug 2019 23:59:56 -0500
In-Reply-To: <a39b81562bcdeda7ffe0c2c29a60ff08c77047a6.camel@buserror.net>
References: <20190809100800.5426-1-yanaijie@huawei.com>
         <a39b81562bcdeda7ffe0c2c29a60ff08c77047a6.camel@buserror.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org, jingxiangfeng@huawei.com, zhaohongjiang@huawei.com, thunder.leizhen@huawei.com, fanchengyang@huawei.com, yebin10@huawei.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v6 00/12] implement KASLR for powerpc/fsl_booke/32
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 23:05 -0500, Scott Wood wrote:
> On Fri, 2019-08-09 at 18:07 +0800, Jason Yan wrote:
> >  Freescale Book-E
> > parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
> > entries are not suitable to map the kernel directly in a randomized
> > region, so we chose to copy the kernel to a proper place and restart to
> > relocate.
> > 
> > Entropy is derived from the banner and timer base, which will change every
> > build and boot. This not so much safe so additionally the bootloader may
> > pass entropy via the /chosen/kaslr-seed node in device tree.
> 
> How complicated would it be to directly access the HW RNG (if present) that
> early in the boot?  It'd be nice if a U-Boot update weren't required (and
> particularly concerning that KASLR would appear to work without a U-Boot
> update, but without decent entropy).

OK, I see that kaslr-seed is used on some other platforms, though arm64 aborts
KASLR if it doesn't get a seed.  I'm not sure if that's better than a loud
warning message (or if it was a conscious choice rather than just not having
an alternative implemented), but silently using poor entropy for something
like this seems bad.

-Scott


