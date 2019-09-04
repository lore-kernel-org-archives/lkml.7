Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBB0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D665206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620698;
	bh=6rtzguU+R9DHSfKFXDoJlFIzfSRNTmxvxakzRZsu3xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FvSRvO8X/U0RPV+xAvdXv60XAdzKePq6ZsukcdheWCJZ6GEkqwhEks2WUbNjV7cbr
	 cdMZwBIdBByk6PTdSX4AuRQwegngaIv7L+bfdaym+6+a4zZunSjDFRhY+tLYmZt8XB
	 N8ECCvsr6BaBI+mOZqu7g2PRMlHnU8lr+qMOP86k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfIDSLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390297AbfIDSLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA412208E4;
        Wed,  4 Sep 2019 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620694;
        bh=6rtzguU+R9DHSfKFXDoJlFIzfSRNTmxvxakzRZsu3xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmQnNwzIkdYiOh9xHHO3HRKnLgQKhPG7ExOkcFTHwuvVj+LIS2XDj706ukSvdvsIJ
         FxVXFa4LOPMixpfTXo9yJ78HSvwLHm4AZrIwSLN00/tO7fzjGw1lgQ63nDtbk1S0Xw
         YbNDdFMqK9wQb3G04DgspV0l9g1aIlEjbYxWM14w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 019/143] auxdisplay: panel: need to delete scan_timer when misc_register fails in panel_attach
Date:   Wed,  4 Sep 2019 19:52:42 +0200
Message-Id: <20190904175314.826965196@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b33d567560c1aadf3033290d74d4fd67af47aa61 ]

In panel_attach, if misc_register fails, we need to delete scan_timer,
which was setup in keypad_init->init_scan_timer.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/auxdisplay/panel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index e06de63497cf8..e6bd727da503a 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1617,6 +1617,8 @@ static void panel_attach(struct parport *port)
 	return;
 
 err_lcd_unreg:
+	if (scan_timer.function)
+		del_timer_sync(&scan_timer);
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
-- 
2.20.1



