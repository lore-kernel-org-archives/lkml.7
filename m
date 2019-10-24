Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FEECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6760D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsCVKoAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502212AbfJXMyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:54:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729336AbfJXMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571921662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rgR8iSUbBvZJUDYblMNNLznvyJfzdNXdD9UJJw1C60w=;
        b=BsCVKoAv34cpXgvuEQ7woXJE/Tg0Pc5eNKdUrpNe64sb4ECAibVDZ2ed4SWwf23VhACFKl
        03k6g+xmD/iKUQykqQPb0NjQITZcNTbz5YRB0m1mBRZF7lU2CuHQihj8EhGTWWCxri5czS
        Sxb2CG1Tr4f6E1pXPo2jaY/mSbrlVdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-eym6RqyEMIuvi5I7I7KVNA-1; Thu, 24 Oct 2019 08:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7A7E107AD31;
        Thu, 24 Oct 2019 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.17.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEF305D70E;
        Thu, 24 Oct 2019 12:54:17 +0000 (UTC)
From:   Denys Vlasenko <dvlasenk@redhat.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Denys Vlasenko <dvlasenk@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Do not re-fetch iommu->cmd_buf_tail
Date:   Thu, 24 Oct 2019 14:54:10 +0200
Message-Id: <20191024125410.19224-1-dvlasenk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: eym6RqyEMIuvi5I7I7KVNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler is not smart enough to realize that iommu->cmd_buf_tail
can't be modified across memcpy:

41 8b 45 74          mov    0x74(%r13),%eax   # iommu->cmd_buf_tail
44 8d 78 10          lea    0x10(%rax),%r15d  # +=3D sizeof(*cmd)
41 81 e7 ff 1f 00 00 and    $0x1fff,%r15d     # %=3D CMD_BUFFER_SIZE
49 03 45 68          add    0x68(%r13),%rax   # target =3D iommu->cmd_buf +=
 iommu->cmd_buf_tail
45 89 7d 74          mov    %r15d,0x74(%r13)  # store to iommu->cmd_buf_tai=
l
49 8b 34 24          mov    (%r12),%rsi       # memcpy
49 8b 7c 24 08       mov    0x8(%r12),%rdi    # memcpy
48 89 30             mov    %rsi,(%rax)       # memcpy
48 89 78 08          mov    %rdi,0x8(%rax)    # memcpy
49 8b 55 38          mov    0x38(%r13),%rdx   # iommu->mmio_base
41 8b 45 74          mov    0x74(%r13),%eax   # redundant load of iommu->cm=
d_buf_tail
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
89 82 08 20 00 00    mov    %eax,0x2008(%rdx) # writel

CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: Joerg Roedel <jroedel@suse.de>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 drivers/iommu/amd_iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index dd555078258c..34c497c4b0a7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -876,17 +876,18 @@ static void copy_cmd_to_buffer(struct amd_iommu *iomm=
u,
 =09=09=09       struct iommu_cmd *cmd)
 {
 =09u8 *target;
-
-=09target =3D iommu->cmd_buf + iommu->cmd_buf_tail;
-
-=09iommu->cmd_buf_tail +=3D sizeof(*cmd);
-=09iommu->cmd_buf_tail %=3D CMD_BUFFER_SIZE;
+=09u32 tail;
=20
 =09/* Copy command to buffer */
+=09tail =3D iommu->cmd_buf_tail;
+=09target =3D iommu->cmd_buf + tail;
 =09memcpy(target, cmd, sizeof(*cmd));
=20
+=09tail =3D (tail + sizeof(*cmd)) % CMD_BUFFER_SIZE;
+=09iommu->cmd_buf_tail =3D tail;
+
 =09/* Tell the IOMMU about it */
-=09writel(iommu->cmd_buf_tail, iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+=09writel(tail, iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
 }
=20
 static void build_completion_wait(struct iommu_cmd *cmd, u64 address)
--=20
2.21.0

