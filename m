Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A1CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75246218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907473;
	bh=sTnlT9fuDAeUB3/iucjyhRAAO8zpsjswbUXbqvyY5QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zl3NUbBBHxtdnl7Vakl/tNmPaU+5nSqW5iAIGewdkuk47+lTU01vbWf7wG+9VBvl3
	 7mCZocFTJQ8RAwf9mw3junQhPLSTDg6TphWa9Sa3kwfMmIv/4jnQgg/tMaUtIxqav0
	 CXYBnzpIeBJoqFwq7Zhuvj7Bo2Cm1M3RmZSezFxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfC3A5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732192AbfC3A5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:57:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2B4217F5;
        Sat, 30 Mar 2019 00:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907468;
        bh=sTnlT9fuDAeUB3/iucjyhRAAO8zpsjswbUXbqvyY5QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACVuOw2bXW1lZhI9ksXvl12tc9HCwRtLCMXv/Z6wvgiVTQk1Ez6N5lNwOWKP/HLoR
         adig8uoYpyTEyNER9r+vyh4WHXtrDT32eS96NH2PlkhJBbtASVOdLEPfyuXsvxxIv1
         l7Mn6ibE6Sq+XsDRbj+YVOFecSkduTS8SIzeKgZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Arcari <darcari@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 09/15] tools/power turbostat: return the exit status of a command
Date:   Fri, 29 Mar 2019 20:57:24 -0400
Message-Id: <20190330005730.28777-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005730.28777-1-sashal@kernel.org>
References: <20190330005730.28777-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Arcari <darcari@redhat.com>

[ Upstream commit 2a95496634a017c19641f26f00907af75b962f01 ]

turbostat failed to return a non-zero exit status even though the
supplied command (turbostat <command>) failed.  Currently when turbostat
forks a command it returns zero instead of the actual exit status of the
command.  Modify the code to return the exit status.

Signed-off-by: David Arcari <darcari@redhat.com>
Acked-by: Len Brown <len.brown@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f771e09eef33..06e1bf9bf1a8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2347,6 +2347,9 @@ int fork_it(char **argv)
 		signal(SIGQUIT, SIG_IGN);
 		if (waitpid(child_pid, &status, 0) == -1)
 			err(status, "waitpid");
+
+		if (WIFEXITED(status))
+			status = WEXITSTATUS(status);
 	}
 	/*
 	 * n.b. fork_it() does not check for errors from for_all_cpus()
-- 
2.19.1

