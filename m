Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABFCC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809DB20856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYcNBvOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfHELT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:19:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42776 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHELT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:19:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id s19so57638621lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=If2p5MuMUgWrpA5iJZhIZ1wfyNa+k0/qK9QG1U50VmA=;
        b=zYcNBvOER7QkOzaZlD5YxYF00/Rtk5gIixj755hN9Pa8PENH1orP4d6NbSMAfr2E1e
         hkVLaoLERziQ0B2dtVD/yIOByDsXQRCoyRcNCggfpm/yT9tpDp26F8bPOcydeY4SVsf1
         EEKJgr8ObbogXKe/+9rzRscnPoZBPWF6HFHa+aiP9TmLLtYI2v8GxKvFDRK9BakbyZ6t
         8cCiNqBgiFT52eNbSCYYGuJLlxVpnKLhM5nQmIaoyylgsplUm9/1oGv9GF6G6VCL32y5
         JVtg8HCpgVrsBuxGQyw5WBG7x3WgEY/S7ZXh8BUd7KYzyc66AahKtyHL//L2ErYuDsHj
         rt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=If2p5MuMUgWrpA5iJZhIZ1wfyNa+k0/qK9QG1U50VmA=;
        b=mTJwzrkU4U4xOcXt8d7cYikT/4Ziey4L5tKmUhmgPJGyXb+espL/PehTFN5kOC2GuX
         wNaIDI8LKlkw3vqgfJw7+TQ6wu/LPchfHjgQc+8+jq1gWur7LCeRTxeQ7Z/HkiAm6v+t
         LFx9HN6eQ2d5N1SUhljgAWjIQAfXtf7BK/L8Cizl9sm9ZGgJP/d0a6rwQ0yuhuLEErS2
         JwoPleGjPyURt/0mYEAYQ8A4aDk3klxqk1mwlr4OPeeCwFumF/49/S19M9VkRAonuyqu
         Q+C3L+1i5nyB+woDFAQVWEVl+sc5pBtg5JTGwosHD2zLw9NDU3NtsRHX7kaTXIQW+RvW
         8NMA==
X-Gm-Message-State: APjAAAVZ2PhuLO1iLAAhOvt9069htj50iqc+09zRhjrOtVDJQohFoUjW
        OHn5gyM5narIDX28w56F4R2lUObGHskQZ2+TfjBP9LQY
X-Google-Smtp-Source: APXvYqxHgbLLB4QzzgK73ltagK7gUx7fz6MICytm9/FkLAF84pKeZp2qo9z7oTMZ3EQfBRWhVJIiLc0VENYNGP67YAg=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr1510773lfq.152.1565003964027;
 Mon, 05 Aug 2019 04:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <1564465410-9165-1-git-send-email-hayashi.kunihiko@socionext.com> <1564465410-9165-3-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1564465410-9165-3-git-send-email-hayashi.kunihiko@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 13:19:12 +0200
Message-ID: <CACRpkdaNFz_S0MV1SSr_yiC3gAAQ3vsT0KQY1BgJ1riyFhxrOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pinctrl: uniphier: Add another audio I/O pin-mux
 settings for LD20
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 7:43 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> This adds support for pinmux settings of aout1b group. This group includes
> audio I/O signals derived from xirq pins, and it is equivalent to "aout1"
> in functionality.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Patch applied with Masahiro's ACK.

Yours,
Linus Walleij
