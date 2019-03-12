Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1C3214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfCLI6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:58:41 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54054 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726638AbfCLI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:58:40 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2C8wd7M011032
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:58:39 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2C8wYlN012145
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:58:39 -0400
Received: by mail-qt1-f197.google.com with SMTP id p5so1639300qtp.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=0apvxecUW+k4NfI2y5dbyFeFJ6xBK7zfPjD0AugeSx4=;
        b=I5E4e5F9Rj4JnXZnF6Vi7r9NKnRd6ZJRtm6iBFxL3zhphgYqAArUsAootqnlwz/5mS
         CFgHnMFWR2Ph5SchciP5gP5YNhSI8ZR8kUvk1rf26YxL9/epovOKxUZ7458Cjg0/EQt3
         yiw81VTHcUKd1DE2RWXyQuUegJeJNz0lpFoqkn9WpiafvqQ4ryjBqrb+BpUg4MCHXOGT
         yKSYIlVf3Bo1A+WMmHFDE6IRy3huXP7pLL0rlzs24w4JDjswlh313Ko7Ae2g5dSfZgSG
         wbvUajZTwnt64M0Pokx0pXrONb4txPdMPYF8eaAGJ3+f9pJMwiTYicQmdDzn+FHzFljX
         ws6A==
X-Gm-Message-State: APjAAAVBUkw4p6iuS+qjjyZQMlxoQUfK9oDDreKgpUbXZQKGRan+I2jW
        gtBOyCiR5YXMcty19FIUeBQJIhpfwd3vRS2VJgPBUuedFFk8OlsVGpPlL9arErSAxUjclzyFVOA
        dqk+ZglX8RrsU68F1dBRWXoxWUrI8kKtcCcY=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr6172507qtb.357.1552381114420;
        Tue, 12 Mar 2019 01:58:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyiop5OLkdTtE1s1kQID3VqWNy78e1iEXj9N2YQ/LiTjIPF/JUcholhlwpagtvHs7Mw+ziBqA==
X-Received: by 2002:aed:20e3:: with SMTP id 90mr6172496qtb.357.1552381114282;
        Tue, 12 Mar 2019 01:58:34 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id h27sm1709156qkk.92.2019.03.12.01.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:58:33 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/trace/trace_kprobe.c - fix comment format
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 04:58:32 -0400
Message-ID: <2812.1552381112@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  CC      kernel/trace/trace_kprobe.o
kernel/trace/trace_kprobe.c:41: warning: cannot understand function prototype: 'struct trace_kprobe '

The real problem is that a comment looked like kerneldoc when it shouldn't be...

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9eaf07f99212..c825c591553a 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -35,7 +35,7 @@ static struct dyn_event_operations trace_kprobe_ops = {
 	.match = trace_kprobe_match,
 };
 
-/**
+/*
  * Kprobe event core functions
  */
 struct trace_kprobe {

