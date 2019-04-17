Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11670C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC8621773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIVNEeid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfDQDAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:00:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46186 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDQDAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:00:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so8693897lfj.13;
        Tue, 16 Apr 2019 20:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPqjQVLtT6aFDQeUyBSw/2LEhQz8zlq+Rgpi71bmly8=;
        b=PIVNEeidDIAHEfu8ckN3kRBlXea6F9HMPioWP1LYlEMjM/x/aH0Nt/bg1Vm2P73HYF
         fd4jUEovycsERRrxrsxm2QiH0pkid57n9b9pAkfQJXmr7XFPKKLx+fB+l7F6EEewLFb7
         GrPxmUeUxW2x+VRPf1YDZVpv30sE7u9nNp4SyAMHDFn3FTbNUKdvUjcehydT6C8t1j71
         sjNy2YTbJkJl59VpL8pOK3UTc87IaHtRpN+jN88p0xNscAj9AkpuR1a79sqmGHWCBfrq
         8Y9pCsN6BerByx9nuwAGxLuiHiGPYBrXXGcMZoh/xcsJvTOhubmZMszbaILNj51/SkEg
         9vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPqjQVLtT6aFDQeUyBSw/2LEhQz8zlq+Rgpi71bmly8=;
        b=sdmJtdjAHqHShyITNtLfEe3HEEriLVs8ElGCdM8S26wIhQq3+fSaJW7grgTC9NITi/
         opnm0HiYhZKBgu2RwpG3IKTt5OG1D+P1r/DwRbdTYsu6lLlq9YgE8apDOJEv0nzM19t2
         cGWIYOGfJNPPJhLxaFWVXGwM0AqZ0gTkvi5O7CRy+SFiRvlT/+74E0G68KhFw0XqDlV6
         YZUj7bVkG5f3yKzsU7OP6rwRXidNZFmSxLEH8CoScF4+wz5blw/2cvQDGNqT3fqtRj04
         V9hKGgqzxH9mr6BRBzl8zwV/9sDpnesPgaE04yXvza7oJ+Z4hGyuB8dutuUCcb3VAwNE
         3ykQ==
X-Gm-Message-State: APjAAAU2OZ1/NFw6HYzTsmPWP2wY2sQs8EKoxIKQl/xjpk99lFZUsmxt
        4sgm7pmsooDKmMcCr+oCTxi8TsTRHmEHy8DdQEU=
X-Google-Smtp-Source: APXvYqyvZea77TNs1EBQ0aI6LNDlEVixHjw2X0tfXkJYzDj9wywavXuRFlqiH9ZF06URo2Z0PNrIYtc3Yzc7eZYneAA=
X-Received: by 2002:ac2:592b:: with SMTP id v11mr22699688lfi.85.1555470000609;
 Tue, 16 Apr 2019 20:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100018.20852-1-alban@kinvolk.io>
In-Reply-To: <20190412100018.20852-1-alban@kinvolk.io>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Apr 2019 19:59:49 -0700
Message-ID: <CAADnVQLzNotsJgniQc0cA0v8K=F0wwfOaT6KirRJ0urLiFib_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: sock ops: add netns in bpf context
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>, iago@kinvolk.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 3:01 AM Alban Crequy <alban.crequy@gmail.com> wrote:
>
> From: Alban Crequy <alban@kinvolk.io>
>
> sockops programs can now access the network namespace inode via
> (struct bpf_sock_ops)->netns. This can be useful to apply different
> policies on different network namespaces.
>
> In the unlikely case where network namespaces are not compiled in
> (CONFIG_NET_NS=n), the verifier will not allow access to ->netns.
>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  include/uapi/linux/bpf.h |  1 +
>  net/core/filter.c        | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 31a27dd337dc..5afaab25f205 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3069,6 +3069,7 @@ struct bpf_sock_ops {
>         __u32 sk_txhash;
>         __u64 bytes_received;
>         __u64 bytes_acked;
> +       __u64 netns;
>  };

stat /proc/self/ns/net
returns inode and device.
inum only is not enough to identify netns.
Both need to be exposed. See netns_dev/netns_ino in bpf.h
