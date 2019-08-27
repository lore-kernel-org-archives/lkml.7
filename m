Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D8BC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAEB2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e3Ygvu5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfH0BeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:34:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40264 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfH0BeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:34:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so10914467pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 18:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=xxFI6ubLbfvjqXcL3rM1wnq7rt5BMnyUXxlv1J4AS0Q=;
        b=e3Ygvu5J0zehwvX/hkR4phMoJOKLlyyexZO8KmLKOZtMg3ljaSQUG2Ds58XnVxxL+N
         GR2YW0Bb2sLP2U8woHfkxj80klllMOuir65UJxAKM9ecZxY/i1opwESlt+nzcZyEhIXV
         8RzM7b2RHkxgtzP74x4xTamgRq/AvYaKy70/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=xxFI6ubLbfvjqXcL3rM1wnq7rt5BMnyUXxlv1J4AS0Q=;
        b=AZcSIL+4n7uMf2rftM1WvyZVQxitYypYQbsDNXnXjxsI4G4c/uyU/3+F43TZWldudS
         QC+6YPOSE6yLvj0ofb96RygaNht8HFVAl4YnbvP7C/kCpfO2DZGM26BoQTPLHOS/F+WT
         kC+dNqTI/RqNil6xmVcAsOYrCM1sxkhMEBBy6p+4ov9IHHvlDi5fnSXom+Po9uD7nxCQ
         4tOfFtAUHj/ZNGU/IlshJiUL2k6FGj4S+xUNdppbPa3qn53lBknH661hsoC/R7/4hEBX
         mpfEVz7zLLFLTQW6U5pgTuWf4lgxOe6u4xKby+AibYSehjeutrCzI/Ra/C+ii/tOy6lr
         oeyw==
X-Gm-Message-State: APjAAAVcxuMjAWvGC15fFFbYyA7vqsm4qmL1I5HvxaNwrAT5d9IhdVG/
        2C4rRuAadTRzCwnMjejHq7e1/L93kGY=
X-Google-Smtp-Source: APXvYqwjzLrAOwdKPlmJhuS5wQw/M9bUwQQM6llz4Ui6ajHAOO1fUqtwJM3NdgDsWk8wh7+ffL4/ig==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr21244217ply.337.1566869652172;
        Mon, 26 Aug 2019 18:34:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n185sm11984541pga.16.2019.08.26.18.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 18:34:11 -0700 (PDT)
Message-ID: <5d648893.1c69fb81.5e60a.fc6c@mx.google.com>
X-Google-Original-Message-ID: 156686963125060@cam.corp.google.com
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC v1 0/2] RCU dyntick nesting counter cleanups
Date:   Mon, 26 Aug 2019 21:33:52 -0400
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches clean up the usage of dynticks nesting counters simplifying the
code, while preserving the usecases.

It is a much needed simplification, makes the code less confusing, and prevents
future bugs such as those that arise from forgetting that the
dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
common situations.

Several nights of rcutorture testing with CONFIG_RCU_EQS_DEBUG on all RCU
kernel configurations have survived without any splats.

Further testing is in progress, hence marked as RFC!

thanks,

 - Joel

Joel Fernandes (Google) (2):
rcu/tree: Clean up dynticks counter usage
rcu/tree: Remove dynticks_nmi_nesting counter

.../Data-Structures/Data-Structures.rst       | 31 ++----
Documentation/RCU/stallwarn.txt               |  6 +-
kernel/rcu/rcu.h                              |  4 -
kernel/rcu/tree.c                             | 98 +++++++++----------
kernel/rcu/tree.h                             |  4 +-
kernel/rcu/tree_stall.h                       |  4 +-
6 files changed, 64 insertions(+), 83 deletions(-)

--
2.23.0.187.g17f5b7556c-goog

