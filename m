Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4539CC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B95F2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvqhtXtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfFMVZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:25:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42021 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:25:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so61641plb.9;
        Thu, 13 Jun 2019 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vQy1k6HKb0RegwKa8MFQ1WuwACmhveaQaWhX6DCfZS4=;
        b=AvqhtXtMmkvBNxAYtS1J9rNxc490NsNyZO0Dy82HNp44sE8TJVD4tWLPdCjf8nMMgj
         9Cx6i6Ko1u2LZmrdgW2a/xxRP6JqZKbVT+sGkFhVQCU1K5/Kfc2MJ1dGoSEi2cmhHDmg
         ICaCb7K6MIW7H9ZM1XUMbjG+go5LW7IqQmhP6fR2gPq3SAgDoH6k+oLVlK9R5GXhtfqW
         6bva1YkEz+4Jp/XpnL8mtBNDM17DN3BE6Jiy91Wat4ld8PqN3qkhkseQqBXD/oUCi0rq
         wTtSctDGWsyBh35TrMrrJzQ0+1EYgHO/JG85SPlxYtjG+BOE2QauSe2YYAc5zKf6KWQG
         53YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vQy1k6HKb0RegwKa8MFQ1WuwACmhveaQaWhX6DCfZS4=;
        b=GyB37Px+UiAaOhh4TmvHK2liMAey6jDwHc4qqiUHvHdIFm6V/7E2HpyAH+wz4Ft3RV
         3fSnNMzkai5nSzSf238d0ywbEe+JiFIlCsO04JtETlVX388YD0nH0aKoTdTzbUyXnPEP
         7MRne3Wuiqnoi98+ubFd+/GKzNoSshZ2VBzjVIWeVEIuWbS3+H7b6jlxxG6uM551R1CF
         lO3hojddhsj9OgprUHqn9Od7RqrJT6RT3+ESJYDXOdC7UFexmCKPS621il9Oklxd1LOW
         YOTkzOCohLhhK8TU5AXBnoArasQf+sGL0/4F3V9dOu3ZY/yTtVPBzPWI9Oc5kJa4Om+r
         xWmA==
X-Gm-Message-State: APjAAAVE96+XvEh0kUD12BtwNrV33fHggfqQAlXaO4iZaOjj0XXLC304
        75fesj8DJwnEk9SmQTDeUjc5LVO9
X-Google-Smtp-Source: APXvYqxKm/ZkzPu+FJJw57ToQYD433M2RDVx7eWyafwjEeJQO382l7aKcMtV5hyD0mMbqNNlmos85Q==
X-Received: by 2002:a17:902:7083:: with SMTP id z3mr25270687plk.205.1560461135930;
        Thu, 13 Jun 2019 14:25:35 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id j22sm618471pfh.71.2019.06.13.14.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 14:25:35 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v4 1/7] regulator: qcom_spmi: enable linear range info
Date:   Thu, 13 Jun 2019 14:25:30 -0700
Message-Id: <20190613212531.10452-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613212436.6940-1-jeffrey.l.hugo@gmail.com>
References: <20190613212436.6940-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 53a61fb65642..42c429d50743 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1744,6 +1744,7 @@ MODULE_DEVICE_TABLE(of, qcom_spmi_regulator_match);
 static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 {
 	const struct spmi_regulator_data *reg;
+	const struct spmi_voltage_range *range;
 	const struct of_device_id *match;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -1833,6 +1834,12 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 			}
 		}
 
+		if (vreg->set_points->count == 1) {
+			/* since there is only one range */
+			range = vreg->set_points->range;
+			vreg->desc.uV_step = range->step_uV;
+		}
+
 		config.dev = dev;
 		config.driver_data = vreg;
 		config.regmap = regmap;
-- 
2.17.1

