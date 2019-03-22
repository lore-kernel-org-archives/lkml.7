Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4207AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC842082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259236;
	bh=88MjLhADRHQ17FPYW8h70d8RBR66pVsu/kBDs82exVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EOslPSSsYdUJLe92KDq62AVKYdCJmL27kjmG/xmLlyHXB+191jKYAxdra8Hnb/hvI
	 PvVE+SYg/xQ8oF8G6IKnH+crg5s6a5d54fVjXIVzjLdYZXGNvZQAf5Yi/c5+bHBkDc
	 6fpWKEK0k3QgJeMDzJSbPeHAGiWua/qsjzalSauk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfCVMxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732792AbfCVLvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:51:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0935D21916;
        Fri, 22 Mar 2019 11:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255498;
        bh=88MjLhADRHQ17FPYW8h70d8RBR66pVsu/kBDs82exVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0cUuX4Xudc41NmnXx1I5nps/CEyM3LQN33pBJZHoTxQryHLxNagW9l+D/jFY4NNu
         G334fdpnFROy9sHd8LsKVa05Ab8Nn3cDtxgFzq4z2zKnIL7QM7a+qZ1gUrZmxVwg9Y
         ArjZOFSVo1gw68neDwRLDqrpUKTM8xvyNNnbdOLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 110/183] cpufreq: pxa2xx: remove incorrect __init annotation
Date:   Fri, 22 Mar 2019 12:15:38 +0100
Message-Id: <20190322111249.674270653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 9505b98ccddc454008ca7efff90044e3e857c827 upstream.

pxa_cpufreq_init_voltages() is marked __init but usually inlined into
the non-__init pxa_cpufreq_init() function. When building with clang,
it can stay as a standalone function in a discarded section, and produce
this warning:

WARNING: vmlinux.o(.text+0x616a00): Section mismatch in reference from the function pxa_cpufreq_init() to the function .init.text:pxa_cpufreq_init_voltages()
The function pxa_cpufreq_init() references
the function __init pxa_cpufreq_init_voltages().
This is often because pxa_cpufreq_init lacks a __init
annotation or the annotation of pxa_cpufreq_init_voltages is wrong.

Fixes: 50e77fcd790e ("ARM: pxa: remove __init from cpufreq_driver->init()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/pxa2xx-cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -192,7 +192,7 @@ static int pxa_cpufreq_change_voltage(co
 	return ret;
 }
 
-static void __init pxa_cpufreq_init_voltages(void)
+static void pxa_cpufreq_init_voltages(void)
 {
 	vcc_core = regulator_get(NULL, "vcc_core");
 	if (IS_ERR(vcc_core)) {
@@ -208,7 +208,7 @@ static int pxa_cpufreq_change_voltage(co
 	return 0;
 }
 
-static void __init pxa_cpufreq_init_voltages(void) { }
+static void pxa_cpufreq_init_voltages(void) { }
 #endif
 
 static void find_freq_tables(struct cpufreq_frequency_table **freq_table,


