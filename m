Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8CFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77BA20854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nFNtfzBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCMSml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:42:41 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43602 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfCMSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:42:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 6081A9B8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 18:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NS31F5cy9RvW for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 13:42:39 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3DB39B9E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:42:39 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id y70so2324493itc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8ghsiZfNwLC/j1f+xgqjTbC5IFJtUmxVAyN34aNAvZA=;
        b=nFNtfzBYSEGJx5paxTIeBAd5YBmmR/u4g7BXmj8U2O/gSPrsXt4U9vJtAe2py/nZwL
         b+1x/U+qkcjU+LI5zKE9bmKj4+fNLtvO/7GMTmjkWLkyNop70Cs6Tru/dz19V+LjjqHy
         gDU1LMMxoggxRmPMiFgkHOYzk7iPa3DU0BpWqE1Qq6+X3ZJsMvXPwpGFkvaoxnHbr8Ij
         Acm/EmyfwbxxXaYJn8y16vfQTgdK5ovhfxTu1MFlJqmb/HdTP6nNNk/QdHYcZM9SNckU
         9t9pjfip6n/olwWyt6bOAdkVJNaVO8lb7ZKdHvYVodzYJ6sIsVMXlVo/pF8+uATqErDX
         JAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8ghsiZfNwLC/j1f+xgqjTbC5IFJtUmxVAyN34aNAvZA=;
        b=P/sPaUP9Xv0UQpkdEHebX36IxiIasn0gyfroFTmHiF/lS6Dbbvp0DjMCtgQFak+oHJ
         LW8UeWiRIEsFrx1vBujJFrC3tP5MhkQzkLp0km2nLXh0rmuHBFMFpesQaVGYlOq7RLFc
         HAK6Q6Dk8Le7uS6naNSzBYy0u8wbQHEY/MrFXq8lWUctLMHQ/79dMWstmGHsFhkIn4Ti
         VJ7fJ5WnvKgleUQn/QVANW7FIlRLXZ+XM80DfjHs9p/VsDPQunnPxStOHmg3DYrHgvEI
         +5kBeaSLHaGFLY79vk3FTHHG+G64Mw6Mj9018r9UCn4InGn5rL2NAHjwez2ReJNqb7eg
         IodQ==
X-Gm-Message-State: APjAAAWHOktiesvyGxfFiZ1HTRfgIsc5isGx0zAw2YJoeEIYvsl+fRs9
        CzT3+Uf49Y9zgTSLeF+mwAJVywuxYGaonx4IYfwZG1khEWpD6zxDza1y0PTsytdtNpOKVA8A/lB
        hm1GEnBdnHXJodOUnhxrnoahciL/g
X-Received: by 2002:a24:5c43:: with SMTP id q64mr2673748itb.75.1552502558801;
        Wed, 13 Mar 2019 11:42:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyt9UzYS4kbMOZoPbgo08PkW3VVK+QnvLOMbz3oC2BTWpqMRRwMJkpz/0Qk36jIBBpUHGaylw==
X-Received: by 2002:a24:5c43:: with SMTP id q64mr2673730itb.75.1552502558576;
        Wed, 13 Mar 2019 11:42:38 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id z25sm690067ioh.43.2019.03.13.11.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:42:38 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mwifiex: Fix potential NULL pointer dereference
Date:   Wed, 13 Mar 2019 13:42:29 -0500
Message-Id: <20190313184229.24780-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_alloc_skb can fail and return a NULL pointer. The patch avoids
a potential NULL pointer dereference and returns -ENOMEM.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 60db2b969e20..4e2fa972a78a 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -341,6 +341,9 @@ static int mwifiex_dnld_sleep_confirm_cmd(struct mwifiex_adapter *adapter)
 		sleep_cfm_tmp =
 			dev_alloc_skb(sizeof(struct mwifiex_opt_sleep_confirm)
 				      + MWIFIEX_TYPE_LEN);
+		if (!sleep_cfm_tmp)
+			return -ENOMEM;
+
 		skb_put(sleep_cfm_tmp, sizeof(struct mwifiex_opt_sleep_confirm)
 			+ MWIFIEX_TYPE_LEN);
 		put_unaligned_le32(MWIFIEX_USB_TYPE_CMD, sleep_cfm_tmp->data);
-- 
2.17.1

