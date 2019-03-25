Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF91820848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nVh/cjdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfCYVTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:19:39 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:49778 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:19:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 5A7E6A10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 197UYdG60DyB for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 16:19:38 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 33B02A5F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:19:38 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id e126so8500057ioa.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J6biI5CWesOY8HXsvli3xRMKXx0roTLCrgzCpmehAC8=;
        b=nVh/cjdHr3/Q1IqytfmfP6tjMm3aqM3ZuWYp3tw4QNCCDiAohoUxOotgfds2JoTdbp
         zhuYLCZMEYG4BqYdnHPa/FT/BCmFA/MllT2gJC0UoRz+dnxt+z+qNObhu0FhwADTir7I
         bRn5YKXksAVtcf7PcA5Eyfvl0/QRewK7HHXUAEQ4LF6An057wmFx4J9j4mQT8rVrMoO9
         lGapYL7wfCu7qhBRywXhKGOxkqBIyC3FXt4UAC/VVjFgdelIlVk//zJM/YflMF3/DDEz
         Bg9dlw+gdNqWVcqGt4JZzZE+TMVurabs5KRlUL9Y0fnpwLKScHxa9dEkBM5CCZxoTNGg
         MOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J6biI5CWesOY8HXsvli3xRMKXx0roTLCrgzCpmehAC8=;
        b=lRxk7nlrkxGTp3ji3rHKPNqpCkGARV4qKC5VMMt30sb+Fwj6VHri7JYZf9TyiCHfsB
         IFDBY5PZT8/vOYaEO6VDeYG8wSTXd2TM/AcaqS1siFf0sRvP1GdyA4dTSVi4LMsD8ccL
         sf233MmwTv4p5gyZpnswmj6k+zr5jDhFtnI8TvBZXxvS0cGp8K4NJJV82DTeVu64wPES
         LQlZZJg7+SBS//f79+vAwJd0t9ebtTujBQoSZjjv1JCPV3NvhRBFs7APACtOc9Fq4eaI
         vM6g2JpCcI8CMYbkQCd/SVMT1VaYjkPXWmwTIs6Dppmqm0Bcu0aJBHJpIN8smLqx3L+o
         Hrog==
X-Gm-Message-State: APjAAAWLKygdbA6vbTTixGy4UTnnYiILz1fE5K11uETFYtOVPaDIAejK
        xoeJFrjYrG2Mmy16D8VSSdxClPlQdG1Sjap4futF7I1Z06C++U8Toa+/UMaQmT4bj6vdqrKS9Zj
        GyHAi2TANLZPdHhEmcERFguHUUrNe
X-Received: by 2002:a24:9fc7:: with SMTP id c190mr839814ite.61.1553548777820;
        Mon, 25 Mar 2019 14:19:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwaMzs1gM7XVNk5sofyqjXav/CJWOHc2dmB0H77nn2OLD1Ufgfy9u5w2DIXpc5tHiwS8J2stw==
X-Received: by 2002:a24:9fc7:: with SMTP id c190mr839796ite.61.1553548777621;
        Mon, 25 Mar 2019 14:19:37 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id q1sm6173398itb.22.2019.03.25.14.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:19:36 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sound: codecs: fix a potential NULL pointer dereference
Date:   Mon, 25 Mar 2019 16:19:30 -0500
Message-Id: <20190325211930.18730-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <4fa0e2cb-7044-12e1-33b3-14015c94e48d@codeaurora.org>
References: <4fa0e2cb-7044-12e1-33b3-14015c94e48d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case devm_kzalloc fails, the patch returns -ENOMEM to avoid
potential NULL pointer dereference.

Also add a check for rt5663_parse_dp to pass the error code
upstream

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
v2: pass error code upstream in the caller as suggested by
Mukesh Ojha <mojha@codeaurora.org>
---
 sound/soc/codecs/rt5663.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index da6647015708..ab03ba499ad2 100644
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
@@ -3507,8 +3509,11 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5663->pdata = *pdata;
-	else
-		rt5663_parse_dp(rt5663, &i2c->dev);
+	else {
+		ret = rt5663_parse_dp(rt5663, &i2c->dev);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++)
 		rt5663->supplies[i].supply = rt5663_supply_names[i];
-- 
2.17.1

