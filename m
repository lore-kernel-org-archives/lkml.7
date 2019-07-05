Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC828C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5370218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7ANQjbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfGEJ6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:58:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45914 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfGEJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:58:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so5921672lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3d7DZVDxTF+1P1r04sZgrqNLdKAcaTJiZmOQo0Hf0lo=;
        b=A7ANQjbzgETo8bypTd7CTupdPefiX80rr3iB1lplbcFGJ6Lj/pEend7B5Yar5Obj58
         b9syE3gDdc0YxdFoY7jgQ4YuhUJsSAIMW4t/iN2py89kVd5pmUYKfHiEVbIzJodiEFY9
         REW23yadtF1F9/NphlTSuc9JY4ds7EUyt9t6OgqYh/3aZU+P93J/bZevFJYs9xu+PFov
         Trbk5dYDBDS550f6U/ryk9FiTqppLaFfXAHeHSvpDXaZEMrIf8k0GEZaQiYFKh0bk4cb
         lEwDZ6EN1CZI0y4fr3RkOMzfStU4VYn5NcRXBxW5cxO3GJ0T+nmsEXtC8qmAFITi9D67
         oeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3d7DZVDxTF+1P1r04sZgrqNLdKAcaTJiZmOQo0Hf0lo=;
        b=kk3PZ1Vb8Z7yJ8YVdD1ewY+9hb6/VfIJbwudd7vDZjinuY/BWqjDp1KB5oTYhAIzpD
         rgG5RcVGiv5fb52FVKYglNk1dGann/RBP0gR/kLMw2XxPcIljsxL6bgFHRT5tVGTo60r
         MCWEcLOp5ZHO8U5FHNzE+g60dLRePp/Bd70CEZBryKOYclMjR84XUD8p9R63N9hHstZc
         siJMszAhR+6Uf3UovwVCQfbt0S2DEIiGN/CgyhMt81zGWHWPEunL+r8cwdrViroVA1J9
         sCqOojAbcxPJelqnQqFBOggetxxFiyUNNMQW9AsLQge3bUpthauwyacW4hi1yEczfjW3
         jSpw==
X-Gm-Message-State: APjAAAVnog62Cn05I2ZPrfaYIOA4kLVP/pEPTPhr+4DEJWQW2GGjvnr4
        +9dDM/R2f1CzR22jTHpyg0iBUg==
X-Google-Smtp-Source: APXvYqwjbM7AX8hHIJs5YC6nRjkyBuavTgd0+gyyiJpufgKhogx9bn+W5bDoNQhNintlVXWZmy1smg==
X-Received: by 2002:a19:8c57:: with SMTP id i23mr1531184lfj.192.1562320703024;
        Fri, 05 Jul 2019 02:58:23 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id o24sm1674955ljg.6.2019.07.05.02.58.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:58:22 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist
Date:   Fri,  5 Jul 2019 11:57:18 +0200
Message-Id: <20190705095726.21433-8-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Add qcs404 to cpufreq-dt-platdev blacklist.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 03dc4244ab00..ec6ef996e637 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -123,6 +123,7 @@ static const struct of_device_id blacklist[] __initconst = {
 
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
+	{ .compatible = "qcom,qcs404", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.21.0

