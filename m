Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148CC468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FC720820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeMFxewI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbfFJFnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 01:43:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45336 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387505AbfFJFnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 01:43:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so4389089pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 22:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tdl49RyRAuUkhNq/FTEulZjMEnaegQupXQMt+JK5L30=;
        b=VeMFxewIUJvxxRvC5lF6kidVI5+hVSdtFihhzgGSCRPn8g5TfhmedwJd3022CF6Qah
         gZtiUQMWI64nxXBjMUcEkrQkFQWeocMRqnkp3yg4jkdNFiSUebJ/Uh7MQqfn2O/eDIF+
         FpgqWvEeWUOr4jP/t+07pdsP/itDTR9RIFwNawnivPgExCWE5JT2H5XnAlDJsYHlGjEh
         +IVKR5iNOpbjFc7F07tuSUEiLIAo+s/SQnST39LE7fSX6Se3M7X+zb/KcDrYErbO+NNH
         Xv1buvNzy17L+/stjQzpWfZ3udreJMleCrmBZOmXBNHK6T/58w2xVplAi67UUMp2aoNo
         7RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tdl49RyRAuUkhNq/FTEulZjMEnaegQupXQMt+JK5L30=;
        b=bXr1Xlue3uPDwWcaet23xKeR0BeLer8baRzb38KpY6fLC5zC7UuQ/cOQ/5vDNbgQp7
         1mJVAuwqCGqnd8m/8eRWBCU9LlCz98NI2ggKHmI02Gl+oK+H3uRIcVgpIWW4kOI3BdWT
         OnLmU3CV/Gqp67qoUB0pPAgLmLly+Y7FiYiuz7y+mchgehPcl8Hxli2413fV0loyjc4x
         8dNXZGRYPmWY4jSp5lcII2qauq+WujbooYD/mvLLHpM9pjZo4MtnNsVHXS8LLeG/PcLw
         KPlVMIGqOioArFyEeEzczTHaedW7u9Qv0wnlKg6Xrp6rZecsG8Zkv4VHdt4cyScc/20o
         HUTQ==
X-Gm-Message-State: APjAAAW/c26WP1MzN6kuUAfUTTwaDpyXag6klD4H5PbP96LEFuD93mHI
        7VrebyQPqrx+1tEBSLBOWT4=
X-Google-Smtp-Source: APXvYqzMyhyfNohO8DPs/Or4CdV+gQAawW1oBt7DF0bsnylcSwQv/l4KIMqMSTPfYd0q+lwpytrS7A==
X-Received: by 2002:a62:8643:: with SMTP id x64mr37320503pfd.7.1560145411460;
        Sun, 09 Jun 2019 22:43:31 -0700 (PDT)
Received: from hpz4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id c124sm10526760pfa.115.2019.06.09.22.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 22:43:31 -0700 (PDT)
From:   Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
To:     gregkh@linuxfoundation.org, gneukum1@gmail.com, jeremy@azazel.net,
        maowenan@huawei.com
Cc:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: remove extra white space in kpc2000_spi.c
Date:   Mon, 10 Jun 2019 14:43:14 +0900
Message-Id: <20190610054314.102880-1-naoto.kobayashi4c@gmail.com>
X-Mailer: git-send-email 2.16.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since whitespace should not appear between asterisk and
variable name in a declaration statement, remove it and
fix checkpatch.pl error "foo * bar" should be "foo *bar".

Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 28132e9e260d..c3e5c1848f53 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -496,7 +496,7 @@ kp_spi_probe(struct platform_device *pldev)
 	static int
 kp_spi_remove(struct platform_device *pldev)
 {
-	struct spi_master * master = platform_get_drvdata(pldev);
+	struct spi_master *master = platform_get_drvdata(pldev);
 	spi_unregister_master(master);
 	return 0;
 }
--
2.16.5

