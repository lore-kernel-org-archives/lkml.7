Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC58CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FD62080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="W6qOtwyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfJ3V2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:28:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39936 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfJ3V2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:28:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id y81so4450163qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uytARhU4JI/IWniohgI1h0y5qFI/5ABlfCC5CreFQxg=;
        b=W6qOtwyIBZjyUMzGqRXB6G/6qHMzRhvEGhB7sUAOb/7Q0fbDCI2YDLOkQh1eth0aoc
         zqIciVQ+G3mGv+zctMK+TFdzw+XCwGqxXmtEkh94OX70f68eyfnbtWgJfSzHi1PcSZ3G
         CAVcLdYgMbOSQHcqkV5VQE+QYliMeOEGx1e3ND3k2EIB6yapWK8ru7QD/5ztb7f5pujO
         Pak0KSIiHl0AOG8ds3zA4UFJLxn3Jca/4N83l505TqjgpGl49Ei9pRJNsnmva3l2tOss
         yS6VPCeMMoksJcTTHiqXoVHSDlPTvqMOf0mX5pLpaldc8m3ZG6ktwT8DHh/Vcz49xOu2
         jpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uytARhU4JI/IWniohgI1h0y5qFI/5ABlfCC5CreFQxg=;
        b=eGl2xgc59EfDMHxSV+kBXjQfibXP8cJBP1dTUCqWPfGGBIIOoirSKasjqmEaRjD+tG
         Qz5HJLmhL2iGYUgHLt1LSpAlEc4SAdKmqz+H+TxRlsKdPzz+JdJ0sNQXBSSH9wkmU+M7
         lQhxcXJQD2J4vuosjiu3U9LmkW6wmf06C/tE8YTum1Eqva28uqipDR2tPaVWnq/U0PXY
         XEnLDTT0mPMPth9zmbecFLRxjpU9dQBjtB20UO4XrCehCbN3xAx0IxqYiXVoUm7lSjRG
         E4FXVFwWBL8Z9UAX2oTW0qK4GRhgS3ooVqWLiZt8QN12fj21QvJ11OUewtGy4F877+z9
         Jsvw==
X-Gm-Message-State: APjAAAXoFJ7wndh+oTucuLESDfsQ6V//9ceQpX9QMA14mmR/oLLYgADt
        yx03JJRlTPGUXd8A6GABvREG6A==
X-Google-Smtp-Source: APXvYqxcwYAkthju/bxaBiwmlQyXIhoDs08LzlEAC4htL2+UH1+5Ji7t08N+xcWqICHjkBR79GnO+g==
X-Received: by 2002:a37:8a05:: with SMTP id m5mr1950049qkd.181.1572470907914;
        Wed, 30 Oct 2019 14:28:27 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 15sm670984qke.120.2019.10.30.14.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:28:27 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        keith.busch@intel.com, ira.weiny@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] nvdimm/btt: fix variable 'rc' set but not used
Date:   Wed, 30 Oct 2019 17:28:09 -0400
Message-Id: <1572470889-28754-1-git-send-email-cai@lca.pw>
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

v2: include the block address that is returning an error per Dan.

 drivers/nvdimm/btt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3e9f45aec8d1..10313be78221 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1266,6 +1266,12 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			/* Media error - set the e_flag */
 			rc = btt_map_write(arena, premap, postmap, 0, 1,
 				NVDIMM_IO_ATOMIC);
+
+			if (rc)
+				dev_warn_ratelimited(to_dev(arena),
+					"Error persistently tracking bad blocks at %#x\n",
+					premap);
+
 			goto out_rtt;
 		}
 
-- 
1.8.3.1

