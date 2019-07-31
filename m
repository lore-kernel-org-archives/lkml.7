Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14024C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF7E21726
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577060;
	bh=iNW8wNE5JHBZzgakkExMWkpVXk60TdQED+PTGb/g0pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t9QGbFZjJjqwtEXgdX5RPSYpP02y6L2lmnLmfYSNvtY9+k2jRlmNWaHybdb9TcN8z
	 OsHthYRT1HcBx/9E1xFFN8X0o1yDug22LKZ7UFI80aVM9y/7ZN0smOYwgGRsqoqX+W
	 NDa7K2EcMK+Lr2PyUXZ9XekwnlyT5/7pNXFYTyVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbfGaMoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfGaMoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0692089E;
        Wed, 31 Jul 2019 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577055;
        bh=iNW8wNE5JHBZzgakkExMWkpVXk60TdQED+PTGb/g0pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFEeDO7GXMu8iFGWL3oPbd2aUKaueXO6WY/Y974vTpcBTA24h+pXl5qA8wo3dT2vt
         ctIKOx/+vIIwU8/IyHDhl43bxXiL8TCEJqKd+84WYwRVtH7kQsX97BB8ERfD8OuU8H
         boNTRZI86fCLVV+vdc2rsW1XJdOJ8pcHjwYasdpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/10] firmware: arm_scpi: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:44 +0200
Message-Id: <20190731124349.4474-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124349.4474-1-gregkh@linuxfoundation.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a sysfs group of attributes.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/arm_scpi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 725164b83242..a80c331c3a6e 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -1011,10 +1011,6 @@ static int scpi_probe(struct platform_device *pdev)
 				   scpi_info->firmware_version));
 	scpi_info->scpi_ops = &scpi_ops;
 
-	ret = devm_device_add_groups(dev, versions_groups);
-	if (ret)
-		dev_err(dev, "unable to create sysfs version group\n");
-
 	return devm_of_platform_populate(dev);
 }
 
@@ -1030,6 +1026,7 @@ static struct platform_driver scpi_driver = {
 	.driver = {
 		.name = "scpi_protocol",
 		.of_match_table = scpi_of_match,
+		.dev_groups = versions_groups,
 	},
 	.probe = scpi_probe,
 	.remove = scpi_remove,
-- 
2.22.0

