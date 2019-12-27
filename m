Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC1AC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF7320740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468614;
	bh=Zhh8mlWbxSNHdATn4ItCyFo0X+Liip+CoikS38de9UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v+Xo6+3fX9HBz3ZCqVUHbHknwdOiIUWSFITMx/S+G1omAGb0nrhlow1Y4JVdQqCK6
	 g1sW+4vGKHoVUdGDFL+a5TOZi/1Yu2FrkXJJp7tF97Eo9k7NSn8QAnZrYnDBtVFOBL
	 oVkOTe2bIVuGhz7DFr9LOqzxvoU5oTfPs92s4mOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfL0Rnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbfL0Rnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:43:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB7122522;
        Fri, 27 Dec 2019 17:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468610;
        bh=Zhh8mlWbxSNHdATn4ItCyFo0X+Liip+CoikS38de9UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ai5Kgt2n6CIpoOJxINcl78PKxkg0lkSMT41FkOrHM+978zNHxs7+UK1sl9uAjQuCK
         xrVfpdO7Dd/rxSfA7LlMaf3tdgfCYk9brGrhJqE4WwY3KcZuxf4KUcQnzbXU/ZqWZ5
         kkIWk9Oz+8T5sxAYXVVH3Q15fK31EFVRm5+KyQ10=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 130/187] staging: axis-fifo: add unspecified HAS_IOMEM dependency
Date:   Fri, 27 Dec 2019 12:39:58 -0500
Message-Id: <20191227174055.4923-130-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

[ Upstream commit d3aa8de6b5d0853c43c616586b4e232aa1fa7de9 ]

Currently CONFIG_XIL_AXIS_FIFO=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/staging/axis-fifo/axis-fifo.o: in function `axis_fifo_probe':
drivers/staging/axis-fifo/axis-fifo.c:809: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Link: https://lore.kernel.org/r/20191211192742.95699-7-brendanhiggins@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/axis-fifo/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/Kconfig b/drivers/staging/axis-fifo/Kconfig
index 3fffe4d6f327..f180a8e9f58a 100644
--- a/drivers/staging/axis-fifo/Kconfig
+++ b/drivers/staging/axis-fifo/Kconfig
@@ -4,7 +4,7 @@
 #
 config XIL_AXIS_FIFO
 	tristate "Xilinx AXI-Stream FIFO IP core driver"
-	depends on OF
+	depends on OF && HAS_IOMEM
 	help
 	  This adds support for the Xilinx AXI-Stream FIFO IP core driver.
 	  The AXI Streaming FIFO allows memory mapped access to a AXI Streaming
-- 
2.20.1

