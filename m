Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64FBC00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FAF222C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cEa3vrOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgADAQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:16:11 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38262 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADAQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:16:11 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so37994182ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RIuIVfrtLNNAiQWfhBPKfzpkRqoqLkA3Gbkp2W9uaMc=;
        b=cEa3vrOjQzP1RRyZickGPt9aNoGbQtU+fWZSCZXQjNGUio6oEaZVzE08Wp0o/d7LZp
         BOJIWAHWNdatUJjdL5dul9Wl4TzRM5SSZuEHyj9JNI2Cecmmb36O25kCu8wvqmDDEvXq
         NOaQmDfxmPD5jrsKAhP4brsYT8+R3rcNCUnSSM7u+dfOnHIA8ziN5hQ66+OvcLspVgEt
         RUA1DHOg8fWBJUxoC/BEQymAro4k8y02UazMzNNmPNIZJg8MRBOn6C27Gypzcj3IrOPD
         waHQCUpwzqHhXVJbUBClexG9/5j+fC37eakd5I8NbsYN2UzbNiyWcLw08BTK9so4CGJy
         R4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RIuIVfrtLNNAiQWfhBPKfzpkRqoqLkA3Gbkp2W9uaMc=;
        b=CAWRF1msUk/N8LRw6zejjqcSXZFdsoNM5C7KUArH0d97YSaiOyapsMe7U5q3gfyrnV
         QYf5qVJ18p7ic9HJXCg0UFwUXXMyl0TGpbhMPq/Q90V3EntloReJUraO/a999NKM1KOq
         9nVwtJJFb9kGvTN+pkcK3i6N6S/hSesoGwOYcbv75QBQZ8PMW3kH1DHUVcZcArWAzUh8
         UjEcLDzuopAEYP5zHLzggfr97Rk1NKsBtfTbn6jJgcDnP9UJ4poVrAOK6tqweJV8eVkh
         PwbbxtCIIW/v7T939PWUB3l9OEhQFsQunrGXg12kjaXRmVRoQsEgZR9LBwY3l8zYqJTI
         IMCA==
X-Gm-Message-State: APjAAAUnisai/JuzB29AJ8PEuWE922IUpYin11L2Ypagz6Es7B9m9qZK
        vKqtQqIaWf3glnAHJIjScNgL5g==
X-Google-Smtp-Source: APXvYqxkrVblXVx0hs2/Nq99Phv4hhYCekQHGzSYfABZIS29YvXZZ98C6UocOym5iQzvXtjKas8Ljg==
X-Received: by 2002:a92:58d7:: with SMTP id z84mr73885881ilf.179.1578096970132;
        Fri, 03 Jan 2020 16:16:10 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id s17sm9609596iob.81.2020.01.03.16.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:16:09 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:16:07 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Zong Li <zong.li@sifive.com>
cc:     palmer@dabbelt.com, rostedt@goodmis.org, anup@brainfault.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] clocksource/drivers/riscv: add notrace to
 riscv_sched_clock
In-Reply-To: <20191223084614.67126-3-zong.li@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001031614370.283180@viisi.sifive.com>
References: <20191223084614.67126-1-zong.li@sifive.com> <20191223084614.67126-3-zong.li@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, Zong Li wrote:

> When enabling ftrace graph tracer, it gets the tracing clock in
> ftrace_push_return_trace. Eventually, it invokes the riscv_sched_clock to
> get the clock. If add mcount instrument in riscv_sched_clock, it will
> call ftrace_push_return_trace and cause infinite loop.
> 
> The result of failure as follow:
> 
> command: echo function_graph >current_tracer
> [   46.176787] Unable to handle kernel paging request at virtual address ffffffe04fb38c48
> [   46.177309] Oops [#1]
> [   46.177478] Modules linked in:
> [   46.177770] CPU: 0 PID: 256 Comm: $d Not tainted 5.5.0-rc1 #47
> [   46.177981] epc: ffffffe00035e59a ra : ffffffe00035e57e sp : ffffffe03a7569b0
> [   46.178216]  gp : ffffffe000d29b90 tp : ffffffe03a756180 t0 : ffffffe03a756968
> [   46.178430]  t1 : ffffffe00087f408 t2 : ffffffe03a7569a0 s0 : ffffffe03a7569f0
> [   46.178643]  s1 : ffffffe00087f408 a0 : 0000000ac054cda4 a1 : 000000000087f411
> [   46.178856]  a2 : 0000000ac054cda4 a3 : 0000000000373ca0 a4 : ffffffe04fb38c48
> [   46.179099]  a5 : 00000000153e22a8 a6 : 00000000005522ff a7 : 0000000000000005
> [   46.179338]  s2 : ffffffe03a756a90 s3 : ffffffe00032811c s4 : ffffffe03a756a58
> [   46.179570]  s5 : ffffffe000d29fe0 s6 : 0000000000000001 s7 : 0000000000000003
> [   46.179809]  s8 : 0000000000000003 s9 : 0000000000000002 s10: 0000000000000004
> [   46.180053]  s11: 0000000000000000 t3 : 0000003fc815749c t4 : 00000000000efc90
> [   46.180293]  t5 : ffffffe000d29658 t6 : 0000000000040000
> [   46.180482] status: 0000000000000100 badaddr: ffffffe04fb38c48 cause: 000000000000000f
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks; below is what's been queued for v5.5-rc.


- Paul


From: Zong Li <zong.li@sifive.com>
Date: Mon, 23 Dec 2019 16:46:14 +0800
Subject: [PATCH 1/2] clocksource/drivers/riscv: add notrace to
 riscv_sched_clock

When enabling ftrace graph tracer, it gets the tracing clock in
ftrace_push_return_trace().  Eventually, it invokes riscv_sched_clock()
to get the clock value.  If riscv_sched_clock() isn't marked with
'notrace', it will call ftrace_push_return_trace() and cause infinite
loop.

The result of failure as follow:

command: echo function_graph >current_tracer
[   46.176787] Unable to handle kernel paging request at virtual address ffffffe04fb38c48
[   46.177309] Oops [#1]
[   46.177478] Modules linked in:
[   46.177770] CPU: 0 PID: 256 Comm: $d Not tainted 5.5.0-rc1 #47
[   46.177981] epc: ffffffe00035e59a ra : ffffffe00035e57e sp : ffffffe03a7569b0
[   46.178216]  gp : ffffffe000d29b90 tp : ffffffe03a756180 t0 : ffffffe03a756968
[   46.178430]  t1 : ffffffe00087f408 t2 : ffffffe03a7569a0 s0 : ffffffe03a7569f0
[   46.178643]  s1 : ffffffe00087f408 a0 : 0000000ac054cda4 a1 : 000000000087f411
[   46.178856]  a2 : 0000000ac054cda4 a3 : 0000000000373ca0 a4 : ffffffe04fb38c48
[   46.179099]  a5 : 00000000153e22a8 a6 : 00000000005522ff a7 : 0000000000000005
[   46.179338]  s2 : ffffffe03a756a90 s3 : ffffffe00032811c s4 : ffffffe03a756a58
[   46.179570]  s5 : ffffffe000d29fe0 s6 : 0000000000000001 s7 : 0000000000000003
[   46.179809]  s8 : 0000000000000003 s9 : 0000000000000002 s10: 0000000000000004
[   46.180053]  s11: 0000000000000000 t3 : 0000003fc815749c t4 : 00000000000efc90
[   46.180293]  t5 : ffffffe000d29658 t6 : 0000000000040000
[   46.180482] status: 0000000000000100 badaddr: ffffffe04fb38c48 cause: 000000000000000f

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[paul.walmsley@sifive.com: cleaned up patch description]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 4e54856ce2a5..c4f15c4068c0 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -56,7 +56,7 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
 	return get_cycles64();
 }
 
-static u64 riscv_sched_clock(void)
+static u64 notrace riscv_sched_clock(void)
 {
 	return get_cycles64();
 }
-- 
2.24.0

