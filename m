Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2DFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 20:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235DB2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 20:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Qu2TbXeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLFUpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:45:44 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40609 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 15:45:43 -0500
Received: by mail-pj1-f66.google.com with SMTP id s35so3219895pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VOsaC4XNGCNL08wJ1Isu8GXBKxKCmyL9XgpAeEcxc/g=;
        b=Qu2TbXeM9nPi9ABZi5uryXxjTA3Is/UmwjhbWfF35Zwjz8U49iAU/TUXmsC4mmERn+
         12TvDE7HIe1t/zA1vjIc1cDAaWGToEtSMCBUOmfqm65oAc/iXfE3r3gc2WponDk7p/+u
         Z9n8+b8IUMk6DDDFm6/WVIHe5Q9AgkpDqPrq6XNL2WMJqyr5MDHd0eP7cgHhgIU7Q0ZJ
         QoCqv+NPv5/kswj14dUtg0BBxBO8vYo3jYLkeF9yLrODSYOIzxiBdXbOxzSayUFvuB0+
         VYjwgGl6GKK6ZenwGaMFDX2fjrrO4sXwleepQLg3SZXpGFO0ZOd3dXSmId6fXRS/EFU/
         +J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VOsaC4XNGCNL08wJ1Isu8GXBKxKCmyL9XgpAeEcxc/g=;
        b=DR5VWfuc8Eet1hbY7UeMIjcCTM6ldgDluBxN1+j0tnCHeVc+VGuLsQYPt82o73rKMR
         gWu/6regrwELsFwfZlKHlwMMuL0WT7x0iLVt5Fw/8EHvCni8tVddoc2AzyuL7RmHxbXH
         +pWLcreWHn55UaZhhPdcyhPLJb5R4TIXaBg8MywX0oyDgVt5GeJpUcx7xzqEC8D7c249
         qU00iAAMJ0utMPkuVR6+15oMpYSSWW3zmp+R6n+n1wo9zm9lwbJXqyDuH+t4H3UgtR5J
         Gbq2HILvgG8spxlWbi5bHrj0C6LAZAz49mbMXwNTZyT2NkgQObe6GmQehfjwh+QPVTH0
         JbGg==
X-Gm-Message-State: APjAAAUOEpHIKtwwuPgDoxZEWj7Rac4a9/TFa/S0nt+pqAFXD9E+Hd9q
        tEyghSS9CwheDYhzGsFDSZW3Aw==
X-Google-Smtp-Source: APXvYqwT/geBWEECcvIpkDT2bhiZjQQUXaFgFClcgH/Ew12WfG1P/yNkP1/XqkLh2e95OgdHwSMRxg==
X-Received: by 2002:a17:90a:cb87:: with SMTP id a7mr3169104pju.135.1575665143005;
        Fri, 06 Dec 2019 12:45:43 -0800 (PST)
Received: from ?IPv6:2600:1010:b043:dc2a:75b0:f9bd:71f4:8599? ([2600:1010:b043:dc2a:75b0:f9bd:71f4:8599])
        by smtp.gmail.com with ESMTPSA id i9sm13461892pfd.166.2019.12.06.12.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 12:45:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
Date:   Fri, 6 Dec 2019 12:45:40 -0800
Message-Id: <4C3DA0D9-EF86-42E5-B80E-94EA9F7ED944@amacapital.net>
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        tycho@tycho.ws
In-Reply-To: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
To:     Sargun Dhillon <sargun@sargun.me>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 5, 2019, at 3:44 PM, Sargun Dhillon <sargun@sargun.me> wrote:
>=20
> =EF=BB=BFPTRACE_GETFD is a generic ptrace API that allows the tracer to
> get file descriptors from the traceee.
>=20
> The primary reason to use this syscall is to allow sandboxers to
> take action on an FD on behalf of the tracee. For example, this
> can be combined with seccomp's user notification feature to extract
> a file descriptor and call privileged syscalls, like binding
> a socket to a privileged port.

Can you document the circumstances under which you can call this?

Does it require that you be attached as a tracer?  Does the tracee need to b=
e stopped?  Does it work equivalently if the tracee is ptrace-stopped vs sto=
pped by seccomp?

If the tracee is running and is single-threaded, is the locking correct?

>=20
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
> include/uapi/linux/ptrace.h |  5 +++++
> kernel/ptrace.c             | 39 +++++++++++++++++++++++++++++++++++--
> 2 files changed, 42 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index a71b6e3b03eb..2b69f759826a 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -101,6 +101,11 @@ struct ptrace_syscall_info {
>    };
> };
>=20
> +/* This gets a file descriptor from a running process. It doesn't require=
 the
> + * process to be stopped.
> + */
> +#define PTRACE_GETFD    0x420f
> +
> /*
>  * These values are stored in task->ptrace_message
>  * by tracehook_report_syscall_* to describe the current syscall-stop.
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index cb9ddcc08119..a1d7b289fe8e 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -31,6 +31,7 @@
> #include <linux/cn_proc.h>
> #include <linux/compat.h>
> #include <linux/sched/signal.h>
> +#include <linux/fdtable.h>
>=20
> #include <asm/syscall.h>    /* for syscall_get_* */
>=20
> @@ -994,6 +995,37 @@ ptrace_get_syscall_info(struct task_struct *child, un=
signed long user_size,
> }
> #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
>=20
> +static int ptrace_getfd(struct task_struct *child, unsigned long fd)
> +{
> +    struct files_struct *files;
> +    struct file *file;
> +    int ret =3D 0;
> +
> +    files =3D get_files_struct(child);
> +    if (!files)
> +        return -ENOENT;
> +
> +    spin_lock(&files->file_lock);
> +    file =3D fcheck_files(files, fd);
> +    if (!file)
> +        ret =3D -EBADF;
> +    else
> +        get_file(file);
> +    spin_unlock(&files->file_lock);
> +    put_files_struct(files);
> +
> +    if (ret)
> +        goto out;
> +
> +    ret =3D get_unused_fd_flags(0);
> +    if (ret >=3D 0)
> +        fd_install(ret, file);
> +
> +    fput(file);
> +out:
> +    return ret;
> +}
> +
> int ptrace_request(struct task_struct *child, long request,
>           unsigned long addr, unsigned long data)
> {
> @@ -1222,7 +1254,9 @@ int ptrace_request(struct task_struct *child, long r=
equest,
>    case PTRACE_SECCOMP_GET_METADATA:
>        ret =3D seccomp_get_metadata(child, addr, datavp);
>        break;
> -
> +    case PTRACE_GETFD:
> +        ret =3D ptrace_getfd(child, data);
> +        break;
>    default:
>        break;
>    }
> @@ -1265,7 +1299,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, un=
signed long, addr,
>    }
>=20
>    ret =3D ptrace_check_attach(child, request =3D=3D PTRACE_KILL ||
> -                  request =3D=3D PTRACE_INTERRUPT);
> +                  request =3D=3D PTRACE_INTERRUPT ||
> +                  request =3D=3D PTRACE_GETFD);
>    if (ret < 0)
>        goto out_put_task_struct;
>=20
> --=20
> 2.20.1
>=20
