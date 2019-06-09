Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6037BC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBCE20843
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099858;
	bh=sdK1Xn6v9YbWQEGAiClWqejKazMG/VXN5F69IhQH0JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14Lj16MjKr5oIMxDc+6z4hmADTR1C9fi7RRrSvH9Q0H4+I593MExQ+dV0btyfFTPH
	 5OEFltCJGt23+RrDyBQVQMuH/nzxHSWJyTRY4RhleauJOv/CFzNSpBNb+DVlB3y1mK
	 ThRvjUDvw9CaZ8MKk11cDmVogjT7zpar3E4GwmgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbfFIRER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388577AbfFIREO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:04:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD47206DF;
        Sun,  9 Jun 2019 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099853;
        bh=sdK1Xn6v9YbWQEGAiClWqejKazMG/VXN5F69IhQH0JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpRdEmAtvJi7DtcT5WUN6b0uiyCYC0Orgc3k88UOhF9gSxqSyj14sl5uZOiAC3rLK
         DXIOdRHQoUZ61dLeiGxf9JALTwlCsuPl8xHLChxL8mFo2KyNbNcFW5fAHVNguvA/ng
         0S7n1J/9sQ/dW1L4OwBt9cP+x7d7BNY8CNzA1NKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 145/241] cpufreq/pasemi: fix possible object reference leak
Date:   Sun,  9 Jun 2019 18:41:27 +0200
Message-Id: <20190609164151.967723685@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
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
index 35dd4d7ffee08..58c933f483004 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -146,6 +146,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
 
+	of_node_put(cpu);
 	if (!cpu)
 		goto out;
 
-- 
2.20.1



