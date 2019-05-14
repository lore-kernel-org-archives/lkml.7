Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21CFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CC720850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfENRb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:31:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41967 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:31:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id g8so16001290otl.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 10:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ErzBDF5ta8fy4S6axV5usgeVf1icUMn3T8UVynCsAWs=;
        b=UohxSKf/RDYZxIdFU4oSsi9uZkXLk53EsAVAFJYTnGOrBEMTtlMnJzoUo/DyMZD4+L
         /zNyEySGkxJXRnJcK8rSRE9wi+OX8CMCb/gRxErcajWgjpuHvR7Zqvm+tR59xqJUP5N/
         93TLYJv7aldBBh6ObLjLENRmvUlyrBGdgjEI88+imPpi8uZ1uPdGHT0ILIjXdvz7uqIt
         zKEsfHh9yN/JRayRlb/Bu7maCaaWMwxRtVRzDSNs6zuabDb10+uE7aiun9PpOLmWT2gp
         ck/5lXJhw5hSDr8CpmVUBSvga4xku6mpZh9EUs40rSJa3iJpm/cXPHwmKJhKfUaF4Hi5
         Do1g==
X-Gm-Message-State: APjAAAUcXOw98cG/LzhqQgcqmYQFFjpoesGAKuMuNtrhLZRTDx9mVNBJ
        RqFEDdm/w+3X6TTNhRzLsUA=
X-Google-Smtp-Source: APXvYqxkxGAxP4ZnVEYXQ1pF+uY0YgUE1LJnsi3HHxrq+TOlnXkjSIbH/bnYS6xVvJ3PilYfe8glmw==
X-Received: by 2002:a9d:362:: with SMTP id 89mr4306623otv.17.1557855084265;
        Tue, 14 May 2019 10:31:24 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id m25sm6357027otp.81.2019.05.14.10.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 10:31:23 -0700 (PDT)
Date:   Tue, 14 May 2019 10:31:19 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190514173119.GA19142@sultan-box.localdomain>
References: <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507153154.GA5750@redhat.com>
 <20190507163520.GA1131@sultan-box.localdomain>
 <20190509155646.GB24526@redhat.com>
 <20190509183353.GA13018@sultan-box.localdomain>
 <20190510151024.GA21421@redhat.com>
 <20190513164555.GA30128@sultan-box.localdomain>
 <20190514124453.6fb1095d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514124453.6fb1095d@oasis.local.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:44:53PM -0400, Steven Rostedt wrote:
> OK, this has gotten my attention.
> 
> This thread is quite long, do you have a git repo I can look at, and
> also where is the first task_lock() taken before the
> find_lock_task_mm()?
> 
> -- Steve

Hi Steve,

This is the git repo I work on: https://github.com/kerneltoast/android_kernel_google_wahoo

With the newest simple_lmk iteration being this commit: https://github.com/kerneltoast/android_kernel_google_wahoo/commit/6b145b8c28b39f7047393169117f72ea7387d91c

This repo is based off the 4.4 kernel that Google ships on the Pixel 2/2XL.

simple_lmk iterates through the entire task list more than once and locks
potential victims using find_lock_task_mm(). It keeps these potential victims
locked across the multiple times that the task list is iterated.

The locking pattern that Oleg said should cause lockdep to complain is that
iterating through the entire task list more than once can lead to locking the
same task that was locked earlier with find_lock_task_mm(), and thus deadlock.
But there is a check in simple_lmk that avoids locking potential victims that
were already found, which avoids the deadlock, but lockdep doesn't know about
the check (which is done with vtsk_is_duplicate()) and should therefore
complain.

Lockdep does not complain though.

Sultan
