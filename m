Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490BCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEA520679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573459265;
	bh=VRXJBXaDTjfrb1mI0S/QXy+w3IL3sZRBIWw/AHaAVXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NJJ0+LQtosRhF/Q8c9J7CCDWBwufU7Uc97qGzwbO9H4leLmazHbOkpiRA3vHJGmef
	 Qys2t9HeGotLvBrnHWtejkf0qQ+vFIb5s3AtjF8VeTJXfV0qevtLUjFL6wbkUaNPg1
	 9pcYGGM4zX2PNTrE0cD1+2g2td5RMoFgb+Zrn4VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfKKIBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:01:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39607 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:01:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so1905125wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1vVEP+E+m7Y4fysVNc+xD7OhAeGoFKJwI55qJ8eWGgw=;
        b=BbOZeR3s5S6o8RGm4Ouom/edrSVpuFZVsuPcPWPWpg+Ftx8qws7Uu2nqBoIVG77xpS
         6xSGOmYfceIpiIU0F3otVjmIizQrY3LCJ52hxEup+doof6od4LdiB+77sK4StqTr+fPt
         FDCqeyWpjkFZnGP+1ygcBpx2yLucKJhaw59X/g3YMurHSZ8CAJ4+7BM3+L9NhPtP8xkX
         lbVaLGMiqzrvJmbDbCJOmh0m7m96S0qbBxBKm8GrkrHDCj3RCP2NWs12MCi7+d6r6RJm
         vrB+m2bos5cCMX0886czI1cP9QSojl8emdKpsGezuY2g0o0sJE0AZS9pBiPrroP51B6Y
         uaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1vVEP+E+m7Y4fysVNc+xD7OhAeGoFKJwI55qJ8eWGgw=;
        b=R8Pt+bTX76LChhkK8xvxdtRZgOI4QqLl8Yqo6h8IFV7idNIb6yyqYTC6mR9DtDZYeU
         YOpT+G4To3NU9n2bKC3VUd5fMl4R9kILsLzlrlQltOwyrWklYB/URbmeRVRB5XjnKDP9
         1ENRpWoiDvA2WUnLzc/RugZnaQJLUm9/dyVIw+adyNZyK9dUIElsSSppntKxHwX09Qvs
         Wy8TKy0ryjoclz+BqZLe7fDIGfDPywPo1EQk1v/7jZ5Xjgwyjob2CQmMUIvkrBhpJNGG
         hdwNp3W8eUPebtHG2VjMGo+k/knMMu+JXtQ9GfHYkvqdPLeDXbC7f3XuNR0NDzDTqvYs
         J3lg==
X-Gm-Message-State: APjAAAXBfe+g8teYNjHLx5zRaMbuHQfqhAoOhmeztTKm9nhOrZURq/cq
        7Bx48HUbl8S5Ov55JY5HwNY8LGE2
X-Google-Smtp-Source: APXvYqzKbqb4J+ABncOUdXGpnHSWuz0P1bb7HF2RAJmEbi4noHprZ/M4QNYQNnbrVui3+zHLElIlhg==
X-Received: by 2002:adf:f303:: with SMTP id i3mr6254352wro.157.1573459261173;
        Mon, 11 Nov 2019 00:01:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 189sm19072780wmc.7.2019.11.11.00.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:01:00 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:00:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] irq_work: Convert flags to atomic_t
Message-ID: <20191111080058.GA72562@gmail.com>
References: <20191108160858.31665-1-frederic@kernel.org>
 <20191108160858.31665-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108160858.31665-2-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> We need to convert flags to atomic_t in order to later fix an ordering
> issue on cmpxchg() failure. This will allow us to use atomic_fetch_or().
> Also that clarify the nature of those flags.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/irq_work.h | 10 +++++++---
>  kernel/irq_work.c        | 18 +++++++++---------
>  kernel/printk/printk.c   |  2 +-
>  3 files changed, 17 insertions(+), 13 deletions(-)

You missed the irq_work use in kernel/bpf/stackmap.c - see the fix below.

Thanks,

	Ingo

===>
 kernel/bpf/stackmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index dcfe2d37ad15..23cf27ce0491 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -289,7 +289,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 
 	if (in_nmi()) {
 		work = this_cpu_ptr(&up_read_work);
-		if (work->irq_work.flags & IRQ_WORK_BUSY)
+		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
 			/* cannot queue more up_read, fallback */
 			irq_work_busy = true;
 	}

