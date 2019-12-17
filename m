Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461CEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1F12146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLN8ykOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfLQMjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:39:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43761 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727958AbfLQMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576586346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B246GLaT3HAQaGu/abosRqj+9QWb/G6+/8B/T9JdjTs=;
        b=NLN8ykOlKEbDicwTqcCtwyEs3j4UEjoMgDFjWgjx6YEX6OjM6IXmnFMqri3RbSZ/VcA/yT
        4AhVam6l1ueyFnC55jYCYomMet43oOcS7mfSey4TLzb7O9azMGYA/rU5sd9gUeXwHwqApl
        qj9LYK2OmNA0DZLFs2giqc24JHCv6PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-lTiwSymxNZWStB5eZN8R8g-1; Tue, 17 Dec 2019 07:39:03 -0500
X-MC-Unique: lTiwSymxNZWStB5eZN8R8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE8DF107ACC5;
        Tue, 17 Dec 2019 12:39:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 538961001281;
        Tue, 17 Dec 2019 12:38:58 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC v1 1/3] powerpc/memtrace: Enforce power of 2 for memory buffer size
Date:   Tue, 17 Dec 2019 13:38:49 +0100
Message-Id: <20191217123851.8854-2-david@redhat.com>
In-Reply-To: <20191217123851.8854-1-david@redhat.com>
References: <20191217123851.8854-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code mentions "Trace memory needs to be aligned to the size", and
e.g., round_up() is documented to work on power of 2 only. Also, the
whole search is not optimized e.g., for being aligned to memory block
size only while allocating multiple memory blocks.

Let's just limit to powers of 2 that are at least the size of memory
blocks - the granularity we are using for alloc/offline/unplug.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/pla=
tforms/powernv/memtrace.c
index eb2e75dac369..0c4c54d2e3c4 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -268,15 +268,11 @@ static int memtrace_online(void)
=20
 static int memtrace_enable_set(void *data, u64 val)
 {
-	u64 bytes;
-
-	/*
-	 * Don't attempt to do anything if size isn't aligned to a memory
-	 * block or equal to zero.
-	 */
-	bytes =3D memory_block_size_bytes();
-	if (val & (bytes - 1)) {
-		pr_err("Value must be aligned with 0x%llx\n", bytes);
+	const unsigned long bytes =3D memory_block_size_bytes();
+
+	if (val && (!is_power_of_2(val) || val < bytes)) {
+		pr_err("Value must be 0 or a power of 2 (at least 0x%lx)\n",
+		       bytes);
 		return -EINVAL;
 	}
=20
--=20
2.23.0

