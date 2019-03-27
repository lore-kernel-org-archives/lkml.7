Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A9DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E94021738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=laposte.net header.i=@laposte.net header.b="RpGuiT2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfC0Wa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:30:26 -0400
Received: from smtpoutz25.laposte.net ([194.117.213.100]:39286 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727979AbfC0Wa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:30:26 -0400
X-Greylist: delayed 1395 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 18:30:24 EDT
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout013 (Postfix) with ESMTP id BA48610785A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:07:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1553724428; bh=e7EYZbrtuARyNuBC1ACysjAw4NPb4zVaHpbgrJbdSAU=;
        h=From:To:Cc:Subject:Date;
        b=RpGuiT2pTvaYfk8YQTYe+CK89D25sTp3dMWhnGMfebu7rqAOYvH0YmcJrXsmdu8lr
         Smv5+ORY5pZrWvwNiR4OFR5j0XsYftuvYoBnNgP15Idw/SoHmTi6qvtirHjaOT8FRs
         hhT9Iib5fi1msJyfi7PsWW4y8YcPYCNsbeq/2xQOuFvYXdT6addlUPwoh+Zz4LoRBq
         83rvulnu7gMY024rorNbvXcM4FgMxniirjKmrNRfe6C9z0I9CtippxGZJisscd23Rm
         7JpKSM3oR03oax4kubKP1xK/ZNDFyeDmaMKkxwnSQnSRaMW4lo+kxPOoflv0g/I94P
         Wss7QZBrmQ9vA==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 5A4F4107849
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:07:07 +0100 (CET)
Received: from lpn-prd-vrin002 (lpn-prd-vrin002.prosodie [10.128.63.3])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 5173810785C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:07:07 +0100 (CET)
Received: from lpn-prd-vrin002 (localhost [127.0.0.1])
        by lpn-prd-vrin002 (Postfix) with ESMTP id 390295E8737
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:07:07 +0100 (CET)
Received: from romuald.bergerie (rqp06-1-88-178-86-202.fbx.proxad.net [88.178.86.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by lpn-prd-vrin002 (Postfix) with ESMTPSA id D4FE55E865F;
        Wed, 27 Mar 2019 23:07:06 +0100 (CET)
Received: from radicelle.bergerie (radicelle.bergerie [192.168.124.12])
        by romuald.bergerie (Postfix) with ESMTPS id 117672E0C7BC;
        Wed, 27 Mar 2019 23:07:06 +0100 (CET)
Received: from vincent by radicelle.bergerie with local (Exim 4.92)
        (envelope-from <vincent@radicelle.bergerie>)
        id 1h9GhN-00027h-U4; Wed, 27 Mar 2019 23:07:05 +0100
From:   =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
To:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: scpi: fix use after free
Date:   Wed, 27 Mar 2019 23:06:42 +0100
Message-Id: <20190327220642.8117-1-vincent.stehle@laposte.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: -60
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedutddrkeefgddtgecutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhs
X-VR-Cause-3: ucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffogggt
X-VR-Cause-4: gfesthekredtredtjeenucfhrhhomhepgghinhgtvghnthcuufhtvghhlhoruceovhhinhgtvghnthdr
X-VR-Cause-5: shhtvghhlhgvsehlrghpohhsthgvrdhnvghtqeenucfkphepkeekrddujeekrdekiedrvddtvdenucfr
X-VR-Cause-6: rghrrghmpehmohguvgepshhmthhpohhuthdpihhnvghtpeekkedrudejkedrkeeirddvtddvpdhhvghl
X-VR-Cause-7: oheprhhomhhurghlugdrsggvrhhgvghrihgvpdhmrghilhhfrhhomhepvhhinhgtvghnthdrshhtvghh
X-VR-Cause-8: lhgvsehlrghpohhsthgvrdhnvghtpdhrtghpthhtohepshhuuggvvghprdhhohhllhgrsegrrhhmrdgt
X-VR-Cause-9: ohhmpdhrtghpthhtohepvhhinhgtvghnthdrshhtvghhlhgvsehlrghpohhsthgvrdhnvghtpdhrtghp
X-VR-Cause-10: thhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhig
X-VR-Cause-11: qdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehr
X-VR-Cause-12: jhifsehrjhifhihsohgtkhhirdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
X-VR-Cause-13: rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghl
X-VR-Cause-14: rdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the priv structure only after we are done using it.

Fixes: 1690d8bb91e370ab ("cpufreq: scpi/scmi: Fix freeing of dynamic OPPs")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 3f49427766b88..2b51e0718c9f6 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -189,8 +189,8 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	kfree(priv);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	kfree(priv);
 
 	return 0;
 }
-- 
2.20.1

