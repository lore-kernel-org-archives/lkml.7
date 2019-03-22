Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6065021934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254626;
	bh=+zHUvYCRT1qMaTzo8W1XBGZmnUr4l3xpXLsLa+MJoek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zReIixemTXD00QJsxoYhVPj9G0sM2lHj8XOX0nvOVKmDMRJkynONLJ+/9KCU19Hw2
	 2Sf4YmeBg5Fw3EBjZkKtjb8sWYzYAFCXIgIVFJtPXuoQ1s+hWJGBdajjfh/5biAyOL
	 cjomZbD78uEH6kwzrWCuOb0FiK7fvWK7rZWcCACI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfCVLhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbfCVLgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:36:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E7E21939;
        Fri, 22 Mar 2019 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254615;
        bh=+zHUvYCRT1qMaTzo8W1XBGZmnUr4l3xpXLsLa+MJoek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJaSMqfQRnH3GKbcT2tprrYeyEpBxpgG53QO5Op9Bt9ZfekzSTeFt7sfgEgX3ljn3
         hn0O3qrhgYP11VpKZgKU5MF8ivKaaNu6wQi7gDbT2YGaAXG75ATGDoD1CKBvcXEWre
         yJ1T/fm67EVkLjz2C2SUx0TSuNxiFqXBefq/LE3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 174/230] mac80211_hwsim: propagate genlmsg_reply return code
Date:   Fri, 22 Mar 2019 12:15:12 +0100
Message-Id: <20190322111248.941119996@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 0d1abcfec003..0f582117b0e3 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3002,7 +3002,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, struct genl_info *info)
 			goto out_err;
 		}
 
-		genlmsg_reply(skb, info);
+		res = genlmsg_reply(skb, info);
 		break;
 	}
 
-- 
2.19.1



