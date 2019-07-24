Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E70C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D25E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998807;
	bh=NFkFRIwreOSnCR1vC8YOMvLJ+63nA0WPzzDhF9pxoIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IcpJOw2HAXyG+Mt/UhJuxqkjOE2TaQJ8x6C5jYs2exv+HmOnJ0C3R2byZ8KSgAkQB
	 yn3F2PPzl5zWy+TspZLq3nRVKJC8A+AY2VbTqgblmfYgRRCQBtXM0VuVA245+xk2GA
	 9tJOTSpilPOwpG0HBC1IbMJMO6SMm5JC+XpvyAOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392567AbfGXUEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405399AbfGXUEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:04:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C435C214AF;
        Wed, 24 Jul 2019 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998688;
        bh=NFkFRIwreOSnCR1vC8YOMvLJ+63nA0WPzzDhF9pxoIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjRUJhdFldO5b7gCN6H0E4Sqrl4gIhMCta6vesnQboH1wJo/HdqgWmBIP4aWVfNNU
         Me9EC8VSEoZyoU71GvddTMiyABQ/LluCwrxDyoG9mX/iatoOhkmWWD5fnQHEAERuXc
         oP2JW+/y4Nagq4U6hgdNj49CxB31TX+Jt226g6bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Thomas Renninger <trenn@suse.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/271] cpupower : frequency-set -r option misses the last cpu in related cpu list
Date:   Wed, 24 Jul 2019 21:18:31 +0200
Message-Id: <20190724191658.786585578@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 04507c0a9385cc8280f794a36bfff567c8cc1042 ]

To set frequency on specific cpus using cpupower, following syntax can
be used :
cpupower -c #i frequency-set -f #f -r

While setting frequency using cpupower frequency-set command, if we use
'-r' option, it is expected to set frequency for all cpus related to
cpu #i. But it is observed to be missing the last cpu in related cpu
list. This patch fixes the problem.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Reviewed-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/utils/cpufreq-set.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 1eef0aed6423..08a405593a79 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -306,6 +306,8 @@ int cmd_freq_set(int argc, char **argv)
 				bitmask_setbit(cpus_chosen, cpus->cpu);
 				cpus = cpus->next;
 			}
+			/* Set the last cpu in related cpus list */
+			bitmask_setbit(cpus_chosen, cpus->cpu);
 			cpufreq_put_related_cpus(cpus);
 		}
 	}
-- 
2.20.1



