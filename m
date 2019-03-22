Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C505C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2B82083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257014;
	bh=d7MW4fdVjZfCRFGmVSbI2ewGdaa5/7eY9wGP9JuWfMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uG3oOiyz0DGzoCia+0DRHV8PBXUwU76IbYsdyxHAQfQ2Dzfr2ny6v1theV51izOf6
	 nGQxexJbUE8MvlZsmW2cHIcAFIYIi6ZAUHtQkd+Fld3nqm/m/S1Ay1g5EMEJ7q5g4n
	 XT+uZTVNyMsYjfoNHpf4ycxfcgQynASgUqjZe0Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390283AbfCVMQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389696AbfCVMQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1CC2083D;
        Fri, 22 Mar 2019 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257009;
        bh=d7MW4fdVjZfCRFGmVSbI2ewGdaa5/7eY9wGP9JuWfMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0r9LwFIMOhdwrYJ39UPZ04kVz2Y7a8u8PTd49vtN1B2zmunVhaJ6XgFdR2lS4Q83w
         gzy6O1k1V4pNbrQsu0IuH7X1QPPLprJAQG6mXKxe36kVxBIIhdio3WOsZmm1OR1hif
         yi6ImSUWaAbL7GvNjmvWRrnC3DCJMTrgThQsZ6wY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5.0 105/238] cpufreq: tegra124: add missing of_node_put()
Date:   Fri, 22 Mar 2019 12:15:24 +0100
Message-Id: <20190322111304.721727015@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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


