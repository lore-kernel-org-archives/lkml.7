Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850AEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3CE206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRm/bFYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfJGSI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:08:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34830 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:08:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so5768354plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwC6F2GJvmhpWHGCr7xF/n4f6KLR7+2yf2OOH5GEsgU=;
        b=uRm/bFYPsstoaYyKukSFhdRLDpzni7itu2EEZfLPwBlxu+qsX3FN7N7lVTsrFB6a6K
         vt7+5nD3qCBr++/ITUQKwWu6K1dnnVKEt8by7hgTzUOMuW8aSJmqfpxVW8GC6fnd69ap
         1pnD3I89VMIFfNvvpwCzdpEh/qO1Od6mzoyPAlHrefC1wGCje/aK5MwPIXZ6chgkFXhK
         KsuQVX0urhlgK8mFNDKZcv7vS+scCHKzOFH+oTcfTWojqCVkR+D+/dCzZmS4njEVH2Bl
         PtJO3eKNJwpLPfTs5A30TwFHfGYk+h+QE5LMOVXSkqZiGpYH1O9FH2LEOwp4700pX9OZ
         2g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwC6F2GJvmhpWHGCr7xF/n4f6KLR7+2yf2OOH5GEsgU=;
        b=Hc2tPgKoq586y0gpdY+Uplcx45mXi/hJ2SrBuyrzsBoiiMQ+S7miY5qhc1F1VKAvon
         Xs/k5Xnf8Nus9vlVrr23YwnkZ0lfoqcB10t+vtyqLaW2madJ2gnIQca/5SFUjzZ9Avbt
         D05/9Y5T6ZaKWTD+WeZjuvm+v3syd08z/+Pw9btI/QF+cPJV2lQVXr0OHP4dcALgEuX3
         lw3bqqgnAL7dMwLQYYBxEu0O1pr+y556j3P5S5d4KeqDm2ENMZLMV0nluCdiERSsOt/x
         y3b9H224gAtKxWWtztBnGrQCXS2+H6nEhRygsYIbx2OE24YyB2vLpmvMH/RXZQj6pfuy
         xRzg==
X-Gm-Message-State: APjAAAUJadF37oB1ii1bVgOyGdOp2ehyzrX1Q+JKvzvV5OBxTj+NwvF6
        gPvq1L45ozqNMDpBhGuFMY4OQfl05ceUidL8uhYCSg==
X-Google-Smtp-Source: APXvYqzOl3JXsj4sTtvjvilp+o9GzSCOZkl0A9M3zcxvheER0viyb3/IMPpVI+XWTbKtuhaCp0QRNTl7H6IBggmcCXE=
X-Received: by 2002:a17:902:7c08:: with SMTP id x8mr29403977pll.119.1570471736235;
 Mon, 07 Oct 2019 11:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <2e0111756153d81d77248bc8356bac78925923dc.1570292505.git.joe@perches.com>
In-Reply-To: <2e0111756153d81d77248bc8356bac78925923dc.1570292505.git.joe@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Oct 2019 11:08:45 -0700
Message-ID: <CAKwvOdmtfUfpGhKODa=UBtq7AKDaJa9cndf7fkjJw1R37SsR6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] net: sctp: Rename fallthrough label to unhandled
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-sctp@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 9:46 AM Joe Perches <joe@perches.com> wrote:
>
> fallthrough may become a pseudo reserved keyword so this only use of
> fallthrough is better renamed to allow it.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  net/sctp/sm_make_chunk.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index e41ed2e0ae7d..48d63956a68c 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2155,7 +2155,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>         case SCTP_PARAM_SET_PRIMARY:
>                 if (ep->asconf_enable)
>                         break;
> -               goto fallthrough;
> +               goto unhandled;
>
>         case SCTP_PARAM_HOST_NAME_ADDRESS:
>                 /* Tell the peer, we won't support this param.  */
> @@ -2166,11 +2166,11 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>         case SCTP_PARAM_FWD_TSN_SUPPORT:
>                 if (ep->prsctp_enable)
>                         break;
> -               goto fallthrough;
> +               goto unhandled;
>
>         case SCTP_PARAM_RANDOM:
>                 if (!ep->auth_enable)
> -                       goto fallthrough;
> +                       goto unhandled;
>
>                 /* SCTP-AUTH: Secion 6.1
>                  * If the random number is not 32 byte long the association
> @@ -2187,7 +2187,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>
>         case SCTP_PARAM_CHUNKS:
>                 if (!ep->auth_enable)
> -                       goto fallthrough;
> +                       goto unhandled;
>
>                 /* SCTP-AUTH: Section 3.2
>                  * The CHUNKS parameter MUST be included once in the INIT or
> @@ -2203,7 +2203,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>
>         case SCTP_PARAM_HMAC_ALGO:
>                 if (!ep->auth_enable)
> -                       goto fallthrough;
> +                       goto unhandled;
>
>                 hmacs = (struct sctp_hmac_algo_param *)param.p;
>                 n_elt = (ntohs(param.p->length) -
> @@ -2226,7 +2226,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>                         retval = SCTP_IERROR_ABORT;
>                 }
>                 break;
> -fallthrough:
> +unhandled:
>         default:

Interesting control flow (goto from one case to the default case, not
sure "fallthrough" was ever the right word for that).  Thanks for the
patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 pr_debug("%s: unrecognized param:%d for chunk:%d\n",
>                          __func__, ntohs(param.p->type), cid);
> --
> 2.15.0
>


-- 
Thanks,
~Nick Desaulniers
