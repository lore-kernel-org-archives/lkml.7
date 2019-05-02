Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2512CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D7F204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs/G3q2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEBVt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:49:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44756 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfEBVtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:49:25 -0400
Received: by mail-io1-f68.google.com with SMTP id r71so3562857iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5HcxFLAOHYDm4q2/95LW5i6fvHO9cvLeIClq07OW1cE=;
        b=bs/G3q2NO3R7R77rcvcPtDWwGM2ladbRMjfmPf00RcM7rE3Njq768jyhnQeD9J1aca
         1X3wIi2FiSK+mYsbJQ6jkqvPliE9mym5t9XfDaBQWltnggp7ZNXQeQMEZPudi0PBktCB
         zmQ24hmSGif6wDITjq3HIlOwqK6GYlYFZJx8BN6u78IeSJ3C5iZkhj6UPjMELQeE46fg
         51qRTjxviLt+4zcd1KXCugFlJfbGoY7xz5ETOC5G9/2RZCWY0/RfAzAbU1sl5FkNcDK5
         irZ7hV2C0Ghx2GXyaldlx71tDpPU8hh6OIjSSYahcpHgybiEbUl6DMHt2H09Gu90Uo09
         1gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5HcxFLAOHYDm4q2/95LW5i6fvHO9cvLeIClq07OW1cE=;
        b=Pa6Cyn85vhUiSvjMencrLgm63tJn4MAsXVXz64Wy4L0Yed1p9cAPJNBZ4M9mg8eQXf
         H4BBWh5wy7es5aQxg1BwWL/sqRMKLFy1cEMM5j3ho8FFD6AqJrQC11foraHlVOq8W1SC
         ZR+XF1RGQGNwGNX/xzDXRft+xDLommTzuyaDkg+nyvvWHoqIFo4ct9cuTN8BiUzllXhV
         Ec7awmMhABKnEFeBGFy53aDKkwEmY45pRBEoMRke93SkoweIbKNEwmyONcYQ/OheE9Wo
         835hDG2f/Hy77lew/sEfFRNnVJWrGqYVFHntT3vK3eHI0gii3z9NPlU4sH6khwb7bSVR
         XLOQ==
X-Gm-Message-State: APjAAAWjOYuwxAoSn7sY4bElJ2YbBjbDMYdrcUDThdLEF9azQnmEOdQy
        oiw71EQP1CPwU7Ele7sJV1zWE3WZur/lznp0K/g=
X-Google-Smtp-Source: APXvYqyL+fSS75OSNlrmFLI4cVv58J8ILudV9rN0q5GJ0JSDgJOcdIs8BxZ/V5E4gOhWMPygYZ4VBZgbu1o6orWh6xA=
X-Received: by 2002:a5d:9d48:: with SMTP id k8mr4684210iok.194.1556833764935;
 Thu, 02 May 2019 14:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com> <1556830342-32307-2-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1556830342-32307-2-git-send-email-jsavitz@redhat.com>
From:   Yury Norov <norov.maillist@gmail.com>
Date:   Thu, 2 May 2019 14:49:14 -0700
Message-ID: <CAJu-Uz4r+s=v8p_jzd=fsa8+e8c4dH3S5iN60u8EFT0O_X2DOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kernel/sys: add PR_GET_TASK_SIZE option to prctl(2)
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 2 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 13:52, Joel Savitz <=
jsavitz@redhat.com>:
>
> When PR_GET_TASK_SIZE is passed to prctl, the kernel will attempt to
> copy the value of TASK_SIZE to the userspace address in arg2.
>
> Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  include/uapi/linux/prctl.h |  3 +++
>  kernel/sys.c               | 10 ++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 094bb03b9cc2..2335fe0a8db8 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -229,4 +229,7 @@ struct prctl_mm_map {
>  # define PR_PAC_APDBKEY                        (1UL << 3)
>  # define PR_PAC_APGAKEY                        (1UL << 4)
>
> +/* Get the process virtual memory size */
> +#define PR_GET_TASK_SIZE               55
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..7ced7dbd035d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2252,6 +2252,13 @@ static int propagate_has_child_subreaper(struct ta=
sk_struct *p, void *data)
>         return 1;
>  }
>
> +static int prctl_get_tasksize(void __user * uaddr)
> +{
> +       unsigned long task_size =3D TASK_SIZE;
> +       return copy_to_user(uaddr, &task_size, sizeof(unsigned long))
> +                       ? -EFAULT : 0;
> +}
> +

Joel, you missed my point from the comment to v1.
This is still broken for compat architectures. On 64 bit machines
compat userspace
has unsigned long as u32, and therefore you corrupt user data.


>  int __weak arch_prctl_spec_ctrl_get(struct task_struct *t, unsigned long=
 which)
>  {
>         return -EINVAL;
> @@ -2486,6 +2493,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, =
arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error =3D PAC_RESET_KEYS(me, arg2);
>                 break;
> +       case PR_GET_TASK_SIZE:
> +               error =3D prctl_get_tasksize((void *)arg2) ;
> +               break;
>         default:
>                 error =3D -EINVAL;
>                 break;
> --
> 2.18.1
>
