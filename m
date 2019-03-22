Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9769D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254874;
	bh=GUe68Aqx89vfTy1vtW5sq0zsyqYNSLgXaP7Da+lzwVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zfS5y6OnUNsKH5XOtjb7EEq/2vkFgDpKxSwoYvbihjR81djXuaFx2jgv0XkZShLXB
	 LhVS5JOT2Fz6jIRk/VCjyozGdZfU9qEw3eadgPN3BVAqZURmEMTeRp0z0/LoYPR6hX
	 zC3bK4x0VbjSBxg3fVDtc+aYcOUNdkQ882DW0Nmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfCVLlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730968AbfCVLlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:41:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D22821917;
        Fri, 22 Mar 2019 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254870;
        bh=GUe68Aqx89vfTy1vtW5sq0zsyqYNSLgXaP7Da+lzwVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkD3SlOsQ7FI0BjJMJ7Y1Sdv+GTQNMtcCDkAgQYrbJQ3XSuBJ4K3Z8UHIt5toYsEq
         uVSyDAyhg2m/LbM9TugRTwfRlGZxDLuevU9j0VU6uXpt3ylpvtdHYy5XJABDI36rei
         1yj4femdhK3GIfCdgrlCYoCmebjJ1uyR7+Dptrik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 036/118] mac80211_hwsim: propagate genlmsg_reply return code
Date:   Fri, 22 Mar 2019 12:15:08 +0100
Message-Id: <20190322111218.742889664@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 17407715240456448e4989bee46ffc93991add83 ]

genlmsg_reply can fail, so propagate its return code

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 780acf23fd19..e9ec1da9935d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3167,7 +3167,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, struct genl_info *info)
 			goto out_err;
 		}
 
-		genlmsg_reply(skb, info);
+		res = genlmsg_reply(skb, info);
 		break;
 	}
 
-- 
2.19.1



