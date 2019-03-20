Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4217C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAB82184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSfanRc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfCTMmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:42:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44471 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfCTMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:42:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id u9so1737746lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04XwcsfTZ1R0QsHYMFDJsfOYyv8/svDLPPFH2qpFOh0=;
        b=YSfanRc2TSVyk5C12aZBx6feqH4EonczhprKzog/b3Fs/K9wlv0KzGxES2Hd2H3Svv
         by5Cn/EQ7MaKq6BlyTlqiMnUTAIbQI+/mHNlBfgZSyX9JgtKwHsyq9/i1wW65GotkR8C
         Mo2BL77rZDXkxyHwhlZ7rmpykF3w/qOkN0s0RSV8WBVCKHrNO81pRADCVKut+8Ogytqv
         Ri8Ftq7zjSWOrZGBrWA+QvPH+HgR2jIqRHSyc2ar/dJOYAsLJMZUsS0cr0HhLq62oXbR
         pCnZlLlxCd2ImPREh1MrfvIMLYXiNorzPzZPoARqBKwP5RnzAIrYXp6Nt5+SULPS3Mug
         ms4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04XwcsfTZ1R0QsHYMFDJsfOYyv8/svDLPPFH2qpFOh0=;
        b=hjPDothoKqlGkImldCxO6mWpFVmm9hziyg32WaI8oMsoBafiwo2eH8TM3ugbD5HMbl
         KcrhaZuLAJOgpLwSciN87P48saEWpdfw7WObqcB9vpvIiuYNM7BSmSr/0QKqUFzEZ2kT
         lpq3oI8+njv0+yxaPKGaRdg6qVjLpfJUXvKewV/kzT+dHpVtRhlvHmfDZC6nLtUURJfL
         tYxfGVeJ85324t2OWSNci4pDgJ8JigPVGIwh1KqWrLLkXyvutxHk8bjuyU5uw469qVzm
         JIk+3cnTyPyq+lPv7yPYHP0MGoI810LlDtcewZH1QyI/7qx8vTKwGU1Nv0Jcu0lHtpGC
         gZNQ==
X-Gm-Message-State: APjAAAUI9QoFKYalVTkxAX3UaNtF0zyCyEB6wmRSGCiPNJ6FIX0ol7eh
        AjAlMxoS+XJVbCH1K/qkwPo=
X-Google-Smtp-Source: APXvYqzjL5KexikbhU1D+bElXWp0TtkKZiOpjTV7cqo1Y0BTzVqhc72EPxNYWg1SbNBvMzu76YNAXQ==
X-Received: by 2002:a19:a40b:: with SMTP id q11mr16159371lfc.33.1553085768910;
        Wed, 20 Mar 2019 05:42:48 -0700 (PDT)
Received: from alpha ([178.71.210.108])
        by smtp.gmail.com with ESMTPSA id q22sm322746ljc.59.2019.03.20.05.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 05:42:48 -0700 (PDT)
Received: (nullmailer pid 15795 invoked by uid 1000);
        Wed, 20 Mar 2019 12:45:23 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bhagyashri Dighole <digholebhagyashri@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Wentao Cai <etsai042@gmail.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: netlogic: replace skb_put/pull pair with skb_reserve
Date:   Wed, 20 Mar 2019 15:45:19 +0300
Message-Id: <20190320124519.15751-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sequence

    skb_put(skb);
    skb_pull(skb);

leads to the same result as

    skb_reserve(skb);

but second is a little shorter and clearer.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/netlogic/xlr_net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index 10f14a5cf490..1897b711d66d 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -87,8 +87,7 @@ static inline unsigned char *xlr_alloc_skb(void)
 	if (!skb)
 		return NULL;
 	skb_data = skb->data;
-	skb_put(skb, MAC_SKB_BACK_PTR_SIZE);
-	skb_pull(skb, MAC_SKB_BACK_PTR_SIZE);
+	skb_reserve(skb, MAC_SKB_BACK_PTR_SIZE);
 	memcpy(skb_data, &skb, buf_len);
 
 	return skb->data;
-- 
2.19.2

