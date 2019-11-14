Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D58CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99202071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olrwoquy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKNXnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:43:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37654 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKNXnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:43:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id d5so6493423otp.4;
        Thu, 14 Nov 2019 15:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8vG0IT0MDKAiIMq9HyAspnaej6ptXHEchDGTD4N3nc=;
        b=olrwoquy+e4zS381RYST+ZX9Fbm9n+26qGv2sUfDGn0bJw5DVJ3dWBcTEY4MnhxTNj
         Q0nZygHrTIxLOETPwY1lyHup9lkOkYcSvpWT2N6ySSryEIhYqWs8eNjfvjPP34Tjh6nS
         /Vk1VFiyCx/vRoboELKtgvyQih4OMJbBryyUrQUwqnlXkT2z9t+Dj7qRDs3jt/I9BtQ4
         ur9KmghKE+M2msESfmP4cDmXWEiR4JRLja2L2r7giNAS0d69d50rcKaew5EG6rmzgjm/
         YrTrSLeIDcV62cPR1udljnAp/MoUy14rr3crvXXVvHkLLM/1lC+djm6jrVukdR4T/vyb
         qPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8vG0IT0MDKAiIMq9HyAspnaej6ptXHEchDGTD4N3nc=;
        b=C+BD0iuJ1V3Rpz2X8IhQfUYp1t6QWtavyy9b0uB8jDNQMk2VgYOuoP4Khr/nu6Ogqk
         NpNXEKXV3mnPdQ8u3p4LP4K9lULaFKroGCn+dOfY4pNbQbMzlpEIAy2p8M43XNFx9PL/
         CHTB2mv5oeosRWV8npjkks5tbAi5KCa6lndzXjsmFqnCw4vTGqs03nX6xYPmIA0/gHEw
         2tdCnMp9TdqJVdOeCM6MrWBCTSPq9g2GxQgpA/zZiN/+Axq1NIdpF0z7cE+POjRcheb0
         y01LtN3AC7RLUsXlyq1IL5rkfI3bDVtLR3Lbi/b4Ctuwf4i7YpX9vCuRcylPkiEi03Aq
         8FzA==
X-Gm-Message-State: APjAAAV903nsNgn9M9tjEU/5QP/QvlLhS9nvg7F2eZU9J25rK+trn/tq
        7+6oYhRGJxx0tdo9XbmUVyBjhQ5gSSqLKAinc9k=
X-Google-Smtp-Source: APXvYqzsrqBPtoNNMhFQSNzHFp5kcSNIvmO4gkcFegzTLuVEJ443QEDwBXQ+CJT2/fLmI0qtRTSVwcOeLkLsC0hFXfo=
X-Received: by 2002:a9d:4712:: with SMTP id a18mr9867331otf.49.1573775019728;
 Thu, 14 Nov 2019 15:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20191114000900.26962-1-mihailescu2m@gmail.com> <20191114130643.GB3084@kozik-lap>
In-Reply-To: <20191114130643.GB3084@kozik-lap>
From:   Marian Mihailescu <mihailescu2m@gmail.com>
Date:   Fri, 15 Nov 2019 10:13:30 +1030
Message-ID: <CAM3PiRwfrFde-fv6_q2+KVCmasczsVus=ozk4B35g6GHdU9G2Q@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: dts: exynos5420: add mali dt node and enable mali
 on Odroid XU3/4
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 11:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Send the patches passing checkpatch and not introducing warnings (make
> dtbs W=1).
>
> Best regards,
> Krzysztof
>

checkpatch passes successfully, fixed compile warnings in v6, please try again.

-Marian
