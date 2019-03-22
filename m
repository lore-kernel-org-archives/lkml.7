Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41982C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A242183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254687;
	bh=YZOgbvk2uq05hTjMJGck1SuCAbgKaFNa4HjjVPHw4uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gOEj9AHGY2+GnbHDP+4aUwWrNgeUnzGTyK3rvcLxMwT2tEBQRIsrluoHclgsI+bns
	 VEt/j8LE1Y0Y9nHGEsCXdW9Xkx2DL+t+hEB8GU8hluajVPqIZHXNCYsR9R21KsEfNp
	 Wd3fKarf1UXOrMk5ajCphPHoufYLuyr0L97csOFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfCVLiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbfCVLiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B133C2183E;
        Fri, 22 Mar 2019 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254682;
        bh=YZOgbvk2uq05hTjMJGck1SuCAbgKaFNa4HjjVPHw4uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivaX8HAY1cntFPER5K78mXMWysQxrWYI+e6rmyA8flqoO3dHX1PXGGf0enOITY6gi
         KOYRDqnj5vtdoponnQOuIM4rej2DKmE6snHHIblItq8OcYZ8Ccna2rcvSN0YVdg/b2
         gn7SJknnaLeAmbaN3gKuw471soGmhk5dhESGVzkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 194/230] cpufreq: pxa2xx: remove incorrect __init annotation
Date:   Fri, 22 Mar 2019 12:15:32 +0100
Message-Id: <20190322111250.423214863@linuxfoundation.org>
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
@@ -191,7 +191,7 @@ static int pxa_cpufreq_change_voltage(co
 	return ret;
 }
 
-static void __init pxa_cpufreq_init_voltages(void)
+static void pxa_cpufreq_init_voltages(void)
 {
 	vcc_core = regulator_get(NULL, "vcc_core");
 	if (IS_ERR(vcc_core)) {
@@ -207,7 +207,7 @@ static int pxa_cpufreq_change_voltage(co
 	return 0;
 }
 
-static void __init pxa_cpufreq_init_voltages(void) { }
+static void pxa_cpufreq_init_voltages(void) { }
 #endif
 
 static void find_freq_tables(struct cpufreq_frequency_table **freq_table,


