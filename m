Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D8620684
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz+We9mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfCDW71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:59:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43738 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:59:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id y4so7025692qtc.10;
        Mon, 04 Mar 2019 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeVtyt6+gK4gj0AOHwzuOV7rIp87XdBaYOsjxe42f7w=;
        b=sz+We9mQuRu2WZSVKWAibeYRfR8rWlGv566a3Z5rtjObVDpDCP8/zu68vPKUH9IS2M
         FCML+KBr75fqxSxuUcnPLIeTmgmbYs4UfIyzyXW9n91UQ6lT7s44y82PWluzyuOMWWH9
         j9wReu7Z2BxZ7/xdrS/FLgYyR6KcQhH5oYOlqkngRDhRECQ9IgRk8Zi9DNpj5Mv0k7dr
         P9OGl5jD122xEeVRFDHhyBlmIPt3V4272nWmLYfIUJ3WunCEp76qYJ/QO1lIvF1bcRW0
         7enBb9JqwLUN2lmvZAH5y3vpwWeUcjDSJBat26a6mOBtPnUHs15mhLUTsIfjTsbZq1gA
         GiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeVtyt6+gK4gj0AOHwzuOV7rIp87XdBaYOsjxe42f7w=;
        b=lxFy1qXU/ECUGUcAISwhn9/jHbMMXXQqpU8ZX4wwe7EryxOOyMhrcHoPxbG8WWROLZ
         VICt60AQROIGG9IuK7/KCKeusoFi+N83VXKujvVJyTNnhkKQh2Lk8F28G/GvXnHtktqg
         hLFlgp1JmGhHJayMtgucdcFGEBQ44ShraiLmKD19mA1ZfPBibX7Wzv+/HIdo/Bg/VjN/
         NmiNGPcGNhXfRalyPdaGze8gkTY/tq2pS6cMdNeHMtBScWRRRsmtt5DiqvxxxdDTQc6/
         0q9jzAt+atQzYEQOniOzZIRqQxNXeQNHvrl4oOI6fB195EgNr7v8hrDbOJwWbBKeLuWP
         xQrA==
X-Gm-Message-State: APjAAAU3H9MbaCCTlDeff9O85VvT0KAmUdY6eITzBIyX6vCZOaVyRor0
        2gnhjfKbt2cB+Glc5ghcEfehdhUikHrY1yLg4P9UKQ==
X-Google-Smtp-Source: APXvYqygD5FSB8EOcNpTxxw6+tMTViQhN0+GodrkOvTNI1ZAcwoRnszEl/u8FPJirtXh09/URM3oj3wkRIvRU0Ja5Tk=
X-Received: by 2002:aed:3904:: with SMTP id l4mr16071088qte.194.1551740365875;
 Mon, 04 Mar 2019 14:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20190304205019.15071-1-adrian.ratiu@collabora.com>
In-Reply-To: <20190304205019.15071-1-adrian.ratiu@collabora.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 4 Mar 2019 14:59:14 -0800
Message-ID: <CAPhsuW4kbZhE=1v4t6v803zA6PnRjzGA5UaAu5Nrbo7mrYyw5Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add arm target register definitions
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     bpf <bpf@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 12:50 PM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> eBPF "restricted C" code can be compiled with LLVM/clang using target
> triplets like armv7l-unknown-linux-gnueabihf and loaded/run with small
> cross-compiled gobpf/elf [1] programs without requiring a full BCC
> port which is also undesirable on small embedded systems due to its
> size footprint. The only missing pieces are these helper macros which
> otherwise have to be redefined by each eBPF arm program.
>
> [1] https://github.com/iovisor/gobpf/tree/master/elf
>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

I think this is for bpf-next tree, which is closed during the merge window.
Please resubmit when the bpf-next trees is opened (usually in 2 weeks).

Thanks,
Song

> ---
>  tools/testing/selftests/bpf/bpf_helpers.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
> index 6c77cf7bedce..f7883576f445 100644
> --- a/tools/testing/selftests/bpf/bpf_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_helpers.h
> @@ -232,6 +232,9 @@ static int (*bpf_skb_pull_data)(void *, int len) =
>  #elif defined(__TARGET_ARCH_s930x)
>         #define bpf_target_s930x
>         #define bpf_target_defined
> +#elif defined(__TARGET_ARCH_arm)
> +       #define bpf_target_arm
> +       #define bpf_target_defined
>  #elif defined(__TARGET_ARCH_arm64)
>         #define bpf_target_arm64
>         #define bpf_target_defined
> @@ -254,6 +257,8 @@ static int (*bpf_skb_pull_data)(void *, int len) =
>         #define bpf_target_x86
>  #elif defined(__s390x__)
>         #define bpf_target_s930x
> +#elif defined(__arm__)
> +       #define bpf_target_arm
>  #elif defined(__aarch64__)
>         #define bpf_target_arm64
>  #elif defined(__mips__)
> @@ -291,6 +296,19 @@ static int (*bpf_skb_pull_data)(void *, int len) =
>  #define PT_REGS_SP(x) ((x)->gprs[15])
>  #define PT_REGS_IP(x) ((x)->psw.addr)
>
> +#elif defined(bpf_target_arm)
> +
> +#define PT_REGS_PARM1(x) ((x)->uregs[0])
> +#define PT_REGS_PARM2(x) ((x)->uregs[1])
> +#define PT_REGS_PARM3(x) ((x)->uregs[2])
> +#define PT_REGS_PARM4(x) ((x)->uregs[3])
> +#define PT_REGS_PARM5(x) ((x)->uregs[4])
> +#define PT_REGS_RET(x) ((x)->uregs[14])
> +#define PT_REGS_FP(x) ((x)->uregs[11]) /* Works only with CONFIG_FRAME_POINTER */
> +#define PT_REGS_RC(x) ((x)->uregs[0])
> +#define PT_REGS_SP(x) ((x)->uregs[13])
> +#define PT_REGS_IP(x) ((x)->uregs[12])
> +
>  #elif defined(bpf_target_arm64)
>
>  #define PT_REGS_PARM1(x) ((x)->regs[0])
> --
> 2.20.1
>
