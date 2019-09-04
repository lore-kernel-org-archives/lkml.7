Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156F4C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ECC22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620420;
	bh=Aonhen+Hf0IKqypzw6q6wfDZU0CswYTHcylXX+4eS8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7wJtz6s41iDC0uYE9oFrd4a08XbyoW7+jfCRKWPNBRQCD/An6umghDGIM/jGWMIl
	 RY42Wjo/sIKyGRq6hqueINTj3DJO0sdRTq0/Xr3OlVQU1l4+X6SaRKy49Zv9WeXsGY
	 7SZnEMrHZUmZohl42ETp5MglmuuPpEoMU364TpQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbfIDSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389118AbfIDSG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:06:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673C022CEA;
        Wed,  4 Sep 2019 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620416;
        bh=Aonhen+Hf0IKqypzw6q6wfDZU0CswYTHcylXX+4eS8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr9WFpX1qup9H7n+9CZuuVzmc8uhY4+8J6PK2g3ICbo1jVWzXRmAee+PPtQwuqBUd
         tXVC7veMrBYWRO1JREeHnf8hs6PMmULTjlVx23h0NdUmRqxPfxKDk+LLR1D0LD5QwA
         4S/Yy9QVWM/MkwzGu6atypy7SuWvUme+VOLFuWN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 51/93] ftrace: Fix NULL pointer dereference in t_probe_next()
Date:   Wed,  4 Sep 2019 19:53:53 +0200
Message-Id: <20190904175307.427412338@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

commit 7bd46644ea0f6021dc396a39a8bfd3a58f6f1f9f upstream.

LTP testsuite on powerpc results in the below crash:

  Unable to handle kernel paging request for data at address 0x00000000
  Faulting instruction address: 0xc00000000029d800
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE SMP NR_CPUS=2048 NUMA PowerNV
  ...
  CPU: 68 PID: 96584 Comm: cat Kdump: loaded Tainted: G        W
  NIP:  c00000000029d800 LR: c00000000029dac4 CTR: c0000000001e6ad0
  REGS: c0002017fae8ba10 TRAP: 0300   Tainted: G        W
  MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28022422  XER: 20040000
  CFAR: c00000000029d90c DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
  ...
  NIP [c00000000029d800] t_probe_next+0x60/0x180
  LR [c00000000029dac4] t_mod_start+0x1a4/0x1f0
  Call Trace:
  [c0002017fae8bc90] [c000000000cdbc40] _cond_resched+0x10/0xb0 (unreliable)
  [c0002017fae8bce0] [c0000000002a15b0] t_start+0xf0/0x1c0
  [c0002017fae8bd30] [c0000000004ec2b4] seq_read+0x184/0x640
  [c0002017fae8bdd0] [c0000000004a57bc] sys_read+0x10c/0x300
  [c0002017fae8be30] [c00000000000b388] system_call+0x5c/0x70

The test (ftrace_set_ftrace_filter.sh) is part of ftrace stress tests
and the crash happens when the test does 'cat
$TRACING_PATH/set_ftrace_filter'.

The address points to the second line below, in t_probe_next(), where
filter_hash is dereferenced:
  hash = iter->probe->ops.func_hash->filter_hash;
  size = 1 << hash->size_bits;

This happens due to a race with register_ftrace_function_probe(). A new
ftrace_func_probe is created and added into the func_probes list in
trace_array under ftrace_lock. However, before initializing the filter,
we drop ftrace_lock, and re-acquire it after acquiring regex_lock. If
another process is trying to read set_ftrace_filter, it will be able to
acquire ftrace_lock during this window and it will end up seeing a NULL
filter_hash.

Fix this by just checking for a NULL filter_hash in t_probe_next(). If
the filter_hash is NULL, then this probe is just being added and we can
simply return from here.

Link: http://lkml.kernel.org/r/05e021f757625cbbb006fad41380323dbe4e3b43.1562249521.git.naveen.n.rao@linux.vnet.ibm.com

Cc: stable@vger.kernel.org
Fixes: 7b60f3d876156 ("ftrace: Dynamically create the probe ftrace_ops for the trace_array")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3112,6 +3112,10 @@ t_probe_next(struct seq_file *m, loff_t
 		hnd = &iter->probe_entry->hlist;
 
 	hash = iter->probe->ops.func_hash->filter_hash;
+
+	if (!hash)
+		return NULL;
+
 	size = 1 << hash->size_bits;
 
  retry:


