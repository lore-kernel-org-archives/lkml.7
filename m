Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0041C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69147208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+9pz1DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfHKI6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 04:58:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44971 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfHKI6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:58:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so101967015wrf.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WC56qM7NPq7J/trp06WddG4lZ3owLrgTw3o336eeXuc=;
        b=P+9pz1DAidU7VJKY6uVrq0H6LmbmfYI9ro6XsZTeHuMNEImSA/9Z4cYYOn3zGadu5d
         uxK3jTg6vwUTqIufAaFJBW1GwPsHnwYUyXdisMVGVkjR1DyCBTOhQrzg2SaHEmTctRQn
         r7s2RB+N/8Qn5nRTgIxxdgduV5o5Gh27LJk4vyp07KgFR8gAjnUTFcK6qDjVfnHzCC32
         ESyMC1e6UyqSzrWMybTlsAmutZ5l+AE5vmgttwzs/8hR62qM5cFtD2nyxhwHQh1+buj9
         aABQmwXqBlienmWlNSIAhNF4BzsW1B4Ksm2evNgtA35t5uMnxBwrI/aRqxSX7mzW9MXY
         G5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WC56qM7NPq7J/trp06WddG4lZ3owLrgTw3o336eeXuc=;
        b=oLI4orbZN/jccBG+1yerH/IXMen/0m6Izqk+gZW2zAptpk8EVDix7iVpYyu/lbVpMw
         vtnkp0w0aRq7hIWB2raytKkRKEwEnEL8Z6gLmS8DAcS9EcQyQTSk67OOVw6zsTk9+iGR
         qUKbibFc4VUDC3Aen7A9rD6p1+/H7Cbl8cQvSj2mCsaxknHvlS5vKdiDiZSg6FN0L5CF
         ev8YiB+4kGxbydzZXqOdiCEmBos+brrzdx43u6u+EfK3lmmNRI2LV6OpWoPxoSeXGcfU
         MZUHqboYTUHv8G5woRrxkq8uDj4TS/cukQFY7Rpn6QVcBU8qVq9FiZZfCoW8rbUG3VUO
         qfzA==
X-Gm-Message-State: APjAAAVDHO6BAtGIBmbwL5pIbdXa3PJNdccUrd936HhJZnVy+FjHnPdk
        J2EW7NMWB2FNf1nzh2IxS3Y=
X-Google-Smtp-Source: APXvYqzDAHKZDmoLV7UCWpBnl0oecn12nHJ8Jddn5rEC7XTqEY3N5uiADmw/NQ3m65+Q7A6kWs+xew==
X-Received: by 2002:a05:6000:145:: with SMTP id r5mr9221716wrx.75.1565513914460;
        Sun, 11 Aug 2019 01:58:34 -0700 (PDT)
Received: from Jitter (eth-east-parth2-46-193-66-42.wb.wifirst.net. [46.193.66.42])
        by smtp.gmail.com with ESMTPSA id u130sm21706865wmg.28.2019.08.11.01.58.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 01:58:33 -0700 (PDT)
Date:   Sun, 11 Aug 2019 10:58:33 +0200
From:   Paul Chaignon <paul.chaignon@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
Message-ID: <CAO5pjwSe+U70tSPjKOgFsqqF=gCKXPDREzYF81NCZ03kGAyWww@mail.gmail.com>
References: <20190809182621.GA4074@Nover>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809182621.GA4074@Nover>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 8:26 PM Paul Chaignon <paul.chaignon@orange.com> wrote:
>
> We need BPF_MOD to match system calls against whitelists encoded as 32-bit
> bit arrays.  The selection of the syscall's bit in the appropriate bit
> array requires a modulo operation such that X = 1 << nr % 32.

Of course, X = 1 << nr & 0x1F, and we can do without BPF_MOD in our case.
I'll put that on a lack of sleep...

>
> Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
> ---
>  kernel/seccomp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 811b4a86cdf6..87de6532ff6d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -205,6 +205,8 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>                 case BPF_ALU | BPF_MUL | BPF_X:
>                 case BPF_ALU | BPF_DIV | BPF_K:
>                 case BPF_ALU | BPF_DIV | BPF_X:
> +               case BPF_ALU | BPF_MOD | BPF_K:
> +               case BPF_ALU | BPF_MOD | BPF_X:
>                 case BPF_ALU | BPF_AND | BPF_K:
>                 case BPF_ALU | BPF_AND | BPF_X:
>                 case BPF_ALU | BPF_OR | BPF_K:
> --
> 2.17.1
