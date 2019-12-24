Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C88C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E82A206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="X2kIE41s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLXXwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:52:54 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42916 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLXXwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 18:52:54 -0500
Received: by mail-vk1-f194.google.com with SMTP id s142so5400913vkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 15:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4E/2wqIKz28ubvLgIUjPVPO4AakvBg1lZqS8m4r8eSs=;
        b=X2kIE41s46grKzpmcuW6/7CNY+JcRLYvIilA91dE/yHnHhmJS14VWCKQUHMkULyE9V
         0eDvHd0Ng+dQNCrxKaHG+mjTxj/VM8z59lwXavB++vYQswHpqOt1hcIrVIqX2TWSmL4d
         ZI6WT2MD+C1oS30urS4pX/ExUvOteXyLjsPnlZEyrBvTRTBRYGzrVX0ilYvrdnwrL+zO
         3/B1F+AmUOTMIGjr1SWN+4edlg3BTTphMyAaQSdyY/wxLhgqMOHzxD4dEBZ54TPpq1GL
         r/8nbmbwkh1feqnYwhAbHJSoNAGiYKGh/OG/0fyXqW7yOgrUEEOIh/W69a6Ir6m7hZzP
         HZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4E/2wqIKz28ubvLgIUjPVPO4AakvBg1lZqS8m4r8eSs=;
        b=EaFuRTbDzThRFsEReBd+6aVV25nJVFEC8Iai/f0l07DoDVZh6Q6W7Dtg7tEkARlXGb
         s7bJl8cfw7viBd1jNGmkzVJROKM4HOQmfPcw53d48DIq9wTZP4dsHNRV7QTt2p9Y9l/a
         Cdu5yhUpdIMh2kWA+R1FMvUdm18luU0nnD1PkwRvrreLar2TCG3adgC6hQna2wJeV/Q/
         5kTVf6LgdkgIbfCyirwhM8J3br7TNzFlvI2HyKCn+bBpVr/y4q/eazwBciJr4XBJYPd0
         3oyXvSN7Eht1RbEteSn8RVCM2qpWeCOJ2Pg4jjX5Gwp8Xu+JTeUkCYZ5VODKsURnXUNc
         6rEg==
X-Gm-Message-State: APjAAAWDECHT/0QnKGxb1ns/DX1BmsOIskbPcpjDTxYCufOmKr3eF7n+
        oWU1c1HwwzJj5YKtHdVbJ00GMQ==
X-Google-Smtp-Source: APXvYqypYJpDPduu3tGRpslbAykmUyby9NfpS892YqjPMp/fmzMHbTAr2aQhkFvIA62Di7U1ed1owA==
X-Received: by 2002:a1f:ae0c:: with SMTP id x12mr23229162vke.88.1577231572942;
        Tue, 24 Dec 2019 15:52:52 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id g140sm7534052vkf.18.2019.12.24.15.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 15:52:52 -0800 (PST)
Date:   Tue, 24 Dec 2019 18:52:51 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: [PATCH 3/3] docs: ftrace: Fix small notation mistake
Message-ID: <22f9a98a972c3155c7b478247a087a5efafde774.1577230982.git.frank@generalsoftwareinc.com>
References: <cover.1577230982.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577230982.git.frank@generalsoftwareinc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of iff ("if and only if") notation is not accurate in this case.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ring-buffer-design.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/ring-buffer-design.txt b/Documentation/trace/ring-buffer-design.txt
index ff747b6fa39b..2d53c6f25b91 100644
--- a/Documentation/trace/ring-buffer-design.txt
+++ b/Documentation/trace/ring-buffer-design.txt
@@ -37,7 +37,7 @@ commit_page - a pointer to the page with the last finished non-nested write.
 
 cmpxchg - hardware-assisted atomic transaction that performs the following:
 
-   A = B iff previous A == C
+   A = B if previous A == C
 
    R = cmpxchg(A, C, B) is saying that we replace A with B if and only if
       current A is equal to C, and we put the old (current) A into R
-- 
2.17.1

