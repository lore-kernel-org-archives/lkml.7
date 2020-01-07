Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B4C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C682080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KDLRNbfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgAGJsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:48:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgAGJsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IWusUDmSIL/SB7RdbIQ699smqvgNkC7EH2eXRvFyN1c=; b=KDLRNbfURfqAdTtFDPk0X9ytm
        epPWwWBRm7xJe7Rm31wFHqQNpguFuh4ELVCVUp38z7vZtHx/Z93vJvRLRHnXNuTzRLIKUScxHfy/v
        U7N0u6aZDnm6cEPG4fU8M7Wn/9HGw8XD4NtnBLP7AfoEf5r3+3ofsWzwBzIaaqRFqjbMAxCKf8Cuh
        4NdQlTC3EFmMFdeVtJvq/DUA72P5Bc8k1BZN9lOCRQhgXZfgxnQE2U1PR1qC8QDkGu17pT6q5Uu+w
        0xwdtMUOg/gX0acaa53dos8UQ1/ePBHqiEa2akjxZZpH98ZJIv0ryPlnSyycEPcFA7Nucy2AZadIC
        njzG+n1nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iolSx-0000tV-9v; Tue, 07 Jan 2020 09:47:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F1B93025C3;
        Tue,  7 Jan 2020 10:46:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90E112B5FB0B3; Tue,  7 Jan 2020 10:47:56 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:47:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Li Guanglei <guangleix.li@gmail.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        guanglei.li@unisoc.com
Subject: Re: [PATCH v01] sched/core: uclamp: fix rq.uclamp memory size of
 initialization
Message-ID: <20200107094756.GW2844@hirez.programming.kicks-ass.net>
References: <1577259844-12677-1-git-send-email-guangleix.li@gmail.com>
 <20191229221119.oaxrygmi37cnzqas@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229221119.oaxrygmi37cnzqas@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 10:11:20PM +0000, Qais Yousef wrote:
> On 12/25/19 15:44, Li Guanglei wrote:
> > From: Li Guanglei <guanglei.li@unisoc.com>
> > 
> > uclamp_rq for each clamp id(UCLAMP_CNT) should be initialized when call
> 
> s/clamp id(UCLAMP_CNT)/UCLAMP_CNT/
> 
> > init_uclamp.
> > 
> > Signed-off-by: Li Guanglei <guanglei.li@unisoc.com>
> 
> This need fixes tag
> 
> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcountinga")
> 
> Otherwise this looks good to me.
> 
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks! It now looks something like so:

---
Subject: sched/core: Fix size of rq::uclamp initialization
From: Li Guanglei <guanglei.li@unisoc.com>
Date: Wed, 25 Dec 2019 15:44:04 +0800

rq::uclamp is an array of struct uclamp_rq, make sure we clear the
whole thing.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcountinga")
Signed-off-by: Li Guanglei <guanglei.li@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Link: https://lkml.kernel.org/r/1577259844-12677-1-git-send-email-guangleix.li@gmail.com
---
 kernel/sched/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1253,7 +1253,8 @@ static void __init init_uclamp(void)
 	mutex_init(&uclamp_mutex);
 
 	for_each_possible_cpu(cpu) {
-		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		memset(&cpu_rq(cpu)->uclamp, 0,
+				sizeof(struct uclamp_rq)*UCLAMP_CNT);
 		cpu_rq(cpu)->uclamp_flags = 0;
 	}
 
