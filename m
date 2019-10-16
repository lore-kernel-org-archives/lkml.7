Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C087FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454312067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnhcrGZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393775AbfJPOB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:01:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37050 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393765AbfJPOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:01:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id n17so16859452qtr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8D7GWcuR2D5yJzftWOZuP7OGBCEWQ2Nv8330rDKYmg=;
        b=dnhcrGZBhMNzuT4xbNGse9Hi6m6R2P2mJfVUllKARjVw5I1IW3bUBIJF21X9ghv2r/
         l5+mWeKlT4khiAo6ircZ+0ZuvkISZ8dApHcl1Q71Bx+w2BNGt5VmQQjXumuOa4zPGbmI
         wTcWoKyjSg/Sc6nU9+wu1fKFR8lMlNb/E6/rjfVkl2A5qICOPD1DKkWovrK+FfuS9x/L
         J87kjFpH9ZS7cTjHjxUh5sfXeA02Ie2+Z4eqov/c7Mn+uwfqn+H6uGCMrMLaw7fEQJJd
         9e9Rk/jBQmCMkwQsqV0QVgsn01zsABYHdS2AMEVh9jWyvGN2ligVIeAjdOnc05dELJYq
         1QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8D7GWcuR2D5yJzftWOZuP7OGBCEWQ2Nv8330rDKYmg=;
        b=dGAqMJB68OCawGcQryqCnZs2Fb25+97Orzew+09lnYjanNdvaVpg1+hpvS+MqZMdC4
         YxPReSW+kWB1kAge+n8M9/JRmxGPvLKlpZMmG9askWi92QmoRwvpV9sZ88xdPzEPgpLs
         wo96iIxeH2eDS9lOjcPZ/topwqCLPbZmInpEXixPhbY5W8WhjrxyRIHMREQS/cmypyh0
         x5bmt12pC4DJwd/0Wr4K4j/Q5DloyxisZWLkD44CCdXeZnUbFwvoplBw3+bpD241+m6P
         eRxkjtr4osawE4RnrEboruK0BC6wfz1cWZfc9enHpReMkxjWMUuk9ypCP1kiIUKwv4YN
         l0hg==
X-Gm-Message-State: APjAAAVeIhkTYyqf+iqyzFmrIXvCs0ueg37b+j7HhwsRk1F3MxWA7hpu
        7Q2YISaqSBtq0qjm3bFD92j9/TmBmv+Gk37k2igvMg==
X-Google-Smtp-Source: APXvYqwFAoVique9IlI8XVI03OPafdgTa5LZeWmuVfGHhzZH0lbDGYUovz4iroQEJzuT6Oha6I6BaIQz57cvrFNMpAk=
X-Received: by 2002:ac8:2a38:: with SMTP id k53mr13452139qtk.387.1571234517898;
 Wed, 16 Oct 2019 07:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <8ae52263b0625c416461821c457e6789b67170b6.1571228451.git.baolin.wang@linaro.org>
In-Reply-To: <8ae52263b0625c416461821c457e6789b67170b6.1571228451.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 16:01:46 +0200
Message-ID: <CACRpkdb6iGs=+EksqfTxuyiO3PBXpuVMOPhp3fFCJ8tqZ=-8gg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sprd: Add CM4 sleep mode support
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, bruce.chen@unisoc.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 2:24 PM Baolin Wang <baolin.wang@linaro.org> wrote:

> From: Bruce Chen <bruce.chen@unisoc.com>
>
> For the new Spreadtrum pin controller, it expands 6bits to describe the
> pin sleep mode with adding one CM4_SLEEP mode, which means the pin sleep
> related configuration will be loaded automatically by hardware when the
> CM4 system goes into deep sleep mode.
>
> Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied.

Yours,
Linus Walleij
