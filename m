Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7121C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD65245C1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188987;
	bh=vbT6JzcrqgZfDANvgbazIhs61L2kvqOjhh2SjOsVIHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sb0XaCYNepjj70wqvplAFQKkPupF3p7cqWXnRB4sHM5ZhznUNbhy6JygqrpLbgy4u
	 SuJTOzVhXhHgjU5SXgCe4bR+mbrGVM+odYx1JDlwckD27yTa//Y7yeBks9GdrzrZzH
	 DVMLqoNoBHaB1LmhcvSZAj8f0jHbNLWXB1EzMGRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfE3EDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbfE3DR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:58 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5CE2474A;
        Thu, 30 May 2019 03:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186278;
        bh=vbT6JzcrqgZfDANvgbazIhs61L2kvqOjhh2SjOsVIHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZptM3BmIOa14p0Sw2s4wSg//GgD+JTx6wuXZovAGfeG+xaqOYAUzhdO1/OiNm8wWD
         4cdrVfTxkxwTCqO9VKs75xJVuCRGqzPHuoZ1Qpt6lU71A9v175TLOwECVFlpLK/UGZ
         v3ULKb/pDanB9+nLwbBI3kYrTf9OFv2yQEitqOYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 180/276] cpufreq/pasemi: fix possible object reference leak
Date:   Wed, 29 May 2019 20:05:38 -0700
Message-Id: <20190530030536.547237935@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a9acc26b75f652f697e02a9febe2ab0da648a571 ]

The call to of_get_cpu_node returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/cpufreq/pasemi-cpufreq.c:212:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 147, but without a corresponding object release within this function.
./drivers/cpufreq/pasemi-cpufreq.c:220:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 147, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 75dfbd2a58ea6..c7710c149de85 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -146,6 +146,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
 
+	of_node_put(cpu);
 	if (!cpu)
 		goto out;
 
-- 
2.20.1



