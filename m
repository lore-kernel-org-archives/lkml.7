Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EEE2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414829;
	bh=6hPF5tdZKwGefFuOFN1JDyKRb95J50q7shAcN+XnPRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Opbq+8MAkjPiUoNCs5rGDfDI8ApvrpFg2rDGcy8LHdDsjcM5EFciET++0xXfvmNCR
	 N3IckQ1SlycMmUyd+setrkAcuM4KeGmq6VcnwIgmGEVMhf+fLcSHs4X1pU47ugkOlm
	 UCosHHOJEztQZlcS45C7mEbe0HcevjecI+cu0qzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfLCWhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfLCWhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:37:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380D2207DD;
        Tue,  3 Dec 2019 22:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412653;
        bh=6hPF5tdZKwGefFuOFN1JDyKRb95J50q7shAcN+XnPRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdKY9pgWr27XG4zoaOoJD5ToyUF9y3X3d3CHFA20H7/qZ5bobliL5Zp7tchyR8nZK
         /nJ/ClYRlEIhr8SxzjPJVpcx1fQVCFdGb98WDdmEoY2ow+vVm8E1D8UoMxJadc3RGB
         ED6oymlYFaMgos3d5OOrNp5dYmIweY1oAi2h4n6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.4 05/46] driver core: platform: use the correct callback type for bus_find_device
Date:   Tue,  3 Dec 2019 23:35:25 +0100
Message-Id: <20191203212715.632735792@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

commit 492c88720d36eb662f9f10c1633f7726fbb07fc4 upstream.

platform_find_device_by_driver calls bus_find_device and passes
platform_match as the callback function. Casting the function to a
mismatching type trips indirect call Control-Flow Integrity (CFI) checking.

This change adds a callback function with the correct type and instead
of casting the function, explicitly casts the second parameter to struct
device_driver* as expected by platform_match.

Fixes: 36f3313d6bff9 ("platform: Add platform_find_device_by_driver() helper")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191112214156.3430-1-samitolvanen@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/platform.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1278,6 +1278,11 @@ struct bus_type platform_bus_type = {
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
+static inline int __platform_match(struct device *dev, const void *drv)
+{
+	return platform_match(dev, (struct device_driver *)drv);
+}
+
 /**
  * platform_find_device_by_driver - Find a platform device with a given
  * driver.
@@ -1288,7 +1293,7 @@ struct device *platform_find_device_by_d
 					      const struct device_driver *drv)
 {
 	return bus_find_device(&platform_bus_type, start, drv,
-			       (void *)platform_match);
+			       __platform_match);
 }
 EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
 


