Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB03C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A5216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AjiQgysK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfK1Hqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:46:39 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:32968 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfK1Hqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:46:39 -0500
Received: by mail-lf1-f49.google.com with SMTP id d6so19299284lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 23:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jdx2MQkwvcftTUnPZKqg3iJvEsTP5EAA9GMYXynV6xQ=;
        b=AjiQgysKXtXC/dybUet8gn6KnPqsNuMCOSKRFTHcLFeRA19rTM5+ZQF+4BlJ9HqGTw
         88a1dYswJkqzye6tyQxnf5B4csb0v3fz9cEK1OEMEJmIIJv6GgkT12Y9PKWLhppWk5nQ
         3F1UxNBCvX2JoVhrDwdDGLda3WNwhtyZVkyN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jdx2MQkwvcftTUnPZKqg3iJvEsTP5EAA9GMYXynV6xQ=;
        b=Rw3TBSDLYdCttZiIq5/BD9OPFEScTqcdP7QckNGcswNiFrTR7+M1M5P+QJo2WCSXvX
         a/IfJJVbuMmPUhK1G5vJS2Hgr/eosZ5O92J6FxREp004VHdoDQ/msvqHpytxQxph0BA6
         RFlP7cVXboYkjGCR5g61Ke5Z+PtjdKOMnFsF738LReaEOtDC4SuC3z3M3Qm4kcn1cfoz
         kTuCXZxge8Xkj5ZYlw45SmiN0w4lumi85iZSMZGwRzvhgq1XrknYjFWVnMXXibMEy+4U
         znWN3iu1JDzUZhVGOAZMky7VmlOdjAiZoI8UJuYEBqus/jwJh6n7jxfwgQ5l5kQkr4+d
         7KXA==
X-Gm-Message-State: APjAAAWMpPETnbSmqljMwJSAj2pB88ppPMqv2EoAqJcZFZuq9VQdH0bC
        nkpC1wi5BfGFeQJri09gxpLdyw==
X-Google-Smtp-Source: APXvYqxzZJWSRNVX2K52T4NrLvmxBt7DhlSHllRy9y5O4IZxQVfRzgFQlNA1lLUPwnQ1OCwilSdlpQ==
X-Received: by 2002:ac2:5616:: with SMTP id v22mr21215766lfd.84.1574927196815;
        Wed, 27 Nov 2019 23:46:36 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 129sm8224582lfj.86.2019.11.27.23.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 23:46:36 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Optimization in pick_next_task
Message-ID: <9af14b44-81c7-cdb1-ed4f-2f684f9fdbb3@rasmusvillemoes.dk>
Date:   Thu, 28 Nov 2019 08:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel/sched/core.c, we have

        /*
         * Optimization: we know that if all tasks are in the fair class
we can
         * call that function directly,

But then the code goes on to do

                p = fair_sched_class.pick_next_task(rq, prev, rf);
                ...
                if (unlikely(!p))
                        p = idle_sched_class.pick_next_task(rq, prev, rf);

which still loads a function pointer and calls
pick_next_task_{fair,idle} through that. Should those be made extern and
used here, or am I misinterpreting what "directly" refers to?

Rasmus
