Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B55FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A421213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259683;
	bh=hVyhiDCj04rp3csRNWp9F7OMoCyRSUzgnWwLtj+AqjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QNtEicujh349SXgVsTJj4xObWTl3JeVjV/zC8tsJtF3x8q6sNhq7CCb99gVoHvpw9
	 Q58AHNPWYDRPXaymRDMzhkD8iUMJV6swZh/h9gqcmWYy+1rWojJUMZ+tH8C5Kyetl4
	 XlFsRqCRSn0Q3j7PeeiIsfBsFm8CjF5CafnXhTTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfCVLnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbfCVLnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:43:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500B5218B0;
        Fri, 22 Mar 2019 11:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254979;
        bh=hVyhiDCj04rp3csRNWp9F7OMoCyRSUzgnWwLtj+AqjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlQ4m0M7bK0PAlheuo2tQ2kSUz8ZDuWoxyCxJKrDX9EGt6SQ30t+JGBY5T299Etk0
         ZHS4seiQov3GmMlqtCJgYqUwlFtgtBGws7lFKQwybPdKKq+PawrcgaY8Xra1xfXh8Z
         +43Lf4Z/p1inn/ETwr0czfAZnTfX6vXuIIdlFQ3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.9 070/118] cpufreq: tegra124: add missing of_node_put()
Date:   Fri, 22 Mar 2019 12:15:42 +0100
Message-Id: <20190322111221.598131080@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


