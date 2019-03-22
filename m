Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5301621900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257010;
	bh=WAmzuokJwkt5+rIJ2jTP5MowtRP91CZu7sLwgjLociY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p/j+zjZkf8H2Opv7Nb5qzp4lc9jfHTe1O84VoKsMhwcXFhn35a6SUdsqJkug3VmI/
	 r8CwKuc5VtxTjJfiBUYfcsDVXPKFESxMBurywr1HUUQcmxkJBMl5xszr4NNe9SaLkK
	 d7IX/0PiddyM4w8V/V02PPIwNN38J5GSUxDgvdB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390277AbfCVMQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390027AbfCVMQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E8A2083D;
        Fri, 22 Mar 2019 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257005;
        bh=WAmzuokJwkt5+rIJ2jTP5MowtRP91CZu7sLwgjLociY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5wqVLf4MNBZ9+r96H3R8zonIOq4rne5HNZfCUzFfUJcp9CCt3sS8uII8p4qCIc5g
         dsCfy9E5F0ntTFQUUobjyd45ckURsfbNq1oerQnqutEned5yTI1nlFuT7H+7UazhpV
         XfB3zcAbYjZnDUb7WsnOSjHktL3Mg09bJIvw7AFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5.0 104/238] cpufreq: kryo: Release OPP tables on module removal
Date:   Fri, 22 Mar 2019 12:15:23 +0100
Message-Id: <20190322111304.671705139@linuxfoundation.org>
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

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 0334906c06967142c8805fbe88acf787f65d3d26 upstream.

Commit 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit") made
it possible to build the kryo cpufreq driver as a module, but it failed
to release all the resources, i.e. OPP tables, when the module is
unloaded.

This patch fixes it by releasing the OPP tables, by calling
dev_pm_opp_put_supported_hw() for them, from the
qcom_cpufreq_kryo_remove() routine. The array of pointers to the OPP
tables is also allocated dynamically now in qcom_cpufreq_kryo_probe(),
as the pointers will be required while releasing the resources.

Compile tested only.

Cc: 4.18+ <stable@vger.kernel.org> # v4.18+
Fixes: 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit")
Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/qcom-cpufreq-kryo.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufre
 
 static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
-	struct opp_table *opp_tables[NR_CPUS] = {0};
+	struct opp_table **opp_tables;
 	enum _msm8996_version msm8996_version;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
@@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struc
 	}
 	kfree(speedbin);
 
+	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
+	if (!opp_tables)
+		return -ENOMEM;
+
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (NULL == cpu_dev) {
@@ -151,8 +155,10 @@ static int qcom_cpufreq_kryo_probe(struc
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
 							  NULL, 0);
-	if (!IS_ERR(cpufreq_dt_pdev))
+	if (!IS_ERR(cpufreq_dt_pdev)) {
+		platform_set_drvdata(pdev, opp_tables);
 		return 0;
+	}
 
 	ret = PTR_ERR(cpufreq_dt_pdev);
 	dev_err(cpu_dev, "Failed to register platform device\n");
@@ -163,13 +169,23 @@ free_opp:
 			break;
 		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
 	}
+	kfree(opp_tables);
 
 	return ret;
 }
 
 static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
 {
+	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	unsigned int cpu;
+
 	platform_device_unregister(cpufreq_dt_pdev);
+
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+
+	kfree(opp_tables);
+
 	return 0;
 }
 


