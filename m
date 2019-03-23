Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27645C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD8D218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WMnfmVvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfCWD5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:57:19 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:38618 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCWD5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:57:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 6CEE7E1C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rXOGTCr9QlMG for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:57:17 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 31578E19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:57:17 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id 9so4033678ita.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pSzJjsTnJ+rvVPvMAXI4CzCBC1u3I5ehw1LY0kNuyYw=;
        b=WMnfmVvUUcklqGVY1voyZ6yjTfrAtmhQHsX8oASmB/F2p/pR0IEqkX7yb9declZOZa
         fBNLKAk/GSPWhOW3uykYgdClZrqMryOhtYTnDGPTaFFVcS/oBKT+nhyuJW/MGVK3V2Rp
         M9q7fQEBhekFIXIfzd48sYngUjl3JyjDT18a3bErgOlzs87UpCXYeEWEpeFkVtzm3Jhm
         0KwL2vP4VZ9beyQ6O0fNupFI1dtEtJor+DwH2P4nENcE0vjZiie1b5Kk0eEtBVz8uONR
         1sVbPROAaNqA2Q94LhYg4uAVZWDaRlHWnQQfLPVAjcJz2iQaEPMygkip2c4ptsuoRkZ6
         7GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pSzJjsTnJ+rvVPvMAXI4CzCBC1u3I5ehw1LY0kNuyYw=;
        b=PqbH5/wrtCkT/LSFutnJze42MwTFOnMGZNTyrHQNbp+eJNyxPGmkVocdRKlx/4b+Pl
         HJdW2Sl88shJqNyOaFDOtcKHPIy6yX0zayTBVdAdrXR7vlDpmzIVX35Md1runk6zGNpA
         8bdPWEU25/WLJwmwREt9P10crbki5PNYJQr2q1lym1vde7vXQJNI7agSP/UIRkMbgww4
         oLLR31fipHa8L9hXmKyafr52fYsmjG5YMoBHIFxHgYohW1wKINPpYNIa/BLLC7caRxb7
         aJRsrvWny+IAMG/MvQaqWbKIDkKqHMcDGD13i12ESFNTmbsndjSfITfjgZSAz5I0D/WN
         KYPA==
X-Gm-Message-State: APjAAAWYZdKAETdZ9JZWrWAJ4kTnUrq6VhafHBLu/9tJxmlhATbbiw9Q
        JgCE6gjQRt9H/xi2Zm76+0gby6oYk+2ju9QzIa6gW54wVLc0vK1mjgTeQDH4NURGg1MShGvLzZc
        j1EQEV4w10g1ZDgurL5Eagnd+NQZL
X-Received: by 2002:a6b:4104:: with SMTP id n4mr9878021ioa.305.1553313436787;
        Fri, 22 Mar 2019 20:57:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUI3unBBOONvUMI9c6AMh44IuN1nAKASV+nQx5otvB1K5XQWjXzxbeJKBi/wa++99yGNNMqQ==
X-Received: by 2002:a6b:4104:: with SMTP id n4mr9878005ioa.305.1553313436571;
        Fri, 22 Mar 2019 20:57:16 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id c1sm2379962itd.23.2019.03.22.20.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:57:15 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: mwifiex: fix a NULL pointer dereference
Date:   Fri, 22 Mar 2019 22:57:11 -0500
Message-Id: <20190323035711.23882-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87zhq04pl0.fsf@codeaurora.org>
References: <87zhq04pl0.fsf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case dev_alloc_skb fails, the fix returns -ENOMEM to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
V2: minor change: simply remove whitespace
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 60db2b969e20..8c35441fd9b7 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -341,6 +341,12 @@ static int mwifiex_dnld_sleep_confirm_cmd(struct mwifiex_adapter *adapter)
 		sleep_cfm_tmp =
 			dev_alloc_skb(sizeof(struct mwifiex_opt_sleep_confirm)
 				      + MWIFIEX_TYPE_LEN);
+		if (!sleep_cfm_tmp) {
+			mwifiex_dbg(adapter, ERROR,
+				    "SLEEP_CFM: dev_alloc_skb failed\n");
+			return -ENOMEM;
+		}
+
 		skb_put(sleep_cfm_tmp, sizeof(struct mwifiex_opt_sleep_confirm)
 			+ MWIFIEX_TYPE_LEN);
 		put_unaligned_le32(MWIFIEX_USB_TYPE_CMD, sleep_cfm_tmp->data);
-- 
2.17.1

