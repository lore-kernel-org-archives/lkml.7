Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F25C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266842084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889280;
	bh=XlB3EbayOSrDJPAc7mG/skmWI+reBdAXbZrxQX47lPc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=c5C7H3mAcy0ZbG71hVhBAE32pxQWtSxKPfZ+KF/XD0yT5KjYR7BfO2sYbeuzJX6rJ
	 A8Pe+oadiseaWhpPwr1dV1Ol9fxOnVtqjn8P3mzZCuK2cYuWuzg9FAPH/mZdTMwlKM
	 SbFvtovmK8aTtbcxBMSdBTqx35JjPxaTJDADcqUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfHOROj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:39 -0400
Received: from mail-wm1-f99.google.com ([209.85.128.99]:50344 "EHLO
        mail-wm1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731784AbfHOROg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:36 -0400
Received: by mail-wm1-f99.google.com with SMTP id v15so1882697wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=gE06bHYUuZ3QYmVI3yQvlrzHi0/sRfjaZGC6+azO7fM=;
        b=KGezymgVibZPJA9h9lnkvRX6FXinDYdsFg73ExOmV+cR+0eX4SO2ghL/g7YWXOb9wM
         CUfLte4aR7YYimv7+Xq/8ycyYJj+Fn/vXm5QSqQyRZ+rAD42Z4hC+/bULByj4zvHB8ez
         6aVpriJzvXwOTk61Eyfis2lwcpGJOI2iNVuidY14dI4drrNb8cH09P4GRzod/9B6sGVG
         rkJsN111CM0ns2Zlmr/q+ECmt/34OgdhWgSFlzpROkLrw6nTWMQ0o7gfw2vQkEpyOYex
         XxqeZh39YYG19HTni1K+JiBD462+6bN6feio5Pv+lL7+RytDhxtvzeemJ0+CuqP08ozb
         IL4g==
X-Gm-Message-State: APjAAAUnKDlNRtpVLN/kltK3FznRWjOKjUWu06uLZBANVcnMK3W1cxN5
        pOfMA7nfC3B7xeiR2wj5nOvDFRKzVw7K6O7vq14nTZTYzMk7gM34E5m66eHQ1w9bhg==
X-Google-Smtp-Source: APXvYqx8H4C2nURJML4ac5xRNzSLHJnRxhU9cISiLhVP/yaYThltxH7sBXT+ks64GHr0RxGbY54V/Qu1F5xE
X-Received: by 2002:a05:600c:2411:: with SMTP id 17mr3424992wmp.171.1565889275152;
        Thu, 15 Aug 2019 10:14:35 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id e9sm57426wre.37.2019.08.15.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:35 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKc-00052p-TE; Thu, 15 Aug 2019 17:14:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4C4D62742BC7; Thu, 15 Aug 2019 18:14:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Add label to collate of_node_put() statements" to the regulator tree
In-Reply-To: <20190815053704.32156-1-nishkadg.linux@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171434.4C4D62742BC7@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Add label to collate of_node_put() statements

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 81eeb0a35c2e40bcaf122c6aae3be4f7d9abe201 Mon Sep 17 00:00:00 2001
From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Date: Thu, 15 Aug 2019 11:07:04 +0530
Subject: [PATCH] regulator: core: Add label to collate of_node_put()
 statements

In function of_get_child_regulator(), the loop for_each_child_of_node()
contains two mid-loop return statements, each preceded by a statement
putting child. In order to reduce this repetition, create a new label,
err_node_put, that puts child and then returns the required value;
edit the mid-loop return blocks to instead go to this new label.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
Link: https://lore.kernel.org/r/20190815053704.32156-1-nishkadg.linux@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7a5d52948703..4a27a46ec6e7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -380,16 +380,17 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 
 		if (!regnode) {
 			regnode = of_get_child_regulator(child, prop_name);
-			if (regnode) {
-				of_node_put(child);
-				return regnode;
-			}
+			if (regnode)
+				goto err_node_put;
 		} else {
-			of_node_put(child);
-			return regnode;
+			goto err_node_put;
 		}
 	}
 	return NULL;
+
+err_node_put:
+	of_node_put(child);
+	return regnode;
 }
 
 /**
-- 
2.20.1

