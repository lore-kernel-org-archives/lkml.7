Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914B3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB612133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEnZSkbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfJFLJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 07:09:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55433 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfJFLJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 07:09:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so9703549wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KNc82HtJTr2S9yPplsKQ29xKge0h6KdPsl2jhs4BKZo=;
        b=TEnZSkbFr2A7oUM78IHHed3IlgHh0tmkpH8RDssbiR0+mBCHkQe9H1Qxx+vWm2PofE
         sGToOgCFb6hXoCRurvp2anQnTqIH03RhsFu2lxcDV8uagaxEWpHnmGBp14zXgB7Ji5DK
         yQkA74rsANN+bsj7tBFGADqhxFVNGCwn0vccgfBJC0S4ul+XS2NGUWI8kKL36SXIEoGi
         Ys368zcUKr4s1+elLPyEJlWSfNOLEUzVoGLdBwmiXWNtuyUiFQ1CDc8EcteynP4OG/+P
         1JPy+3ec+C6ru4Rw7bsV4fQWWQz7c42N/jqxS6luY8aIfxhWUly2EHxSYvZRsFg+emn2
         lNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KNc82HtJTr2S9yPplsKQ29xKge0h6KdPsl2jhs4BKZo=;
        b=BBPpX26xpfdi5SYjjAuGbQhS0Xjhu8xU236yXaQJkGy0XuiiVN3ZBmjt8B51ZkjAqm
         GQLMmYes5415DtGQomBBlKRuiElx748Dl5Q+1bt+XHVrD4X7NsonbgchTAtFbI9C8XvV
         NEpf8vCqJDCVT2KX0n5DKRlrOVkrqUe5ZkTrfITvQfu5x1W3k7xI3XeoeyW7rttexaPz
         wOyc12EN0eP7AACLs9Xr2/1iGVbWMTAYdLrH2zvfJY+odJwVN/SLBTH0XJAIRZLIyTmJ
         PEZYkiZpt5QyKKGtHBAD8IpUNvpXrnMDhXHWbc0SZrShCDt1t7k3mvCH2CQtGgRnNQjY
         KENw==
X-Gm-Message-State: APjAAAUBR0tCKGW+9cEwTxkxiR6/o/wrlt1p57KChWdTI0irXPa9JE9W
        3DNmsz4yZUs+lRm8Tge0tLiiEg==
X-Google-Smtp-Source: APXvYqze9DN/H2RXzVEdSmtpoum+tTRMTWdWq6wiMUONDwQ1y3I9igSwjnOhiK6Ch9ZxdQYuTaIxmA==
X-Received: by 2002:a05:600c:2311:: with SMTP id 17mr16465507wmo.39.1570360184748;
        Sun, 06 Oct 2019 04:09:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id n1sm21203796wrg.67.2019.10.06.04.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 04:09:44 -0700 (PDT)
Date:   Sun, 6 Oct 2019 12:09:43 +0100
From:   Matthias Maennich <maennich@google.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, jeyu@kernel.org,
        gregkh@linuxfoundation.org, yamada.masahiro@socionext.com,
        Markus.Elfring@web.de, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: add_namespace: Fix coccicheck failed
Message-ID: <20191006110943.GA172281@google.com>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <20191006044456.57608-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191006044456.57608-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing!

On Sun, Oct 06, 2019 at 12:44:56PM +0800, YueHaibing wrote:
>Now all scripts in scripts/coccinelle to be automatically called
>by coccicheck. However new adding add_namespace.cocci does not
>support report mode, which make coccicheck failed.
>This add "virtual report" to  make the coccicheck go ahead smoothly.
>
>Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
>Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for fixing this!

Acked-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>---
> scripts/coccinelle/misc/add_namespace.cocci | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
>index c832bb6445a8..99e93a6c2e24 100644
>--- a/scripts/coccinelle/misc/add_namespace.cocci
>+++ b/scripts/coccinelle/misc/add_namespace.cocci
>@@ -6,6 +6,8 @@
> /// add a missing namespace tag to a module source file.
> ///
>
>+virtual report
>+
> @has_ns_import@
> declarer name MODULE_IMPORT_NS;
> identifier virtual.ns;
>-- 
>2.20.1
>
>
