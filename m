Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC23C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBDE222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dD3bgNfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKGURk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36339 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfKGURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so4580323wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmH4Sn1DdXunw1TL7f6sfjm3qJQSjiedEKITkUOQrRc=;
        b=dD3bgNfBay8ldyW/wTKnzuDbWLyYPl9wqdt360DazEyPc+zkaFEvjjAwZyme4xR0of
         YpzlFpdOVt3HEMliEp/pzdVcFPBNpdytncF4Mnrngda/K/Ld7QSO6/a5msBWe6RUpvYx
         jrYL9k5TKCXxTFJDavRz87FW6ZKZetilAcNBwA7eLMXLNa6YdAd3voAmhH6N45aBPCV3
         HkOLWYaR4oOjExVV56NiTL1VfZtLQwCfqXS2BY5KNyADh4EtxQ4spV73b/174e8p66Ke
         kggAjzd1S+7PqyV2pUBZZBeJ1sFY+KSFYMRgV+TnSPU79hEDxckUOpSe3KnWRfUacQya
         mgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmH4Sn1DdXunw1TL7f6sfjm3qJQSjiedEKITkUOQrRc=;
        b=SJC2BOTT0QQ3UDsjIcgCb0Mz8VsEFloDiabiFwui7/2Xpe/73CSLd6DOfUlFvfYk46
         4nxoMIoUv+vwzbdbit5Fo3U59/LAhvZDGX5m4flivZdv6QI38AKqYIxXhE57UgtJjj2c
         wKNG1TieIYcUnRmuC1oRBzyq4XiEzvHmvEY+3ZEqtpzHw1VAIPCtCT0Flc0jMQNpw6ug
         U7VGxLyM9mq9vHBYsHIh/6SQS+kF/Tn5rojZvt8zk7YEY52rdChLLGkL31KT8ZZI+HPq
         gXUfPcbdupAhh6tbhhMY16wrDM0t9GhyjB0QhNC2tt6uyt6+PHtC6UA0724+6Y1cHjDL
         8EPg==
X-Gm-Message-State: APjAAAVsQv34gDMzgRK2F/VHPtvT34tFLVaAGoa7HZyMDYNYtW7UCiPF
        eKgWnix3mTG+9a8quK6Axgy8sA==
X-Google-Smtp-Source: APXvYqzj4L+0U+5qBm9k8ytHroUi7rJ9GvABgTsk0w/eIsHl2OaCQNODEhgAMGDB5z6jZPEoi9l7ww==
X-Received: by 2002:adf:8123:: with SMTP id 32mr5012062wrm.300.1573157829246;
        Thu, 07 Nov 2019 12:17:09 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 04/10] mwifiex: Abort at too short BSS descriptor element
Date:   Thu,  7 Nov 2019 20:16:56 +0000
Message-Id: <20191107201702.27023-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 685c9b7750bfacd6fc1db50d86579980593b7869 ]

Currently mwifiex_update_bss_desc_with_ie() implicitly assumes that
the source descriptor entries contain the enough size for each type
and performs copying without checking the source size.  This may lead
to read over boundary.

Fix this by putting the source size check in appropriate places.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I8812db5f71b733e14573cacb6136e8a1a23036df
---
 drivers/net/wireless/mwifiex/scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mwifiex/scan.c b/drivers/net/wireless/mwifiex/scan.c
index 81a50d8af370..cff755475bc0 100644
--- a/drivers/net/wireless/mwifiex/scan.c
+++ b/drivers/net/wireless/mwifiex/scan.c
@@ -1296,6 +1296,9 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (element_len + 2 < sizeof(vendor_ie->vend_hdr))
+				return -EINVAL;
+
 			vendor_ie = (struct ieee_types_vendor_specific *)
 					current_ptr;
 
-- 
2.24.0

