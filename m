Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7EAC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5598E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSMaAQUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfDWWLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:11:17 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37480 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWWLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:11:17 -0400
Received: by mail-ua1-f66.google.com with SMTP id l17so5350317uar.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlRBsB6IGIWbgBpSBxzuqPEKc4JDD6ALsTbUturvgj4=;
        b=bSMaAQUwBpg31mfIB0yKhMYIBwQkWPqWs+4gBjimft5C9/y2YFzl4JI18ch7ozKvxm
         7cp/BgXeIWdwFxtqvUKYNX2/4w2AduwA3DGikKXmUxluNt/PQBK6i/grb47SjHF3ctCF
         V4u4fWZ9c53ZdkZT+lY/y+cWuX5yWjmlZ5QAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlRBsB6IGIWbgBpSBxzuqPEKc4JDD6ALsTbUturvgj4=;
        b=LSCN02ZTKz2PZlR7mRVBMbkiMozCAoYdggaFX/n1bQfEsm2Ee2l8a07wYzJkn0bta9
         eEENvWAU6JFlT9nbrEET+umZtUn3eHSa0wtwDVgsji2jxBMrN1WUl4x5HNep1UnvacbJ
         KnfqfHaJ7BvAT7PG2axagsF8mdcuIAucOmoHgUbifi+DL55zVEN+NF0CNNIzQRWsLT+m
         v6jB+HNujslDOoDaCuT19iJTq2/YNz1QUWi9ecjFyEn3nMG35WbqtwCDjm3FjPrEk5Ja
         N401Xz+wYCmrlYGxUd33p5tiCcr1cF1apJjbHPv1dkL6l/EqQMg5+CckJR2+tQOWH9AU
         C0Gw==
X-Gm-Message-State: APjAAAWfWMZ0J+7k3EsdCC9pjoBWaRIqniZrfn5H4bocWJo10k3r04b4
        45Xzd3Yu6ZMOqjO2PUOeKQ233NmfBdk=
X-Google-Smtp-Source: APXvYqy2LDTEUak/IKQLe00OABqTRi//6i6KVJPeQLbUgJ9cKEb/+MFrwHXR8A2//3rwY0K90SlhCA==
X-Received: by 2002:a9f:2c09:: with SMTP id r9mr12917658uaj.56.1556057476195;
        Tue, 23 Apr 2019 15:11:16 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id y18sm3080099vsm.10.2019.04.23.15.11.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:11:15 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id f22so9240656vso.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:11:15 -0700 (PDT)
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr14921317vsc.172.1556057474640;
 Tue, 23 Apr 2019 15:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190306201413.14153-1-tycho@tycho.ws>
In-Reply-To: <20190306201413.14153-1-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:11:03 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJDhQ_3jS9-VSUwruFDpb4GwqUs=iz7uNGMkPbLnNWKUw@mail.gmail.com>
Message-ID: <CAGXu5jJDhQ_3jS9-VSUwruFDpb4GwqUs=iz7uNGMkPbLnNWKUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] seccomp: fix up grammar in comment
To:     Tycho Andersen <tycho@tycho.ws>, James Morris <jmorris@namei.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 12:14 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> This sentence is kind of a train wreck anyway, but at least dropping the
> extra pronoun helps somewhat.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Acked-by: Kees Cook <keescook@chromium.org>

James, this can go in for v5.2 -- no rush.

-Kees

> ---
>  kernel/seccomp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index e815781ed751..d0d355ded2f4 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -329,7 +329,7 @@ static int is_ancestor(struct seccomp_filter *parent,
>   * Expects sighand and cred_guard_mutex locks to be held.
>   *
>   * Returns 0 on success, -ve on error, or the pid of a thread which was
> - * either not in the correct seccomp mode or it did not have an ancestral
> + * either not in the correct seccomp mode or did not have an ancestral
>   * seccomp filter.
>   */
>  static inline pid_t seccomp_can_sync_threads(void)
> --
> 2.19.1
>


-- 
Kees Cook
