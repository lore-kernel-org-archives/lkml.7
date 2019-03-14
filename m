Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091202085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="kmyO8qFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCNGmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:42:11 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:46670 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNGmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:42:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 1CD7DC3E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BmHvyCaDp-Kr for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 01:42:08 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id DC71FC39
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:42:08 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id v125so3731565itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=djczHsp7CBHav0Hh11ppVz3UNxAxa2JmLPeSFnm+Eo0=;
        b=kmyO8qFyE1SjY3hAgU214XoSWSUVUuJ2n01JQgoIQgmEZXZ7rMRBfBBPpwWcyvO2+7
         aNuTUlaeMfM0GNCy+i8PW53dEgjpJBNN5dhIHVyhUvGqb2jOmb7hzlCXGT1xXioXgtu7
         RnaBOcb3fCWKpzBEmxCQMS/yPKk2CfAU4u+D2t1J06uJE3sy1pN2ZFkFGdy5PgMpY8zq
         UkGpugDiA5/I8EyMpqC0UgR5PyK59zThunc2BKLk2QfjuV50ZUmcbpcZPK/mzbKFDG22
         YblhXV5KeRY/Zbuxq7uMDO8HOg4BRA1wjzlj+iUtxm4qQhRC8dfRv5YWk2zaKDGFBFXo
         jE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=djczHsp7CBHav0Hh11ppVz3UNxAxa2JmLPeSFnm+Eo0=;
        b=RhZgnL0gBf3aSBRfBmwumGEP7QWxmB84pD/HnAYUH6iILF3NQStjp4KqLtMZQLp/RR
         1ROL8VrOgpNXadHlP9RtETTZZPzyEd2LXh0w0eZuNos8rt9Yte2NKfqUCgbpsO5z5iQH
         UvVkgGH0+tpRNAKoq2sNWvG5hQRAaaqi2qDievvpHO+UqbOWUUtoN7V9DqO8F0vsowSP
         uMkkVSkdnQkrLJ8atZXNsfdjVQb0CXdKa62Q8ZDrhlLw1lxkoRRyefH9r0VjAlUR4x/W
         HzSExQmz5Q2PAzceITckr9Z+ylH+sWN4hk6qAOHOoiCpVI5hRcaF2k43CywqGY4e75El
         cGrg==
X-Gm-Message-State: APjAAAVuUD/7CA1r39p4hdFCkufaU+ff7frVcBdVPDEE8v3jdQObfxsd
        rCQxkQ5UChtwkW51S1Skq+cmK7A3k9l4JplaD/kP260Gc20XuBasr33mxbbdsZfuhgIeCFg0vBs
        yC8r3pK618tc9fi2NS4AwUtJoON6d
X-Received: by 2002:a5d:9455:: with SMTP id x21mr26922707ior.250.1552545728500;
        Wed, 13 Mar 2019 23:42:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFWKuN/f6S7G/2+tGu7Ix/FMi6al4o5VH9Mwnfc1piVdtuHnK72QxIfLkreCKIJli6pvenZQ==
X-Received: by 2002:a5d:9455:: with SMTP id x21mr26922698ior.250.1552545728284;
        Wed, 13 Mar 2019 23:42:08 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id p4sm6132871ioj.36.2019.03.13.23.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:42:07 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fix NULL pointer dereferences by checking dmaengine_prep_slave_sg
Date:   Thu, 14 Mar 2019 01:42:01 -0500
Message-Id: <20190314064202.14864-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case dmaengine_prep_slave_sg fails, the fix returns to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7b7151ec14c8..3a5f161ce558 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -293,6 +293,8 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
+	if (!desc)
+		return;
 
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
-- 
2.17.1

