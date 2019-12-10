Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77902073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bvvbWxH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfLJUlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:41:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39854 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfLJUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:41:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so16767736oty.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6hdh3Yasu69i9dWWMioWcRGOBc9Yi+2xpwtcGer3X8=;
        b=bvvbWxH6cM1+GBdK66ZeOEclRZ+hs5dAr5g57Qtv+PidTPCCFpmLBzNDOyubU/tZtU
         pMp1R/p4kq7XXYVPTyouGb6uKLph86sAvsJhS2blwcY45LMVyF7NXREAUwiYDsa+MLLI
         fCgSGUolyjBRMO3sT67pWEcsU/LctDd/qNv1rLmIAiR+G3JRDPb8yi1XjOMIrN1V0eFK
         CQ9zSthXI/LYvo8KxfQR2zq14AbEJ96UR0MdbuEVrWQtxtgvVaPfX4EKMTBfQDvXOAzi
         1OArGY1aso91OqOqVrquwLr2p3nr+mXp1Hz0J6rOtgBR937RVdzBLhRfq1LGQv+PoRG6
         tbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6hdh3Yasu69i9dWWMioWcRGOBc9Yi+2xpwtcGer3X8=;
        b=j2BOj5YVFDBjAd9A2EIoCSKAtXFJimJPm5wp64H+nZpEFt0RncHOBsepQVHxitd/Iy
         ZHZxztjeaP1t54H8vwCbdMOwW6j/WENSxTLoAaucce2PZ0PtA13tICPh+4q3/vQqh/j/
         yrrlmnOoKtFDXGxt+Dp0VVpyYo03sMi2OG6pEvPD8y/Fm+4BHFWLbDdap1ewwjh31B17
         OShRJZFmoksiw/H15zG7NICh5mdhcWXBIybW2JzmkNoHnU1DBvgWuxc7xH/YaPy2yn+z
         RzY4H7w0Jmp0zR9o7LibYSiAJES2Z8qfwLWcjruBKpaEPYVN+4QcGCDqQaNJcpBPB3yD
         kKAA==
X-Gm-Message-State: APjAAAWNWWUYwWMKc/Tz6VkTsZyp0ioCcwPrfvRyYDV/Uv8UkwMQXl3N
        UaBZxmf5qVCd/keI7Z2TDSFAeIjPobsTLaaLDZg=
X-Google-Smtp-Source: APXvYqz0tm1N8+ubqYR/OOBcKGeaKmNmUTLZ3Lsf+UNuSurmjY+qD+u50hP0NL/44rNmRakKxqujcYRZann1YBKO4IM=
X-Received: by 2002:a9d:588d:: with SMTP id x13mr26062357otg.6.1576010494766;
 Tue, 10 Dec 2019 12:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20191210203149.7115-1-tiny.windzz@gmail.com> <20191210203149.7115-4-tiny.windzz@gmail.com>
In-Reply-To: <20191210203149.7115-4-tiny.windzz@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 10 Dec 2019 21:41:23 +0100
Message-ID: <CAFBinCDOoe2-mYVf_eD6BAcFyc7GvHH_Sk8te_QKeWON8QUWpg@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvmem: meson-mx-efuse: convert to devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        srinivas.kandagatla@linaro.org, vz@mleia.com, khilman@baylibre.com,
        mripard@kernel.org, wens@csie.org,
        andriy.shevchenko@linux.intel.com, mchehab+samsung@kernel.org,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        bgolaszewski@baylibre.com, tglx@linutronix.de,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 9:33 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for taking care of this!


Martin
