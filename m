Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EF8C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF6621882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573115374;
	bh=ypQ0oGv5xTZ3ezFvn/nyzQ6wLsdkz8CyKqsvp1oafww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IpMTLF48L9zGfTLSwMXwiXRot563iZx3u2tQhIbUx3j/uTd/f5I2D5zHVtVnGYpmj
	 qWLz4z4e4PZRcM7JIZe1u9YPElbTXkQww6cGTXPCQvRfCk5aHbpngiRJdNSfe5EbEI
	 YYTV4OFGfNl2jF0E9eoPdpPj3Aou+83Z+Q2jbD+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKGI3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:29:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54334 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:29:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id z26so1438162wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GvVqcCA+q6bwcbhqBOnVhfqTaPMnQr5sWIL/eIvexxM=;
        b=J9w2R/Y1krAr0xou7NLC1nIsGTO3ey7vfeiFQ9ZpJRGAkiS7z1D3hzCuCXV8NWXRnj
         tQffv5iIY5wcIim8DzEDFzuoHZEV/x7q4f31BJjm9vgaJ0LkwW05cYLHJ71lwvty7eQr
         WfQWUSK5SJqb0OyY8BddXDIgln+wzbcZxO0yx3wcGZty7F5pxFvCCqZ36MwM6KR4nCLy
         6q/da+Vr6r/m340bW4/KXRTnQ1nvZIRy1ZvPxRDyouA32UX5lcX/p5AwGDoXlk3TmK7w
         Xa6NjXWGvGacxvo0eSMYShAVGMaWvb+q76sszoBDrQ4h2AWUnOCgSsWy7+e+90nmzTFb
         SNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GvVqcCA+q6bwcbhqBOnVhfqTaPMnQr5sWIL/eIvexxM=;
        b=Pcz/qTB3UXpibdduhMQztyk7vAvVF1zG0NA3qdZGTXfFPthifwHpPO/Ays+acz8AJc
         jpBhX7ANZk3T180Fb9pMyuPzwzpvhKw//VkiQHewJuvx3Mxk25mDcejNJLczQHcLvC1a
         f7D/R+PGd5BHRsAEU4RB1c8gc67pcOlYb4vN7Mcvj4XgC+qOL/dNPD07agPQAyOx31/F
         7CP2Q8aS2kHotlAnANlLIT1OepwQ4oKngqWCuSMNgmXDtIWDxz/LbwS8QxhssdlhevTE
         pARS6R8q544IYN0vmE1lDgHi65o0CLikUChme8a0p9MQceuxIlFgfuOXtF9TzYrx7if6
         dGDg==
X-Gm-Message-State: APjAAAVkBqv6SE3hW0w8APzJP4qmnyEvgc+0kHeXiJVaG2emKjcQg50P
        cRmbC54WOYrN0v4vesaUzY4=
X-Google-Smtp-Source: APXvYqx6es8p8oWO8zbCtfbJxPqD4LVBVgOFhmcwMrGmgNVbrCT4aco4WOrnU5CMANm98FalTcFPmw==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr1596005wmd.79.1573115370204;
        Thu, 07 Nov 2019 00:29:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h8sm2138166wrc.73.2019.11.07.00.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:29:29 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:29:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/12] futex: Cure robust/PI futex exit races
Message-ID: <20191107082927.GG30739@gmail.com>
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106215534.241796846@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.locking/futex

Quick testing feedback, doesn't build on 32-bit systems (32-bit defconfig 
for example):

  kernel/futex.c: In function ‘futex_cleanup’:
  kernel/futex.c:3750:19: error: ‘struct task_struct’ has no member named ‘compat_robust_list’


Thanks,

	Ingo
