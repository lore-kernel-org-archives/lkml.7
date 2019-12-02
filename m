Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D3C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D523D20717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFYSUR2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfLBPRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:17:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35265 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:17:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id r15so86968lff.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 07:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Se4YrQxFPNL2rveYYc+5xD204O8T47J4HIQMqM9+jU4=;
        b=VFYSUR2AzLOlRPpeb7rkgJfri9DNc5dNDRZUJv2R+vJhK1km5sQ9vhRuM0g+Wla/pu
         2NKMjFyHMmYRbcvncSrypOeYGbgZ5pVcM+Q5yIAAsG9d9+xlEwPaQUcVOikYicPWjwbU
         Zk4BT4zNftJpe3kEzHMTC9rK90IHja7ltMG7yix7uzs70Fs7CUYoKQteN4SERy++qfdN
         XNuKQzvxgXd4Oq5AIJddY3HS88rOwzUSxypvoeKCkWJRw/AiuKijEyNW2OtgSNeOVhFl
         RIifnY0TEWbkn+wIRGvVdsA1Y1ZTKCKdFYVGEN/94AIUnAWQXU6nbu/X14Jf7712pZUC
         G9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Se4YrQxFPNL2rveYYc+5xD204O8T47J4HIQMqM9+jU4=;
        b=O+TCQsKFjXINOBUa+cAMUMqTHULoxrcZIZmGIsaARZa8PjFFjYXNMWtRxywBSXNirx
         Ryl2/S3tqrAkURP31fYTRhfe1KZiKnFX9cAnPuOrlGTw9717G/87buRMtiTTcpLCq8Tj
         Yuob5UbDV/hk70btYGt5hsAUa5SUkK14+Kz8jWd6lL8ufKEpcOrhDEAilR9hvXl/oYDJ
         aG40I4LjRRD30eebgRUjmQoGGht5Ms2eB35HDhSzmR2pWxpbCiDy8xrVh0CGXyqOWceg
         TzQJFVHI5lnWCdTp3p3dANw8NNgh4Qt9fPJqXcvWYoUdEz/fZHI9nnsnOlC4H2AkNo7z
         xciw==
X-Gm-Message-State: APjAAAV9UkZl8KNFWWw654bqGS18rSCfkkt9eqkoZPuaYHxxYx6V0yuw
        BBK2Q62MZ2qqEi+cxUFyZcTQFMb2hH6FcibFUvRLiQ==
X-Google-Smtp-Source: APXvYqxZZRllsDbHMzvnX5s7TUGOR811rpICMHakIyLcBgV97YKXIBW0ZY8bAziazv7FAz6oSrxAY3i4KdgP6kO7+rk=
X-Received: by 2002:a19:c3ca:: with SMTP id t193mr30555777lff.40.1575299857187;
 Mon, 02 Dec 2019 07:17:37 -0800 (PST)
MIME-Version: 1.0
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
In-Reply-To: <157527193358.11113.14859628506665612104.stgit@devnote2>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 2 Dec 2019 16:17:24 +0100
Message-ID: <CADYN=9KgdrEkjkC5BC6C1WvxrsWoqt4AaoiCeqX25ieMebO4gg@mail.gmail.com>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 at 08:32, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Anders reported that the lockdep warns that suspicious
> RCU list usage in register_kprobe() (detected by
> CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> access kprobe_table[] by hlist_for_each_entry_rcu()
> without rcu_read_lock.
>
> If we call get_kprobe() from the breakpoint handler context,
> it is run with preempt disabled, so this is not a problem.
> But in other cases, instead of rcu_read_lock(), we locks
> kprobe_mutex so that the kprobe_table[] is not updated.
> So, current code is safe, but still not good from the view
> point of RCU.
>
> Let's lock the rcu_read_lock() around get_kprobe() and
> ensure kprobe_mutex is locked at those points.
>
> Note that we can safely unlock rcu_read_lock() soon after
> accessing the list, because we are sure the found kprobe has
> never gone before unlocking kprobe_mutex. Unless locking
> kprobe_mutex, caller must hold rcu_read_lock() until it
> finished operations on that kprobe.
>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you Masami for fixing this.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>  kernel/kprobes.c |   18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 53534aa258a6..fd814ea7dbd8 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -319,6 +319,7 @@ static inline void reset_kprobe_instance(void)
>   *     - under the kprobe_mutex - during kprobe_[un]register()
>   *                             OR
>   *     - with preemption disabled - from arch/xxx/kernel/kprobes.c
> + * In both cases, caller must disable preempt (or acquire rcu_read_lock)
>   */
>  struct kprobe *get_kprobe(void *addr)
>  {
> @@ -435,6 +436,7 @@ static int kprobe_queued(struct kprobe *p)
>  /*
>   * Return an optimized kprobe whose optimizing code replaces
>   * instructions including addr (exclude breakpoint).
> + * This must be called with locking kprobe_mutex.
>   */
>  static struct kprobe *get_optimized_kprobe(unsigned long addr)
>  {
> @@ -442,9 +444,12 @@ static struct kprobe *get_optimized_kprobe(unsigned long addr)
>         struct kprobe *p = NULL;
>         struct optimized_kprobe *op;
>
> +       lockdep_assert_held(&kprobe_mutex);
> +       rcu_read_lock();
>         /* Don't check i == 0, since that is a breakpoint case. */
>         for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH; i++)
>                 p = get_kprobe((void *)(addr - i));
> +       rcu_read_unlock();      /* We are safe because kprobe_mutex is held */
>
>         if (p && kprobe_optready(p)) {
>                 op = container_of(p, struct optimized_kprobe, kp);
> @@ -1478,18 +1483,21 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
>  {
>         struct kprobe *ap, *list_p;
>
> +       lockdep_assert_held(&kprobe_mutex);
> +       rcu_read_lock();
>         ap = get_kprobe(p->addr);
>         if (unlikely(!ap))
> -               return NULL;
> +               goto out;
>
>         if (p != ap) {
>                 list_for_each_entry_rcu(list_p, &ap->list, list)
>                         if (list_p == p)
>                         /* kprobe p is a valid probe */
> -                               goto valid;
> -               return NULL;
> +                               goto out;
> +               ap = NULL;
>         }
> -valid:
> +out:
> +       rcu_read_unlock();      /* We are safe because kprobe_mutex is held */
>         return ap;
>  }
>
> @@ -1602,7 +1610,9 @@ int register_kprobe(struct kprobe *p)
>
>         mutex_lock(&kprobe_mutex);
>
> +       rcu_read_lock();
>         old_p = get_kprobe(p->addr);
> +       rcu_read_unlock();      /* We are safe because kprobe_mutex is held */
>         if (old_p) {
>                 /* Since this may unoptimize old_p, locking text_mutex. */
>                 ret = register_aggr_kprobe(old_p, p);
>
