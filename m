Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C3EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C52214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962138;
	bh=P2CYpXye8DbTKR0oyZpsvbw71QAhKzpkdb3FtwsCdnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHXRJq3C7dPFFobxAulLV/xtqH4MEUojLljkaTe9eDHyfVwibLIenRG7f3HDyW1Kn
	 mjhr/UAYNO6wHcHtCEVtCp6sxLkwpFc7V3Rw5YYDYe6vSrxtg+9/+nZVl4IjY0JMY/
	 BmQsvbwZvrRV35FnpJaL+iRrHn32uN42QfgpvA74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfDVTmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbfDVTmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5CD21738;
        Mon, 22 Apr 2019 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962133;
        bh=P2CYpXye8DbTKR0oyZpsvbw71QAhKzpkdb3FtwsCdnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1su6fWCLwRnk+wZOnhwe1G71hi8lH+qxJmN7dFAeJCHmh1iDbtk/NoW8QP+G1aSK4
         LwAL4DuR8Z0+dN65jcihXvXY7WeKYUOyb98Y4W6KxB9YmBx6jHjAFctXjHnir9N7tg
         thyOETKiNd0r4zbG0+Ef+kbwCzAy/iJ7Ck0AbJkI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 08/98] ieee802154: hwsim: propagate genlmsg_reply return code
Date:   Mon, 22 Apr 2019 15:40:35 -0400
Message-Id: <20190422194205.10404-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

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

