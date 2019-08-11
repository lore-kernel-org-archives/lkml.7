Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C54C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 22:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD092084D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 22:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mvrBrR8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfHKWMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 18:12:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45224 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfHKWMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 18:12:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id a30so9949856lfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FY7aY7/rAMquy8xmrOkqN/GNbl5YhGEDuc/fn8Fq/bE=;
        b=mvrBrR8gHlX5FiGSQWTmftyc/WrLC8GK2OQWXmkeIioVsLiXcOkp4aoPVfaH7Ntu/Y
         byc1Jo0B65TGpASFNSjY3jaml5RAMwEmQ79/qGJDJP2YXsNsUVquOSfF3DQGLgOXUIkA
         MoRd3Em/NfWyaY+LtaaJi8gU5N8gb6XkqxMG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FY7aY7/rAMquy8xmrOkqN/GNbl5YhGEDuc/fn8Fq/bE=;
        b=PoAg9be+fm3l1ny5vf8ZBQPNJwAeCMO23Roxmjv2N49Aag2pHCOacVUeUiC9UVWONd
         xpFwytorlc1D6SokSwNzTkh+h65b+r37jqhmDLQp+VqxnOU4CPmUaHptAK3guyfUf2jo
         JOMTjP/9wxjX8CsqzsAtaxhA6XxCYX1KFaNDyvYSahkKmaDxwaKW/llVVwjZ58/BdTF5
         6E089UCjKvkOwHJedPt3zXTz/owHrBVIwwyIWioo84YB4kwkvv+4MH339Nt7h8ACcPku
         rInzbK9jRoW/W2vplAom1/PyobzDVEkjfZNNWgG0ALKeYCtp/cZAT/X9mlTxCaMS39PM
         GB5g==
X-Gm-Message-State: APjAAAUfomIDqWtBIhYRS8jlSmpoJAU4rzNo9oXDoKQr3wMk9oSV5PnJ
        IkWuWKrO4cpSNnXOZ6ifUYIBFMaq54D3vGXyGH1RjeUy
X-Google-Smtp-Source: APXvYqyukhEgHZH0kh2WWC+7VgUH9yYc4gTR2/ZkRvOBjbdCjMywvVHb4kU8/1EL05AP0OSXHuXHNwywT1NnRZ5qxKE=
X-Received: by 2002:a19:674d:: with SMTP id e13mr13993327lfj.176.1565561563343;
 Sun, 11 Aug 2019 15:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190811221111.99401-1-joel@joelfernandes.org>
In-Reply-To: <20190811221111.99401-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 11 Aug 2019 18:12:32 -0400
Message-ID: <CAEXW_YT8AE3A25ZJhFd3N5dJhFUb0nRDUvwupPq=7QQFw7_KQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] workqueue: Convert for_each_wq to use built-in list
 check (v2)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 6:11 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> list_for_each_entry_rcu now has support to check for RCU reader sections
> as well as lock. Just use the support in it, instead of explicitly
> checking in the caller.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Tejun,
Could you please Ack this patch? I have resent it here.

Thank you,
- Joel


> ---
>  kernel/workqueue.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 601d61150b65..e882477ebf6e 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -364,11 +364,6 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
>                          !lockdep_is_held(&wq_pool_mutex),              \
>                          "RCU or wq_pool_mutex should be held")
>
> -#define assert_rcu_or_wq_mutex(wq)                                     \
> -       RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&                       \
> -                        !lockdep_is_held(&wq->mutex),                  \
> -                        "RCU or wq->mutex should be held")
> -
>  #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)                       \
>         RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&                       \
>                          !lockdep_is_held(&wq->mutex) &&                \
> @@ -425,9 +420,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
>   * ignored.
>   */
>  #define for_each_pwq(pwq, wq)                                          \
> -       list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)          \
> -               if (({ assert_rcu_or_wq_mutex(wq); false; })) { }       \
> -               else
> +       list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,          \
> +                                lock_is_held(&(wq->mutex).dep_map))
>
>  #ifdef CONFIG_DEBUG_OBJECTS_WORK
>
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
