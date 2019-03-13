Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBCAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB26213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCMU10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:27:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44792 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCMU10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:27:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id g1so3002061otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQh9oCty3X12wR6Qth9IqtpQXMvTmvN4B6jdIkdrfYY=;
        b=AOLt3tcPGjgKESTo1eeKlzq3aSVG0/65OrObzJifiEdTSg0T2W0GiyfEq59zxZrugk
         VskVHH9sKUwlMK9IkYfX8bKGX5zWQvrl6KAckjGYiGtZ4n++sTzBK85XLI1MqppfJJsZ
         5W+Ch7dWnEBuIEI4/MwEo2YrduuDfFZgHquvNdeMaE4kNfqu8eukfighZgGW3JOGQnrm
         4TlnqFy6J48k/oKMzVZP6VKsHtAosP4BSwEpldmt1TAIKNPs3JYucpQTwoqd6dL4YV91
         qlgzceYsi6vXPv0uHY65DSrvpZU8laiEX3YD0yVffTMdYxgEIsyrTo51s/Iaodz9W5U2
         8dLA==
X-Gm-Message-State: APjAAAX5y6AnKRMLBH3vv82Y+ZMOLt7Z/4KP2TXnBPsTul9PXSIAOTEp
        BYZqkXkiBDiuU0cO5yW2AAON95jda18iOZBK7EY=
X-Google-Smtp-Source: APXvYqy5+Ay2WKjtEkX+oBlmASofYr/40FIyxSBRsL6BdzOH5mSPKmV27eZp6Me4ydRNXGN8002yqhEImcwpJJhFwaI=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr1269743otn.300.1552508845231;
 Wed, 13 Mar 2019 13:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190114203505.17875-1-malat@debian.org>
In-Reply-To: <20190114203505.17875-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 13 Mar 2019 21:27:14 +0100
Message-ID: <CA+7wUswdVU=JuHPAVo9gxZJ8BYWhThnsLggVM5t9h--=AhCPPQ@mail.gmail.com>
Subject: Re: [PATCH] signal: annotate implicit fall through
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On Mon, Jan 14, 2019 at 9:35 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
>
> This commit remove the following warning:
>
>   kernel/signal.c:795:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  kernel/signal.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e1d7ad8e6ab1..aa7a507757d7 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -794,6 +794,7 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
>                          */
>                         if (!sid || sid == task_session(current))
>                                 break;
> +                       /* fall through */
>                 default:
>                         return -EPERM;
>                 }
> --
> 2.19.2
>
