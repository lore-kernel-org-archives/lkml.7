Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB44C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0208F2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfDBNkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43248 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731448AbfDBNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:06 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdu-0002mb-7Q; Tue, 02 Apr 2019 14:39:58 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdt-0004r5-KX; Tue, 02 Apr 2019 14:39:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Christoph Hellwig" <hch@lst.de>,
        "Paul Burton" <paul.burton@mips.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.103156486@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 09/99] MIPS: SiByte: Enable ZONE_DMA32 for LittleSur
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 756d6d836dbfb04a5a486bc2ec89397aa4533737 upstream.

The LittleSur board is marked for high memory support and therefore
clearly must provide a way to have enough memory installed for some to
be present outside the low 4GiB physical address range.  With the memory
map of the BCM1250 SOC it has been built around it means over 1GiB of
actual DRAM, as only the first 1GiB is mapped in the low 4GiB physical
address range[1].

Complement commit cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need
DMA32.") then and also enable ZONE_DMA32 for LittleSur.

References:

[1] "BCM1250/BCM1125/BCM1125H User Manual", Revision 1250_1125-UM100-R,
    Broadcom Corporation, 21 Oct 2002, Section 3: "System Overview",
    "Memory Map", pp. 34-38

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Patchwork: https://patchwork.linux-mips.org/patch/21107/
Fixes: cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need DMA32.")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -633,6 +633,7 @@ config SIBYTE_LITTLESUR
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select ZONE_DMA32 if 64BIT
 
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"

