Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2414C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7D205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL/DwRZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfEGQ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:59:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44699 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfEGQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:59:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so4455491plj.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkDmKHN/t0FLLqvqBKew99AjKdIrGt8ctiEpmuZPQEg=;
        b=mL/DwRZ6NNE/tDrfyJO92P34yidij+IBavjnpFg+vLE7NxYbAdRI3A3VMvYhslLP+M
         nzJpelgOI5WlnMSUiO2DLDiObsStnF75NA5K4GOPR2Tpf+Mte7AeN7m9u/GkN1tkj/BA
         ioJAXF1PTTz56OYBYzX4N0FBnJtVbr/5AaT9pmbrAyIIdbgWmPJvFlXLcV14BAJyA0Rz
         6edAUUl/bt2Lpp5VTwHKdXY226DIe11A2NmQRFKad4Vq37ZUnT9N8mOH7YS6tKEWWlvT
         lxcCLHwCrgm9u2hi7xdJyey5Fz+2mmlkZCtuWAgSPr2pP9tw7C3PR0P9oK7glcguRLgT
         Ec2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkDmKHN/t0FLLqvqBKew99AjKdIrGt8ctiEpmuZPQEg=;
        b=hD+x4MmxayLWnpEbpvG43iSBI4UL657gg8Gq2Pv8NoEE3Jam3t8jathnCzLzvGv8XF
         gC8Z6yZ9RfhZKz0egFvpiDQKCDqvaKwQaa97QIDNGFF+/y47oRIn+s4Ct4STLWeOmkaI
         Ijy4t0LLqhgSLxkeo3pEamHAFFR60x1H7Dwm7395WwIP1Y9Mt4OL26AGVGg2XMV0mrLS
         fLXq1MpbwO3816wIZuz8ZUE5n2SawTByhP8F3GAePAqLiYKVl+zB6dDC9Kh5ulLvUe8/
         w8oBEgPNwSmHZbwPoDOkatWX4AZ714wQlq84p5WP1B9UFI3RatGJDzPIIq4P+GsjkIdH
         yTAA==
X-Gm-Message-State: APjAAAXlEgbpLrYFmcwC+Mj2w+suGb/0Sq7P2a5akB1+P3czBTXWrgtd
        EBbKuVhCJ6ixwPsw5hR+/rQ=
X-Google-Smtp-Source: APXvYqxJ+EQKiVy218dYR7Dm20kGmAZ+GmsLMjRTyqSTJFjZWJoq+O3itK0N2nmenAgyxxLL9dUu9Q==
X-Received: by 2002:a17:902:b606:: with SMTP id b6mr5432879pls.100.1557248342269;
        Tue, 07 May 2019 09:59:02 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id r12sm18140093pfn.144.2019.05.07.09.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 09:59:01 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v2 4/7] nvme.h: add telemetry log page definisions
Date:   Wed,  8 May 2019 01:58:31 +0900
Message-Id: <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy telemetry log page definisions from nvme-cli.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- New patch in this version.

 include/linux/nvme.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c40720c..5217fe4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -396,6 +396,28 @@ enum {
 	NVME_NIDT_UUID		= 0x03,
 };
 
+/* Derived from 1.3a Figure 101: Get Log Page – Telemetry Host
+ * -Initiated Log (Log Identifier 07h)
+ */
+struct nvme_telemetry_log_page_hdr {
+	__u8    lpi; /* Log page identifier */
+	__u8    rsvd[4];
+	__u8    iee_oui[3];
+	__le16  dalb1; /* Data area 1 last block */
+	__le16  dalb2; /* Data area 2 last block */
+	__le16  dalb3; /* Data area 3 last block */
+	__u8    rsvd1[368]; /* TODO verify */
+	__u8    ctrlavail; /* Controller initiated data avail?*/
+	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
+	__u8    rsnident[128];
+	/* We'll have to double fetch so we can get the header,
+	 * parse dalb1->3 determine how much size we need for the
+	 * log then alloc below. Or just do a secondary non-struct
+	 * allocation.
+	 */
+	__u8    telemetry_dataarea[0];
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
@@ -832,6 +854,7 @@ enum {
 	NVME_LOG_FW_SLOT	= 0x03,
 	NVME_LOG_CHANGED_NS	= 0x04,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
+	NVME_LOG_TELEMETRY_CTRL	= 0x08,
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
-- 
2.7.4

