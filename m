Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B71CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57F1214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fgzwQRrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391176AbfJWMIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:08:02 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:38402 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731256AbfJWMIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:08:01 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 330932E15A1;
        Wed, 23 Oct 2019 15:07:58 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id oYVUBvCsZw-7u9iSf2L;
        Wed, 23 Oct 2019 15:07:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571832478; bh=MD+sLQE5eqeoFptjarxWtncPV6DVfff5l/oKBMfD5DQ=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=fgzwQRrF015w0NxreHfFuNEvHSmKM8Tkb69gQ/b4dWA1fbNnmCFzsuItZAFtYXh1p
         S2RaryEqHz6WUAfKSUOYhZS61ypYmMDv3pLEn6TUUoVl5vY+vwyWpkTvSVmzrDdCVx
         Q0h85+SXE3cl0VTrrDc3ADJ9KR3zzh2K5rxnxMUM=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d43:d63f:7907:141a])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id IMWjVteQNg-7uW8xmS9;
        Wed, 23 Oct 2019 15:07:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 4.4 1/2] x86/vdso: Remove direct HPET mapping into userspace
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Oct 2019 15:07:56 +0300
Message-ID: <157183247628.2324.16440279839073827980.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1ed95e52d902035e39a715ff3a314a893a96e5b7 upstream.

Commit d96d87834d5b870402a4a5b565706a4869ebc020 in v4.4.190 which is
backport of upstream commit 1ed95e52d902035e39a715ff3a314a893a96e5b7
removed only HPET access from vdso but leaved HPET mapped in "vvar".
So userspace still could read HPET directly and confuse hardware.

This patch removes mapping HPET page into userspace.

Fixes: d96d87834d5b ("x86/vdso: Remove direct HPET access through the vDSO") # v4.4.190
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/6fd42b2b-e29a-1fd6-03d1-e9da9192e6c5@yandex-team.ru/
---
 arch/x86/entry/vdso/vma.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 6b46648588d8..cc0a3c16a95d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -18,7 +18,6 @@
 #include <asm/vdso.h>
 #include <asm/vvar.h>
 #include <asm/page.h>
-#include <asm/hpet.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
 
@@ -159,19 +158,6 @@ static int map_vdso(const struct vdso_image *image, bool calculate_addr)
 	if (ret)
 		goto up_fail;
 
-#ifdef CONFIG_HPET_TIMER
-	if (hpet_address && image->sym_hpet_page) {
-		ret = io_remap_pfn_range(vma,
-			text_start + image->sym_hpet_page,
-			hpet_address >> PAGE_SHIFT,
-			PAGE_SIZE,
-			pgprot_noncached(PAGE_READONLY));
-
-		if (ret)
-			goto up_fail;
-	}
-#endif
-
 	pvti = pvclock_pvti_cpu0_va();
 	if (pvti && image->sym_pvclock_page) {
 		ret = remap_pfn_range(vma,

