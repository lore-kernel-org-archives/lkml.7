Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8B321872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610613;
	bh=J62XNEOCcq5xob/5dZkfj4A5zciROak2iMyi1rZLTkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P/UUfD9vPXSF2XvYxu2T/feQw3cMqrhEMwO46mjCsBYhyNnCc9An4ouv544HSrF5P
	 WemPXY/eSXV6zd/Pjl3+vze0phxUBVBVvsU7UmAi7pNqfyZj5JD1c7hCB/1YQHbLHN
	 jJQMn3U+1H4Upv2mmbfqBfEsLYbyp2Dlb/W/wxBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbfDRSDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390930AbfDRSD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3CCB21872;
        Thu, 18 Apr 2019 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610608;
        bh=J62XNEOCcq5xob/5dZkfj4A5zciROak2iMyi1rZLTkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cy/dcBcCttCcrik68b4IlwG4tXePsBC2/kYR44Cop6guH+xNzlxIKrfVHyQJkRtHw
         E4h0RwsxD7UCwGuaEI3gorjBxWuwmZH/6Y8v5ebHzmA7K1Ze58Jk8xp//Wr1ai8Ako
         e9LMh78d4kCfHOmSIQalsaLgo5Dp8QKaIVO6xTUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 16/92] thermal/intel_powerclamp: fix truncated kthread name
Date:   Thu, 18 Apr 2019 19:56:34 +0200
Message-Id: <20190418160431.776871087@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e925b5be5751f6a7286bbd9a4cbbc4ac90cc5fa6 ]

kthread name only allows 15 characters (TASK_COMMON_LEN is 16).
Thus rename the kthreads created by intel_powerclamp driver from
"kidle_inject/ + decimal cpuid" to "kidle_inj/ + decimal cpuid"
to avoid truncated kthead name for cpu 100 and later.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 45d9840491bd..c3293fa2bb1b 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -494,7 +494,7 @@ static void start_power_clamp_worker(unsigned long cpu)
 	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
 	struct kthread_worker *worker;
 
-	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inject/%ld", cpu);
+	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inj/%ld", cpu);
 	if (IS_ERR(worker))
 		return;
 
-- 
2.19.1



