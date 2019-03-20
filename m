Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBEAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E151213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OOU1IZOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCTQrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:47:25 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:48562 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfCTQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:47:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 114ED170
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 16:47:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nY35TWa28hr0 for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 11:47:22 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id BCB64BD8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:47:22 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id i4so2711882itb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OCgBGZ9QjrlJl4iqs5f+O79+0bjbKr934DYkhHFKtlI=;
        b=OOU1IZOV9kn1tAIKwAszR4rbr3YZUrdscvNFOXpdRgrs6/eYjIAoPUrjtJvcqQVcJf
         A36wmRrtoTk5TPenXYIzTMciqQQ2sYJrbSISrXgcrl1H5X2FWGWCpLx2JQ8kXdDFrvSu
         62M9xppkgs2x47romIPEU52RfQD8w9tXUBgxUhfAZlYaLauoET56ggrQWG3V7PZr24hH
         fojdSk4F79VsAhYF5Q+z4E1onMTCdGou7QMySYKO+pUlZGVZ/2M/cm5E7LcxFk/OZI8S
         yyp/VSf67HnGSgBxGiZXHRBiajTrdNcyVgur6cO8PI/A4/7M1YcDraPC2Rihi1G8mWQG
         miEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OCgBGZ9QjrlJl4iqs5f+O79+0bjbKr934DYkhHFKtlI=;
        b=h9W/qN40fOcoN+1CRFibMu4hnDnyXQ1xealj/jz/M+HsIhRSKU9cAaBEPtewY/x61P
         +39M//F2JxoBZUkUdfm3G11BboA1oFl5+URqrRZpmg4kCCBSuDhppE5sY1WW7p/2cDzE
         uebh6YsCIqLDXYyk/0QOqNg4DL9Uc7NBna7lH2miqsq5k5n2FxvdoRiSfUot/cXos3Zs
         jv8P2SId2HWGHxE9xf2EMhHcpCKTYBz4iZtdHlUWCnBcGm9+7KCLVNdTYJW6WwtnitvU
         cxyTkEfeVqoF/0BABFsvSDskzbmg6qc4hGKS2AURVsY3fTeOub8WSIFg2AsQXevvh9GT
         kfwQ==
X-Gm-Message-State: APjAAAX+cajR4WjCPKbYc1Fi4Rlu1G6oKLW47JbzERuJzTLWKoCrAXyb
        l/khs5qMlHuCNengIm2Y8owzVWjvb2onG2Fd6b/6s3/vnUtrAClQ5w2I2baFsw7AJIVhCGBHjAO
        DT+PMNU/DeV4znU5RxPnT5C1Fc4iZ
X-Received: by 2002:a02:224b:: with SMTP id o72mr6035563jao.16.1553100442381;
        Wed, 20 Mar 2019 09:47:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+NDgp64O6AmEVq1LCbh8ES/jB1pQ+DbqegVXDMft241QSXQGu2eOSh7t51T3tQyvIPVoHEQ==
X-Received: by 2002:a02:224b:: with SMTP id o72mr6035548jao.16.1553100442203;
        Wed, 20 Mar 2019 09:47:22 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id v4sm982480ios.10.2019.03.20.09.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:47:21 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2] thunderbolt: xdomain: Fix to check return value of kmemdup
Date:   Wed, 20 Mar 2019 11:47:20 -0500
Message-Id: <20190320164720.31264-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup can fail and return a NULL pointer. The patch modifies the
signature of tb_xdp_schedule_request and passes the failure error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Missed clean up of xw in case of kmemdup failure, per David
---
 drivers/thunderbolt/xdomain.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index e27dd8beb94b..316360109bea 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -526,7 +526,7 @@ static void tb_xdp_handle_request(struct work_struct *work)
 	kfree(xw);
 }
 
-static void
+static bool
 tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
 			size_t size)
 {
@@ -534,13 +534,18 @@ tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
 
 	xw = kmalloc(sizeof(*xw), GFP_KERNEL);
 	if (!xw)
-		return;
+		return false;
 
 	INIT_WORK(&xw->work, tb_xdp_handle_request);
 	xw->pkg = kmemdup(hdr, size, GFP_KERNEL);
+	if (!xw->pkg) {
+		kfree(xw);
+		return false;
+	}
 	xw->tb = tb;
 
 	queue_work(tb->wq, &xw->work);
+	return true;
 }
 
 /**
@@ -1416,10 +1421,8 @@ bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
 	 * handlers in turn.
 	 */
 	if (uuid_equal(&hdr->uuid, &tb_xdp_uuid)) {
-		if (type == TB_CFG_PKG_XDOMAIN_REQ) {
-			tb_xdp_schedule_request(tb, hdr, size);
-			return true;
-		}
+		if (type == TB_CFG_PKG_XDOMAIN_REQ)
+			return tb_xdp_schedule_request(tb, hdr, size);
 		return false;
 	}
 
-- 
2.17.1

