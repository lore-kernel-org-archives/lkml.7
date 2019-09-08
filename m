Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B2DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FE52054F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="SEZqD8xs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfIHRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 13:35:52 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:35637 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbfIHRfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 13:35:52 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id A3E63217; Sun,  8 Sep 2019 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567964146;
        bh=XRcp16eIoyi8ADWHdwIkGyJ9o2KRVxhAjMqhIsYVNgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEZqD8xsF4sLEsMEIJaZh5KyxgYhQq/Q/2ZOS0+29nFnqIrNqxtvFSVap7MDTEhle
         NVqT10IHhfhm7cmlGo22FiJ/1fCEiazkiZkTLfnz9Cm4HW5jI/CuKUYy4/kIQVG1Zx
         89o0iyG6yCDYqLeajDsrw9UVgdsBRYENwl3jJ/RqH7X1QlKQyVE4t8iB0fNBeM9ZxO
         z9DFrmb724t00S5eMjrQvWggtM8oHiPuHkkOqJxgxzHn9XJsWQcTm7HO5RQfCXsd/c
         1/BhOcwBqfxDNF5oHu8wiPruYheR8Zil2pD7AnyXI588oxjponOrcpZDs6ovTARUe/
         LyOOAfJz4A50w==
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v3 3/4] staging: exfat: drop unused field access_time_ms
Date:   Sun,  8 Sep 2019 17:35:38 +0000
Message-Id: <20190908173539.26963-3-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908173539.26963-1-vvidic@valentin-vidic.from.hr>
References: <20190908173539.26963-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spec defines that UtcOffset fields should start in this
position instead.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/exfat/exfat.h      | 6 ++++--
 drivers/staging/exfat/exfat_core.c | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 58e1e889779f..9b75c5d3f072 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -444,8 +444,10 @@ struct file_dentry_t {
 	u8       access_date[2];
 	u8       create_time_ms;
 	u8       modify_time_ms;
-	u8       access_time_ms;
-	u8       reserved2[9];
+	u8       create_utc_offset;
+	u8       modify_utc_offset;
+	u8       access_utc_offset;
+	u8       reserved2[7];
 };
 
 /* MS-DOS EXFAT stream extension directory entry (32 bytes) */
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 995358cc7c79..d21f68d786b8 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1456,7 +1456,9 @@ void init_file_entry(struct file_dentry_t *ep, u32 type)
 	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_ACCESS);
 	ep->create_time_ms = 0;
 	ep->modify_time_ms = 0;
-	ep->access_time_ms = 0;
+	ep->create_utc_offset = 0;
+	ep->modify_utc_offset = 0;
+	ep->access_utc_offset = 0;
 }
 
 void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size)
-- 
2.20.1

