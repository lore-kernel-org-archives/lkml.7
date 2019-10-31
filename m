Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CCCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283B8208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ojd9BDEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfJaOFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:05:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42758 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJaOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:05:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id m4so7092597qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8g/fCqmTpfKLTY3+g19TSl1xtmw42oOlQtbZEptQxXY=;
        b=Ojd9BDEap9xE3g4HQnpHAdCyMWxWnAfFSiVEhn/xryjjQTXRroD9B72k6zI6oz35XG
         nvS5bWyOWkEYu07cHE+RaZOHJVd4szHa1v/b6LaXkmuY/8NsKYXaw1kEXNFKj1nhtLvQ
         8L7v8iwSmFNlH6DHcWDuDDOC9SF90c1r3IkwhiIf6FJKmmACUcBhikG68rM6l7xNAbcO
         fSoDlE1vBp64Dp9vcPD6egrrMQYRWKXEenVF6lR4v8/3if8Vjkqj87Q4AqQ8tAD4CcRH
         YnnJnZjMShZjIldORX3KpAvCbb4QetumevJo4jxpSt4cFDxybJBcaQNoVvhRRkyPizDt
         r3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8g/fCqmTpfKLTY3+g19TSl1xtmw42oOlQtbZEptQxXY=;
        b=i+mZXHxcSyRPJWsWYl6ZxxH76Yi8x4ooLkRoB2pFH66oGsOErfhwjSqW1oL891vScm
         Kx2BqBVQ4vdZN04Z+eC/ynFRXvAtDBi5tJzkj8HdMYCtWxkEOLgsnK40CbsKGAUryMKb
         qyQzV+nl5ABde68tknlrxF6Toes3lYTyejtNfxTBJ9R2/CcfMrwGY7EpnXNX6NCK1V3I
         Dr2cHOPVyrDkUiavfHFUzfXc4p5vKb/1RhHpBG9Us3zdf+myDfUgKYw/jNpdWPLRndtQ
         qUvlpJNYhuJagW56+bXWZlxlLQBfTY7BO3pzPxA6bHWgmB4WBDfMvaysrDKRDCxKyIm6
         py9w==
X-Gm-Message-State: APjAAAVBZ2PgisjucasihYsZZqNGX0JJ01/LKltB71omuFqvIWpNyKy5
        UPudNPd3MyLNat23K28bLFXegQ==
X-Google-Smtp-Source: APXvYqyG/hUnDLvbvo52/8FbBpz3n8E2t1ayAlf4yaDYMPmL9atb/FR4GhdAJID08GoPMr6e2rjD1w==
X-Received: by 2002:ae9:e714:: with SMTP id m20mr5276736qka.280.1572530736235;
        Thu, 31 Oct 2019 07:05:36 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y33sm3167025qta.18.2019.10.31.07.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 07:05:35 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        keith.busch@intel.com, ira.weiny@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] nvdimm/btt: fix variable 'rc' set but not used
Date:   Thu, 31 Oct 2019 10:05:19 -0400
Message-Id: <1572530719-32161-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/nvdimm/btt.c: In function 'btt_read_pg':
drivers/nvdimm/btt.c:1264:8: warning: variable 'rc' set but not used
[-Wunused-but-set-variable]
    int rc;
        ^~

Add a ratelimited message in case a storm of errors is encountered.

Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
Signed-off-by: Qian Cai <cai@lca.pw>
---
v3: remove the unused "rc" per Vishal.
v2: include the block address that is returning an error per Dan.

 drivers/nvdimm/btt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3e9f45aec8d1..5129543a0473 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1261,11 +1261,11 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 		ret = btt_data_read(arena, page, off, postmap, cur_len);
 		if (ret) {
-			int rc;
-
 			/* Media error - set the e_flag */
-			rc = btt_map_write(arena, premap, postmap, 0, 1,
-				NVDIMM_IO_ATOMIC);
+			if (btt_map_write(arena, premap, postmap, 0, 1, NVDIMM_IO_ATOMIC))
+				dev_warn_ratelimited(to_dev(arena),
+					"Error persistently tracking bad blocks at %#x\n",
+					premap);
 			goto out_rtt;
 		}
 
-- 
1.8.3.1

