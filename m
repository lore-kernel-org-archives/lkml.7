Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE07C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DE82147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4X9nbNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDDAed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:34:33 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53907 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfDDAdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:49 -0400
Received: by mail-pl1-f202.google.com with SMTP id 102so605697plb.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J18ALo3LueGVhn7lBcFJjxgV6Duc6Nrvg9c6IUw3gFk=;
        b=f4X9nbNHfY4KPoiY2rsTDeZzZS0xVYDSJh48T/INc5xcxO6l06XtPToGB5Yf4apcsF
         QO9MOn/GG22R7EaKsFZ5VoOMO2fyeDZ2nLv5NFyTUIcChYQg+eLUp5gALnVlBXrYfTQp
         RPpFDlg7gyi/RfbU/aUNdvCAMzBbq4Ux9qoL8qcq3qckUGaWWU5ehr//0EPmpZuM51fH
         rEXxgeXSu9SkJgqz7FnM2j66Vm7PfIenJp7rjiBnINO41wb0GMcbfQdm+vCGGxCVXqra
         UAy733GzeE5eTRjvF98IFUyGNKiT5Sa5nKXo2vH8rdjB/GkvJoZbfYLJS/M4g3VQ751b
         SkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J18ALo3LueGVhn7lBcFJjxgV6Duc6Nrvg9c6IUw3gFk=;
        b=GcsHVW9dk3M1Refn56zCkqtriBdgTaYeO0shG0Txz7W7+bP7XoxoBIidElPRHDl+bS
         jtxQUnpUpDHHB/dpUPBJu2a88DP+GNf1wQ3JA0WU6QeB11wYAOiOKgt05ZyvRUuUnQ5F
         P9sdFjchorfKOXHFJ7myPB0FemVr2k4wvuS6B3o3IJTq+Jlx2JuTvrLNo1oT0BtaZ4ot
         sRuOcQZdyljXoFDT1gC5FxR9Pb9g7dbOApmaA03qG2dQBZnN48dM5TaS+Hu1N9g4ZhQK
         yFy4baTfl67zViMDoptpjAmJq7c5+ooThZ8eHZdkphVcRrS+URhhJcUUkvAnHS51vAgo
         jEOg==
X-Gm-Message-State: APjAAAU0GM5SnjyWYq4Q+WMR1eKnr+H/pJkY5Q85nkJoGdciVfaI87Yn
        r9l0AmSeaoOa+PcOgRTJfwabTe2A/HM3gQHgwJgXTg==
X-Google-Smtp-Source: APXvYqz4j3QeuhcSeCpssrYno1HhWQWSUHEQbxzBBQkzAYaBEuGhtUI12IUFX6VGtthFChJDwz6dBYHGr0vkhfKiuAft8A==
X-Received: by 2002:a65:6483:: with SMTP id e3mr60177pgv.12.1554338028850;
 Wed, 03 Apr 2019 17:33:48 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:43 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 21/27] Lock down tracing and perf kprobes when in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the creation of perf and ftrace kprobes when the kernel is
locked down in confidentiality mode by preventing their registration.
This prevents kprobes from being used to access kernel memory to steal
crypto data, but continues to allow the use of kprobes from signed
modules.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d5fb09ebba8b..5c70acd80344 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -420,6 +420,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	if (kernel_is_locked_down("Use of kprobes", LOCKDOWN_CONFIDENTIALITY))
+		return -EPERM;
+
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
-- 
2.21.0.392.gf8f6787159e-goog

