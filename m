Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A2AC2D0CD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069B92082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520322;
	bh=F2n07ws10lQmM2LodegTTQfMXCbscbF5aBDGHTmAry4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BSvpznb0+Vj6IlsuPkJ57mMHYB1kvuAsrok2pV9uvrWK2yW5eLCtjKQuJ/dzFm8Op
	 F7f7suWCvyW2OPRfzaJVE/h0+CbabXsFrz9WAyLLod4LJO//CuMNVt0ugQ+R+IEsO9
	 IGPUxB6aDcc7MI1xp4e2HN8PMQ/jYTuKVZNfHp4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfLPSSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731380AbfLPSSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:18:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC44207FF;
        Mon, 16 Dec 2019 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520315;
        bh=F2n07ws10lQmM2LodegTTQfMXCbscbF5aBDGHTmAry4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWbkW2tUiXiz/191GieDSrP8VZ71NHtPtW4UZCjdktAtX1XgfC8hxsGQQftcNErDk
         Np+AP8apvHM6H0g32VMlMcWJlYL4dCUxjjqVI/1Aq1v8wWClTyqWo3CtnuzYzifczN
         wpcG29cwQqC4WPzxzFX0j+VdMyODSekxi5JNAGr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 104/177] cpuidle: Do not unset the driver if it is there already
Date:   Mon, 16 Dec 2019 18:49:20 +0100
Message-Id: <20191216174841.364350808@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@oracle.com>

commit 918c1fe9fbbe46fcf56837ff21f0ef96424e8b29 upstream.

Fix __cpuidle_set_driver() to check if any of the CPUs in the mask has
a driver different from drv already and, if so, return -EBUSY before
updating any cpuidle_drivers per-CPU pointers.

Fixes: 82467a5a885d ("cpuidle: simplify multiple driver support")
Cc: 3.11+ <stable@vger.kernel.org> # 3.11+
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
[ rjw: Subject & changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/driver.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -62,24 +62,23 @@ static inline void __cpuidle_unset_drive
  * __cpuidle_set_driver - set per CPU driver variables for the given driver.
  * @drv: a valid pointer to a struct cpuidle_driver
  *
- * For each CPU in the driver's cpumask, unset the registered driver per CPU
- * to @drv.
- *
- * Returns 0 on success, -EBUSY if the CPUs have driver(s) already.
+ * Returns 0 on success, -EBUSY if any CPU in the cpumask have a driver
+ * different from drv already.
  */
 static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
 {
 	int cpu;
 
 	for_each_cpu(cpu, drv->cpumask) {
+		struct cpuidle_driver *old_drv;
 
-		if (__cpuidle_get_cpu_driver(cpu)) {
-			__cpuidle_unset_driver(drv);
+		old_drv = __cpuidle_get_cpu_driver(cpu);
+		if (old_drv && old_drv != drv)
 			return -EBUSY;
-		}
+	}
 
+	for_each_cpu(cpu, drv->cpumask)
 		per_cpu(cpuidle_drivers, cpu) = drv;
-	}
 
 	return 0;
 }


