Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E3CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F23D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="QXh2hFWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCLPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:19:23 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:42756 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfCLPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:19:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id E10ED6E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:19:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aIQhHWSPU2fs for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 10:19:21 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id B450353F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:19:21 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id p17so2019264ios.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TDbruUSn2kMZp/MgTUJbLp0m/oWtXeu0QPIZQKwJ2Gk=;
        b=QXh2hFWloaPUDbs0VLAO28oUxqOqQetyiYLXwOfyeS0H86EMcfRTT+12hKC2H5YTeJ
         tCgjgNFfPMDDZnGK5xKITD4KTPl2PIpUvIlgyLVh/b16FxbEYqc29AF0mlpcn3V3BDOi
         2a5d2az/K7H6TweoQ6mIlFOCgRXnTDRmKVvrkKSU9m0oUEPlLkjE8rJHgNy6k28pk+YQ
         IeJCXwM3R5HFF9DOt0YPZjKJZxqk2yYrMjiIuigAXOln+AlEoOxT5prtPnxo86R0aM0J
         Bu35WHjdyy/dUaiCBAnyiYnxfBLJh85UjNSjhoSZY0jRIBX+GUZPIOwqVWVEc/tGcu6F
         9pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TDbruUSn2kMZp/MgTUJbLp0m/oWtXeu0QPIZQKwJ2Gk=;
        b=RU+9tF60kjwTeNhaVsRhqvn0ZyQAkO0LPQA2N7qiW3tm4KgZTJAbrLD8k2/rl6QXzs
         BCaCCDulVeDIbfFFGxw/mirZCeCQIWmi+0/FDfQaKeKiwXN8r7GidVZM2MsAXonsbw0P
         zKl9KxkVe5WIuJTD28HzDmzibve488WDvix0TJ+oKIfd0OYVCOU89INmv3QfQWxV5oWf
         jJcNdfMMm6rMG+0ihG+hj1RSzJT+/nBQuIB0k+t49JmCdt5tTD8rxYQwr5tgMHfmEmkU
         uUhBk88G+1TKYE0pbWobUpHz5KtF+zBCE9IhPyKziq0u06pqC1NyX/N81Y3rj5N3cG5k
         Jr7A==
X-Gm-Message-State: APjAAAXqogBLEYiNWP1EDYfAFX1XRRirYid9FZh/w3ZaGTgBzebuTy+J
        a8BYKPx8tcbCzTnUFmcTSvzHuTDa6Rw6ZdnmafulrDgPJ8V8hdH3NtOf1l0zrcIsnxRiP3Ln3k5
        z9MyhYTmDTM6DVu3ngNi/nW8nQ1Ko
X-Received: by 2002:a5e:dd44:: with SMTP id u4mr1422852iop.44.1552403961354;
        Tue, 12 Mar 2019 08:19:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXSCkBYKmyeXFFp07bTAbszkcRSihTbPavUH9pynngRsRjhnoAvEEMHPPXIexEHMG1h1XNXA==
X-Received: by 2002:a5e:dd44:: with SMTP id u4mr1422838iop.44.1552403961114;
        Tue, 12 Mar 2019 08:19:21 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 136sm387605itu.35.2019.03.12.08.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 08:19:20 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: axp209: Fix NULL pointer dereference after allocation
Date:   Tue, 12 Mar 2019 10:19:10 -0500
Message-Id: <20190312151911.2207-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

axp20x_build_funcs_groups allocates groups via devm_kcalloc and tries to
dereference without checking for NULL. This patch avoids such a
scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/pinctrl/pinctrl-axp209.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index afd0b533c40a..4fcf7262bed9 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -366,6 +366,8 @@ static int axp20x_build_funcs_groups(struct platform_device *pdev)
 		pctl->funcs[i].groups = devm_kcalloc(&pdev->dev,
 						     npins, sizeof(char *),
 						     GFP_KERNEL);
+		if (!pctl->funcs[i].groups)
+			return -ENOMEM;
 		for (pin = 0; pin < npins; pin++)
 			pctl->funcs[i].groups[pin] = pctl->desc->pins[pin].name;
 	}
-- 
2.17.1

