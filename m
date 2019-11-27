Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F55C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8CE2154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890890;
	bh=MAOsExUO1LX6olohxHbtXv7sXIynRIuvN8sG2DMYCAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yyggu5cIGzXR7G78pxmrAbdaCPI0ljt9TspLSfc+6N/vCXIqq/a5YhdRF6CoWZzEm
	 iaWLGrbSkFZcOI1XfKKV1W8aJUx0RAnSZT3IslVUQcnYMejC7yH03AxcMvpQdWeIpi
	 otfMGjTkzPwzLERLkw4OcFy4nw9bYzVP5N+cT958=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfK0Ulg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbfK0Ula (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:41:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C7B215A4;
        Wed, 27 Nov 2019 20:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887289;
        bh=MAOsExUO1LX6olohxHbtXv7sXIynRIuvN8sG2DMYCAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XG3mT+XdhEJqS5HUEBzgO1F03HT4XORDwDhvyzRLTwlobNxba1vhirnuOh+U7ywrH
         8f4RiIiboHY+oRFIpAQLJgmoWlmmt2qxkE3ZeYQPNp6/HTTCRMmHJZEQmxlqPOaKxb
         9ua+ynfGqYYcYTO6w3JZKQfttm8xKsVkjoCE7l10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 052/151] rtc: s35390a: Change bufs type to u8 in s35390a_init
Date:   Wed, 27 Nov 2019 21:30:35 +0100
Message-Id: <20191127203031.061238898@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit ef0f02fd69a02b50e468a4ddbe33e3d81671e248 ]

Clang warns:

drivers/rtc/rtc-s35390a.c:124:27: warning: implicit conversion from
'int' to 'char' changes value from 192 to -64 [-Wconstant-conversion]
        buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
            ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
1 warning generated.

Update buf to be an unsigned 8-bit integer, which matches the buf member
in struct i2c_msg.

https://github.com/ClangBuiltLinux/linux/issues/145
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-s35390a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 5dab4665ca3bd..3e0eea3aa876d 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -106,7 +106,7 @@ static int s35390a_get_reg(struct s35390a *s35390a, int reg, char *buf, int len)
  */
 static int s35390a_reset(struct s35390a *s35390a, char *status1)
 {
-	char buf;
+	u8 buf;
 	int ret;
 	unsigned initcount = 0;
 
-- 
2.20.1



