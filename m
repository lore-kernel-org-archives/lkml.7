Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30802C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB7520843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749243;
	bh=VGm125cSj3WrIJHOq9rxYEOLOznVR29gy0J1pP3+YTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hi/qDsc4TEK1YmsZDUKq2G13JSp/EwyBnwjME8AQpipSiycKmatV+GZq8BSHRkYMz
	 K5BYC7sKfftugmRxTEWnPhQ5w4/Qp2giL5gJbW6R8L4a2saMK4RYiq/13SviIwQc0C
	 ZOuiNXDAfkbRD33cX+wVN8IwMTdj6mXH/20yMdxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfHNCTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbfHNCTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:19:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1AA7208C2;
        Wed, 14 Aug 2019 02:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749157;
        bh=VGm125cSj3WrIJHOq9rxYEOLOznVR29gy0J1pP3+YTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtClgyPG4Q3I2JoEknBN4a+TLEyILwQjAZbCaZT5hxVZEeO0jF7ig0jmZkUQhJ6MZ
         cbK/GcwqrWDlWJWZgDlppmF/QeUhEbXNWi5O7r9bmbjfqMcI3RLxiGnGSA2zHqoewp
         nCCOy6iD6+5n7teuEQjPKNPyF+Orh2l9UdFBqgKg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Xiayang <xywang.sjtu@sjtu.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 25/44] net/ethernet/qlogic/qed: force the string buffer NULL-terminated
Date:   Tue, 13 Aug 2019 22:18:14 -0400
Message-Id: <20190814021834.16662-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021834.16662-1-sashal@kernel.org>
References: <20190814021834.16662-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>

[ Upstream commit 3690c8c9a8edff0db077a38783112d8fe12a7dd2 ]

strncpy() does not ensure NULL-termination when the input string
size equals to the destination buffer size 30.
The output string is passed to qed_int_deassertion_aeu_bit()
which calls DP_INFO() and relies NULL-termination.

Use strlcpy instead. The other conditional branch above strncpy()
needs no fix as snprintf() ensures NULL-termination.

This issue is identified by a Coccinelle script.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.c b/drivers/net/ethernet/qlogic/qed/qed_int.c
index 7746417130bd7..c5d9f290ec4c7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.c
@@ -939,7 +939,7 @@ static int qed_int_deassertion(struct qed_hwfn  *p_hwfn,
 						snprintf(bit_name, 30,
 							 p_aeu->bit_name, num);
 					else
-						strncpy(bit_name,
+						strlcpy(bit_name,
 							p_aeu->bit_name, 30);
 
 					/* We now need to pass bitmask in its
-- 
2.20.1

