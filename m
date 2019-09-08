Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797AEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4857F218DE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="QWHNxgX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfIHQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:10:23 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:50199 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbfIHQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:10:23 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 50569216; Sun,  8 Sep 2019 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567959019;
        bh=1MjEh5GX4AmKOIbspwOJIzlsp3OjQFimOJ8snyEnEd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWHNxgX05BBsQ9msph7aos3/JbpEadD4z5D61uvc+wGAkIX10ZihK/AMEi+j1kWqt
         jbTytgA2R/B5ANgUUix6uMVDJ6jgqxs/9hIqG9X+MPim09U6PfRw6R/TvlZBBp03M6
         ebUsfUyEl1CM9IoIDZFa3tkxETRRvtV2+8uyF2aE7drZQEnHiQ6qcKMz8fO7RwMq6i
         l91mQutX4qr62x1QENYZaOM/lB0yQrez3ddXrBaZuARhFzOPi4dKwTgyCXbU0Kgezu
         eTpgjq/NhnB92tjoXAnimRZ5dBfAhKG/QURl1XJQFzfn5iSH5lpIEy/8T/rKY1FzeY
         yRSqsEQh2saKA==
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v2 2/3] staging: exfat: drop unused field access_time_ms
Date:   Sun,  8 Sep 2019 16:10:14 +0000
Message-Id: <20190908161015.26000-2-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used in the exfat-fuse implementation and spec defines
this position should hold the value for CreateUtcOffset.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/exfat/exfat.h      | 3 +--
 drivers/staging/exfat/exfat_core.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 58e1e889779f..6491ea034928 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -444,8 +444,7 @@ struct file_dentry_t {
 	u8       access_date[2];
 	u8       create_time_ms;
 	u8       modify_time_ms;
-	u8       access_time_ms;
-	u8       reserved2[9];
+	u8       reserved2[10];
 };
 
 /* MS-DOS EXFAT stream extension directory entry (32 bytes) */
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 995358cc7c79..8476eeedba83 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1456,7 +1456,6 @@ void init_file_entry(struct file_dentry_t *ep, u32 type)
 	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_ACCESS);
 	ep->create_time_ms = 0;
 	ep->modify_time_ms = 0;
-	ep->access_time_ms = 0;
 }
 
 void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size)
-- 
2.20.1

