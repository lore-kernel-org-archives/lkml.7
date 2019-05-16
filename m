Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8797C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D192082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558046295;
	bh=O3aAna4OKLt2YXhiPy3mAYtt6yGXq9TXqns2IOQYDkc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rEr2F+ficpNMft0tuub+/U2AAPQ/sZaj6Vjh0aEdkVoc6iZ6FK4mSAkOMLI0NWhQO
	 DQA4KYLLS3qPnO5nJNS35hVkQamcYolCm+2dDg894JB6FnLICew7DMM5nhNE/iO+6V
	 39AQsBCcrs9biZ21KK5AV/Gu/B5Y8a2J2wViQFtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfEPWiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 18:38:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33111 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfEPWiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 18:38:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so5980319qtf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EWXzXtWxkqwu0CPQRvvsDDIoqrmy6tr8WAbR6k8JzAM=;
        b=OOMTDvz72lqgTdq6+PPpmUMakmyAIeVpw8XEX23d8uoFzmVfMdtjt79froGhRfX+YM
         uFXNh6TiWVlLUJ/wE5RKoQsCnBmejeQRRdTyNdYF+W/vSKLBICViF4tebAieNf/g7+iW
         6ucVXtPb6SXZsj3Ii6UBSYZRjq9zg5IujkPYnKYBjR4oHY043Lup1e8On4u8mWNQh1ml
         TcdSVZBDZg9Xf77tMypcT5IhQwfkaK54Xd4cmalwRcT8W12qL92aWwo95GtlizpFjWFy
         xlpRocna7WanAwG0m1EHLzBW5+VPksagCmMgQRjKrAMxaCvi6ySXd7BtV7jl208KYqYB
         dIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=EWXzXtWxkqwu0CPQRvvsDDIoqrmy6tr8WAbR6k8JzAM=;
        b=ADYL+MplG084WpVmxTR1SH/rDs2fKdwb3vv1S2Mjx444I8jlZw7pBqok4h611HZXS4
         VzSiDe7XyMc3X5apY9KNBbQmTbL+pxB1dkPy6yiT0mQ7s6iZhCu80KsH/Qa289+yLmW5
         iyMiXSEHuvXOjznss6gtJr+byGNNei6BBB1Zbi3Z3VUgda5jt+H1v0MkyZjRWrtJWzzN
         gCmNuIzYtk5l71EOlTKy3PIIEXXEJLFCg11RvPJDVApfkChNXrFktMCARqxj+umstddd
         jwSVB1bfPcPJ1RTqCgX5rtKWkpqXKaRtJ+h6PcM3Jq9074h4X+5w8H2auVSkz8AeGosP
         e6Pg==
X-Gm-Message-State: APjAAAUtRSiMeJcnwbjsklxsc0LrSMPZqYSi9MM0IfnaLJxiULnIr2O4
        XyqwYDeN2ZcY4PBhpYXiLbeCH05Y8KY=
X-Google-Smtp-Source: APXvYqzFnJxEcraxL5XB4XkX9T/ORqzQd7xFl2GLz59pQfn9445Y8q3Cpu1mfyOh4VgYluYlqzN4fg==
X-Received: by 2002:a0c:8ae9:: with SMTP id 38mr43048207qvw.157.1558046292944;
        Thu, 16 May 2019 15:38:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:cd83])
        by smtp.gmail.com with ESMTPSA id g206sm3169407qkb.75.2019.05.16.15.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 15:38:12 -0700 (PDT)
Date:   Thu, 16 May 2019 15:38:10 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [GIT PULL] cgroup fix for v5.2-rc1
Message-ID: <20190516223752.GE374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

The cgroup2 freezer pulled in this cycle broke strace.  This pull
request includes a workaround for the problem.  It's not a complete
fix in that it may cause spurious frozen state flip-flops which is
fairly minor.  Will push a full fix once it's ready.

Thanks.

The following changes since commit 8c05f3b965da14e7790711026b32cc10a4c06213:

  Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm (2019-05-16 09:41:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2-fixes

for you to fetch changes up to 05b289263772b0698589abc47771264a685cd365:

  signal: unconditionally leave the frozen state in ptrace_stop() (2019-05-16 10:43:58 -0700)

----------------------------------------------------------------
Roman Gushchin (1):
      signal: unconditionally leave the frozen state in ptrace_stop()

 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index c4dd66436fc5..a1eb44dc9ff5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2113,6 +2113,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		preempt_enable_no_resched();
 		cgroup_enter_frozen();
 		freezable_schedule();
+		cgroup_leave_frozen(true);
 	} else {
 		/*
 		 * By the time we got the lock, our tracer went away.

-- 
tejun
