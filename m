Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D548CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C7220854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="G6Cil9Km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCMQ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:29:25 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36468 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCMQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:29:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id AB99C78
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 16:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CY5Vl95cibl6 for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 11:29:23 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 7B42B9ED
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:29:23 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id v125so2003123itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KRTpCYk3ZpgRgMJEbk91V+GgCIV1pfhGOWnDidwoEF0=;
        b=G6Cil9KmM5eByjps3eEBI6fo2uGc9UUISJ6vBTJGCbMSUYCXsoIEf3iYzgRNvG/KAR
         OPs3P4CmaAheCot+i25l3nlGAx0mvh2m70CayfC54sda6VrTgconnYKOBUNjmNJAP0rD
         GDOd9X+BRuxowSqWKJyguX0K06tF9lSQ6TnKQBrEQjpDXLEGW+X49Pkf3fs11EiTJp0p
         Y81n6s/m01QR4o9XSdFtX26Uf5J6c4SuvuWvsXYxAN1dL+7dbgrFMWzozIwMV09rYg0X
         6QNCF2hbOPjVGwZXCX+BPLTKuv+XEv3TWIY3Eh54bKYJ97OMb9p3PX1eR2aNZfg04NH8
         tXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KRTpCYk3ZpgRgMJEbk91V+GgCIV1pfhGOWnDidwoEF0=;
        b=YarznoJN2PwKYWJDtg5U86RRnjaufCuyUO50DDDykkEVVpSI5rzyJX6aMiXPv/ZVEU
         y0ns0UoBsgDvyz3hil++4yvSEG9HJgmOGoy/M3ZBIVXhrewcBBbd953SY6OGoHzlWTFU
         F+ft2N1yWJwUBnzl1NuE+IoAbXhw3+IxWPuT/lCwbYSrWUL9UtoEdphVrCcXOup3Zi3q
         8JkRAXoVXvsCkz863uLXpgzj/McXKTaYBODZfzXN2ToZ/xK7IpH+jf1TAXKNQBVKGW2Y
         3RlLTwdPv1gNXDkjPo91+Dkki2EbKH7/4kMmgu3VLLTbBWHYZSeNZms6iisG4neH472E
         XHBA==
X-Gm-Message-State: APjAAAWtyPIbtEZzKOHlaliJCRFc8sQQVQsJLMeiudi51HyLNvvntRaD
        YEMEItYFBPiH46d7MjJAB2RqePZj2iBVLQLc98teHaKMg71j9cLEJFq+UxdVt/tRonXhAyZ+X+M
        nPC+zdl/ML/j0+TWkGAlIMMPL2mB1
X-Received: by 2002:a6b:7701:: with SMTP id n1mr21787748iom.143.1552494563104;
        Wed, 13 Mar 2019 09:29:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy34vhNZUrFcrODe/juOs8SukJIH0AZA3K3Lgw7obGkM0gIA/ObTlYCWUROW0KlNvWPdg4UsA==
X-Received: by 2002:a6b:7701:: with SMTP id n1mr21787737iom.143.1552494562890;
        Wed, 13 Mar 2019 09:29:22 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 143sm264710itw.43.2019.03.13.09.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 09:29:22 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: Fix potential NULL pointer dereference
Date:   Wed, 13 Mar 2019 11:29:12 -0500
Message-Id: <20190313162914.20727-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb allocated via dev_alloc_skb can fail and return a NULL pointer.
This patch avoids such a scenario and returns, consistent with other
invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
index f061dd1382aa..8fab9c8d1dd0 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -743,6 +743,9 @@ void rtl8822be_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		      u1_rsvd_page_loc, 3);
 
 	skb = dev_alloc_skb(totalpacketlen);
+	if (!skb)
+		return;
+
 	memcpy((u8 *)skb_put(skb, totalpacketlen), &reserved_page_packet,
 	       totalpacketlen);
 
-- 
2.17.1

