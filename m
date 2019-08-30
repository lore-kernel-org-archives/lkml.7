Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA9FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6233923407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567179822;
	bh=hckvUu+AH8s9AnJumzwHdoU9dL0jFNOS5cpjuRy4Xqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nbELHRViDpT9nyMReKK1n69Dsaz7o8ybiW2EF2RMBVhxvjKAH7yFNN94Nd/RrHvnC
	 MYm8DtW1P28dwS6zcU1/MlCmDry3kFaAzJpZlfxfMAqtTX80qQu+6tMTYRt4ZGMXjw
	 Ketoy15hShYbD5dFOIoQVOEAEoG93ZfcKBFnrzr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfH3Pnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:43:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46479 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfH3Pnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:43:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id f9so6848905ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTA0gedVw618t+Kf7dOTI7q2YbfXx9rp+QOfL/WGIwg=;
        b=QaD0KeEvtDCdqFBd/v36FtnvNayWhMUlo7JuHAHRwXqkvR8KZbB5DwoKkh/wDKwKYL
         6uJMYacfI4JxfmdYz/TPerI+EZNZyDwpDjTTUoLCr8hOn9xd/oMpl1nL5VcJk3bEe7id
         fx0/Mmr3PMEgXvbk+7zjg6mS93NQgzOmweG7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTA0gedVw618t+Kf7dOTI7q2YbfXx9rp+QOfL/WGIwg=;
        b=tbbn/urGiR8U+8UP44UhlW7XBUv/T9h+IGCLCfR7QzBJCUeqOUtK1vTb+zUhLGdy8g
         2l3jZ3aLpEnVhZ1M0Bm8zsAZWR/mmQ8hUk4yI1UyrJ68d1UgXe+o0iGTLOyDOyJAvT/v
         rsOXIErq3jOf1zeG1zJrcmT4+s94ifBQlA06b2Az9/GfUdkWTxrcJrm0b5AWUZy3VAjT
         zswrcVvaqzGigNCBc4rX1TubXxKvZJGixbydVBQyLsaYcxMMZHw6Xg7lSMtRuv6zQjvG
         IP5IWu4fqRInm2j9a6yEC+bCIbVTuMQ7H3E9znPIUTzj/K9kQOn1Vuok6zkv0XjfXDaQ
         GFSQ==
X-Gm-Message-State: APjAAAXmz6DI72kATh6Y2FMZH4dy9Ri8VgQvD3Tdt55Qucuaj7xJSUne
        gAIp2Urnlaq04jlYNw5kvKX8asPizCM=
X-Google-Smtp-Source: APXvYqy9XlXrX+PWspb3zXYwbfbI7KWnlSLBIxB+WhdzAb8EZi8s2El3WtOg5JVMNo63oZ0jzsPmAA==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr2481553ljj.62.1567179819092;
        Fri, 30 Aug 2019 08:43:39 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z23sm566932lji.58.2019.08.30.08.43.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 08:43:38 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id l14so6901619ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:43:37 -0700 (PDT)
X-Received: by 2002:a2e:9702:: with SMTP id r2mr8842714lji.84.1567179817730;
 Fri, 30 Aug 2019 08:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190830140805.GD13294@shell.armlinux.org.uk> <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <20190830154023.GF13294@shell.armlinux.org.uk>
In-Reply-To: <20190830154023.GF13294@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 08:43:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKqLjr_9cqJvgEzWWnMKQJgCpc1sT9o0kimfQdyE6NFA@mail.gmail.com>
Message-ID: <CAHk-=wiKqLjr_9cqJvgEzWWnMKQJgCpc1sT9o0kimfQdyE6NFA@mail.gmail.com>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov@parallels.com>,
        Kirill Tkhai <ktkhai@parallels.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:40 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Ah, ok.  Might be worth some comments - I find the comments in that
> function particularly unhelpful (even after Oleg mentions this is
> case 2.)

Yeah, a comment like "This might fault if we race with the task
scheduling away and being destroyed, but we check that below".

But that code has some performance issues too, as mentioned. Which is
all kinds of sad since it clearly _tries_ to perform well with RCU
locking and optimistic accesses etc.

             Linus
