Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7423C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IKdnQoG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfCRWzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:55:17 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:53400 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfCRWzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:55:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 33F11B6E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 22:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GrPPmhUGfEXV for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 17:55:15 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 09A20B55
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 17:55:15 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id b16so10622469iot.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ekgEiSdzFq4TTcMvB4m0KnKmaQJ4Bt4kfyIC02uEVFE=;
        b=IKdnQoG783bjQDMPkChNhU+904HcFtJY8kRv5M/NTbdsRypmK2Ha3Dfg3Fa4YB4ivA
         rtJKB9uVZSyNrPxOOau+pynu2nWK2lNxBlAqoL5tilzmZZki2RcPLyg//oOA/fXqiUFC
         hTk6H9PAZoIVyQRdzgt+SQAFdLI2AwaVCGoaLw3bDb051k/zc9TXxGv8vola2Ivi6B5e
         GLn06PkDXZ/hz5Jk+Q4LuMTdJQQQtirp8iBy19EKJKJGLxzvxZR7jwT5/wbv/KbQi59W
         16IQeXYtCCrhrol6iYDJts1x+S1BUg562BfLP1km01j48USerurH7efwVqA6fW83PYH6
         nwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ekgEiSdzFq4TTcMvB4m0KnKmaQJ4Bt4kfyIC02uEVFE=;
        b=bM/OhVhNGupjvmBI/qQ81OOC43Azd3qLdmsiRdPRFGyxcuX297qSEmeoFg8ezNNo1B
         o2zmaei+kuG9I0mEDShMheixlu2o+yL61RLfEbJzlfOVhBh8vi4JNBAoM2gBrM12r8/j
         GFUYIvQGzyV/0SZ/ltHqo7wvk9BbvbCabhiW6GAUUxLCXHlvPflQmwDgGM9T+NrQIj4T
         bbESAnhoe9kNVNGorJ/NoYpAOxxn/tMwJSKLLUXFE/u0vKWIYWm1fqjvmy7UrxvS4IV+
         1dAXKhUlPXlfwxWoqnjBdhXsWAfb+6zBpBdi+25heF25UOfqUqFopKQWPB6OmTBdHxwI
         EiSg==
X-Gm-Message-State: APjAAAXAQQVsP5AOel2jm6jZnFNjC1oDMoYljRFhJeDlkmci4n6HiDbU
        /KRZT5cLOTiVHjj0jCMtD57cUmz6Fq5rhUb0wThVbbk0C/3N9F5yz5zFXRVhioDX29ryhhzOukh
        TxMOmkCMNiWts5abrY9zITr6RvphT
X-Received: by 2002:a05:660c:2ca:: with SMTP id j10mr825125itd.151.1552949714623;
        Mon, 18 Mar 2019 15:55:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1cC/KD1WTqoDDUMD3Ij2/KGLEj/VcgMi062V38Pod0ZpngskU1Qbco3YesIwR1VV7jNdo0g==
X-Received: by 2002:a05:660c:2ca:: with SMTP id j10mr825100itd.151.1552949714026;
        Mon, 18 Mar 2019 15:55:14 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id y3sm403420itb.2.2019.03.18.15.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 15:55:13 -0700 (PDT)
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
Subject: [PATCH] thunderbolt: xdomain: Fix to check return value of kmemdup
Date:   Mon, 18 Mar 2019 17:55:08 -0500
Message-Id: <20190318225508.7886-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup can fail and return a NULL pointer. The patch modifies the
signature of tb_xdp_schedule_request and passes the failure error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/thunderbolt/xdomain.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index e27dd8beb94b..b0e9cc30d708 100644
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
@@ -534,13 +534,16 @@ tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
 
 	xw = kmalloc(sizeof(*xw), GFP_KERNEL);
 	if (!xw)
-		return;
+		return false;
 
 	INIT_WORK(&xw->work, tb_xdp_handle_request);
 	xw->pkg = kmemdup(hdr, size, GFP_KERNEL);
+	if (!xw->pkg)
+		return false;
 	xw->tb = tb;
 
 	queue_work(tb->wq, &xw->work);
+	return true;
 }
 
 /**
@@ -1417,8 +1420,7 @@ bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
 	 */
 	if (uuid_equal(&hdr->uuid, &tb_xdp_uuid)) {
 		if (type == TB_CFG_PKG_XDOMAIN_REQ) {
-			tb_xdp_schedule_request(tb, hdr, size);
-			return true;
+			return tb_xdp_schedule_request(tb, hdr, size);
 		}
 		return false;
 	}
-- 
2.17.1

