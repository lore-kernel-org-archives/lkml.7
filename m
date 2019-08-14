Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D262BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A805A2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750142;
	bh=vvz3aWMk50EHAH8sSwBbk24YETRqG1RoH/Mhp7Jmt+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PErqnZ2ujtIG0X5lzPU6VnPzbwW6VgvQAN3gID9sT+RFPUuLKXxnbPKOeldkvB20i
	 M7d4R1pDJOr5H+CRqhgn1IBsOVKr/ifbY82+PgM1Rjw289ZlOp+PCRSnzYZGm5etuV
	 FhKLAI1WPr9hk3nr7oXavcTG6fqg6vSVih93x1YE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfHNCfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfHNCN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:13:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507B320874;
        Wed, 14 Aug 2019 02:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748807;
        bh=vvz3aWMk50EHAH8sSwBbk24YETRqG1RoH/Mhp7Jmt+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YecRtSKzJLEv6t24usBuLgu0ixRsgiWCKp+uYUMK5PeC0rqDHwjYy4T2reDOyRHBx
         0veu6lEuea6/z2i48MHy+TTx0BaDjjFnhsr6LISqgKNO3iWkEyzYiC4+D+o5o8u/BH
         N7j0tR8bv0gsUJMVMRH/cYjqi0ZB+wfo/FozY+aE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        syzbot+3499a83b2d062ae409d4@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 073/123] net: usb: pegasus: fix improper read if get_registers() fail
Date:   Tue, 13 Aug 2019 22:09:57 -0400
Message-Id: <20190814021047.14828-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kirjanov <kda@linux-powerpc.org>

[ Upstream commit 224c04973db1125fcebefffd86115f99f50f8277 ]

get_registers() may fail with -ENOMEM and in this
case we can read a garbage from the status variable tmp.

Reported-by: syzbot+3499a83b2d062ae409d4@syzkaller.appspotmail.com
Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/pegasus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 6d25dea5ad4b2..f7d117d80cfbb 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -282,7 +282,7 @@ static void mdio_write(struct net_device *dev, int phy_id, int loc, int val)
 static int read_eprom_word(pegasus_t *pegasus, __u8 index, __u16 *retdata)
 {
 	int i;
-	__u8 tmp;
+	__u8 tmp = 0;
 	__le16 retdatai;
 	int ret;
 
-- 
2.20.1

