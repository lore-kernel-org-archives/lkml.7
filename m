Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD460C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE15206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="rBfPBrvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLaI6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 03:58:25 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37753 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 03:58:24 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so5502772uah.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 00:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vTwhE34G2EQrxYCOGa6ICBnbyQtGjJl5kOerqp9PP+k=;
        b=rBfPBrvx6R5HgioGzrnVdZfWULjZhDqnTQXoR4gd5ZTnxcmrt3klxae2NiEukMuUew
         pl8mLL/gWSJn7DAK5ZfOQkH6QS83TdK0ClZX1O2ViBoiqZFhyRby4m65LBFxRLHfYxl/
         LRYyoHy/j5IWRzs1vMdBHKHVG9g+uXai8FbMDX8nFPY1zmlmCbElaGcO0yDP1nPRShcZ
         z7F/Hew6gzjGgzp4xDdXvg4e3Prl34tW6dJ3ygVwWysGelFVV/dKMjaQ2JARGqcHjwEK
         /QCdOi+RsopzehhvuHpT/meeZj0rJFST8OiEC2Tdt0IAvfrBdBtajTii4eq/KzcqSqgx
         Vgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vTwhE34G2EQrxYCOGa6ICBnbyQtGjJl5kOerqp9PP+k=;
        b=ssJLUJjhnNvj8V8bKwzZMdKWbUf7RRZn/M+IuVVXVisPGyjyQC9BZQ47EYYReaRPrn
         4v9K+uckshukQ03YK9titpFO1cnGdj/8ltucitIz74kRU8CLLp+YF4bHSiRdduwwSZ+L
         pCJsfNpchNvXmLWHLAXGDrSkj9P5QARp4ojboZA6AgrnzUbmx2CYApl0Pt3eYBty3TPJ
         Aa/vIX/4SzK58MQN7SC1BXe9x7cfFDFmpPrJ1dJYom3hLLWz/9QEs+HosA42Lkgi893D
         CIUPF1eKlI95v+OtmHblptczVmc81UD7R8SxSQUuCEtHsKPk+dhEwRrV6uSztIropgx7
         oEQg==
X-Gm-Message-State: APjAAAXTbs1mPwUTjkkt9NgsvvzGtz+LCdRAB2cilztPEtfPLcTmbRK2
        qVZOHpiaO6jRR2PpU3rMq2f9QQ==
X-Google-Smtp-Source: APXvYqyGsHpWL739HSNavKQ5WKKCxK4OvP13tIQGLUoPTSmt99scgZ+e/WbkG8kJ3AuiCGF40Dv1rw==
X-Received: by 2002:a9f:282a:: with SMTP id c39mr39817343uac.103.1577782703763;
        Tue, 31 Dec 2019 00:58:23 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id o39sm11204236uad.6.2019.12.31.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 00:58:23 -0800 (PST)
Date:   Tue, 31 Dec 2019 03:58:22 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com
Subject: [PATCH] tracing: Resets the trace buffer after a snapshot
Message-ID: <20191231085822.yxhph6wcguejb7al@frank-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when a snapshot is taken the trace_buffer and the
max_buffer are swapped. After this swap, the "new" trace_buffer is
not reset. This produces an odd behavior: after a snapshot is taken
the previous snapshot entries become available to the next reader of
the trace_buffer as far as the reading occurs before the buffer is
refilled with new entries by a writer.

This patch resets the trace buffer after a snapshot is taken.

Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---

The following commands illustrate this odd behavior:

# cd /sys/kernel/debug/tracing
# echo nop > current_tracer
# echo 1 > tracing_on
# echo m1 > trace_marker
# echo 1 > snapshot
# echo m2 > trace_marker
# echo 1 > snapshot
# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:2
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            bash-550   [000] ....    50.479755: tracing_mark_write: m1


 kernel/trace/trace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ddb7e7f5fe8d..58373b5ae0cf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6867,10 +6867,13 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			break;
 		local_irq_disable();
 		/* Now, we're going to swap */
-		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
+		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 			update_max_tr(tr, current, smp_processor_id(), NULL);
-		else
+			tracing_reset_online_cpus(&tr->trace_buffer);
+		} else {
 			update_max_tr_single(tr, current, iter->cpu_file);
+			tracing_reset_cpu(&tr->trace_buffer, iter->cpu_file);
+		}
 		local_irq_enable();
 		break;
 	default:
-- 
2.17.1

