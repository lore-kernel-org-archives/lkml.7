Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0EF218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254683;
	bh=zV6vqOO8z89dN2eFGmapVREkFGJAbse7I/6LmDGd7rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BeWeTBNuuzJcz1MCOr0unM0is6Jo7LgX9OlNjt8i7kT3BcAyN4g3WOsXvUKO0upd0
	 5wVIw6b9/6b5ElUX6eEcMSEL8YdXdr9Djujdy/SqcAZR/JOlbCfTtNwsrm+EQ25Xy2
	 Hoz10oOo7N/h7VsWusE2p2xTS3RU6b9S2sqXFKjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfCVLiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730909AbfCVLh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:37:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0711E2183E;
        Fri, 22 Mar 2019 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254678;
        bh=zV6vqOO8z89dN2eFGmapVREkFGJAbse7I/6LmDGd7rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGcMT4jl6nLtvg1zAvIBjX9/6+YTNL3ssjENY2CUvdTSbRgZIgD+vN4Zqu1mOqW3J
         9/wsCdAVvdLiox+K739oygxYP9bDoazw7EMXQyu0pvRpK7jgrTPLK1Pydz/ZA3MAnG
         KUdB/11I3xhjaNQR+VM3Q1g6banSAzlEKICiHzgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.4 193/230] cpufreq: tegra124: add missing of_node_put()
Date:   Fri, 22 Mar 2019 12:15:31 +0100
Message-Id: <20190322111250.356660698@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -141,6 +141,8 @@ static int tegra124_cpufreq_probe(struct
 
 	platform_set_drvdata(pdev, priv);
 
+	of_node_put(np);
+
 	return 0;
 
 out_switch_to_pllx:


