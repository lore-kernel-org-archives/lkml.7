Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5745C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07BC213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="InszUE3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCRXhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:37:42 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56048 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCRXhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:37:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id C405C9B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DZRTeFFIUY-q for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 18:37:40 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 951AEA57
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:37:40 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id b16so10697576iot.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hvaDOjczP2tHJR7iHoTrMBVqF/jk1BbRhfkP/xYyhpk=;
        b=InszUE3eMG9KncrTEvwHus8HEHLwffbWywS9fcIfyzigVnqenD9xipoPx4Y+kJNIgB
         +COYwwaNYeF4ofL10LvsnHO3+ivCNmM81bzYL7/voS2b0lsO2QfFraP0Ti/jbsaQV5iQ
         A1xF42NI9awG8Bd/jOJVCyncNduslHJJaguQWm+8N5nsiKIdLJbtvyG137Howgeh8I4j
         enO5tFTvKW6P2xyHSz8S9/9P5KCzL+H1jN0MuKpTeuFi5kzCrneIfE5dsTAOih/zaHjo
         N+cnJvi82fai34TVGLK33KRhuFnIzR3jhEqu+7nk5p0aTO7yLpnygbbWr4cjy2QdFPGK
         N/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hvaDOjczP2tHJR7iHoTrMBVqF/jk1BbRhfkP/xYyhpk=;
        b=n3iAEAf3SBdyyfhOWmeSJpq/CHz4xcVco3+WN4UnqafjoUe3RGtVGSk+xXZJ05iZba
         9/nlRi30TsSF8cmT/67dLwJwdpHKAZWGBjwpsF1i3aYW2LqbmFMf5Fir74DsdOm+sw0a
         e12+W6vHciVnjpG6NN+zzmnNWq810xaj+2NLgf5GShcti8I9DtzmN/iplHIe0091opy+
         RpG2/wOomKIIsr+/GfRBGMiP6glscmTCfsS7GtGbX9b4Alf9gWf7wwtwc6IT129BgoiA
         FkA/6o0aMTlzF/YIu9iA81guaotSvNVBKzM9pme4l/nWgskJGcnwbnBQRvF/IZ4C3e9S
         uu4w==
X-Gm-Message-State: APjAAAXU23WfFo+Cu6wtkH5p7N0E9VL4qAcrtsV1MwqyLuo4r36u1IFW
        HvwHPxkE5u8Iustg3U1BfeaCC6N54y/WooxcpGi4Ju1IvqgS+wbxofn2hsqTuHGLXfGeOHe4xdT
        AR5tIcRL2SmQZGeE05yA2QBjdoiDQ
X-Received: by 2002:a02:6206:: with SMTP id d6mr13418332jac.84.1552952260270;
        Mon, 18 Mar 2019 16:37:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmIUfGLwQfLoHNZinT/FegiBPPbmUDCWvz2HhE/kyuqN+nHe5tkwREPmSuCIB0Y8/Ra9pZow==
X-Received: by 2002:a02:6206:: with SMTP id d6mr13418320jac.84.1552952260096;
        Mon, 18 Mar 2019 16:37:40 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id 202sm673429itl.1.2019.03.18.16.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 16:37:39 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: berlin: as370: Fix to avoid NULL pointer dereference
Date:   Mon, 18 Mar 2019 18:37:27 -0500
Message-Id: <20190318233734.9991-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device in as370_pinctrl_probe can return a NULL value
when the matching device is not found. The patch avoids a potential
dereference in such scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/pinctrl/berlin/pinctrl-as370.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/berlin/pinctrl-as370.c b/drivers/pinctrl/berlin/pinctrl-as370.c
index 44f8ccdbeeff..78bb5b866c99 100644
--- a/drivers/pinctrl/berlin/pinctrl-as370.c
+++ b/drivers/pinctrl/berlin/pinctrl-as370.c
@@ -337,6 +337,8 @@ static int as370_pinctrl_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 
+	if (!match)
+		return -ENODEV;
 	rmconfig = devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERNEL);
 	if (!rmconfig)
 		return -ENOMEM;
-- 
2.17.1

