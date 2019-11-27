Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8815520665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890326;
	bh=kN3WIv/LyoTwwkl5EnavKlDXb+7KafpH6vrOsCLhcoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BWYl+vr4NwL0IZGKm8OwLMcGVuJn7riJSnE+CoxlIa6EXPcq9xcO7XdrCaXQx5UOP
	 bXDlmvOpJaqr1y14s4pa/zvgQNCJ8v9cQd4zYiMRY3rr9ZFTe6pOwARutG8GhCIpon
	 f4bbYzoAQTYaoQUMJ3dD1/K5y0vj5UTiqzCS/FyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfK0VcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbfK0Uxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:53:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA252070B;
        Wed, 27 Nov 2019 20:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888034;
        bh=kN3WIv/LyoTwwkl5EnavKlDXb+7KafpH6vrOsCLhcoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JREx76pmw4sZOG07G1Vbp7wvSg1cTLmFZzPojkkEECMs1BDtRD7yQshzMXtFSyuc0
         +iKCXYIt8YFkWE7l0ROExa44/6TDVGF5mUQv3Q0i+YfFh5/ZWgOO8LKijS5Z9IdVGF
         zPdHJoAS8/FIOUayNV6el72FZbikSizPYDX9Pnxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kai Shen <shenkai8@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 191/211] cpufreq: Add NULL checks to show() and store() methods of cpufreq
Date:   Wed, 27 Nov 2019 21:32:04 +0100
Message-Id: <20191127203111.731778105@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Shen <shenkai8@huawei.com>

commit e6e8df07268c1f75dd9215536e2ce4587b70f977 upstream.

Add NULL checks to show() and store() in cpufreq.c to avoid attempts
to invoke a NULL callback.

Though some interfaces of cpufreq are set as read-only, users can
still get write permission using chmod which can lead to a kernel
crash, as follows:

chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

This bug was found in linux 4.19.

Signed-off-by: Kai Shen <shenkai8@huawei.com>
Reported-by: Feilong Lin <linfeilong@huawei.com>
Reviewed-by: Feilong Lin <linfeilong@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Subject & changelog ]
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cpufreq.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -911,6 +911,9 @@ static ssize_t show(struct kobject *kobj
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret;
 
+	if (!fattr->show)
+		return -EIO;
+
 	down_read(&policy->rwsem);
 	ret = fattr->show(policy, buf);
 	up_read(&policy->rwsem);
@@ -925,6 +928,9 @@ static ssize_t store(struct kobject *kob
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret = -EINVAL;
 
+	if (!fattr->store)
+		return -EIO;
+
 	cpus_read_lock();
 
 	if (cpu_online(policy->cpu)) {


