Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F277C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E391213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DKRv1KED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCSUVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:21:32 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50428 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:21:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 7C661C51
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 20:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VdJxZZkXeW1z for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 15:21:30 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4C2EDCE4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 15:21:30 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id j127so117917itj.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4XbTTjIpiLnxJcyBxCsfFIXdDM651MBiT2q5Ta5m9mE=;
        b=DKRv1KEDHavcTtiRlKGtHGXyuC/RXZg7f7UumYSvaL256iDULMKIyHE1jUDuz7gnk1
         J/LIPAUOWbgb3EBPeXDBf21LvkX2qMt6Bv/cTcga8kaU8Iw31pJrTnfEmU66P17L8ocV
         +Qapj/+W44jqulus48Iwj1xdtAUqlJnHylnFfYjDQRZwtUqaaSByCZfWVWrJBdD/ED1C
         cO6EUp7xFIKfdWm5V2NaGIN09BvPG5rJ3ot4pKnufryJVfDdgzxxF9r55XS8SCfhZ4Fo
         x8cNIqbYvdn95ayG0TYGgHFmdu/SQ1cXidNkm7iTmHnsmM5MKCCDifd5MxKwBqj5YN/0
         Kd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4XbTTjIpiLnxJcyBxCsfFIXdDM651MBiT2q5Ta5m9mE=;
        b=GuoEObwMVG5gCweD114fD6IXIAbd1qa8K/14Sy2MfreZwllKa151lwh2uk5iZ6F+D2
         9cV3pBKtuhTWgpitaYMwU7dQipTUJQ4NKhMtmwqPeDzkp+Xywj7vlY+oEOcBFIieYXZU
         nBHINFUnlACwNxgmcRDmoLIuc2kBBHwCQbGC5GPY/fBm8b9rk+bnGx8FohzNYA278I3z
         9H4TqVRJGADhyAFU9gT6qulIWOiTwMNLe/ahcn9XjI3VSdoPjFqCwvS5X36PCcKfCla0
         vZxb0UysCVy1xikFzBZqMcMDrc+khEClt025sw010e5h52BlAxaJZEPNUCt+rnLZ84Jk
         WGUg==
X-Gm-Message-State: APjAAAX86MrTSQA9wY0chNcCGmfTv1iXBiuCCvIQdNJZkm2c9S7dUD3D
        yrMvyJUgMSRezU4Y/Q3EOapVFGXvCntHtJNiErNrhpFRcJtpwe3f+AosBH78rMPC1NgiGltt9ir
        3EnD5OpHgytdZKMry6GUf0Uh8fboH
X-Received: by 2002:a24:3655:: with SMTP id l82mr2640842itl.107.1553026890258;
        Tue, 19 Mar 2019 13:21:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztpNUNli8bozcP0nGtV3GGAwI9u5P7M5k8VVeDQASG3DWDgAqHlt2pH3/Ubk8P9DAqFg6hZw==
X-Received: by 2002:a24:3655:: with SMTP id l82mr2640831itl.107.1553026890080;
        Tue, 19 Mar 2019 13:21:30 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id i5sm41441itb.3.2019.03.19.13.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 13:21:29 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtlwifi: rtl8822b: fix to avoid NULL pointer dereference
Date:   Tue, 19 Mar 2019 15:21:25 -0500
Message-Id: <20190319202127.16692-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb allocated via dev_alloc_skb can fail and return a NULL pointer.
This patch avoids such a scenario and returns, consistent with other
invocations.

---
v1: Patch collision with rtl_phydm.c, fix as per Greg
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
index f061dd1382aa..cf6b7a80b753 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -743,6 +743,8 @@ void rtl8822be_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		      u1_rsvd_page_loc, 3);
 
 	skb = dev_alloc_skb(totalpacketlen);
+	if (!skb)
+		return;
 	memcpy((u8 *)skb_put(skb, totalpacketlen), &reserved_page_packet,
 	       totalpacketlen);
 
-- 
2.17.1

