Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82078C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB962171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfCMKLV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:11:21 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46719 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMKLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:11:21 -0400
Received: by mail-ua1-f65.google.com with SMTP id j8so441232uae.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 03:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w6c/sy5kIHwpmb/ad29lLtozgPvilF5ILnjRBOcqq6Y=;
        b=Y9QT/R4t87bBXxfGR2Adkm8ujh5ht9t1Ymc37fpebw37d6W7HlgMvV6dKwATiHD4mH
         V/AFgokA03dW6c7LAQQAn9ECgdQHIVextQhooZTUKEJttH7N0Ythu9bNjWBRcLpxXxgz
         nwclFJWdhNiQhvjs4g1H0YGbp72Up1Dr/hcp7vTjFJxOu7iSIaaoTgTlObU77fgOcVen
         qI2F9ww9w8JgXxXwr1352giNneCIP8MJcCIAIoDqcoLKBZpaXf5L/cGMJQQFSZf+NfpC
         m1qnTMRsy4dFcM3U/Q7kH+ZNCCHfVFOoluhBO8CjwOGtYp4Jna5cis6iDvHh6re6J4F+
         mNYg==
X-Gm-Message-State: APjAAAV0fb5AkVtl8L+0mwAzpI8gDWjI06km9hlFaeY8F+NjskIbWN3r
        ETZGx6XgGjjR3scTNKQ79MDuMNRssrQO4lBS5YBsERc7
X-Google-Smtp-Source: APXvYqy+m1IP0Ho9eLUXkPptS/YqM3STxxnLLblA9jCLirklhGwIb+3GwfCloEznB7o+WLSHFOhAMg8Y9gOwZr9a6QU=
X-Received: by 2002:ab0:7191:: with SMTP id l17mr21062310uao.28.1552471880343;
 Wed, 13 Mar 2019 03:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190312133047.16201-1-brgl@bgdev.pl> <56704758-ee74-0e9b-de1c-1dc94deda8d7@cambridgegreys.com>
 <CAMRc=MdRKvM8ug_KNcwUGHv9J6OLFa1o_WaCbebxWUGyGVZtiw@mail.gmail.com>
In-Reply-To: <CAMRc=MdRKvM8ug_KNcwUGHv9J6OLFa1o_WaCbebxWUGyGVZtiw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Mar 2019 11:11:08 +0100
Message-ID: <CAMuHMdXC5QffaOj479j3WCt5_GH2jeQnGrPoCrRPoFkHmFeDfw@mail.gmail.com>
Subject: Re: [PATCH] um: remove uses of variable length arrays
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Wed, Mar 13, 2019 at 10:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> śr., 13 mar 2019 o 10:45 Anton Ivanov
> <anton.ivanov@cambridgegreys.com> napisał(a):
> > PID can be more than 5 digits nowdays.
>
> Do we have a macro in the kernel that yields the minimum size of an
> array to fit a number? I can't find it. I vagely remember seeing
> something like this in systemd tree. If it doesn't exist in the kernel
> then maybe we should copy it over.

1 + const_ilog2(n) / log2(10) = 1 + const_ilog2(n) / 3.321928

Using fixed point calculations, that can be approximated as

    1 + 19728 * const_ilog2(n) >> 16
    1 + 77 * const_ilog2(n) >> 8

(the factors might be one off)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
