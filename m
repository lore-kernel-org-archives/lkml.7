Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3D6C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991620833
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="iMQQQuPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfERWnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 18:43:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34923 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfERWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 18:43:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so12216832qtk.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eO6mO59GQBmOS/DlZnxdkxlS21xeFUZXbaBYNCMZMIU=;
        b=iMQQQuPNdWSowS10fp7KXUOV7QV+ye+/Y7mbyrwE1CNpcnTqZ93Szn0szcUOu6qGfS
         c31HNJcdPRoLO7kn3rIyHmb00NxIlheW/2It7nOouMH+HO5Munr8g9d8HAMwPDMkpCI4
         /uyZ6cZXCo81Ogh4QNWIbI+if76+zx8AECxsVAE+zWbx+ZVnco/swyc0EB4gSH8yWHR0
         9he7583KcqHFZwQCLCMn8iihXRLVY7S0o65DZV1DFw4/lVY9VNkZQ6xcH7lsoeg/Gyge
         wgCo8LoTTGhxNIz9R9T2eXXwP67UsVMA2ZdchQDMeInvBnRA2ZgL8r2GEZ9v4NRTF7AJ
         K9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eO6mO59GQBmOS/DlZnxdkxlS21xeFUZXbaBYNCMZMIU=;
        b=bUVsebCGbzYkDMldLlidJYeU446Rk/sGH4CadbBnmSqjKLdfH4XS4j8kLa8X+8Icnj
         AAGfbYmXoVw0utZX8KCc9FKaHE2/2wQtzl5P6pX1bfBN2jdnfggSTlcu7WWEoC/LVBX0
         gQnB8KV5paMbw+EO1OyXUo6dyeSitE6o+/0Pd0WopZVG1SW6E8yRBjgAtYJQFWd4OIMQ
         drjit5IqaSyxVJvWqOQ8dqdtSu9lJppVe6IbQ6p0jGODM1PuogByKz0jSHncbge13Woa
         TGKxmQEGEAljUEe7PhktZ4Ol5/1aoYnGEpZC7WzvIGQpfu/MlzRsI2uJU40PT5I4NLhF
         tWNA==
X-Gm-Message-State: APjAAAXCJjO+r7nhSH31nYuKgHsd2AYKGX0qzVgew/5Q4reVqSHJwhqv
        6PiMVGttkwWur0efHmrPa2jxwg==
X-Google-Smtp-Source: APXvYqxuURr2hxU2QOxPsPBOesZOTga1YQIBXTqdf8EFG4ggK8/H7A4p9X0nZ2l1g7DLSX/yEpxirQ==
X-Received: by 2002:aed:2b44:: with SMTP id p62mr27078963qtd.308.1558219421796;
        Sat, 18 May 2019 15:43:41 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j62sm4834234qte.89.2019.05.18.15.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:43:41 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [RESEND PATCH] staging: iio: adt7316: create of_device_id array
Date:   Sat, 18 May 2019 19:43:33 -0300
Message-Id: <20190518224333.18067-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create structure of type of_device_id in order to register all devices
the driver is able to manage.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed-by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/addac/adt7316-spi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 8294b9c1e3c2..9968775f1d23 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -127,9 +127,22 @@ static const struct spi_device_id adt7316_spi_id[] = {
 
 MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
 
+static const struct of_device_id adt7316_of_spi_match[] = {
+	{ .compatible = "adi,adt7316" },
+	{ .compatible = "adi,adt7317" },
+	{ .compatible = "adi,adt7318" },
+	{ .compatible = "adi,adt7516" },
+	{ .compatible = "adi,adt7517" },
+	{ .compatible = "adi,adt7519" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, adt7316_of_spi_match);
+
 static struct spi_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
+		.of_match_table = adt7316_of_spi_match,
 		.pm = ADT7316_PM_OPS,
 	},
 	.probe = adt7316_spi_probe,
-- 
2.22.0.rc0.1.g337bb99195.dirty

