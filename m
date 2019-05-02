Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E30BC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E4520B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810950;
	bh=s/AAX1UEWBA673sm0A49Y3i7KR+3WkkM5w339LZRE40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvBZApue6KX/KYsxN8aVIG9z/Y69oveoQQ2+nVFT8pJm5QDCF+EaMiCm386EGv00Z
	 B3SMWiuNyu5rt7TPwemXC/EbuK/pFYAc8ow72xg2qeYs8CYaq+7OpUA8ipMQSSs0xK
	 kShBmc4yUBwmyhchsv0uAVe6bsqV66LHVo5qOJmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfEBP3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfEBP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:29:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B5F20B7C;
        Thu,  2 May 2019 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810940;
        bh=s/AAX1UEWBA673sm0A49Y3i7KR+3WkkM5w339LZRE40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zM9eluby54I41HjWnNh18O49y60nD6Xx17yPFXm0e2TUyWrGk1M+SGPE00NJ4KIEM
         mRRTCLM+xk1Grv0aakBKShNSIiSuIJ/VNO2lRUHRrKobJmB4IcHrjyqq32WwqAVKVQ
         2Da8Hu4iBUDOFPPnR1pWnugAXZZgGxsGEq5dIzEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 015/101] ieee802154: hwsim: propagate genlmsg_reply return code
Date:   Thu,  2 May 2019 17:20:17 +0200
Message-Id: <20190502143341.114195926@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 19b39a25388e71390e059906c979f87be4ef0c71 ]

genlmsg_reply can fail, so propagate its return code

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index b6743f03dce0..3b88846de31b 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -324,7 +324,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, struct genl_info *info)
 			goto out_err;
 		}
 
-		genlmsg_reply(skb, info);
+		res = genlmsg_reply(skb, info);
 		break;
 	}
 
-- 
2.19.1



