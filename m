Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F7DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F97A20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjkrzO7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfHLMvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:51:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38662 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHLMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:51:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so717239edo.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGrGeul0SC/umyrFN5VVINyiciJfk+nILd0h/dFFtd0=;
        b=hjkrzO7KDdoCyrll/AIT9a5zlI5P9yMGmS9KOUbaiSUwmlgmfohkjMgRW7iFmuY/kg
         BAMuoV3oCnAjCNuowFU2Rmfpp3s5/q2ULB4PJ3pSWu7IEdHfpMOrqEykRhLTjVBGsW0o
         C/jK7YNqSRTaUS0f4quizSP02RTiK22iytfYvD50kwHoCR73Glku+2qHChYVKIgXnjvu
         C37cV7Gg/FvbVp+ks/PuHAsecNMkmETXx9I0qD+C1gDLtbKeosoLRE2G7XCVDlhcJcsL
         X9EWwYehg5WFlZRmKtfihCcU3e2JNm6aav4YZcILrd7nDMRWrMpdv4Cn3wc3qwcpQDH9
         csvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGrGeul0SC/umyrFN5VVINyiciJfk+nILd0h/dFFtd0=;
        b=LI0bbW+e0y72p/ogpgHIjr1oEt+6KixsN350FhlnQIRxXeRT0sJqJqIF0zWCREdn1u
         2KM1pdfLu+ok5gv2jjMHsQBfoAmyW/O28sUP43Az62lUB1kYuZoAgcjWkaykKI2t6+om
         I9UP6YShP1jTGJK7nh8hbffuWFFU4fGbilveDMcTcllJfMMojefV09EAP+6aFEw1gEB+
         9opaPMK2mCB59D8wwozJBCmeoeDz8GMV3aa0YYwsfb3wfnP0w2tr26wGwZSu7fOHfsJZ
         uon/QkUy/dfaynxwDtbdQ53RPQH9/HAC4AMAaBn+7NKoZcEHuQCRNP5J+HJhk1mTWt7j
         IDfw==
X-Gm-Message-State: APjAAAUuisxfu/Tla92hEQnwhYE6hPOhwmFr+ml3O5Ya+KlPdlGhz8qd
        U/2h0GtkaJWoB15UMTteZIX/ymGPwSJjEid2W5fPqi4EBQA=
X-Google-Smtp-Source: APXvYqwT2NNHOrzwcYifunWugAjwGKFkuM7CQhD6a4PeKBA6EtZsLdqYIP9HnY07POUFb7wTuVYsSkeDd1p7dUW39PE=
X-Received: by 2002:a50:b66f:: with SMTP id c44mr36364139ede.171.1565614296251;
 Mon, 12 Aug 2019 05:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190809030352.8387-1-hslester96@gmail.com> <20190809151114.GD3963@sirena.co.uk>
 <CANhBUQ09+q9_=7nMs63w4KRLGOhW1=z-AnuwOzAnUrWRY6uC6A@mail.gmail.com> <20190812110719.GE4592@sirena.co.uk>
In-Reply-To: <20190812110719.GE4592@sirena.co.uk>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 12 Aug 2019 20:51:25 +0800
Message-ID: <CANhBUQ2XWAJBgfzbiiffaJ60wnoP__kDPHOF4d+Z_1b1HzSpPQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Add devres versions of regulator_enable/disable
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 7:07 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Aug 10, 2019 at 09:44:45AM +0800, Chuhong Yuan wrote:
> > On Fri, Aug 9, 2019 at 11:11 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > I'm not super keen on managed versions of these functions since they're
> > > very likely to cause reference counting issues between the probe/remove
> > > path and the suspend/resume path which aren't obvious from the code, I'm
> > > especially worried about double frees on release.
>
> > I find that 29 of 31 cases I found call regulator_disable() only when encounter
> > probe failure or in .remove.
> > So I think the devm versions of regulator_enable/disable() will not cause big
> > problems.
>
> There's way more drivers using regulators than that...
>

I wrote a new coccinelle script to detect all regulator_disable() in .remove,
101 drivers are found in total.
Within them, 25 drivers cannot benefit from devres version of regulator_enable()
since they have additional non-devm operations after
regulator_disable() in .remove.
Within the left 76 cases, 60 drivers (79%) only use
regulator_disable() when encounter
probe failure or in .remove.
The left 16 cases mostly use regulator_disable() in _suspend().
Furthermore, 3 cases of 76 are found to forget to disable regulator
when fail in probe.
So I think a devres version of regulator_enable/disable() has more
benefits than potential
risk.

> > I even found a driver to forget to disable regulator when encounter
> > probe failure,
> > which is drivers/iio/adc/ti-adc128s052.c.
> > And a devm version of regulator_enable() can prevent such mistakes.
>
> Yes, it's useful for that.
