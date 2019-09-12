Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A6FC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF474208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568277548;
	bh=/KDvi2wwC3DkyMak40XpohJE1W/EZnHtjHFmfTMjLMQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=s+CKGdxFiKGIt9iLnUsgSzLfePHs1vxXzexLXrXPHoAbZ1lYRB0VODuhmgjCp7Q9V
	 XTZ8z3zJWfuz587oy90FD7YchiZuvXMCoqxVQu5O+tsSl8xAfcNwX5ktTJ30r+UqeE
	 97foM8w8eTNiW31t2i3cra1N79DAi5COA2r+2K7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfILIjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:39:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39770 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:39:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so27472269wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hhA8cQZFwGiGgmzl9cc7cEI8QlLF+DhUKxMfNpbJqeM=;
        b=YGW24aIudLNoRJhhloywhmuJ1Kck9ge5aQJZefEneAE4nWQgyd9nRtFGUTdctRL29y
         kzIKRBSKK4+/9t8k5gfGMl06MKh+x/vo3V8HSfDkDLBF5WIr95CLIlyssfbO/FBdzoU5
         do2/b3LpL0FiLW+ltFR+1Td/hypOr5srzSs+XEVLv1dZi0MighWPtMUeN+M16bnJRukn
         Es0GjKHDlfED/SKtG8f7ocRqbvKL4ALs2cb7QzgrkpAnhw4F2FrZW3nU7pFzs/MpF+k0
         bruKLzM/e3tkuMOhwahbhm+i2zWy9tPYfo8v/O+4N+u8yQSgbJntQqhRUzU21gHSgUBv
         pXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hhA8cQZFwGiGgmzl9cc7cEI8QlLF+DhUKxMfNpbJqeM=;
        b=f57j4i/Zg1WngAs0bVz5xNW/yqbDaRc2agbE4B1Csnx5B8FxQbjKnkQ+RLETmLicgJ
         R3f+vITRhVpdmHVw4wDrwkM9yUYElw+kybzgP1KsTyUDSPFr3xMiAy0ErXAARvc7Js8m
         vckmY3LN4MQdefyPIpYc1NZDIKwo8hVtmn5cc/zLiyFDO5uvxxNErRbOi43bZIlLEPSA
         kh0IaaiSa+DcIGuRdANw0YwZbTMPBHpcWlfGGuJEaMq3lQIl4tMS4GL8XioivLPeiyUF
         nGfrfR9B9VUi+sHPDmqvpOY4OR0Ot63xSqb8kckx0HaMF1dwi2gtdXQ2FIaZjNwoioWa
         OUNQ==
X-Gm-Message-State: APjAAAVoOaPBb7TJtxhjn3MFDbFhhXYotClkmgiru3Ts4Z8D5k+2sEgf
        Yxbn4n0eaG+G54uxsVUEfeQbCWnR
X-Google-Smtp-Source: APXvYqyPaRirDYE1V2gaB8nTOBMtuTQaVQlUm0lDOvQBR6o7lLJkSiTvoNSDhIdLg6GKIE1haQt3ig==
X-Received: by 2002:a05:6000:45:: with SMTP id k5mr5464722wrx.259.1568277545674;
        Thu, 12 Sep 2019 01:39:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w15sm18569309wru.53.2019.09.12.01.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 01:39:05 -0700 (PDT)
Date:   Thu, 12 Sep 2019 10:39:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fix
Message-ID: <20190912083903.GA38044@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 310aa0a25b338b3100c94880c9a69bec8ce8c3ae perf/hw_breakpoint: Fix arch_hw_breakpoint use-before-initialization

Fix an initialization bug in the hw-breakpoints, which triggered on the 
ARM platform.

 Thanks,

	Ingo

------------------>
Mark-PK Tsai (1):
      perf/hw_breakpoint: Fix arch_hw_breakpoint use-before-initialization


 kernel/events/hw_breakpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index c5cd852fe86b..3cc8416ec844 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -413,7 +413,7 @@ static int hw_breakpoint_parse(struct perf_event *bp,
 
 int register_perf_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint hw;
+	struct arch_hw_breakpoint hw = { };
 	int err;
 
 	err = reserve_bp_slot(bp);
@@ -461,7 +461,7 @@ int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
-	struct arch_hw_breakpoint hw;
+	struct arch_hw_breakpoint hw = { };
 	int err;
 
 	err = hw_breakpoint_parse(bp, attr, &hw);
