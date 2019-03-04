Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE255C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA51420835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QX+XERJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfCDUrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:47:45 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44814 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:47:44 -0500
Received: by mail-ua1-f67.google.com with SMTP id r21so5654657uan.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8mwHyTQD3viibZhlwqMBx4el6lQf1vUm4nyYwj8u4Q=;
        b=QX+XERJpa12NN7BG83hwaLrRmRKeSTj/iLPZ5Rvc3NZtHb0XWTH2x5Z0t2+rsxKlU9
         iNMVpLkRMTYeiVTK0Tu8anwvPVL97EYa/4fvIQA9lX5LAcva8M4D8i4m63Nv0fE6Dl0B
         YEsd+8SbGlgiC+DdawHMX8+0BWFfldL2AYZbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8mwHyTQD3viibZhlwqMBx4el6lQf1vUm4nyYwj8u4Q=;
        b=BDtlSKOXQMX4DnOvc3gOWEamDcrkeVyJjgoT3sdawy8LnkrCrjHw7MDZLPB/wVMB0o
         zYW/YRwNHiOgQOWRjTbi1RMJkdgsRs+EVTrRBH/HdpStWxPyQugsoRtu+IQz9e5ceIxW
         KdpR3RRpsPKi30sChdTRxIcLKF9YQz+DP8FsRD/mOYJmgpT8q3DnBTIJA5pxKLLjqU8F
         oeTVch+PmBrfgUl53yCMZe2GfF9O6FEPEkbEbdzpFe3ixhFNS+9EhW7a2c4SSFoc/tHv
         iATux43vRrw3fICHRXbBStErVDuvOyMH54fXPIZcU6k6CBBQvTIHPgDYXZAmoAHBGvX6
         Tn9A==
X-Gm-Message-State: APjAAAXTM5Avz1PwUNG5pVrsXsRYEUST0PYQ5VoYW6NHLnZ7+MAfI2np
        SGSvlXHghxOfme45nBJovIMEBiKjUU4=
X-Google-Smtp-Source: APXvYqxxjwD1adYZwpXD0Ay31JlKrNvG3Hil6w824DXbhlg6qHjwtCqhjikE5Ic2Rx2hRCJvPnbFMw==
X-Received: by 2002:a67:d403:: with SMTP id c3mr10473658vsj.67.1551732463362;
        Mon, 04 Mar 2019 12:47:43 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id y125sm1554407vsy.0.2019.03.04.12.47.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 12:47:43 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id u1so5661514uae.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 12:47:42 -0800 (PST)
X-Received: by 2002:a05:6102:d2:: with SMTP id u18mr10635494vsp.172.1551732462335;
 Mon, 04 Mar 2019 12:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20190304203443.1992942-1-arnd@arndb.de>
In-Reply-To: <20190304203443.1992942-1-arnd@arndb.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 4 Mar 2019 12:47:31 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLfAqwFBGH6VPLKrGXOdeEX4ngKdvsG729MbMOuBU7AcA@mail.gmail.com>
Message-ID: <CAGXu5jLfAqwFBGH6VPLKrGXOdeEX4ngKdvsG729MbMOuBU7AcA@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix sysctl.c warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 12:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_BPF_SYSCALL or CONFIG_SYSCTL is disabled, we get
> a warning about an unused function:
>
> kernel/sysctl.c:3331:12: error: 'proc_dointvec_minmax_bpf_stats' defined but not used [-Werror=unused-function]
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>
> The CONFIG_BPF_SYSCALL check was already handled, but the SYSCTL check
> is needed on top.
>
> Fixes: 492ecee892c2 ("bpf: enable program stats")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 46a0d0a14a66..b3df3ab7ac28 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3330,7 +3330,7 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
>
>  #endif /* CONFIG_PROC_SYSCTL */
>
> -#ifdef CONFIG_BPF_SYSCALL
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>                                           void __user *buffer, size_t *lenp,
>                                           loff_t *ppos)
> --
> 2.20.0
>


-- 
Kees Cook
