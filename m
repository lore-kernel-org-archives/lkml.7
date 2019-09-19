Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D87EC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB9B2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568928354;
	bh=+qyZXoiyFRluOIHnPQhyY1XBnxGpWRGG19+3OTj9JZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b5VL7guRBqhojNU07JLjL7DT7SHRLuKI0ihdnTqNo2dki8hIZUSoPCpNCOg0vkzkp
	 KqISqwJqw4xMWSRaAJBLs0hiD166eyj5uNpTZjm1qDfvj8xP9Ts5RnGa1CLuvCDvIW
	 yHcwE6lQfcw4VOibHydiACSjVftwE6ogOfMkt+CM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390962AbfISVZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:25:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37131 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390868AbfISVZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:25:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so3454473lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFlQqPMwF2oKRoCy99o/0fcbEkaEzqDPgo54HkJjGwo=;
        b=QYGEBRfB218lq3Cke9eCjqIiN6Wf0j2td7002hFcAjOvsFYVECsjYFCUkApgWn3no8
         gEApY84ExYwT1UuZmVMX50F9llaHaFWKCUWUK9WH5z38tbwkYt1iwCfqojcLmUe2Dc24
         DkNvqa74UAADSQNKgmT2moNbWhaBqIMeGf5Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFlQqPMwF2oKRoCy99o/0fcbEkaEzqDPgo54HkJjGwo=;
        b=PikMZtsnl9xC58R3OmkECyfYjkQk3oRjoi0vuc5Ne+2FQM2IIc3CZDUzcl1IVlAoBQ
         yDgLwubed5eGrA4QEoyc75tulSjkiET2iV0/u9LbIF4Me9bnq+4LFKTAoNVpamS4aSQ8
         NuU89MnUpozXRIdDOnLNV5qEjeH+FgdEM0ameF3aEtirHutcUw9wIs8GOPz3Vh5FbMiF
         f5zTEkVJaoMQIQ2hW9akGOKwySA99Bu0bgry4FJFLaPNQ0K6tlw5cscfqEu70ZEUCJW2
         7IUWvsEiDkjF4rShR3wRAwJZMrxFYozWrhhT4Hced4o3Ic4bKZ6eMRu3faDNiYlvJrYb
         6Ijw==
X-Gm-Message-State: APjAAAUmomBJNoxZ9a/ZI/mz9BJbSPE2AwJWJXEqaiAzBC7UfrdFSpRG
        FiGXCfliYQ/zDTTiI/9FxQzHR4OG8V8=
X-Google-Smtp-Source: APXvYqwEyH9UgvJJKuYkQWKXNrgQqFw8vor4EajLIdedxRMxQQfoxUt3yD1IREgy+BGL434V5eCXJQ==
X-Received: by 2002:ac2:4853:: with SMTP id 19mr5906481lfy.69.1568928348258;
        Thu, 19 Sep 2019 14:25:48 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z14sm1441813ljz.10.2019.09.19.14.25.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 14:25:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a22so5102315ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:25:46 -0700 (PDT)
X-Received: by 2002:a2e:1208:: with SMTP id t8mr4478514lje.84.1568928346030;
 Thu, 19 Sep 2019 14:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdaHfhNjR-3GJOO-47rqopmO1SE9dLAU+AiCaWTuLje=8w@mail.gmail.com>
In-Reply-To: <CACRpkdaHfhNjR-3GJOO-47rqopmO1SE9dLAU+AiCaWTuLje=8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 14:25:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjP4YuM8myHkb20avZA8r=KCN3wLi2piWuPKBTH4T3vQ@mail.gmail.com>
Message-ID: <CAHk-=wjjP4YuM8myHkb20avZA8r=KCN3wLi2piWuPKBTH4T3vQ@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v5.4
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 2:08 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Alernatively you can wait for the m68k tree to come in first. Or we nudge Geert
> to send the changes ASAP. The usage of a wildly different pin
> controller on Atari hardware is only a compile testing artifact so
> we didn't drill deeper into this.

The m68k tree came in days ago, long before your pull request. It was
already merged on the first day of the merge window.

So no need to nudge Geert. We should be ok.

              Linus
