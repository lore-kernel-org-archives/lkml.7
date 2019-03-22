Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAE52083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="pr/eyPLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfCVIaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:30:12 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:58864 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:30:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5D7A327E0325;
        Fri, 22 Mar 2019 09:30:10 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bPEh3-2UzFND; Fri, 22 Mar 2019 09:30:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 04FAA27E0404;
        Fri, 22 Mar 2019 09:30:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 04FAA27E0404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1553243410;
        bh=pAt5bo1w0fujeK/gO18NIvOQ/KJwXWKF/XMl3ba247A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pr/eyPLY6PWFL4Lnw6m1xjqsVZELFO2fNWpyg+NirLaGT7EodUxGo1YBf2NOpRMxU
         1xDcOga7lKK5GA+DM8uCBx4aMOqHwKSSwnda2pi+UqwI67UX12v9b8EpmkDy02wypn
         NlDCPkav7MFAp4BTsqvF3+zEk95bnV9Qp7alnO8A=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HzhzvaWuKNBY; Fri, 22 Mar 2019 09:30:09 +0100 (CET)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DCC5627E0325;
        Fri, 22 Mar 2019 09:30:09 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:30:09 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Message-ID: <1443307786.4859175.1553243409888.JavaMail.zimbra@kalray.eu>
In-Reply-To: <1741404498.4767335.1553163629182.JavaMail.zimbra@kalray.eu>
References: <1741404498.4767335.1553163629182.JavaMail.zimbra@kalray.eu>
Subject: Re: [PATCH] dma: select GENERIC_ALLOCATOR for DMA_REMAP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - GC71 (Linux)/8.8.11_GA_3787)
Thread-Topic: select GENERIC_ALLOCATOR for DMA_REMAP
Thread-Index: NGPCvDoj7yFWRpAnvrjujfr+mHAQTQM+LIVT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Mail original -----
De: "Cl=C3=A9ment Leger" <cleger@kalray.eu>
=C3=80: "linux-kernel" <linux-kernel@vger.kernel.org>
Envoy=C3=A9: Jeudi 21 Mars 2019 11:20:29
Objet: [PATCH] dma: select GENERIC_ALLOCATOR for DMA_REMAP

When DMA_REMAP is enabled, code in remap.c needs generic allocator.
It currently worked since few architectures uses it (arm64, csky) and
they both select GENERIC_ALLOCATOR.

Signed-off-by: Clement Leger <clement.leger@kalray.eu>
---
 kernel/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index a06ba3013b3b..6a43c4ae77f9 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -58,6 +58,7 @@ config SWIOTLB
 config DMA_REMAP
 =09depends on MMU
 =09bool
+=09select GENERIC_ALLOCATOR
=20
 config DMA_DIRECT_REMAP
 =09bool
--=20
2.15.0.276.g89ea799
