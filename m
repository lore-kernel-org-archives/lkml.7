Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEF520674
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHUvIbK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfLSU3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:29:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54738 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSU3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:29:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so3051662pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 12:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqzxT6mrWsbaIeSRURSlPRTTrfPOgvLrfU674s46ZS4=;
        b=JHUvIbK/+L4HVr3NgelPDooqz+SUR0A7IPxyuLymVu6hr5drzLNV8lA9w0pOYwLWNi
         H0TTlxwQ8fSdNCnE0CbI5VMqnbdkqD+QVBjfgnV71R7VExGpxulJ5tw18480KLsAf0oi
         mxKY9ZaIzCFJ6hU8RdsVgILrAnQj8302qcORSx0Hr38OJI8QPIrOBmDUHJjzV5hyngrG
         8ShC0xWu9tNeB+8hRRhE9PSAHl+qAcfkD0pv551fkPfsVyF1LpH+WHY5FQcj5V/YUQGN
         9ozIhLywGfbbQvcqvrB3KigXXm6gCGySm0gG9R+5FUVmKqndjWbdFe7jhSlA0hBtZQ2e
         BimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqzxT6mrWsbaIeSRURSlPRTTrfPOgvLrfU674s46ZS4=;
        b=ZHP0QKBTCo5Q7bMS6hL0LD/McPmZ11C35ETWPueBro81MOpwVIP8IlLE+SVNlws19e
         57PB/aEC8Te562P7OnxqCrvC/mr+xix7uJVTtcJxeylNsQyAcpVAuBSNCBCSnn5EGSZw
         NNl509qH39kWcFodaYIamnXNSWyBF+rVSJhn5XbADjs4UYBqHa/9HNGtaOkIttC7vElQ
         SXLt7dv4JmHhoCdcoKrh60+acIxHhJse/RrYippE9NxJwvH1OGJQuIRkf3e72Kyddfmc
         lgzQDHfy9/gIfGCKvk3BsvdEzufrc2n3NQwTKn1wRcAASL1wRy8yqaD+OCmISncvR8TW
         +Bng==
X-Gm-Message-State: APjAAAUSfwdBM5O+xGDbcHmnky4e1Bvv1ktRQ010N6X9A8+aM44XOJRc
        uRqxE+GJBPlvKBfxXk5ZHveOMWsR8ySQYwDokO7ZoA==
X-Google-Smtp-Source: APXvYqytjFvCj74dY3WNhU9s/+3nsvJRtaXXSEdscBye1JkLzXuFS79r+12e5mLtSovK2cogylBvVhUzYP+1cr1TSiY=
X-Received: by 2002:a17:902:9f91:: with SMTP id g17mr10768022plq.179.1576787339454;
 Thu, 19 Dec 2019 12:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20191218032932.37479-1-natechancellor@gmail.com>
In-Reply-To: <20191218032932.37479-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 19 Dec 2019 12:28:48 -0800
Message-ID: <CAKwvOdnJddjhijk4pyHuEKAGKFXiG200rvJg+Mk7EPw3oKcYwA@mail.gmail.com>
Subject: Re: [PATCH] ipc/msg.c: Adjust indentation in ksys_msgctl
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Lu Shuaibing <shuaibinglu@126.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 7:30 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../ipc/msg.c:621:4: warning: misleading indentation; statement is not
> part of the previous 'if' [-Wmisleading-indentation]
>                  return msgctl_down(ns, msqid, cmd, &msqid64.msg_perm,
> msqid64.msg_qbytes);
>                  ^
> ../ipc/msg.c:619:3: note: previous statement is here
>                 if (copy_msqid_from_user(&msqid64, buf, version))
>                 ^
> 1 warning generated.
>
> This warning occurs because there is a space after the tab on this line.
> Remove it so that the indentation is consistent with the Linux kernel
> coding style and clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/829
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> I assume this will be squashed into the offending patch since it is
> still in -next:
>
> https://git.kernel.org/next/linux-next/c/658622e448a6e6a6a69471daeff7e95e98d34ed1
>
>  ipc/msg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ipc/msg.c b/ipc/msg.c
> index 22ed09ded601..caca67368cb5 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -618,7 +618,8 @@ static long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf, int ver
>         case IPC_SET:
>                 if (copy_msqid_from_user(&msqid64, buf, version))
>                         return -EFAULT;
> -                return msgctl_down(ns, msqid, cmd, &msqid64.msg_perm, msqid64.msg_qbytes);
> +               return msgctl_down(ns, msqid, cmd, &msqid64.msg_perm,
> +                                  msqid64.msg_qbytes);
>         case IPC_RMID:
>                 return msgctl_down(ns, msqid, cmd, NULL, 0);
>         default:
> --
> 2.24.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191218032932.37479-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
