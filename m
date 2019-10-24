Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948E621906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NM5QxTW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410222AbfJXROg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:14:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39069 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405901AbfJXROg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571937274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hGQbFOEkQFyCy0U41zGhn7pQEikaBMfg60zJuN/yD6g=;
        b=NM5QxTW7k8mCQGulRevRSDck/NKS5DUB6md7Gfd/gLrLjVq+QAu2MySRXT/ocCHwVpb5XP
        l42wSEMcyfD5FbpZ65KT51BgWaGhLhop7KIwhjUfbTPpedw3tjHN4XkZWHuV4iNHUDhT7S
        DtCbBb475dFqF99AEJj66sHg/GkaCiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-rg3A0xWPPUS5FssTmyfhbw-1; Thu, 24 Oct 2019 13:14:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A008C800D49;
        Thu, 24 Oct 2019 17:14:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AECCD10027BF;
        Thu, 24 Oct 2019 17:14:25 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86/kdump: Print a notice if SME/SEV is active on crash reservation
Date:   Fri, 25 Oct 2019 01:14:17 +0800
Message-Id: <20191024171417.14175-1-kasong@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rg3A0xWPPUS5FssTmyfhbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SME/SEV requires SWIOTLB to be force enabled in both first kernel
and kdump kernel, the detail is covered in following 3 commits:

- commit c7753208a94c ("x86, swiotlb: Add memory encryption support")
force enables SWIOTLB when SME is active, even if there is less than
4G of memory, to support DMA of devices that not support address with
the encrypt bit.

- commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is active"=
)
kernel keep SWIOTLB enabled even if there is an IOMMU, to support special
devices that IOMMU can't handle.

- commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory encryption")
force enables SWIOTLB when SEV is active unconditionally.

Force enabling SWIOTLB in kdump kernel will make it easily run out of
already scarce pre-reserved crashkernel memory.

The crashkernel value is user specified, and kernel should respect the
given value to make the behavior clear and controllable. And currently
there is no way kernel could estimate the crashkernel value after all.

So when SME/SEV is active, just print a notice to let the user know the
situation and adjust the crashkernel value accordingly. Suppress the
notice if high reservation is used, as high reservation will always
reserve a dedicated low memory region which will cover the SWIOTLB.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..d5ceea03c0a3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -594,6 +594,13 @@ static void __init reserve_crashkernel(void)
 =09=09return;
 =09}
=20
+=09if (crash_base < (1ULL << 32) && mem_encrypt_active()) {
+=09=09pr_notice("Memory encrytion is active, SWIOTLB is required to work,\=
n"
+=09=09=09  "%luMB of low crash memory will be consumed by it.\n"
+=09=09=09  "Please ensure crashkernel value is large enough.\n",
+=09=09=09  (ALIGN(swiotlb_size_or_default(), SZ_1M) >> 20));
+=09}
+
 =09pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM=
: %ldMB)\n",
 =09=09(unsigned long)(crash_size >> 20),
 =09=09(unsigned long)(crash_base >> 20),
--=20
2.21.0

