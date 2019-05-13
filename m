Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42D2C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74776208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phXvz26i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfEMHer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:34:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35017 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfEMHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:34:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so8535681wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SrKOrxCUTi42whkmh8C32Tg5zmMnBqJytzi0/en5Cy4=;
        b=phXvz26iMBHGz1Fgu8fxkESf2xt31+02S9dZ5N6nuqO/Z0Y4+omR0nsmOJJb0TQkMX
         XhzqVUVjdw1LOZzb3bhk+rNoKc6NsLvMTb0SZmodCPiVXZ/kyQvGD3BPz824PnLdW2pY
         2TqPggNDFxGgZDzL9Ta7pcUmLPYMJsMZ+RjxWucyA14SHUk/4zEeksnBaOicyVK0PIAr
         I1+1aozZH8VkwNb0+EqoRwMuczz59qw1WpZti7AQAaYXyn+PSW4h7shqCVTzOYGlPlzn
         Z0BMtT8P9zQO4uCghRqT4aTP1AFHbIqW1H1E8wf/LQGvH6ncvPYAl1oWChf8y3Zx7MpY
         S5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SrKOrxCUTi42whkmh8C32Tg5zmMnBqJytzi0/en5Cy4=;
        b=kljn+7VvVzS+G337AwozWFOQi7RAuAlCBjObtjsOGGMEAKvd49S5xladTMbfTpeC7C
         6tVytxbLd4PhfUpozH8ZEBts6HnZBaO0JChE6pQnzjuwjfoMhkRbVxQrOna/HWLBXNde
         hb3elyq5GeJi7AT1pdmUV5M7cJet69iASbcqShmdRRD9JsvGP9cwZTbep3a8ma+HBxBf
         kD0lZ6NGDI56NSiNlBQb1IaMSWuzlOL6AqSYNSJbAxD/hlih8U1tGD2JfQMrvYK92NJ/
         ABpzaHWLVge3mqUML58SJ+NlWhMypAwod2oMDIn/wyUE5o1HymDUbI7OFfv9+R6urbb+
         YWmw==
X-Gm-Message-State: APjAAAUGem6dzhNkvvTyaMepyEzikyr3YjI6QgGlElgqVcPImLi58TMo
        mrEgTcSwiJD1ejEyYvk3H0OSrg==
X-Google-Smtp-Source: APXvYqyxFA25Gtez8Oa7moTqe7JIAnTCxZbpNYt+pUAEHYfAL5o0skgCCz8F858El1d+hev5N8CdVw==
X-Received: by 2002:a05:600c:1109:: with SMTP id b9mr14338717wma.77.1557732884212;
        Mon, 13 May 2019 00:34:44 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h14sm1009883wrt.11.2019.05.13.00.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 00:34:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amelie.delaunay@st.com, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/2] pinctrl: stmfx: Fix 'warn: bitwise AND condition is false here'
Date:   Mon, 13 May 2019 08:34:29 +0100
Message-Id: <20190513073429.12023-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513073429.12023-1-lee.jones@linaro.org>
References: <20190513073429.12023-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/pinctrl/pinctrl-stmfx.c:441 stmfx_pinctrl_irq_set_type() warn: bitwise AND condition is false here

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-stmfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 074c8fa3e75c..eba872ce4a7c 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -437,7 +437,7 @@ static int stmfx_pinctrl_irq_set_type(struct irq_data *data, unsigned int type)
 	u32 reg = get_reg(data->hwirq);
 	u32 mask = get_mask(data->hwirq);
 
-	if (type & IRQ_TYPE_NONE)
+	if (type == IRQ_TYPE_NONE)
 		return -EINVAL;
 
 	if (type & IRQ_TYPE_EDGE_BOTH) {
-- 
2.17.1

