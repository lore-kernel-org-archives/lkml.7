Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE9EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210FD20729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy5U+R1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfKOVzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:55:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34410 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:54:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so6606524pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDJQqV14uzEihQXEpY7fuGIQSC23HgxbcUZqBOWf+Nw=;
        b=Fy5U+R1xvEOuYKVgnuCEwCPMd3SfQNlaFTyjq0mFtKU1qjz0Dv0Fe6H7jYiQ3QKcyh
         r9Pyxw7I7nHXrMKRxP3GUNZdOuds6TQpF7dj0nIxsX3gqjbhT22+grKTugbSm8/gQkxI
         9ep2HgGKOFOi7viRHE/WY7raBu8QIkwZXYnI1pKqyIaSajotLHgRWrXrxWw4Emcv43up
         W95na9gzOjAdCMFHIS/l2wgeUoslrB4bcUiOESFjvL65ycv0c3wq/rEFU/uWhzR/FrP3
         IExTZh9OQ6Ash9au44/rvKQpX0ycOECDO2vWr8ALSO0GoMTWh/vF3fIHv6pLNHvl5mBt
         u7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDJQqV14uzEihQXEpY7fuGIQSC23HgxbcUZqBOWf+Nw=;
        b=sJldEA/rVLRgcCeQUeJsvloU6YrjdFuZbeMQIK5/8yKD6Y2f51CnO0ADWrfBiwykGa
         F1MJw8W4/0YfM+FjVdAlNV1rLGzjD/8FuBWpRjcQQTRU34GiBo/dGFi4v4AlCDIXCtPB
         DFKEFT7Fw93QUU5d/X9MSEa3nGAZKkKbgkwfCAgg54/p7FjGCKWLNlMQeIZNDSLlgzzi
         tLD3e7fqHBTuYaUQdrCTZgRGVFdGdiL0Tq94ERQaQ/1QDrxn4pxDwY4jCOaRAJdIQx5P
         SacdnwVhheSbVHRZIzPjxitHoPJrz5EXN2dG3pgUdjDXUqIsVKW5kKPkjQge6hW2e/yE
         KjYQ==
X-Gm-Message-State: APjAAAUyqwhd5kOqoFmmPOna+4EKoYMqFIMuZe7vNdgUAOEwaBDZ2QaD
        YaZGjf09z2pvwonL3L1JazY=
X-Google-Smtp-Source: APXvYqz86pZgIQl1BS+mnutW6Ul/aBbTtGeedlZddA3o0EUe46/JzOESsjLrVBabRxlFaJFZ+xyCWw==
X-Received: by 2002:a63:712:: with SMTP id 18mr18278499pgh.384.1573854898495;
        Fri, 15 Nov 2019 13:54:58 -0800 (PST)
Received: from gmail.com ([2620:0:1009:fd00:e14f:8808:551a:63ec])
        by smtp.gmail.com with ESMTPSA id i2sm11369820pgt.34.2019.11.15.13.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 13:54:57 -0800 (PST)
Date:   Fri, 15 Nov 2019 13:54:56 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v11 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191115215456.GA353836@gmail.com>
References: <20191115123621.142252-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20191115123621.142252-1-areber@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:36:20PM +0100, Adrian Reber wrote:
> 
> v11:
>  - abort alloc_pid() correctly if one of the PIDs specified in
>    set_pid[] is invalid (Andrei)
> ---
>  include/linux/pid.h           |  3 +-
>  include/linux/pid_namespace.h |  2 +
>  include/linux/sched/task.h    |  3 ++
>  include/uapi/linux/sched.h    | 53 +++++++++++++++++---------
>  kernel/fork.c                 | 24 +++++++++++-
>  kernel/pid.c                  | 72 +++++++++++++++++++++++++++--------
>  kernel/pid_namespace.c        |  2 -
>  7 files changed, 122 insertions(+), 37 deletions(-)

Acked-by: Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei
