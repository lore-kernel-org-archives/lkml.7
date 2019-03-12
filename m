Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7475C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Gqigo32J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfCLPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:06:04 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:43720 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfCLPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:06:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id AAEE95D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id raoe5th92Jvi for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 10:06:02 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 7AF1F6E3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:06:02 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id h3so2451385itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PcleQXejzChKs56WfhVs3UACNACnxYGFgyPQZSsblDU=;
        b=Gqigo32JnYq8PVxmnYWjk2nrIh4Dcsljy0jn6VeP21JN/bJu6wnlppwt3/nUqqPfDc
         N+Kc6r+B/LlCDbZ0wpPLEqdlDKFyRnCwlR6yJeKVtAYIEtzPduCbE/8oWKngVihA8zZ0
         MDfFhnTLtopJIjDxvPXIKIv93EIcTr2ZXTFD3YBN5l/LLrkZLsqD3whzn3DQfJSnMjve
         cFaDzG30i6l5V6CYn2Nu211sZM+eiUQgm3sDlUyD+yJddOodVUhkonjoY6XuuQEa4qSE
         j6wFqYTjuDYkgekMbJqGwGdcHw0PBbOzRGO/J3j9uOuEhn1jkca1dX6vV3JZXMuXsRRf
         R5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PcleQXejzChKs56WfhVs3UACNACnxYGFgyPQZSsblDU=;
        b=Zw/MzJf7dPitVkEWSaPTkP1qFPw9ysJhZUr2kgA2P7JV8bZW4stMdXedGgv1dm2E9M
         Q7nqtZrryxcE/yKo8pSJOjA7V3NENe+M1a7qNnRLB4/bC2lZGEjYdi4hEg3XE9cZGn+v
         AZ53MT271jz+DOOqzp8tGBcooQRbj0XSjO3OpAs+7WRfDfmHgKe1CFbAYwnR5MOO8r0l
         dYzemvswvN5YhywZ7nJGlu8GPqC0aQ1SNH0su6NHuNYNdycSxdwMAfwntGdE0drvPMKf
         kUN76rPYYnW3ca0P4lBTqvlqq88P5gmB/1APKle33AQ/PqbK0gswzkYx3q7Fgb04FMyX
         CZ3w==
X-Gm-Message-State: APjAAAUL4gDiKUlg0V9KpVQDJ9rq3n2LDPUs2gDk2LEHMhUOdxcAKfjV
        VsSEQBOJ/dgYaJCXywa2Rl/SkXCzd7rwtWobFfEM/4mp9dzBKCuR4bL/5W2n9Q3br/QJSnpaPqg
        VXpTaBT2jIS7OZmtBUG3OflEM27d0
X-Received: by 2002:a05:660c:88f:: with SMTP id o15mr2448798itk.46.1552403162040;
        Tue, 12 Mar 2019 08:06:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHyiWQQ+00sfSl37gZ0GEzRkquztoTVXRP7JJihhpvQLG4o7hXlEqYHQIaM2sNiLgnuIkbdg==
X-Received: by 2002:a05:660c:88f:: with SMTP id o15mr2448777itk.46.1552403161809;
        Tue, 12 Mar 2019 08:06:01 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id s142sm373742itb.37.2019.03.12.08.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 08:06:01 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: baytrail: Fix potential NULL pointer dereference
Date:   Tue, 12 Mar 2019 10:05:52 -0500
Message-Id: <20190312150552.1429-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

saved-context in byt_gpio_probe is allocated via devm_kcalloc and is
used without checking for NULL in later functions. This patch avoids
such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 241384ead4ed..18d9ad504194 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1710,6 +1710,8 @@ static int byt_gpio_probe(struct byt_gpio *vg)
 #ifdef CONFIG_PM_SLEEP
 	vg->saved_context = devm_kcalloc(&vg->pdev->dev, gc->ngpio,
 				       sizeof(*vg->saved_context), GFP_KERNEL);
+	if (!vg->saved_context)
+		return -ENOMEM;
 #endif
 	ret = devm_gpiochip_add_data(&vg->pdev->dev, gc, vg);
 	if (ret) {
-- 
2.17.1

