Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15CEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C062081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRuKM28t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbfEXISm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:18:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40210 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:18:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so4867879pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MVjgGhmeDVVcsd1Bp0XT3uzjq2j5RVjcC5adv2QpbQ=;
        b=iRuKM28tYfKNZrvip2A5NOWelVL/4eBtb964IsQlQSIxC/7erSXVG83O6CVtGoqz/+
         vBJHdI3/i+9VXVzomdVKI8qa+vg2YULe2U+7m/oukpljX8eu34y4MpEz3MYLuxxU7uhb
         lJtB+dR823Ada50ALi0DAOQdfMAYLi2gdjrq3FYq9X3yf7GIfTdyJn5g2LlTa8Xjcjxa
         u9Q1BULQoqV0wrU2AGe9oLIW0AlCwoRjN6eI+Wg0WD5oqVJVLzDW43GCY9MZ+/Kn5XuY
         XUIYlHu83mJWrQ05/Iga1DctvwXC0OP/5qiUkbUUZqapVnvB7V1Qn8TbFvrzXCRSp0Uu
         vgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MVjgGhmeDVVcsd1Bp0XT3uzjq2j5RVjcC5adv2QpbQ=;
        b=UOf/k4eUueS+1qz55+mY3ugjb+ZzBXTkLC1mmz1hCgN/aNF71Su/eUai04sL5f4syh
         VpW5VCCuk9x5izc3VdZwT3JLCZ1VCSo/ceb5lmYdK6Z05RDJ0/5o15c3Tss5QXd4ZF3V
         TqCr26hNpQzms13+9r3I21wJ2AZN+ZroNJ32+81Fc586y7uvKcwL0Ojx79iV4/pnoI4R
         eodYD5JI0x9x/hrT/zhEgZx1RWTL2dwj+bmdMyTnI6t5IcbbtkBtgjlirIuDVJxFXICy
         domBbGoK4tTXFBcxYoHVzAdaFjBsN6arq1B/jdnFhEdQ6+sMF6HVv9yAX58T7NOql9eI
         jA9g==
X-Gm-Message-State: APjAAAWOKrfwsaBN7gDensFqtQ9c0WCQ+7YjGgFln6JZbXs/MA4TYB7J
        gdnX9FWortQVt85rvzh1iMI=
X-Google-Smtp-Source: APXvYqyIQSkcOIdJYgcmWe/9jjru5iacQQMg57EgrzxY52IaOz0WwUYWgCUYZURSvIOGbqe1zdETYA==
X-Received: by 2002:a62:ab0a:: with SMTP id p10mr11335022pff.143.1558685921271;
        Fri, 24 May 2019 01:18:41 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id e10sm3356478pfm.137.2019.05.24.01.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:18:40 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        herbert@gondor.apana.org.au, qader.aymen@gmail.com,
        sergio.paracuellos@gmail.com, bhanusreemahesh@gmail.com,
        mattmccoy110@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: ks7010: Merge multiple return variables in ks_hostif.c
Date:   Fri, 24 May 2019 13:48:21 +0530
Message-Id: <20190524081821.5671-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hostif_data_request had two return variables, ret and
result. When ret is assigned a value, in all cases (except one) this
assignment is followed immediately by a goto to the end of the
function. In the last case, the goto takes effect only if ret < 0;
however, if ret >= 0 then this value of ret is not needed in the
remainder of that branch. On the other hand result is used (assigned a
value and returned) only in those branches where ret >= 0 or ret has
not been used at all.
As the values of ret and result are not both required at the same point
in any branch, result can be removed and its occurrences replaced with
ret.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 3775fd4b89ae..2666f9e30c15 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1067,7 +1067,6 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	unsigned int length = 0;
 	struct hostif_data_request *pp;
 	unsigned char *p;
-	int result;
 	unsigned short eth_proto;
 	struct ether_hdr *eth_hdr;
 	unsigned short keyinfo = 0;
@@ -1209,8 +1208,8 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	pp->header.event = cpu_to_le16(HIF_DATA_REQ);
 
 	/* tx request */
-	result = ks_wlan_hw_tx(priv, pp, hif_align_size(sizeof(*pp) + skb_len),
-			       send_packet_complete, skb);
+	ret = ks_wlan_hw_tx(priv, pp, hif_align_size(sizeof(*pp) + skb_len),
+			    send_packet_complete, skb);
 
 	/* MIC FAILURE REPORT check */
 	if (eth_proto == ETH_P_PAE &&
@@ -1225,7 +1224,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 			priv->wpa.mic_failure.stop = 1;
 	}
 
-	return result;
+	return ret;
 
 err_kfree:
 	kfree(pp);
-- 
2.19.1

