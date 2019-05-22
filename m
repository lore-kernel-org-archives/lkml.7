Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0273AC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C242D20644
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558513943;
	bh=mT1FPfvdr/dGkIr4pBgWEXh274KkM+Hil9nvHfQ4kkY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e32XFa21G5gr2kmKpdcBmX9rJuAkJiEB8yrYq5kKYJYAVpR9/wnU81Z1lucs/Q+lM
	 PLIoeynfT0+DDaqfdJgjT14biKQmlyjvpTXTNjylnL6vfq9An/lstE8274Od0KCJX/
	 MhwxAX/x6Cwl5bGU9DUkz+nTfuFCPGsz/BdheI8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfEVIcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbfEVIcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:32:22 -0400
Received: from devnote2.wi2.ne.jp (unknown [103.5.140.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14948204EC;
        Wed, 22 May 2019 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558513942;
        bh=mT1FPfvdr/dGkIr4pBgWEXh274KkM+Hil9nvHfQ4kkY=;
        h=From:To:Cc:Subject:Date:From;
        b=fY1Z2KvIe+a82afaN9oe4kqH1gG6/zYIZva5MJHULmVbLBw6WFIZw6bd0jaZpWFyT
         FAviYyzJQpe7Wi1fZVy/U1PWK3kiBCiwy3b6xDsY5OxQixyCOAuXJTUWriJ3Jncuem
         muRo3b0ZpXlpS65VVE/pqebhTugD3hFx4S4CPDJ8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] Enable new kprobe event at boot
Date:   Wed, 22 May 2019 17:32:18 +0900
Message-Id: <155851393823.15728.9489409117921369593.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This v2 series adds a kernel parameter, 'kprobe_event=' to add and enable
new kprobe events at boot time.

In this version, I changed to use postcore_initcall() instead of
subsys_initcall() for kprobes initialization.

Currently ftrace can enable some existing trace events at boot time.
This also allows admin/developer to add new kprobe-events at boot
time to debug device drivers etc.

The syntax is similar to tracing/kprobe_events interface, but
uses ',' and ';' instead of ' ' and '\n' respectively. e.g.

  kprobe_event=p,func1,$arg1,$arg2;p,func2,$arg1

will add probes on func1 with the 1st and the 2nd arguments and on
func2 with the 1st argument.

Note that 'trace_event=' option enables trace event at very early
timing, but the events added by 'kprobe_event=' are enabled right
before enabling device drivers at this point. It is enough for
tracing device driver initialization etc.

Thank you,

---

Masami Hiramatsu (2):
      kprobes: Initialize kprobes at postcore_initcall
      tracing/kprobe: Add kprobe_event= boot parameter


 Documentation/admin-guide/kernel-parameters.txt |   13 ++++++
 Documentation/trace/kprobetrace.rst             |   14 ++++++
 kernel/kprobes.c                                |    3 -
 kernel/trace/trace_kprobe.c                     |   54 +++++++++++++++++++++++
 4 files changed, 82 insertions(+), 2 deletions(-)

--
Masami Hiramatsu (Linaro)
