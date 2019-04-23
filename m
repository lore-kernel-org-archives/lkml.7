Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE71C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8BB21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oEJIhRd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfDWWKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:10:07 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39071 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDWWKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:10:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id d5so5334702uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaCOHOEOCjLoZombeuRIMFkxCo4UDtePXL1HrIXNyOE=;
        b=oEJIhRd3Yvr3TaM+pW+RRCamM6MiDbQn4Un+pIEY+vreURktZIqaIr8+rDXwALO1JK
         e0Y1Isj8/AGs4R+4xBEyGwnBGvCm8dVaAofITxvZVkOzHmaBzx6WHJoqD0pj7pOYEJez
         TQ3K/wuhGGAcYRkJf2rVPRLWzuhOVb0ELYhxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaCOHOEOCjLoZombeuRIMFkxCo4UDtePXL1HrIXNyOE=;
        b=lUtuCMll0e6IrBeM/E/y8Bc87Hdg+NbJ/+Tha6E8xnRM8Hcfweuau+qtR6zu7WfgdH
         OrhUAp4bsdp1KIQ8pK3VnHRHLr2icPoD60FDuYAUhdcqX1dB/Gv668bhe958clv3E93q
         Ph0euV6dSoKQDiNZZPbCQXx6FocNxbUTa46DOXIzC+ovXW1Qqpqw84m+2B763ppCor7Y
         TJ1g0x0oLUJ7hV/HKs2u5BNucHaNWSSw2ppK6yuaef1nAv+sPTZxP/NFaEbwTEiPSITK
         lqTSP30iqsmILG5Dti9aRSzIXkdxOxZI77M6DGTU8NeZ0c7LkfBj8oRCy8B4JniMMX8+
         ioEQ==
X-Gm-Message-State: APjAAAX8qNcuEZ0K8FzkioUx90jqdFocaKm3CKYvysYA9A1q81v9inop
        vjNx41X2OGSZCSd6yYyPbzGqhcPilXU=
X-Google-Smtp-Source: APXvYqz/azaPr3SLWHwRiIi+hopa/qvUD5WmnBrQBubzG8U+AAxHyQXXxdVL5gWRBmdAkhNkPhNlsQ==
X-Received: by 2002:ab0:644c:: with SMTP id j12mr3567425uap.61.1556057404701;
        Tue, 23 Apr 2019 15:10:04 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id r63sm5146334vsc.15.2019.04.23.15.10.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:10:04 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id q189so3565891vkq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:10:03 -0700 (PDT)
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr15089491vkk.13.1556057403077;
 Tue, 23 Apr 2019 15:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190306201413.14153-1-tycho@tycho.ws> <20190306201413.14153-2-tycho@tycho.ws>
In-Reply-To: <20190306201413.14153-2-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:09:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKaK-mTq=Qez7E_fYysz916_xEN7Houj-y8gdmNGkMMVw@mail.gmail.com>
Message-ID: <CAGXu5jKaK-mTq=Qez7E_fYysz916_xEN7Houj-y8gdmNGkMMVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
To:     Tycho Andersen <tycho@tycho.ws>, James Morris <jmorris@namei.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 12:14 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> As the comment notes, the return codes for TSYNC and NEW_LISTENER conflict,
> because they both return positive values, one in the case of success and
> one in the case of error. So, let's disallow both of these flags together.
>
> While this is technically a userspace break, all the users I know of are
> still waiting on me to land this feature in libseccomp, so I think it'll be
> safe. Also, at present my use case doesn't require TSYNC at all, so this
> isn't a big deal to disallow. If someone wanted to support this, a path
> forward would be to add a new flag like
> TSYNC_AND_LISTENER_YES_I_UNDERSTAND_THAT_TSYNC_WILL_JUST_RETURN_EAGAIN, but
> the use cases are so different I don't see it really happening.
>
> Finally, it's worth noting that this does actually fix a UAF issue: at the end
> of seccomp_set_mode_filter(), we have:
>
>         if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
>                 if (ret < 0) {
>                         listener_f->private_data = NULL;
>                         fput(listener_f);
>                         put_unused_fd(listener);
>                 } else {
>                         fd_install(listener, listener_f);
>                         ret = listener;
>                 }
>         }
> out_free:
>         seccomp_filter_free(prepared);
>
> But if ret > 0 because TSYNC raced, we'll install the listener fd and then free
> the filter out from underneath it, causing a UAF when the task closes it or
> dies. This patch also switches the condition to be simply if (ret), so that
> if someone does add the flag mentioned above, they won't have to remember
> to fix this too.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> CC: stable@vger.kernel.org # v5.0+

Thanks! Sorry I missed this. James, can you take this for Linus's
fixes for v5.1? (Or should I send a pull request to you?)

Acked-by: Kees Cook <keescook@chromium.org>

Let's also add:

Reported-by: syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com

> ---
>  kernel/seccomp.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index d0d355ded2f4..79bada51091b 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -500,7 +500,10 @@ seccomp_prepare_user_filter(const char __user *user_filter)
>   *
>   * Caller must be holding current->sighand->siglock lock.
>   *
> - * Returns 0 on success, -ve on error.
> + * Returns 0 on success, -ve on error, or
> + *   - in TSYNC mode: the pid of a thread which was either not in the correct
> + *     seccomp mode or did not have an ancestral seccomp filter
> + *   - in NEW_LISTENER mode: the fd of the new listener
>   */
>  static long seccomp_attach_filter(unsigned int flags,
>                                   struct seccomp_filter *filter)
> @@ -1256,6 +1259,16 @@ static long seccomp_set_mode_filter(unsigned int flags,
>         if (flags & ~SECCOMP_FILTER_FLAG_MASK)
>                 return -EINVAL;
>
> +       /*
> +        * In the successful case, NEW_LISTENER returns the new listener fd.
> +        * But in the failure case, TSYNC returns the thread that died. If you
> +        * combine these two flags, there's no way to tell whether something
> +        * succeded or failed. So, let's disallow this combination.

also a tiny typo: succeeded

> +        */
> +       if ((flags & SECCOMP_FILTER_FLAG_TSYNC) &&
> +           (flags && SECCOMP_FILTER_FLAG_NEW_LISTENER))
> +               return -EINVAL;
> +
>         /* Prepare the new filter before holding any locks. */
>         prepared = seccomp_prepare_user_filter(filter);
>         if (IS_ERR(prepared))
> @@ -1302,7 +1315,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
>                 mutex_unlock(&current->signal->cred_guard_mutex);
>  out_put_fd:
>         if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> -               if (ret < 0) {
> +               if (ret) {
>                         listener_f->private_data = NULL;
>                         fput(listener_f);
>                         put_unused_fd(listener);
> --
> 2.19.1
>

-Kees

-- 
Kees Cook
