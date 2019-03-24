Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE11C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F0720989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="D6ZrUomk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfCXXMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:12:45 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:55238 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbfCXXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:12:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id B903CA32
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2J_DMkstm9a8 for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 18:12:43 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 842179C8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:12:43 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id r136so7338539ith.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p81W2EYAA1XZwVj8g477yTnZNACSB+CaBpw4yHrp2XE=;
        b=D6ZrUomkVE/EDM3m4y0wfKrLUmpb0ID5z7ZLPt/bxRNtGUS85j0gtfgZfcibc97yRP
         ondZXsdfG/r/N6ZpZZKUCx+3KG82REHC/ms+QqlpZpzti6raRHknMmo2Uh3lDYKhY/Ge
         OZxvfzGduocjR6t6OKyczTkmPYl4BXZ6MthP2U0KHHp31tzIryiBwWbS2R+ln6DA58Mg
         DkASmOfMKEITbVcxYEFnYDj4lg8Tznhz8CuoGMs3X8CPehM/d7sCYIKCa8OpoTci8HyV
         A3zUaqPJgnvUT/gRCOGfsNhlI0eJVP47fcXc+4Oz/obY/qR5VYcOtj+WxJN7dI+ixXIW
         sXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p81W2EYAA1XZwVj8g477yTnZNACSB+CaBpw4yHrp2XE=;
        b=P5oNUgZqcaWPhd3lOOOr5a1RSdXfYTXSnyu5MJZGezogTXKYpm/2XRIeTroeYrQ3JW
         g4kHSczPfi93dAqxLuQtHvVTakhus8IZwpOADINKRRx8xdvOjnNyL7GeiNW/qE1HdSMY
         zKcaSq5J2R8VaJZY/d/Q5tlWGPWsofnxjT8NQFGO3VNw1bliXhTyaOEO6dSuz4g9tF3H
         ZXcBUKGrbzKEkkiZN/XeAdLKHScr05FoeRtXEWscRsE/P/cWFnJW1FqInKRUKvZ2n8vM
         CvB2L1yT4aFgUTyN3d+eX+ZqkvrHIdfO/3STvO16ESNC8A7zn/gIUJa6iAEY+nAClADs
         11Ow==
X-Gm-Message-State: APjAAAWnNXr+ffJqc8o1ujborNOdNsRuVmTQWVpPIYnWkupeyJTHnZl3
        86VzUt/2HMbuvxSFBiihj4sPblJwUidbla5Aa97bGes2+gDCFtSr89KgiNvA6iTSPmE3anRi3nW
        e/zFh/PueGqyEgEHoWvY6CQoSqc1a
X-Received: by 2002:a24:46cc:: with SMTP id j195mr2255808itb.161.1553469163154;
        Sun, 24 Mar 2019 16:12:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwrUTyermKglrW/G2TO0sGfMkMdypG3iMXcjincVHuMKFn0bCJH1IKu4vEA3SoNhZysE9TVmQ==
X-Received: by 2002:a24:46cc:: with SMTP id j195mr2255794itb.161.1553469162949;
        Sun, 24 Mar 2019 16:12:42 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id i23sm6008964ion.40.2019.03.24.16.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 16:12:42 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: codecs: fix a potential NULL pointer dereference
Date:   Sun, 24 Mar 2019 18:12:37 -0500
Message-Id: <20190324231237.2246-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case devm_kzalloc fails, the patch returns -ENOMEM to avoid
potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/soc/codecs/rt5663.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index da6647015708..909ab99a1995 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3480,6 +3480,8 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 		table_size = sizeof(struct impedance_mapping_table) *
 			rt5663->pdata.impedance_sensing_num;
 		rt5663->imp_table = devm_kzalloc(dev, table_size, GFP_KERNEL);
+		if (!rt5663->imp_table)
+			return -ENOMEM;
 		device_property_read_u32_array(dev,
 			"realtek,impedance_sensing_table",
 			(u32 *)rt5663->imp_table, table_size);
-- 
2.17.1

