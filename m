Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B07C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390D42192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256336;
	bh=zIMtOKQXzEaA28TgCzk7eKjYIzVwgy+vwAl7uA8Kpc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nM2Fj9/aEr8vtUYzrXtb/EWKuphvF4PC1SFVDnu1+9lPoUncUW41LFlOeIDBQ7W1t
	 xIEwJGomanwj0LAbI+MVGNPGeRU6rx05DvvAGDgCGv7ZBbeDE6DBGvjcGzXezsUXwi
	 azCemUgQDiIq4ta5g+BM2fA23MUxgdUqqEqT3V/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbfCVMFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388077AbfCVMFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD6A2082C;
        Fri, 22 Mar 2019 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256331;
        bh=zIMtOKQXzEaA28TgCzk7eKjYIzVwgy+vwAl7uA8Kpc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yU9qV27Chv3hxci2EsCpUruOFpliJwy+nlaOPGAk4gXnMK/RSvE1I94yoKXvXAFbd
         RPFV6WBES+CJRjT4fEdc64fKf1O+rjYzq/RORn6RbcM0EPrxlO83eINYtlLfk5l6fA
         r1oJsvx2uwlwdjVsM2ZSiWJqG+fo8P442goe28/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.19 178/280] cpufreq: tegra124: add missing of_node_put()
Date:   Fri, 22 Mar 2019 12:15:31 +0100
Message-Id: <20190322111326.106846563@linuxfoundation.org>
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

From: Yangtao Li <tiny.windzz@gmail.com>

commit 446fae2bb5395f3028d8e3aae1508737e5a72ea1 upstream.

of_cpu_device_node_get() will increase the refcount of device_node,
it is necessary to call of_node_put() at the end to release the
refcount.

Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/tegra124-cpufreq.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -134,6 +134,8 @@ static int tegra124_cpufreq_probe(struct
 
 	platform_set_drvdata(pdev, priv);
 
+	of_node_put(np);
+
 	return 0;
 
 out_switch_to_pllx:


