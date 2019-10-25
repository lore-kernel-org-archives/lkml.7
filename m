Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6379CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8881E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJiUcCuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfJYAX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 20:23:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45004 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJYAXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:23:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4so596462lja.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 17:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UTBBbjjGhkUzYjni38iAVJDDOSqBGYBLzDuPmm8drc=;
        b=ZJiUcCuNRuN8x8hLUgarA1Fyi0mRTD6RD7k+zNz1cGflSwKyrWUXKnVacmRvGgZkeg
         sqntB/xY9lCmxuqLkoNxQ2RmupuveXw28T6bl9ID6OoNwiEAH0cNoIz+9UEraLDj4/q9
         UEO/sPGiHcJavHzuXJsnbt/fHHaRW1hp3cqDW83kZNKH4iJe70VvGN/MNaWQcXGP+gVs
         LRhBEDEMIYUBPygWIBPXHJw/86aLKC8dBZ8EppkJg8nYaAGw4BC5uo6lNUMYuHViQPHY
         dz6TBJRZItkvn3Fsc9hmXfO7gJRiOlu3FFjzWpNQWHi5hnCrKBQVtK76X/SJWkv0Ryiu
         /1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UTBBbjjGhkUzYjni38iAVJDDOSqBGYBLzDuPmm8drc=;
        b=gEpu3IArTU2QN+fSEINadMSmm39Z7a9RzLsbh6BecOrqlbjZrLkcOK09JddUf97h0h
         XBvvqKtu8pzlRDGq4chS0KWluPsN9vL4DWlI887nDXxwAsc6PoXDuWPv3/YfIIRBEdfG
         c3o6wK0te5YMAKGhip/JFKRo/YPcSBGUUKWmQpCRL+7+7zp4gZiZrF+Zvrus/lLhjNGa
         XeidSLdjE1AuywjVIk558gfsvj1qwVO55Z9S0sUEuQqir2h/633rsURd3go96dm97SzU
         45ZfmcFSrCjnK4KnkCW2jrRKtFiXBfxrwd5wqoSxOCPZDENfQRxpzTyYvJfIYKP1HzaI
         2ZAw==
X-Gm-Message-State: APjAAAWSBjIbNhiOJTGfPssO3owZjj6vtMQ8tnWL6pdFwluwzcwSvTgV
        NAJkgEvvlgSLQMO9WlYDRecYKQsT
X-Google-Smtp-Source: APXvYqxPl5TUa9Y1CyQEAk0R97M26BdDAK5TG446KFkGkJTPAPbVQsL8y1LTpi1LR90REcebd8963g==
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr285831ljj.52.1571963033747;
        Thu, 24 Oct 2019 17:23:53 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id p18sm78949lfh.24.2019.10.24.17.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 17:23:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] regulator: core: Allow generic coupling only for always-on regulators
Date:   Fri, 25 Oct 2019 03:22:40 +0300
Message-Id: <20191025002240.25288-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025002240.25288-1-digetx@gmail.com>
References: <20191025002240.25288-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic voltage balancer doesn't work correctly if one of regulator
couples turns off. Currently there are no users in kernel for that case,
although let's explicitly show that this case is unsupported for those who
will try to use that feature.

Link: https://lore.kernel.org/linux-samsung-soc/20191008170503.yd6GscYPLxjgrXqDuCO7AJc6i6egNZGJkVWHLlCxvA4@z/
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 51ce280c1ce1..970905124382 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4963,6 +4963,12 @@ static int generic_coupler_attach(struct regulator_coupler *coupler,
 		return -EPERM;
 	}
 
+	if (!rdev->constraints->always_on) {
+		rdev_err(rdev,
+			 "Coupling of a non always-on regulator is unimplemented\n");
+		return -ENOTSUPP;
+	}
+
 	return 0;
 }
 
-- 
2.23.0

