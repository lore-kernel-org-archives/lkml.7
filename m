Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60CC2467A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431205;
	bh=VUk8N758h10bHhDX3icRA/m2eVIpqZWmuwjnkIMvuAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uzelF0n92GdXfuJux2b8iTShxd4PsjSXii4ofpV1RmNbOfiiLQMUPLcuhZU+TbLp3
	 rlxNwWuoIiuPMar8fHUKYgU140HJN6qE7HJnHw/Etftd+iWu7fpPKJtZRfDSgAI0fP
	 QOc3s39broGEiNiuBFgDRNarhsO5inTvrkVR0tlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgAGVGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgAGVGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:06:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EB92072A;
        Tue,  7 Jan 2020 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431195;
        bh=VUk8N758h10bHhDX3icRA/m2eVIpqZWmuwjnkIMvuAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlJO7OPfFdi2/9QqN6nYhu1nQmAq4wEh/e5A8d9Ow/cRmN5xuwDYOYDx+4zvoEkNO
         MdJAsp8saOnXEVmSncXWW2H8LrLERXJddbShyuyieR2WQ9cADnwFFOW/P8ZG1HSZxI
         iuyd2SloMggMxnFkqE/9Dy3K6S0SGMu5+BqWtFCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 072/115] tracing: Fix endianness bug in histogram trigger
Date:   Tue,  7 Jan 2020 21:54:42 +0100
Message-Id: <20200107205304.023893520@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

commit fe6e096a5bbf73a142f09c72e7aa2835026eb1a3 upstream.

At least on PA-RISC and s390 synthetic histogram triggers are failing
selftests because trace_event_raw_event_synth() always writes a 64 bit
values, but the reader expects a field->size sized value. On little endian
machines this doesn't hurt, but on big endian this makes the reader always
read zero values.

Link: http://lore.kernel.org/linux-trace-devel/20191218074427.96184-4-svens@linux.ibm.com

Cc: stable@vger.kernel.org
Fixes: 4b147936fa509 ("tracing: Add support for 'synthetic' events")
Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_hist.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -665,7 +665,26 @@ static notrace void trace_event_raw_even
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
-			entry->fields[n_u64] = var_ref_vals[var_ref_idx + i];
+			struct synth_field *field = event->fields[i];
+			u64 val = var_ref_vals[var_ref_idx + i];
+
+			switch (field->size) {
+			case 1:
+				*(u8 *)&entry->fields[n_u64] = (u8)val;
+				break;
+
+			case 2:
+				*(u16 *)&entry->fields[n_u64] = (u16)val;
+				break;
+
+			case 4:
+				*(u32 *)&entry->fields[n_u64] = (u32)val;
+				break;
+
+			default:
+				entry->fields[n_u64] = val;
+				break;
+			}
 			n_u64++;
 		}
 	}


