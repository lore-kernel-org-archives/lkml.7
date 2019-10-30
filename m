Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F0BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4352080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YNRHsI+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJ3TQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:16:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35856 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJ3TQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:16:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id x14so4823944qtq.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Cpa84iefVqkjjKhqw25JrRoeu7AV++eH5Wze4rYcprw=;
        b=YNRHsI+lzFIiZJuqWErT6nhqJdHUyOrITkT3K6GC6+WwQsRwHDvaP7tzLLxSxPz5JB
         9C77ZS54M3BSa6J7bRjLDbtzS8mqi5cXygauY0pVzMvLI8aRQTNPGdmZERtK1p7Wroz9
         gccEHjx45NGthf0L0f/068kTn9bkB1g8/+AEsA09Eu2To9ppMpcOgJHJFsELj8ld8YyE
         xjK3hAeky/7uf2skmKt21k7Oohf0EW+fIc7EjVCaHKRkLWSBaXgSNWR7CPxYOxricPxG
         MTq1NaftRGcMaSRSJCBXtQw8WEiZnhhDXxe5DiAX9/5Wf5FXjhVpqNPcIyniA65qwuhe
         qDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cpa84iefVqkjjKhqw25JrRoeu7AV++eH5Wze4rYcprw=;
        b=qpF5R5zv5dcjj06mh+FnwQp1VpEF5HZNEZMVknOEBzPAh6dJi6lf6atidNC/DgKAeY
         K80kCFv15OoppWdJi7SqhlJvxT+nCZQcIHtB7DO7p+1PMW3LsmyC9YHmUmW2YdXY0yeQ
         fNDG7ZtpFcgK1dgVo/90MC7UW8H6IrnVTbGsMyCTVAYLUsYXhkEariz2TNR4r8Y9YZZG
         cW3m/nKQCUWCIwBFYSDKQtK1gOI8slDkQ8xK3ZLXcRmaPnxZyhyAiOKn3e/1DfQgwK4z
         VPYRLZZil0BizzO6iXgNPyrhBoSLJCOM1cK5qR69IbFVcq2Its46FETA02XFxks5/BUA
         nedw==
X-Gm-Message-State: APjAAAXurNXnHinICXDadD+qeCbGJSXo1AVvyS/ou6JPVBW4Er9oTWME
        CRZKM2+gSySwMfqIPAI7alHILmnrd66Grg==
X-Google-Smtp-Source: APXvYqyC3vTZaFFNPiCvhN+5dfaKyIGMRbKBbGNx68oP0+sqyT+P89zOg9sJyPT8UnXmgHax7qvcAQ==
X-Received: by 2002:ac8:746:: with SMTP id k6mr1698563qth.135.1572462962616;
        Wed, 30 Oct 2019 12:16:02 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v205sm476037qkb.123.2019.10.30.12.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 12:16:01 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        keith.busch@intel.com, ira.weiny@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] nvdimm/btt: fix variable 'rc' set but not used
Date:   Wed, 30 Oct 2019 15:15:39 -0400
Message-Id: <1572462939-18201-1-git-send-email-cai@lca.pw>
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
 drivers/nvdimm/btt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3e9f45aec8d1..59852f7e2d60 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1266,6 +1266,11 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			/* Media error - set the e_flag */
 			rc = btt_map_write(arena, premap, postmap, 0, 1,
 				NVDIMM_IO_ATOMIC);
+
+			if (rc)
+				dev_warn_ratelimited(to_dev(arena),
+					"Error persistently tracking bad blocks\n");
+
 			goto out_rtt;
 		}
 
-- 
1.8.3.1

