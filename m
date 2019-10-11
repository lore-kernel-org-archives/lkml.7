Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1EEECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414662196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9nQZH4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfJKGDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:03:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41322 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfJKGDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:03:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so5406743pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/wT9/t7A7HYNz/iX11tkHS3rBfrsw9PYcflAAbRT90=;
        b=Q9nQZH4CDkUFTAl2+DJ6ZNZ1QHR/rqxgghwGvth2AXWM0MGBrQDH44O7i0AU/86qht
         LVO+dlnp7g5IPI9DAFW77C+A1pdePrXYwrAbQtXDZ+lME7HNkMRVMntBIcOHDKivm3rL
         tulRrhMtEGLJ6H6T7xoCqC4QonryEe7/GKvYJkHRMj/3xyXHBe6Psu6wcqmUrCMaZq7u
         ENu3PiQvVRYJEXD3XW23KVujsbJPBbel5WtUB+ZX93Sf3Y+t6QvxYtsvg7H7BODDr/m+
         S3kn/8I71qrf6o05f380Veg0mIUy8fC1i1Jop1T7v8a6iYv5eE83+WPIj8WIGCFDlQWW
         LSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/wT9/t7A7HYNz/iX11tkHS3rBfrsw9PYcflAAbRT90=;
        b=bwPcZ4QFNhzIE9VXT0IShB+oyAHr4jlCgoUfkSkEx7GgqTGq+WlNGA4vJbxNFU2NBx
         t/T3fhR1HmMiAI4plPXQ+hdna/eROT+k+Va3NuPTPcchkWT+4fufH5QweHlliJ4fQcZU
         yPKGM46J6LGDgD80DMoaSuH6yYLDNXFckKPn3IN+MANF1CwBY05XLLINd0BRkQ7x2tTw
         PIXYDUHeTGzDk98kwFot63A8EXAH8oHtNv/GWicmWC/7IvBl25z1Jor+4NLGmTQ5eEdc
         6TKMOjqkDsxd85A8Zp1MkEAtl37rS/ZK9ggKcXiMN/10Esxj9MlNyIZXCRXjv+6vNWAL
         xcRw==
X-Gm-Message-State: APjAAAVWwPgerne5q+nXsHh3X9lHuFqNv4qjAxqfFVwH8SiCV5/HtZnP
        /6+xa8ADNld5DRQoMu3codo=
X-Google-Smtp-Source: APXvYqx3WzAG2UnyD+20/+pzJk3qbAXa1FhKQULRUwdjiDwOjuBn4rm6pxK6t3ZAIA2KK9QHSCKXtg==
X-Received: by 2002:a63:4622:: with SMTP id t34mr15529950pga.0.1570773817999;
        Thu, 10 Oct 2019 23:03:37 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p11sm9395715pgb.1.2019.10.10.23.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 23:03:37 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH 4/5] staging: octeon: remove typedef declartion for cvmx_pko_command_word0_t
Date:   Fri, 11 Oct 2019 09:02:41 +0300
Message-Id: <2248b40bda9295263ba998c216fe1ac18a2324b4.1570773209.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570773209.git.wambui.karugax@gmail.com>
References: <cover.1570773209.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes addition of new typedef declaration for
cvmx_pko_command_word0_t in drivers/staging/octeon/octeon-stubs.h.
Also replace previous instances with new union declaration.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/ethernet-tx.c  | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 7ececfac0701..f88d8e6f5292 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -127,7 +127,7 @@ static void cvm_oct_free_tx_skbs(struct net_device *dev)
  */
 int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	cvmx_pko_command_word0_t pko_command;
+	union cvmx_pko_command_word0_t pko_command;
 	union cvmx_buf_ptr hw_buffer;
 	u64 old_scratch;
 	u64 old_scratch2;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 1725d54523de..06e6a0223416 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1137,7 +1137,7 @@ union cvmx_npi_rsl_int_blocks {
 	} cn50xx;
 };
 
-typedef union {
+union  cvmx_pko_command_word0_t {
 	uint64_t u64;
 	struct {
 	        uint64_t total_bytes:16;
@@ -1157,7 +1157,7 @@ typedef union {
 	        uint64_t size0:2;
 	        uint64_t size1:2;
 	} s;
-} cvmx_pko_command_word0_t;
+};
 
 union cvmx_ciu_timx {
 	uint64_t u64;
@@ -1384,7 +1384,7 @@ static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
 { }
 
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
-		uint64_t queue, cvmx_pko_command_word0_t pko_command,
+		uint64_t queue, union cvmx_pko_command_word0_t pko_command,
 		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
 {
 	cvmx_pko_status_t ret = 0;
-- 
2.23.0

