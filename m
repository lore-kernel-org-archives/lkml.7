Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158FC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2342070D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188376;
	bh=k8XCWb3nVGyoshzNZpVRJe/i8quHXBLiNB8Xg/6kpDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h9Vx06e6cDo7gRVnzirrcLqGR6K4AhEkw9uuSq9Otj41oVVeT4Inp94qLibTE4ZLI
	 ZNH1yU+lkWL3o2K5dnahIT1Dbv7CFFuRpPyfAGXnTg9TH67Tqa14+gSMNqabTN+JwP
	 +g8nS2XUiEOPTemK0tGew6sxX+LmJl+QEmqhRKqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfE3Dw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbfE3DTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:19:34 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB19124879;
        Thu, 30 May 2019 03:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186373;
        bh=k8XCWb3nVGyoshzNZpVRJe/i8quHXBLiNB8Xg/6kpDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uH82h4yPgMpMkBurhOMiV6jh6o5A8eXUa2VxSTu9ZuugLZg2uwuckXqXlWEPbPd/6
         vPuf44+UZ95nTBVSl55BLfR3xHqe/cRwB22wPtkHbWedp+J8Y6Pb9fzIfE0M6/zy0Q
         +2+GtyCmyqISjYLoZWN6LUD+nnf2j7z0psqlXMiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 132/193] cpufreq: pmac32: fix possible object reference leak
Date:   Wed, 29 May 2019 20:06:26 -0700
Message-Id: <20190530030506.796645818@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8d10dc28a9ea6e8c02e825dab28699f3c72b02d9 ]

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/cpufreq/pmac32-cpufreq.c:557:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 552, but without a corresponding object release within this function.
./drivers/cpufreq/pmac32-cpufreq.c:569:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 552, but without a corresponding object release within this function.
./drivers/cpufreq/pmac32-cpufreq.c:598:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 587, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/pmac32-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 61ae06ca008e7..e225edb5c3593 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -552,6 +552,7 @@ static int pmac_cpufreq_init_7447A(struct device_node *cpunode)
 	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
 	if (volt_gpio_np)
 		voltage_gpio = read_gpio(volt_gpio_np);
+	of_node_put(volt_gpio_np);
 	if (!voltage_gpio){
 		pr_err("missing cpu-vcore-select gpio\n");
 		return 1;
@@ -588,6 +589,7 @@ static int pmac_cpufreq_init_750FX(struct device_node *cpunode)
 	if (volt_gpio_np)
 		voltage_gpio = read_gpio(volt_gpio_np);
 
+	of_node_put(volt_gpio_np);
 	pvr = mfspr(SPRN_PVR);
 	has_cpu_l2lve = !((pvr & 0xf00) == 0x100);
 
-- 
2.20.1



