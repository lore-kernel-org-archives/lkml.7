Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B88C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A335E206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642001;
	bh=zGS+aqvAvxMzGQtbGteTq1Bu11ZdWToCeo4/By73nVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4frkDoxOwV8rURTt6BnIXXoSIZ6NsIvbl6bI9c4gpZJ89g7tjHCG7U36yXflNDYD
	 z/ptKj4l1N9JEfrhmD7zf24AtTvGc9t8qYwRI72uaQo0Xt7nBeF3RylP56ZEBnNQXp
	 E4+jEGWjKidxeF78b3qR4oUl13MYHTILFgsfE6gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfL2RxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732440AbfL2RxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:53:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D217208C4;
        Sun, 29 Dec 2019 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641997;
        bh=zGS+aqvAvxMzGQtbGteTq1Bu11ZdWToCeo4/By73nVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/PE5+ISbURZ+dyOC5f0NA8GLSSdEf7br4qTE0NnVmdcBcBIE37i108/FltGyA1jw
         fX1Z3gpPaET+EgzzC0HzSDSbTtwSl4YfB+KgebbVPWSxIIR7QT5ZLS1vvQPoQCcEZt
         XSvuAd9gfXmRc7BVgpIENnEimDUPkCFk0jJ1o7go=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 299/434] cpufreq: Register drivers only after CPU devices have been registered
Date:   Sun, 29 Dec 2019 18:25:52 +0100
Message-Id: <20191229172721.812455633@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 46770be0cf94149ca48be87719bda1d951066644 ]

The cpufreq core heavily depends on the availability of the struct
device for CPUs and if they aren't available at the time cpufreq driver
is registered, we will never succeed in making cpufreq work.

This happens due to following sequence of events:

- cpufreq_register_driver()
  - subsys_interface_register()
  - return 0; //successful registration of driver

... at a later point of time

- register_cpu();
  - device_register();
    - bus_probe_device();
      - sif->add_dev();
	- cpufreq_add_dev();
	  - get_cpu_device(); //FAILS
  - per_cpu(cpu_sys_devices, num) = &cpu->dev; //used by get_cpu_device()
  - return 0; //CPU registered successfully

Because the per-cpu variable cpu_sys_devices is set only after the CPU
device is regsitered, cpufreq will never be able to get it when
cpufreq_add_dev() is called.

This patch avoids this failure by making sure device structure of at
least CPU0 is available when the cpufreq driver is registered, else
return -EPROBE_DEFER.

Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Co-developed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bc19d6c16aaa..a7db4f22a077 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2634,6 +2634,13 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	if (cpufreq_disabled())
 		return -ENODEV;
 
+	/*
+	 * The cpufreq core depends heavily on the availability of device
+	 * structure, make sure they are available before proceeding further.
+	 */
+	if (!get_cpu_device(0))
+		return -EPROBE_DEFER;
+
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
 	    !(driver_data->setpolicy || driver_data->target_index ||
 		    driver_data->target) ||
-- 
2.20.1



