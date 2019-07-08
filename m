Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762DFC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7372084A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfGHHg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:36:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45685 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfGHHg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:36:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so15162920otq.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 00:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNTUqnku8niNB9d4DJJdvCwiKFHyHplYOWjk0lkMatE=;
        b=lcZ+HZaRxTIJKVlrSBQgzLCdNHYSFBocb28tpu0E1H/Qvn1ANvRNDcuMBA7WGphdER
         bXxTuQzVRk9GYpibTZA5mCHwGAHtlhTSsmF5uP8iapUZ8cTR+kSWkF3jAAMwhHspmhs6
         arFmCKnlbWQhlkvrzxf1/UkO3cFdb0STGP3LWqmCJvSm4E/S53QiJ/4KvF2QOQnZ+w6J
         rQ5dcpuaL3Tpky1EIrPpzgKCRVWi27ZNCR1trzVQewUhuCNL204vUWvfJ8T3aXRk4u2N
         rBBo8zYFXthtJe+e0Nkt/fjAmsRuhg/sVJexIUON9t9fBHVTSWMEsCMCX2U6/uPXdzc4
         WQ/g==
X-Gm-Message-State: APjAAAXN4tWjRh2Rvt/7V9GGRhdxh358HKsKHnimyDUgVfwdTB1j9uAr
        eeU+EQbwkXa/hWKhn/kJW0eKKzyGGtBm5QDdX1Y=
X-Google-Smtp-Source: APXvYqyo472/t+mGYfo5uuK1/V8g77+ciL53SR+frag8PpzDGidAds1XBVfRWATv1RPYNwBNDg7KEsURk1Vs+HdAyVs=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr12692675otk.107.1562571416966;
 Mon, 08 Jul 2019 00:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn> <1562566745-7447-3-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1562566745-7447-3-git-send-email-wen.yang99@zte.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 09:36:45 +0200
Message-ID: <CAMuHMdVodmpcVXCESDxR3_oVK_5g2-9tW84YPP+eRh-0t_OBiQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: renesas-rza1: fix an use-after-free in rza1_irqc_probe()
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

On Mon, Jul 8, 2019 at 8:22 AM Wen Yang <wen.yang99@zte.com.cn> wrote:
> The gic_node is still being used in the rza1_irqc_parse_map() call
> after the of_node_put() call, which may result in use-after-free.

Thanks! This use was added in v3, but I forgot to move the of_node_put() call.

> Fixes: a644ccb819bc ("irqchip: Add Renesas RZ/A1 Interrupt Controller driver")

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
