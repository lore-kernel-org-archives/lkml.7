Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9426A2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522087;
	bh=7b7jS37hdbkIbafvVGOIgdZ/TibNlW9EEmrV6xUZF9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXQQeCR0Shv2fWUh1CdUdtuujSDCG8vGtWaq5bPUWCehSO7gYpHSh1Up0gGV899/a
	 FuokCiHoK9DTf1jAVYwUpMQ1MQLDg5U8XLJRH6gW1MoIY7Aty6feEEHXxAj+LPgOWu
	 vPqVrlGuZzU+M8KvJJjiIXx4l79/foRjCFPPWoOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfLPSsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfLPRyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:54:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4464120733;
        Mon, 16 Dec 2019 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518871;
        bh=7b7jS37hdbkIbafvVGOIgdZ/TibNlW9EEmrV6xUZF9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7Mlcjm+uDIVmzcWNVGqBMzbOOanepLz2CbDzE9rsN5p6Rk82R3z95+1DFEGqxZXZ
         rC4uD+Spu6VEYJGDignL+Gax4rEVrOGizICIbrIEhplaGJt+trnYsmzCfduZ6k4l3E
         ZbAPWH+UpA40r/UbXK9XRwjUu08ZldvDdkKRPjA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 064/267] ACPI: fix acpi_find_child_device() invocation in acpi_preset_companion()
Date:   Mon, 16 Dec 2019 18:46:30 +0100
Message-Id: <20191216174855.893939339@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit f8c6d1402b89f22a3647705d63cbd171aa19a77e ]

acpi_find_child_device() accepts boolean not pointer as last argument.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
[ rjw: Subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d7a9700b93339..4bb3bca75004d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -99,7 +99,7 @@ static inline bool has_acpi_companion(struct device *dev)
 static inline void acpi_preset_companion(struct device *dev,
 					 struct acpi_device *parent, u64 addr)
 {
-	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, NULL));
+	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, false));
 }
 
 static inline const char *acpi_dev_name(struct acpi_device *adev)
-- 
2.20.1



