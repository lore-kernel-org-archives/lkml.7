Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0870C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2B121479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jF1jLJIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfFSH40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:56:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46644 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSH4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:56:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so2228918ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ay8I7XJ9iCOvh0M9Fd42oOlQR4wemxkRFmtvtAGMWPE=;
        b=jF1jLJIMjj62N1sJ/CeWes0b/z3GjaG3HiDI20T0YQdCmP6e6VUjjIPaoanpdpYeD1
         oyOKbIViVeufbYehdZ2oxsUTHxmoD6kPcKZdlyW3q04HpdT+ICakz5JZxME10w5v1MzS
         gN5AZJzt61T+WDruBbbUOnKO4p2HujxsPXsNvXZ1yp9K4IcCLdeZbMAPjAPw6aGLZJK6
         Sr2MG72KAG9m/k6x3Bo4KAQtefacuvQbWqWzAdbdFD/+rELTYjZh39PyHkcUwnAe8lYx
         pTCczbloa5W3cr9OIol0bg88q0wLkTYk5Lgb8qYs5jXnZcich6NWQs7/VmcJY8Ztna4z
         rOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ay8I7XJ9iCOvh0M9Fd42oOlQR4wemxkRFmtvtAGMWPE=;
        b=cAVaJLqFD2cdPP8TfXYR3SC8pacBMTb6X/ueJK25Di/5esl1FyYs+AXD3qD/ckBabb
         NwENbtYpWSVwUUvKWQ8eV4GqNZW/X7jE2RPMTZNK1WlQzTJGEt8wFemn0RLT/xQroB5r
         8N409fQKR2b6V/0qeN6SqOrD7O1sEVtUeA9JQ+yIEk3aiYp8eyScEopHv36tGWRR2mNn
         AyX/VMkQWya2ODndlforCkfLP9y1gds0q9sHgkzs89YpZ65YavxcY0S1+Y5/U3q/w7fl
         ZdbzfBIRBSLNYrggPg8qnak7yhRmrUPQTIPR2uvKt/0QFFQpiYgom6e64o6SlIzXbejD
         DAww==
X-Gm-Message-State: APjAAAUm7bWs0wb7LlQK7ixg4n3bM6YWGIcbECMH94os7zErLAWeuet6
        qZsm6xXDuSD/U3BRrm2pCJsAIuOAjpznZuZ37fmWRg==
X-Google-Smtp-Source: APXvYqwjfWxX+EG4Xqz7eu0QZY2s9wB/HAP4nhdPGeG9Hus7luuLwMAdoDJTs+YfuKobg/C2mU9tsnW1VzFiwiyNjrA=
X-Received: by 2002:a2e:9284:: with SMTP id d4mr66873430ljh.26.1560930983583;
 Wed, 19 Jun 2019 00:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190108143713.15120-1-anders.roxell@linaro.org> <20190110081615.GD5213@ulmo>
In-Reply-To: <20190110081615.GD5213@ulmo>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 19 Jun 2019 09:56:12 +0200
Message-ID: <CADYN=9LtpcJMbcUHN0Eg4bsYoX7f+xm_KiJ_3fE15-5k6mwC5g@mail.gmail.com>
Subject: Re: [PATCH] mailbox: tegra-hsp: mark PM functions as __maybe_unused
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     jassisinghbrar@gmail.com, jonathanh@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 09:16, Thierry Reding <thierry.reding@gmail.com> wro=
te:
>
> On Tue, Jan 08, 2019 at 03:37:13PM +0100, Anders Roxell wrote:
> > Without CONFIG_PM_SLEEP, we get annoying warnings about unused
> > functions:
> >
> > drivers/mailbox/tegra-hsp.c:782:12: warning: =E2=80=98tegra_hsp_resume=
=E2=80=99 defined but not used [-Wunused-function]
> >  static int tegra_hsp_resume(struct device *dev)
> >             ^~~~~~~~~~~~~~~~
> >
> > Mark them as __maybe_unused to shut up the warning and silently drop th=
e
> > functions without having to add ugly #ifdefs.
> >
> > Fixes: 9a63f0f40599 ("mailbox: tegra-hsp: Add suspend/resume support")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  drivers/mailbox/tegra-hsp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Acked-by: Thierry Reding <treding@nvidia.com>

Will this be picked up ?

Cheers,
Anders
