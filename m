Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE6AC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FFC205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202512;
	bh=ipCcHjIhlJAKSpf0KtDgEtW1PuWtCoxSDhCf9IAkvUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUDwxLUIfUCHQ3r9S6q7mOqNbaNVfJxt6Ll7NgJcrL/XBhKkShWKoggN9uEeRlV5g
	 hGiaQOjXGmEBsGcuBDTUTyTu8Fk2jUJ49aGc2cv4TR4ZsaQWeXLmZB5Kcz1vtK04Uq
	 Gn9rb1bmd8gLY6+QiaSa411IFUUDYdhCYnS+bF+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391414AbfGOO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391393AbfGOO0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:26:52 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C311A206B8;
        Mon, 15 Jul 2019 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200811;
        bh=ipCcHjIhlJAKSpf0KtDgEtW1PuWtCoxSDhCf9IAkvUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K83LbY+cJCSDQ1+4tWvcLsYHpvRNsA3HaT32mjfdNutJ+qSwA2V5/1FAC5P9ZGl9A
         GvpASQttmmjMNKx3zTjJHISCAcJxycni1IiLK3MRmrPhw5z+fuLY70kIeNbOduSYWU
         gcIh5huOCItGSqD70+qJ2iyzkSLdDvwWyMSLM/wM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baruch Siach <baruch@tkos.co.il>, Song Liu <songliubraving@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 135/158] bpf: fix uapi bpf_prog_info fields alignment
Date:   Mon, 15 Jul 2019 10:17:46 -0400
Message-Id: <20190715141809.8445-135-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit 0472301a28f6cf53a6bc5783e48a2d0bbff4682f ]

Merge commit 1c8c5a9d38f60 ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next") undid the
fix from commit 36f9814a494 ("bpf: fix uapi hole for 32 bit compat
applications") by taking the gpl_compatible 1-bit field definition from
commit b85fab0e67b162 ("bpf: Add gpl_compatible flag to struct
bpf_prog_info") as is. That breaks architectures with 16-bit alignment
like m68k. Add 31-bit pad after gpl_compatible to restore alignment of
following fields.

Thanks to Dmitry V. Levin his analysis of this bug history.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/bpf.h       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2932600ce271..d143e277cdaf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2486,6 +2486,7 @@ struct bpf_prog_info {
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
 	__u32 gpl_compatible:1;
+	__u32 :31; /* alignment pad */
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 66917a4eba27..bf4cd924aed5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2484,6 +2484,7 @@ struct bpf_prog_info {
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
 	__u32 gpl_compatible:1;
+	__u32 :31; /* alignment pad */
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
-- 
2.20.1

