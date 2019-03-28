Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A052146F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HKDhNHHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfC1AGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:06:19 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45622 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1AGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:06:18 -0400
Received: by mail-vs1-f68.google.com with SMTP id n14so11027509vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 17:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2cVcm/RST7uJ09vSKN4lLzNpuFJFWS/r1qSzZQdpwQ=;
        b=HKDhNHHKW1kSgrsWQyrrVFgYT1q3cX2aIieILTkKG5i1xV5p6K2FLK7y8MdonoJGfL
         0Djwe4hYW/OAR9B9fpu+wJCtgRuaF6DPvfLoChH6P0iVDexaxWuESjVUY/Lbs/eeaNeB
         AzmZ2V99mXmIAS2C+G197nXYa4vtLQBnzGcKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2cVcm/RST7uJ09vSKN4lLzNpuFJFWS/r1qSzZQdpwQ=;
        b=FUNxjU+gRxxkH3daxgzotYrGHYwXF2B0XvfHh0lw7s9dfp//5eMkiwjzGtgri6XXWp
         Yyh8rWUtOeBqJaMtQqWRBWC0KU0YXRHaFO27vS6Yatpcv6hirrFfp9pbRAhUE/wHaNq7
         zL2M7uk3f+ksbHLKmxLKyMCwanZznLNyu2/+85kS1XwVqoEYcHMrYTj9VS8KpWReA75E
         YiMz4T+gyg48cC3KqVe0mnWN7hVlCWtu3/wj6KC4bILsnDBpjSZoApucSbKbOx8ZcBg4
         SjPbFloH4foaux8yyFCcAttbLnLTRNm+4viizd6WRrnxhwWU99GnuCK8RmE7OjQqDeoR
         bklA==
X-Gm-Message-State: APjAAAXyEEY1KlHjnePiNZ2KKa90hloikM5ljMpCUZrvNsbUYFsYCLWj
        vDZFoO2rsratuFmyYJ1SIbYS6t/hA04=
X-Google-Smtp-Source: APXvYqxAnp0oCHXkugkemvTlT8vjpT7YhsZRWBvFSDW2eQjSgKE3gox0jq6WLtVuQTM0f4t8SgmDOg==
X-Received: by 2002:a67:fe13:: with SMTP id l19mr24920240vsr.143.1553731577226;
        Wed, 27 Mar 2019 17:06:17 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id r23sm18577294vke.36.2019.03.27.17.06.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 17:06:16 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id j184so11067407vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 17:06:15 -0700 (PDT)
X-Received: by 2002:a67:89c9:: with SMTP id l192mr23612585vsd.188.1553731575610;
 Wed, 27 Mar 2019 17:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190327145331.215360-1-joel@joelfernandes.org>
In-Reply-To: <20190327145331.215360-1-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Mar 2019 17:06:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
Message-ID: <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 7:53 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> struct pid's count is an atomic_t field used as a refcount. Use
> refcount_t for it which is basically atomic_t but does additional
> checking to prevent use-after-free bugs. No change in behavior if
> CONFIG_REFCOUNT_FULL=n.
>
> Cc: keescook@chromium.org
> Cc: kernel-team@android.com
> Cc: kernel-hardening@lists.openwall.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> [...]
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..2095c7da644d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -37,7 +37,7 @@
>  #include <linux/init_task.h>
>  #include <linux/syscalls.h>
>  #include <linux/proc_ns.h>
> -#include <linux/proc_fs.h>
> +#include <linux/refcount.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>
> @@ -106,8 +106,8 @@ void put_pid(struct pid *pid)
>                 return;
>
>         ns = pid->numbers[pid->level].ns;
> -       if ((atomic_read(&pid->count) == 1) ||
> -            atomic_dec_and_test(&pid->count)) {
> +       if ((refcount_read(&pid->count) == 1) ||
> +            refcount_dec_and_test(&pid->count)) {

Why is this (and the original code) safe in the face of a race against
get_pid()? i.e. shouldn't this only use refcount_dec_and_test()? I
don't see this code pattern anywhere else in the kernel.

Beyond that, yes please. :)

-Kees


>                 kmem_cache_free(ns->pid_cachep, pid);
>                 put_pid_ns(ns);
>         }
> @@ -210,7 +210,7 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>         }
>
>         get_pid_ns(ns);
> -       atomic_set(&pid->count, 1);
> +       refcount_set(&pid->count, 1);
>         for (type = 0; type < PIDTYPE_MAX; ++type)
>                 INIT_HLIST_HEAD(&pid->tasks[type]);
>
> --
> 2.21.0.392.gf8f6787159e-goog
>


--
Kees Cook
