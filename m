Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C52C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B546420863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mj2gaCth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCDJxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:53:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37351 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDJxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:53:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id a17so3750069ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 01:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dICar9YBcpsWCKchDqceP+SXt4tHv1K93+swn5v7MI=;
        b=Mj2gaCth9u/0NSdpa0zyBGnhWBEKXcwO3ub8KD1hOIc5NTlrfMyeEQ4cdG5Vs1CWfX
         MPeLLUjrLMJUCp2WY0s3eHzksbvMGznmqQNUnWXPLgktKz0udXizIa3ilJvgNrwWwkH1
         WpoUelYWJre8ap5TnfWP5DhKBm/e0aZ2bogVHwe9bXJdBqh35zVu6+xzm7efGqycSruk
         7LqMdzs4intOapBngfTckpSRv+YVSotgmFgtlcEcf3OmKogB5ulqb5Hs5J095upJfNMk
         iiM3QwQVkl7EkEu762a2ZdXr/9bVWs4PKUrrqc65sfAKCjnGLmBqZtk+SR2wrmJVOg31
         ZmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dICar9YBcpsWCKchDqceP+SXt4tHv1K93+swn5v7MI=;
        b=DtjQN+5eWULq+kqaLK/xmUmnwdqA9O2ZkwW0HAKaqDlMlwag7Tl7+i0ad/vYm7+lym
         QQFc/tB+Qeu70WkwDjiBCHeH6ybNX8lzgXq4FJpyoWldj8uKrqTuDq9gvteBAf23AhVe
         odtpw3zolU4J6/adhsjn8797UfRi6+GlD4kIpLuHsbWA2LNlj65cG1HgvznjRmpd3MGW
         hS7B9JRSh0Ob1nkYrJWpvczP7CbssWAcgejUhTRuMsHGrLXsLh4KMntkhHJ1qhIX/eJl
         HGl4j6MRDq9mXqaTM1LVpv+3TRvhyo+1iR54jfc7ZglW3wfOuppRIf1Qy1TtovHV3+t1
         y1jw==
X-Gm-Message-State: APjAAAUO3jArySnK3foBWB6Z25utosK04IGUGRv592dlPWqhouCHxBae
        XQ9b9NLnx2vlZaHrnZ8BAI6BNpytnWTAH0vbAbqmGQ==
X-Google-Smtp-Source: APXvYqw4FfLU86QI20UK5htdyLtrf3aZSIj6InfLN60UIgGD6s8lq/zshx8L2OOXrUT/GVMi1wxAbcYVB5EMocvj3kc=
X-Received: by 2002:a2e:9217:: with SMTP id k23mr116457ljg.159.1551693218721;
 Mon, 04 Mar 2019 01:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20190301035852.26780-1-marek.behun@nic.cz> <20190301035852.26780-6-marek.behun@nic.cz>
 <CACRpkdYpjjpVNUXRgT=XY758FGtDYow2fvwpah37T_GjTvLauQ@mail.gmail.com> <20190304001701.0b1b9986@nic.cz>
In-Reply-To: <20190304001701.0b1b9986@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Mar 2019 10:53:26 +0100
Message-ID: <CACRpkdYqRzRSdu+xhO2NAt7NYovvkxoE6SCJCq5_UqfD4bY-zg@mail.gmail.com>
Subject: Re: [PATCH v3 bus+gpio 5/5] dt-bindings: gpio: Document GPIOs via
 Moxtet bus
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 12:17 AM Marek Behun <marek.behun@nic.cz> wrote:

> do you know who is responsible for merging into drivers/bus?

Usually the ARM SoC maintainers arm@kernel.org merge drivers
there. You should just send them a pull request and explain the
situation I think. Else they know who should deal with it.

Yours,
Linus Walleij
