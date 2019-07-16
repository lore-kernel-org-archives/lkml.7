Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F3C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F8920880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uakV8TcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbfGPJzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:55:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44011 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733254AbfGPJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:55:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so9173069pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9CPag+ihAeKmeHNKcPHDy3IUTBk0GySQWFpNM7jlh0=;
        b=uakV8TcQGVyYIY3mCGPNuqIsaoT779Q6itiqhB5woh+Rh4UZK047zRIWVEwZGqm/Uo
         R9tyHSLa4YS1kRHGj0xlEB4bsQaC6dKp7/BR7xQ9fqA3/riZMPfZnU4YUvqHvPKfuUV0
         yzMy0zq1h1C1ra+z/k+whZQAJ7TmP9A70pJlzHhumNS5RQ8wousuAAKMnLmbiaPvlGT8
         DC1MBvbhsZFOVnhcAAfU0Z7VCn+5kx18m7HOrXgrfUqQIEKP+w6TL498T8V0cCSI0JN4
         0l8eUsimM2NqHmfrb68Lf/PYsX4n4eCZwcs6oGHdDFl3oa7zTKk+NBCKbDLWRiSeEk4v
         5fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9CPag+ihAeKmeHNKcPHDy3IUTBk0GySQWFpNM7jlh0=;
        b=BKQ54Blf2Lmo2Qi2yJ9JiYoOne+dmj1Muzb3lon3UDrxNctE0g1qVc8SM/4ZXoi9Ar
         /TjJQ4w7BEr2pUxjSEmmW8ksqZLzB3VLz/RvbuGbLl+3n/YjawQEwgeeaddVJuYMIB2e
         cKyWI+DcbmvaCfP+7x5e/f1yzUh5IUdG+ifiyq7b64SSq297OObpA9+A5fkyIzyllOcp
         m4eAKMdvqFfdYeUfQaZOhdbsKNqculc5rIRGJ0PDL5BDZ+QdRf8hvOzfJdoVt3KLLSwY
         +8x6oDn8l+W/xFM0S9OI7rTsVywsL8xN6cjr6BCdIjVhSJz0a8iKF6XG07LUUIv7Fpsw
         UIYg==
X-Gm-Message-State: APjAAAUbfNv0hLh5jCZ9eHNcYcIu7vWY8jZ38T3TjOWxPNkzev7jodV9
        uNewPnLM8Wsl4oqNOensDL6zLQ==
X-Google-Smtp-Source: APXvYqxSyjUvTCMPHA7wt8ibpdmo4x3Z3PJd0gErdaHsbd0ES3WkY7e8V0mPoQFvBA0/mGSwtVS/nw==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr25725239pgp.339.1563270926697;
        Tue, 16 Jul 2019 02:55:26 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 21sm8260153pfj.76.2019.07.16.02.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:55:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] Documentation: cpufreq: Update policy notifier documentation
Date:   Tue, 16 Jul 2019 15:24:54 +0530
Message-Id: <437a6b7e7876b6edee52f7ef829ee905b14d89a5.1563270828.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563270828.git.viresh.kumar@linaro.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation with the recent policy notifier updates.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/core.txt | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.txt
index 073f128af5a7..af5c0d60b466 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.txt
@@ -57,19 +57,11 @@ transition notifiers.
 2.1 CPUFreq policy notifiers
 ----------------------------
 
-These are notified when a new policy is intended to be set. Each
-CPUFreq policy notifier is called twice for a policy transition:
+These are notified when a new policy is created or removed.
 
-1.) During CPUFREQ_ADJUST all CPUFreq notifiers may change the limit if
-    they see a need for this - may it be thermal considerations or
-    hardware limitations.
-
-2.) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy
-   - if two hardware drivers failed to agree on a new policy before this
-   stage, the incompatible hardware shall be shut down, and the user
-   informed of this.
-
-The phase is specified in the second argument to the notifier.
+The phase is specified in the second argument to the notifier.  The phase is
+CPUFREQ_CREATE_POLICY when the policy is first created and it is
+CPUFREQ_REMOVE_POLICY when the policy is removed.
 
 The third argument, a void *pointer, points to a struct cpufreq_policy
 consisting of several values, including min, max (the lower and upper
-- 
2.21.0.rc0.269.g1a574e7a288b

