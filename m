Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74B5ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EEF21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwFimumA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfIKHW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:22:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45347 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKHW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:22:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so13068268pfb.12;
        Wed, 11 Sep 2019 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/gqa9V2L+P7ZTpCq0TlKj9v1dS5cmC4kjSw+65uCNc=;
        b=hwFimumAJ3dzVLsdJRz6iV+uEzELODNL2lJiw22kfZYn5GP2uekM/xd0F4bLyVDQWx
         8EijycLwidpf5y0+hrXiZMNoZSBPF4ZfwbxcDlQNwYR3XEYaSlfeuMKCot1AOu4vvWt8
         gfDJMfgbS23x/1mu2DEzNk/rzXff+9/I0Ds+to25lT8g/d48ILdjGeIviZti+SGrbWgT
         n+wWaCOqn9mfaegzo1J5hIYiBFp9Mw2do5NdqnK+8aGT9WO0DsJ0HlzCJC9UazMVWEgO
         8S2Cwo+wo3p+xyKb+x+lbY8cM7wH+KQXgAJTHKxF4C1QDAbdSz9JqjxWYXhvKN0p7yoJ
         pxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/gqa9V2L+P7ZTpCq0TlKj9v1dS5cmC4kjSw+65uCNc=;
        b=AG8EJw0GyluwvfDPQyphC2RScZ0JcQJRYhEY28P0+EL9tsuiT1+lQPgOrGsWEDJ0eB
         Khk6cCaB6dfkO7o5x/ZT7U9uWvVl4eRDobUATTX38D7EioYlkrYsBgd6VHVXw4gShhWj
         /7Ywy/RoyOixBJ8eVWtLVaIFcLfzMHk1Dpd1gzfk6juG3QmfYL6h8X22NInv3WXBodCl
         iLhnElCrS3mqJYZGtB5FR6LNhmq5Gaf1zdjTYez/5WPW+ZvHZua7b+4M7nxPWdTmduIs
         vh7xQYlLvQNy/IPcooxzfbG+De4A2jWayPbmaRxmeDDceGSQEXyza/ZzwcgLUBJORuIA
         Kl8w==
X-Gm-Message-State: APjAAAUqTuCOHyAEW94lmqdKueH6gzsEkQNKw01GvlqUkWF4eHClLei1
        fnhjkvq9qWGS7D80zaCCRC0=
X-Google-Smtp-Source: APXvYqwuXoPT0z6Tle9Liqq4AWtT10UkBBHDtFueE/NPKV1wjQgRBVUBB0ZlO9L1c7/YP7UIwn7z0w==
X-Received: by 2002:a17:90a:e98e:: with SMTP id v14mr3956501pjy.101.1568186578617;
        Wed, 11 Sep 2019 00:22:58 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d22sm884962pfq.168.2019.09.11.00.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:22:58 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V9 3/5] PCI: Add Genesys Logic, Inc. Vendor ID
Date:   Wed, 11 Sep 2019 15:23:15 +0800
Message-Id: <860ef173fe110630d91e384ae44d7ad42cb72d3a.1568184581.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568184581.git.benchuanggli@gmail.com>
References: <cover.1568184581.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add the Genesys Logic, Inc. vendor ID to pci_ids.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..4f7e12772a14 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2403,6 +2403,8 @@
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
 #define PCI_DEVICE_ID_RDC_D1010		0x1010
 
+#define PCI_VENDOR_ID_GLI		0x17a0
+
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
 #define PCI_VENDOR_ID_QCOM		0x17cb
-- 
2.23.0

