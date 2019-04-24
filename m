Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048B5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E87206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126763;
	bh=+sWUvqFRKhNJy+oZneOs9XU3BPS3lE2uJw2vX64Zzak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jNOeV2IhiloNrH8uFU1mh1brLxorELbe5pAMV+j1JOiQBb39MjLghUEKxunJeVHg4
	 mBIEdwS9ooffSCMl8ifjBSyoXuSZwpeYpLqqcg1IWam95weepoyxdl/JOJnXFEtHkf
	 B1RgYdBouZZGgldHHZb7F9DRGSEBrGLVlhAClh/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbfDXR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390131AbfDXRZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:25:58 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2BE20835;
        Wed, 24 Apr 2019 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126757;
        bh=+sWUvqFRKhNJy+oZneOs9XU3BPS3lE2uJw2vX64Zzak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7GtIScM8s19e4dRvZiobT9JkH83s5XMJ9NP+gMeDXH8UltIEom7DNABVTcRfZN2Q
         4LLGBMODUgPJGLUDM1hFLT35iyE6pSSDzVzvNz/noMTHqUk7o0Q6JBmf1EKZAR5kqf
         vjaKRaTrX/TGOcneGItqx/Etdb+/bCrv6ZxKKyo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 4.9 43/44] percpu: stop printing kernel addresses
Date:   Wed, 24 Apr 2019 19:10:21 +0200
Message-Id: <20190424170901.854871656@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

commit 00206a69ee32f03e6f40837684dcbe475ea02266 upstream.

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
at boot "____ptrval____" is printed instead of actual addresses:

    percpu: Embedded 38 pages/cpu @(____ptrval____) s124376 r0 d31272 u524288

Instead of changing the print to "%px", and leaking kernel addresses,
just remove the print completely, cfr. e.g. commit 071929dbdd865f77
("arm64: Stop printing the virtual memory layout").

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/percpu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2048,8 +2048,8 @@ int __init pcpu_embed_first_chunk(size_t
 		ai->groups[group].base_offset = areas[group] - base;
 	}
 
-	pr_info("Embedded %zu pages/cpu @%p s%zu r%zu d%zu u%zu\n",
-		PFN_DOWN(size_sum), base, ai->static_size, ai->reserved_size,
+	pr_info("Embedded %zu pages/cpu s%zu r%zu d%zu u%zu\n",
+		PFN_DOWN(size_sum), ai->static_size, ai->reserved_size,
 		ai->dyn_size, ai->unit_size);
 
 	rc = pcpu_setup_first_chunk(ai, base);
@@ -2162,8 +2162,8 @@ int __init pcpu_page_first_chunk(size_t
 	}
 
 	/* we're ready, commit */
-	pr_info("%d %s pages/cpu @%p s%zu r%zu d%zu\n",
-		unit_pages, psize_str, vm.addr, ai->static_size,
+	pr_info("%d %s pages/cpu s%zu r%zu d%zu\n",
+		unit_pages, psize_str, ai->static_size,
 		ai->reserved_size, ai->dyn_size);
 
 	rc = pcpu_setup_first_chunk(ai, vm.addr);


