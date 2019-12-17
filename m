Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D00F21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmjX1qCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfLQMjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:39:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46676 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728051AbfLQMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576586349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIiQFFDXfUcgIvM2Nb3KxFpLZCLOM7WNsSYtHUtaG8Q=;
        b=LmjX1qCJAUvXUteS9cBU7e4/0ag9ImAF6OM8fqKOweOmxkOk5EjgN+Xyxw12lVANSixcXK
        OwCAooaS4EKpKXDjAsmSNrM3KVrcwKEHFy3VPwYvgkFs653W22KPGv/WwqwK9272I8F+W3
        cvzuweLgMzs5qWiHo2WXclG4EZ3U2IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-muAGo-jKPuemWvDF66R4fw-1; Tue, 17 Dec 2019 07:39:06 -0500
X-MC-Unique: muAGo-jKPuemWvDF66R4fw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3247800EBF;
        Tue, 17 Dec 2019 12:39:03 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 393FA10016DA;
        Tue, 17 Dec 2019 12:39:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        Jens Axboe <axboe@kernel.dk>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC v1 2/3] powerpc/memtrace: Factor out readding memory into memtrace_free_node()
Date:   Tue, 17 Dec 2019 13:38:50 +0100
Message-Id: <20191217123851.8854-3-david@redhat.com>
In-Reply-To: <20191217123851.8854-1-david@redhat.com>
References: <20191217123851.8854-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, move it, we want to reuse it soon.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 44 ++++++++++++++---------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/pla=
tforms/powernv/memtrace.c
index 0c4c54d2e3c4..2d2a0a2acd60 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -50,6 +50,32 @@ static const struct file_operations memtrace_fops =3D =
{
 	.open	=3D simple_open,
 };
=20
+static int online_mem_block(struct memory_block *mem, void *arg)
+{
+	return device_online(&mem->dev);
+}
+
+static int memtrace_free_node(int nid, unsigned long start, unsigned lon=
g size)
+{
+	int ret;
+
+	ret =3D add_memory(nid, start, size);
+	if (!ret) {
+		/*
+		 * If the kernel isn't compiled with the auto online option, we
+		 * will try to online ourselves. We'll ignore any errors here -
+		 * user space can try to online itself later (after all, the
+		 * memory was added successfully).
+		 */
+		if (!memhp_auto_online) {
+			lock_device_hotplug();
+			walk_memory_blocks(start, size, NULL, online_mem_block);
+			unlock_device_hotplug();
+		}
+	}
+	return ret;
+}
+
 static int check_memblock_online(struct memory_block *mem, void *arg)
 {
 	if (mem->state !=3D MEM_ONLINE)
@@ -202,11 +228,6 @@ static int memtrace_init_debugfs(void)
 	return ret;
 }
=20
-static int online_mem_block(struct memory_block *mem, void *arg)
-{
-	return device_online(&mem->dev);
-}
-
 /*
  * Iterate through the chunks of memory we have removed from the kernel
  * and attempt to add them back to the kernel.
@@ -229,24 +250,13 @@ static int memtrace_online(void)
 			ent->mem =3D 0;
 		}
=20
-		if (add_memory(ent->nid, ent->start, ent->size)) {
+		if (memtrace_free_node(ent->nid, ent->start, ent->size)) {
 			pr_err("Failed to add trace memory to node %d\n",
 				ent->nid);
 			ret +=3D 1;
 			continue;
 		}
=20
-		/*
-		 * If kernel isn't compiled with the auto online option
-		 * we need to online the memory ourselves.
-		 */
-		if (!memhp_auto_online) {
-			lock_device_hotplug();
-			walk_memory_blocks(ent->start, ent->size, NULL,
-					   online_mem_block);
-			unlock_device_hotplug();
-		}
-
 		/*
 		 * Memory was added successfully so clean up references to it
 		 * so on reentry we can tell that this chunk was added.
--=20
2.23.0

