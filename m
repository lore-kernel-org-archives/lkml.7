Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E66C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257C22192D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138575;
	bh=yPJyp/SFO84MXg1VYSYIzh+pLkjUbgne2WK2cW3Xy8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ygMGBfjJvu5MdyuLnvb2YIUQZLLD2/zwQ4GVNQieyrYX02b1k2mLcPCKijXfrtVXJ
	 wpIz5mCKW27Y5SS2aOh7FnWsG1Jogd0rajJ7t7DjqHwSGxxGZdGEhWGfkr0u0Hxkz3
	 2vJ8QF+/4UmKDV/Y/XZ7R1ixlsJpsHVGJ+XPey/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfDARJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfDARJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E192192C;
        Mon,  1 Apr 2019 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138571;
        bh=yPJyp/SFO84MXg1VYSYIzh+pLkjUbgne2WK2cW3Xy8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3Sy9RJQZleMGaYMQtAj5O1xeIZbKP1fxfSB90odgKL1XINVc/Awjg1aVuGLGtqeL
         DJLTWzvpLdPFNG6SNsM4yWtGqXt219cGUYo2v1HLernt5z2nCtFN6q9kNEbcDvqAoA
         Z+9wwqhcx9i9nChOEetwOQW+f8t4e65RL6IZ0C3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.0 105/146] cpufreq: scpi: Fix use after free
Date:   Mon,  1 Apr 2019 19:01:57 +0200
Message-Id: <20190401170057.515109461@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Stehlé <vincent.stehle@laposte.net>

commit 31d4c528cea4023cf36f6148c03bb960cedefeef upstream.

Free the priv structure only after we are done using it.

Fixes: 1690d8bb91e370ab ("cpufreq: scpi/scmi: Fix freeing of dynamic OPPs")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/scpi-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -189,8 +189,8 @@ static int scpi_cpufreq_exit(struct cpuf
 	cpufreq_cooling_unregister(priv->cdev);
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	kfree(priv);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	kfree(priv);
 
 	return 0;
 }


