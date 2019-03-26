Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6FE20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko9TC5vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfCZF6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:58:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41527 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfCZF6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:58:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id y5so1112892plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=CbYmRGUZEd1iQvum1IXYqF42ybOYTBKz3+p6mg+oYlo=;
        b=Ko9TC5vvEKuLwoXWFWzSAreUCqwrexYQMDa9zIoj6ql1FmP/l//6Ugs9azCRPyRu6J
         3rB852ZUpel8SIRAf1eA0VXvpeRr6gGfASPseK4uV3ZnuBZcy1lEUTLBEsSL7Db9ANKd
         8o8kh2cMlQR9PXoKKK3OkAnDekzGyhdfTLjBPSQi4IrHKdu48rwSnrWUESCOgx7OmYLe
         NuJ8h6kSYMSPTd/YeqYCrrD9iqEV3RYTRXzclPfWx8vYe19Z6xcDINB/jVaeOe8lzh2j
         eXmjJGFYw0Du/D5AhoU+ln+15kZ6rEM59plczL2dYyrQq/tDxtpP5uY7calONo898Fl/
         5htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=CbYmRGUZEd1iQvum1IXYqF42ybOYTBKz3+p6mg+oYlo=;
        b=MTJ4NIWFCJtiujPKuBPu3Iknd+kXHPivZN7dvxwh0c26Zu4aDnYij04cIzLYzTAg7z
         YWIfBqMYVeIPqEaqHEuXevS9DyTSfeWAGF8DUaKF6onbaRvKbAbcDm5UqumKzWRbkwcL
         vUVGIcV+KPfRdjMANz7QY8n31U0mQShH8elYx6B/gXtDz5Pb0lJQ4+Xy8JPK63gY6hva
         4IBo7x5Nh8rZ7YD3ZUI8CefsiIMahYh6SOBvXqDR9qJx3fh3AxuknyOOJ9jYPCeffyYy
         W3IfVUDbrtoa5ZMpn4kuzwHREAjo7wahQ8fckvvUiqCi7EBP7rXxDfvyXXWiWweyv+54
         cBzw==
X-Gm-Message-State: APjAAAU2W4y6KzNdDlbDhLLVdvSz7l0XZ2ptGwG2gCQQFgdWBz4n9G6Y
        8MkZGRHrAJyWLdpeBIudTGk=
X-Google-Smtp-Source: APXvYqwYpL9AXMOqLKcqIJyllvGM0xwvhgBITtdXdHbwwCZFAwPbb753YOq1ogdG3ANmWqO5UHFx5Q==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr28480020pla.120.1553579930670;
        Mon, 25 Mar 2019 22:58:50 -0700 (PDT)
Received: from localhost ([193.114.107.176])
        by smtp.gmail.com with ESMTPSA id 25sm22419793pfo.96.2019.03.25.22.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 22:58:49 -0700 (PDT)
Date:   Tue, 26 Mar 2019 15:58:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2]  arch/powerpc: Rework local_paca to avoid LTO warnings
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
        <20190314023125.10076-1-alastair@au1.ibm.com>
In-Reply-To: <20190314023125.10076-1-alastair@au1.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1553579424.0r39b9otz6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair D'Silva's on March 14, 2019 12:31 pm:
> From: Alastair D'Silva <alastair@d-silva.org>
>=20
> When building an LTO kernel, the existing code generates warnings:
>     ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
>         =E2=80=98local_paca=E2=80=99 used for multiple global register va=
riables
>      register struct paca_struct *local_paca asm("r13");
>                                   ^
>     ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
>         =E2=80=98local_paca=E2=80=99

Isn't this a bogus warning? It doesn't look like there's a way to=20
define it any other way.

>=20
> This patch reworks local_paca into an inline getter & setter function,
> which addresses the warning.
>=20
> Changelog:
> V2
>   - Address whitespace issues
>   - keep new implementation close to where the old implementation was
>=20
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/include/asm/paca.h | 37 +++++++++++++++++++++++++--------
>  arch/powerpc/kernel/paca.c      |  2 +-
>  2 files changed, 29 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/p=
aca.h
> index e843bc5d1a0f..2fa0b43357c9 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -34,19 +34,38 @@
>  #include <asm/cpuidle.h>
>  #include <asm/atomic.h>
> =20
> -register struct paca_struct *local_paca asm("r13");
> -
>  #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
>  extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
> -/*
> - * Add standard checks that preemption cannot occur when using get_paca(=
):
> - * otherwise the paca_struct it points to may be the wrong one just afte=
r.
> - */
> -#define get_paca()	((void) debug_smp_processor_id(), local_paca)
> -#else
> -#define get_paca()	local_paca
>  #endif
> =20
> +static inline struct paca_struct *get_paca_no_preempt_check(void)
> +{
> +	register struct paca_struct *paca asm("r13");
> +
> +	return paca;
> +}

Problem is it now changes the global register variable to a local=20
register variable. The compiler would presumably be within its rights
to "cache" that return value or use another register for it, which
is not really what we want.

Thanks,
Nick

=
