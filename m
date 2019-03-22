Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA26EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7982E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256453;
	bh=zrqT579Uozy7woccN8hNtenCHCXJ5clVFYtk5kFHFPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vwym7/Nzo94QXrfWo2TX5Bd8RYu1z4RX5baOJGzkR/qVETeInzv+w6cz7qEnJg9/C
	 3/HBSJXwT0rKl+tbwvCqg7TRNl9npwjv7ic9wrOVbg24jWkxPF+E5ijXvOCe+jsdCk
	 XL1kXljSboJ9I71uH/oa4Vc4+kDnGnpXpyNAJdb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbfCVMHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbfCVMH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E22521929;
        Fri, 22 Mar 2019 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256448;
        bh=zrqT579Uozy7woccN8hNtenCHCXJ5clVFYtk5kFHFPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9i5H2Q3OI7ds0dxw4eF4LqocwwHq6gdKUcrg2nHAuftga0EJnxMBv6fw8BCySqKk
         isBr+gC/bvtTjzc5XoDAAppGmaPfWu1ZWxHIUzCPF5Vh08QKRzSYgMQwIPwlQ7BbXZ
         QjkhcnHSDeKsviE+ByYm7fMtWFiw9MHkfYG7XAT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 193/280] clk: samsung: exynos5: Fix possible NULL pointer exception on platform_device_alloc() failure
Date:   Fri, 22 Mar 2019 12:15:46 +0100
Message-Id: <20190322111329.022653634@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 5f0b6216ea381b43c0dff88702d6cc5673d63922 upstream.

During initialization of subdevices if platform_device_alloc() failed,
returned NULL pointer will be later dereferenced.  Add proper error
paths to exynos5_clk_register_subcmu().  The return value of this
function is still ignored because at this stage of init there is nothing
we can do.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/samsung/clk-exynos5-subcmu.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -136,15 +136,21 @@ static int __init exynos5_clk_register_s
 {
 	struct of_phandle_args genpdspec = { .np = pd_node };
 	struct platform_device *pdev;
+	int ret;
 
 	pdev = platform_device_alloc(info->pd_name, -1);
+	if (!pdev)
+		return -ENOMEM;
+
 	pdev->dev.parent = parent;
 	pdev->driver_override = "exynos5-subcmu";
 	platform_set_drvdata(pdev, (void *)info);
 	of_genpd_add_device(&genpdspec, &pdev->dev);
-	platform_device_add(pdev);
+	ret = platform_device_add(pdev);
+	if (ret)
+		platform_device_put(pdev);
 
-	return 0;
+	return ret;
 }
 
 static int __init exynos5_clk_probe(struct platform_device *pdev)


