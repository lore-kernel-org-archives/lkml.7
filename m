Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29A4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E67C2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="rwFdPy8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgAIQTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:19:03 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:35930 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgAIQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:19:03 -0500
Received: by mail-qk1-f177.google.com with SMTP id a203so6504283qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:date:message-id:subject:to;
        bh=d88Xq53MKTDEJhK31IGTSeb6nL+720DGGuqob3OXfa0=;
        b=rwFdPy8zJV4rDrzUrwoPihzrxRWL7XDmnNQCU13Evd8P428xLWbB0UgvxHcq2BJqY3
         YbBbyQPLxRfmJGz+MMr10dlPkhL6KjBEZrFaYA7R7ZFC7IfUfETQwL2h4rUcF4zEdUlj
         la/rkaKJqCSfxyRTKFV3YB8ZXwbEUgeIBpJEOeoJANe+C8lJE7c/jznxB5bn7evGqJJM
         UfZqc8Y1CsOIQAFM7wl5hYnqpscgaqkaamRsrOIpuAxyQU20x5geSNeLEZHXftaWYeFL
         7RYDenLf2lsm9oJMxdfMul82aUBQm8VNgaBo3k6oPk/LR09QV7XrzolQl9klQ4lqkiTn
         Tc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to;
        bh=d88Xq53MKTDEJhK31IGTSeb6nL+720DGGuqob3OXfa0=;
        b=uEmYknCWvKFdjVaWB9dULeAyhPtkhjFfJGPYojH0PeoA7hKkJAFJbYw96VfjnmcqWf
         jmuMU/hsB8o+T4JN1ar2TCqwGN8PZlxTyrjIg9nexQ4yrBFwmJZgDnjGh7cgFVoLZBdF
         5H16ItJSRdfm8qg1o/RHjylxec6iVWYtKu+cW8T4dODdA3JcLirLOZKuR5uDotOmAAiV
         OmDiA39ocy/6bnBQ1tbQLi+KJF3bHnbckBLfynDaYrqu2PNyC3O3gd9uSedTG+gjEsmA
         /BBpnefxiKoZHr4M3uVhj3E1oIKSVxU+PQggr4SvplJxjPz1kaeIDwjVJ8nNtXyXG7zS
         2IRQ==
X-Gm-Message-State: APjAAAXifB/ub8mJhVbkBaMdE8ucrYQBGb/7nW63m6DQYM4NoOsBI9H3
        mgBeHsEOzLWoHAD2xJvQDReu56ld8a9H1w==
X-Google-Smtp-Source: APXvYqzY0QqnYHRnYMP4cGRYSbA/2KvYtSJlsbAI3OKFEVU5zpZtf4rrOSOB+zbNVeZ//Fu2wheJ6Q==
X-Received: by 2002:a05:620a:1001:: with SMTP id z1mr9174643qkj.99.1578586742112;
        Thu, 09 Jan 2020 08:19:02 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id h1sm3645079qte.42.2020.01.09.08.19.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 08:19:01 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-qt1-f170.google.com with SMTP id v25so4480856qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:19:01 -0800 (PST)
X-Received: by 2002:ac8:3510:: with SMTP id y16mr8837483qtb.6.1578586740862;
 Thu, 09 Jan 2020 08:19:00 -0800 (PST)
MIME-Version: 1.0
Date:   Thu, 9 Jan 2020 13:18:48 -0300
X-Gmail-Original-Message-ID: <CAP9ODKo8UPbU+JR45T2rjJH3FefcWw=tS71EmjFzVyPMA_R7gg@mail.gmail.com>
Message-ID: <CAP9ODKo8UPbU+JR45T2rjJH3FefcWw=tS71EmjFzVyPMA_R7gg@mail.gmail.com>
Subject: RV1108G run-time detection
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We would like to know if there is a way to distinguish between RV1108
and RV1108G versions in run-time.

The reason we are asking is because arch/arm/boot/dts/rv1108.dtsi
defines the following operational points: 408, 600, 816, 1008 MHz, but
the RV1108G version does not support 1GHz and its maximum operating
frequency is 800MHz (not 816 MHz).

In the i.MX SoCs we can read a fuse that indicates the "speed grading"
of the chip and decide which operating points could be used for that
particular version.

Is there such a mechanism in RV1108? Any suggestions to limiting the
RV1108G operational point at 800MHz?

Thanks

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
