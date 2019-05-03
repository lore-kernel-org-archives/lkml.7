Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DD4C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDAA2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jf69vmuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfECGtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:49:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41196 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfECGtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:49:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so4331277lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXAK1ulb/vcSgb2pd77d2EZm7UG82ynLQc1JZ6Vcu+0=;
        b=jf69vmuwzCyDeTyzrpNf6Eu0pW34zkJvMy75KCm+8TajY01Zlp0oDtIpQvBxmIsA+4
         4jFnJUSbERgFEavYDawKg4UaNQmbIsm9PzvhQ5rFt/EurU/g1PnaxRvdXlNEyFRL6ZqX
         bfISG1dH3xJ3Kb4mxx7kkfsp+i4zU5cVtLLzSHfYODSlOnhtW2Doqdpu8a9dyDlNWbEs
         Oqtaloi6J6dKJI+sJlUq2qqaFx5lAOLLkztcLcJ8Xdnk4Z8mhg6MJ5S6CgvJzVzfBBXy
         iHsv894tXVMk/1nCzj3Oc/2gWguy9xornWA/xr8yoIapR4k79dgX0J0OajT4d7e1xA8R
         E0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXAK1ulb/vcSgb2pd77d2EZm7UG82ynLQc1JZ6Vcu+0=;
        b=UesPgV8ASGyvWuQ7JG/FLIFXCsZ4zsx4bCiTAah4d73ZJPOciOEVbgHIsAa8JJtAXx
         gvhPiKO6b9pAvilYgVn3cUwlle5KTb+XfFoPAjtk+jvbY8E455PZfMfkaKxdANTyLHvR
         yrP6q3lGcpOx1U+FvFL59ReiN+LrAoLEvLBKb6vO3FPGJkJsyq+N5tDtKTLdJLtWzqeD
         UJ4QQJDrXGwVXEtl2euGGzIrgA7B7mPTuBhJddDpwj7nfHm2x69pil5aqoVFdjhOFOCM
         sK17WwLoCNps1BF/IjPohBGI7HkQBYO7uyDUSolZo3WFLigWD3GpEF7/aRhk0842L99K
         oSaw==
X-Gm-Message-State: APjAAAXYxPWYXZQRMxVCSMs/UBgD9qI0LJfDPDRiCNVDefPimrwK+ZIa
        M9SDyx0Gr6mamIySWP7Jjb+MOyl7CHi215ahEhEd7Q==
X-Google-Smtp-Source: APXvYqz08Q0LXJKUPd9rh/k89P1WML5/iS1DxcMbScMPKcbZEELiLJ/4k/1lYnAK2jfH2rxmZAFg3ZsnLAyoJGznflk=
X-Received: by 2002:a2e:3a17:: with SMTP id h23mr4472998lja.105.1556866185213;
 Thu, 02 May 2019 23:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190430092839.767e5bf8@canb.auug.org.au>
In-Reply-To: <20190430092839.767e5bf8@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 May 2019 07:49:33 +0100
Message-ID: <CACRpkdYBuBf7jA2nUitiZWRriXVTPWCyB93q2CzmP4tbVZXqHA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the arm-soc tree, today's linux-next build
> (x86_64 allmodconfig) produced this warning:
>
> drivers/clocksource/timer-ixp4xx.c:78:20: warning: 'ixp4xx_read_sched_clock' defined but not used [-Wunused-function]
>  static u64 notrace ixp4xx_read_sched_clock(void)
>                     ^~~~~~~~~~~~~~~~~~~~~~~

This is kind of normal for timer drivers, as the sched_clock() call is #ifdef:ed
for CONFIG_ARM, it is not uniformly available on all archs. This appears
as a side effect of COMPILE_TEST which I think is fair to produce
things like this.

Yours,
Linus Walleij
