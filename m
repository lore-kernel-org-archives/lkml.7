Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A47C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAF6216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557422846;
	bh=VrRi9r59twO2Vs9VtBsqWzoXA63LlV7OtgbqgUs3E9U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vfkjIQHgb++812VCbkrjme20WuvwdfIcBfyVT/uPgt+HJu0bdBgvkxleDObsVzhTq
	 L3jTyPgOVrJjtO0TH5tRzVYvIdK7jbvCr1QoY5OghRmIYNXS2atNEVkbLKIF15hQ9k
	 QKsIHSt3Q0kEW9e8q+77xKxGaxCMBJQbNPLJA18Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfEIR1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:27:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37615 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEIR1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:27:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id c1so628047qkk.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lJ+oV/BjYceCK1GZQhzvwgz1jAhOdMdk8uo4mTMDG6U=;
        b=gcmGBjpAecqfUvZnbi0WKiQP7pjf1TFkr7XGVBKHkBnDS8x7xyeGaakAKCxs08x5cd
         2GEopMhCGGUHMHDcJ8df3fgwmuJy+YlN3qo4tZW8kkQ5pNBPjOh4aakTrHfnwO8/vPHz
         AwkbqLzTYagNJEvvLEDfrCuLxWbs8VqWvLzz14SiMHk1hyFT/rAzL8J9dL/AVgkZTRFz
         TI4SaXGx3uBbwFsDw3ze/5vZLeYQuGpfayzi0YISQ9RyM0xkOum42ZSI9FpFdofe4wfO
         q2RROR4x4JGerm1pYoPKdxOK0ckTc7XtcxRWYmbzUWdPkWVzXQbtOMdM2Mj7mG5gO+4b
         1fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=lJ+oV/BjYceCK1GZQhzvwgz1jAhOdMdk8uo4mTMDG6U=;
        b=PI9ozVcZwvHOCpkN1UJ/X8PsIR+IQ4XgSwYIDivKdJ6Pv0b2V3kfrmoCfllfSjdlPI
         RTvIQIs2mfp+hiczolCH5eDVa+0820srpqqZz279xb6dHogg3VPlvBR3L6C37taryiT3
         JO+SjG5ZBxmdT+OYaDiEr3ROUlSg/sqgajEppKESjSoeZmIvZP0Xd0m+ozLPkmJzyF/2
         kCoXscztkYbzedK35Z5EONGhlSc9QS2GB7gLfX9HZxhLt1RioqyIyeMDajA7tbOm6rdt
         7Ugefc3rjqDdy5C6sx+rOGn9s57UPTATqMNAJbleMkfdgxl7dcSbTq0VSiuDCZrqM3mi
         yAkw==
X-Gm-Message-State: APjAAAVpTaQ0Y5P6hBcfv8TmeG69/Vj8nJ43bOBff65sas0v3qvd45+y
        asdUKsvedYFsHkRoYS4RPk4=
X-Google-Smtp-Source: APXvYqy1pYpILW7eIkfHsfDeZJsx+V48NlTl7HtVcXWNTyvC8zYoc3jTKYB3idGFLTVlxsPC+MY+5w==
X-Received: by 2002:a37:5005:: with SMTP id e5mr4356853qkb.99.1557422843676;
        Thu, 09 May 2019 10:27:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c346])
        by smtp.gmail.com with ESMTPSA id p37sm2025453qtj.90.2019.05.09.10.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:27:22 -0700 (PDT)
Date:   Thu, 9 May 2019 10:27:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.2-rc1
Message-ID: <20190509172721.GZ374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Only three commits, of which two are trivial.  The non-trivial chagne
is Thomas's patch to switch workqueue from sched RCU to regular one.
The use of sched RCU is mostly historic and doesn't really buy us
anything noticeable.

Thanks.

The following changes since commit f261c4e529dac5608a604d3dd3ae1cd2adf23c89:

  Merge branch 'akpm' (patches from Andrew) (2019-03-14 15:10:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.2

for you to fetch changes up to 24acfb71822566e4d469b4992a7b3b9f873e0083:

  workqueue: Use normal rcu (2019-04-08 12:37:43 -0700)

----------------------------------------------------------------
Bart Van Assche (1):
      kernel/workqueue: Document wq_worker_last_func() argument

Mathieu Malaterre (1):
      kernel/workqueue: Use __printf markup to silence compiler in function 'alloc_workqueue'

Thomas Gleixner (1):
      workqueue: Use normal rcu

 kernel/workqueue.c | 95 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

-- 
tejun
