Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C83EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F5E206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSAgw7gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfCHTrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:47:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33200 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfCHTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:47:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so22580580qtz.0;
        Fri, 08 Mar 2019 11:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RrEnffFHlOD8ovUk228i30cx429UY6FjxAK/KSGO/hk=;
        b=cSAgw7gkCCwz21cKMyBbT6sKKKpZwA8Ju/AeHRPRoaBYC7UhizTBeYwXLETDbScOlt
         zfHnUYLSXxKyouhGhFVXnAFTGHB0h6HNojpEdTecogIJ787e5X2T4MbRaXbsXrKlpZwV
         SkWFB5SaS3pFIzRkdqjvjKQR6kxMkh5H3FxYbYZFhuBloiKdF90Y2Zzp7dwCptQ+CDxY
         0qmc4WVuWomKiHoeKXEj1qFNjhPpc8ttNsw3ojvy5vzDj8xtQlCSyK1jGOO4P2QQhVtc
         1XfCHjhpQB4wf4PRUNPDVWk4oOkl/Z+VdDUdV9EI6rr0Ej9Wd46+Bhensg3K7LjKKuvQ
         kZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RrEnffFHlOD8ovUk228i30cx429UY6FjxAK/KSGO/hk=;
        b=LRBV85akN48hZQcjeNZx4nLa/ihaHvZWuQhrP928XyKak88PWoJueWfWPU9XS8AH8b
         r1/+QWhNI2b7zuh6x/UECi08S6K4pf3xM1X+P5AVJvJpKSQI/KtSaHHC8b045/f7Rk6x
         Cys9U+qhSPhQbiy9wqykUowqr4ygo9+EHntypOmGp2GtDuZU0I/za9PwA0ozvauXwMm/
         wIlnN0J+DDXBiB0zl9FrqZQPp35vrbqurtchLB66LXmYQLaDP4D2gOYQOLMXcji2V6vk
         U3agoSVQLcE0bHPE62IMSsW3h4W76elwQ5OuE8j6fsGMFjgVOY5iupjlxHSieuOCUsN0
         8OTA==
X-Gm-Message-State: APjAAAWsgH2dytV92WrXjqkBdoAbcF8bUGMS5nKD7k2ii4h6Y8bzqmTH
        B8K2SFcpeOW/Pnbxyj4su80=
X-Google-Smtp-Source: APXvYqxXRO54DIoDjTs7SHBRMb9v7T5ktd4ozhmpf8eak+y0mKmwIE2DRz+BSqn4vajm2fVJCYw9Ag==
X-Received: by 2002:ac8:37f6:: with SMTP id e51mr15910001qtc.1.1552074473449;
        Fri, 08 Mar 2019 11:47:53 -0800 (PST)
Received: from crypto.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n27sm2393038qtf.11.2019.03.08.11.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 11:47:52 -0800 (PST)
From:   Anderson Reis <andersonreisrosa@gmail.com>
X-Google-Original-From: Anderson Reis <anderson.reis.rosa@usp.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, matt.ranostay@konsulko.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <anderson.reis.rosa@usp.com>,
        Lucas Oshiro <lucasseikioshiro@gmail.com>,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH v2 3/4] iio:potentiostat:lmp91000: invert if statement
Date:   Fri,  8 Mar 2019 16:46:54 -0300
Message-Id: <20190308194655.5983-4-anderson.reis.rosa@usp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert if statement arms in line 214, in order to make the code cleaner,
solve these checkpatch.pl CHECKs:

- lmp9100.c:214: CHECK: braces {} should be used on all arms of this statement
- lmp9100.c:216: CHECK: Unbalanced braces around else statement

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index c45cfb632649..1de17924e154 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -211,12 +211,11 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 
 	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
 	if (ret) {
-		if (of_property_read_bool(np, "ti,external-tia-resistor"))
-			val = 0;
-		else {
+		if (!of_property_read_bool(np, "ti,external-tia-resistor"))
 			dev_err(dev, "no ti,tia-gain-ohm defined");
 			return ret;
 		}
+		val = 0;
 	}
 
 	ret = -EINVAL;
-- 
2.20.1

