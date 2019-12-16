Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B3AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E9820665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522193;
	bh=cZRXYZr3dnqdd2ZANv1oCOypDbcNrsP6ksZp+LUmUVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tdKC5HjW7isOx4GMxYRk2t4fkRzpW7yIpt0moQ2wYQDl65iym9LIDltCxF/t/qP5O
	 vYyET4IU2xiwipsIRHg27AdEkvV0cb+A9WMHuZNvCKpSrOQrG/RwQvyjZ9yiFiMCiz
	 DSI3Mc5Io99XiX2kD4a3QwOlxISfM3RQQ19OkAM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLPRw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfLPRw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:52:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995362166E;
        Mon, 16 Dec 2019 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518746;
        bh=cZRXYZr3dnqdd2ZANv1oCOypDbcNrsP6ksZp+LUmUVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5DAQhB1lCE1PQSJBd2cVVWhjrYqF+PDTw0v5GCnxNfLfwvBRt6fZsrSQ03DQme/S
         8cn1byg90qOcY1aLAhKXbF2g4yS3pYInIq5/gaHYmW3SPNS5Pxf/iK90LKzEqIDSwQ
         YAJUkr/vlwIf3sy1JHa+i3TnYmJCKjYkP1iPwke0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cheng-Yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/267] regulator: Fix return value of _set_load() stub
Date:   Mon, 16 Dec 2019 18:46:14 +0100
Message-Id: <20191216174853.876135512@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit f1abf67217de91f5cd3c757ae857632ca565099a ]

The stub implementation of _set_load() returns a mode value which is
within the bounds of valid return codes for success (the documentation
just says that failures are negative error codes) but not sensible or
what the actual implementation does.  Fix it to just return 0.

Reported-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/regulator/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 25602afd48447..f3f76051e8b00 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -508,7 +508,7 @@ static inline int regulator_get_error_flags(struct regulator *regulator,
 
 static inline int regulator_set_load(struct regulator *regulator, int load_uA)
 {
-	return REGULATOR_MODE_NORMAL;
+	return 0;
 }
 
 static inline int regulator_allow_bypass(struct regulator *regulator,
-- 
2.20.1



