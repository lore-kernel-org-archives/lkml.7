Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E16DC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04FB2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOX+o7dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfFRLpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:45:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46671 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfFRLpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:45:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so12753238ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rf7AWCdhvsdlYX1vGjLsRXGhLZLWagUfJ8IC6/ih9w=;
        b=MOX+o7dc4nQUgrPXR6SRipHOnIbKnt2HYcx98CNXdoUAzFYWxUGdJl/ymQZ9NYJfDQ
         vK0hCpbN99vUYn3KKtcTG3n1TKJAOZCXpHZqGKPkgIUW56guOXNso6T9zbOB41sDRzss
         tjg5jghf/SW2jj1/7XwnC2j/bOfOnwmmB1ur5Vf3gb7u6fTeZyMD8D253oDxFioawO9S
         wPckepNRqm8LrMIZtu769hBpiuNYjvEi3x+8nIyLtRgrMrXpZ7DcgX1n5KU6ps7U6Rxd
         YOTGk3mXkdVYJetD23pE6UwfBo72YqI3Dae/v4aC3yLOCOTAWUJFGUd2nhqPEwI8DXA+
         dqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rf7AWCdhvsdlYX1vGjLsRXGhLZLWagUfJ8IC6/ih9w=;
        b=WDWs+EQ4D86dOsuB5WDB7ItbigVLWe2hnvU+OWRS4omUSgvVowV7vkWFI4YvoRyEqf
         ebgQLZ3KUmIozVrOa2pfhPdTpoBiWPUXHYEQuR+WkgeJsW2ZLdaPUj9NL+XIvRpC43wO
         2xrp8kpvGSklz3JUUbkxvcNx0oLNpfAMF5EuQSipmxKGCOwZQfbfp142SrlZ4cSqUsTB
         sXswGVWnS/aA3PzLNGJ+3Rmb8YZtM0Q0zhQA7x4EJV9whj2uen5ne1k3rCIXiPxGJf2B
         Bjw3zYwAIobAbBolCxW/YLuHgik2UfIKu8dHvuJXdC1gcvzPORvvsNpT3yLelzHgvqVd
         3h1A==
X-Gm-Message-State: APjAAAXeNkN5ANhyCoSjGkwb5lT+B3YSvWCCvBp4nQNmEVCuWh4GyNEs
        s75euEh4vrdTApBhP32F0KqhDIhZJXoeY1P9y0IyvQ==
X-Google-Smtp-Source: APXvYqxAK85u3378CbhOlOqgXBCoow4rwfeShnZdq8Wf/4Fq6yXWqFZNGGIR47IzFf/o7qxQ6z9tbWZ4onX27LCn+ss=
X-Received: by 2002:a2e:650a:: with SMTP id z10mr22560572ljb.28.1560858348452;
 Tue, 18 Jun 2019 04:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190613015532.19685-1-yamada.masahiro@socionext.com> <20190613015532.19685-2-yamada.masahiro@socionext.com>
In-Reply-To: <20190613015532.19685-2-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Jun 2019 13:45:36 +0200
Message-ID: <CACRpkdaHrKh3Ai1FyiJd0cZU=48R5XnfJ_oVdJWGQ4bQsWQgxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: make pinconf.h self-contained
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 3:55 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> This header uses 'bool', but it does not include any header by itself.
>
> So, it could cause unknown type name error, depending on the header
> include order, although probably <linux/types.h> has been included by
> someone else.
>
> Include <linux/types.h> to make it self-contained.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
