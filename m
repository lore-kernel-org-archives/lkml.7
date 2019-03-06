Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D3FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D620684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="L64b7S4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfCFRLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:11:48 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:51856 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbfCFRLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:11:47 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 7906421877;
        Wed,  6 Mar 2019 20:11:44 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1Xkp58js1F-BhEGukeU;
        Wed, 06 Mar 2019 20:11:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551892304; bh=N4pJuOAOM/HjAH7jthQtu7ug1NWBtPIhc7uNuJlsls8=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=L64b7S4Idl4iBSHfy4E3Cej6Fn8IsgExIzcoXbnkKR17KlxmuGRkSo7+3iAwj1ypo
         25rpzukurur/tlRWHD5CiGOXiOKaz8tIBgPpFxL8BuTnGHtZhIjOzIBGz06AfUAcoI
         88ARSg0KDwOOeeE7xy8uunc4RIJ3giniuyE+rL9A=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:60f::1:1f])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id KJ2hoth7Rg-Bh4K2vpK;
        Wed, 06 Mar 2019 20:11:43 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] sched/core: fix buffer overflow in cgroup2 property cpu.max
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Wed, 06 Mar 2019 20:11:42 +0300
Message-ID: <155189230232.2620.13120481613524200065.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add limit into sscanf format string for on-stack buffer.

Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified hierarchy")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43f44539b88f..3971bc62521d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6968,7 +6968,7 @@ static int __maybe_unused cpu_period_quota_parse(char *buf,
 {
 	char tok[21];	/* U64_MAX */
 
-	if (!sscanf(buf, "%s %llu", tok, periodp))
+	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
 		return -EINVAL;
 
 	*periodp *= NSEC_PER_USEC;

