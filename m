Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD9C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1886F218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="m1ZfnGZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfGCAq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:46:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33302 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGCAqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:46:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id u15so612584oiv.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/LR59K4n2NpGvRZpSrMlExpZ6t8aHVL7QCUI5shco4=;
        b=m1ZfnGZP2wao1pfpBciR9QVwvmICdJ4yeAKJXaIVlcbimy7/OKpd3vAuPRVC6fvrAG
         Paaxs7nDaOQNrJgGk7bBlPbHF+/HooMpT2EWnQNFYZB94nf22g9mzCW3WBfffmhVou31
         C5ykE+MxpfB1QOBe1uGXl/YOyvVK745m30pJjkvik5NuAPVWzyOhLo8gnGGmZDOGW457
         Qby0QbhvCNuhSBup7IbkPzlH0CjTLxDJpqyVgkHVAZFxTRoULwm9DgYqR7HeN947HMWy
         qzlPlUb35ILttMlYn2dxCyVk3Cn++LxqAFBTfpYIBsBlU3bYd7fGzie/v87dWe474olr
         j3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/LR59K4n2NpGvRZpSrMlExpZ6t8aHVL7QCUI5shco4=;
        b=aZsr0hyn3ON5/jKfc4aDuA0pm2h6ZbiEzbmIcujieThPko35eS5zzBV93d3EiUtrPI
         /OVdWhVH+KLsdXEd/gheR++n+cdTYZcpUbJ3Q2r9rOQMLekXycZwdp9F39t9l7zlYG7x
         ju70R/iyRntmU0WJEBDI3jHCFeC3UQG226o8sThwuENWnCLKMr1DVWnpouH3/vsXMhsc
         9URmZ2HbtFCo4/lFNlK68Biwnc3kp6QCPYZONRR18hYRFGgbsjCG/SN2py7f9vGZKozy
         fl1L989wq82EMZCnr+Cd6iilSqG9tX9jfmL/Cvq3V3pB/USg+jHbjwPsGw65s63SfMvb
         7n0g==
X-Gm-Message-State: APjAAAXXWPItaCQ8B3bLR6y7l8PurQ6CNA/OK6+3PdP/phRVI55hoa6F
        3SXT+MEXFIHlrKDqbgxNT2J6hwAYqbUlSLVHIWaQj+mj
X-Google-Smtp-Source: APXvYqztWhmeaDg8T3K0pmGU/qZhQ+fCAj/s1HnyoXH6d4sZovOx7CJ19m/uyyQ3H8w+wL38c17urJw0X9Mw0cHLFag=
X-Received: by 2002:aca:4ad2:: with SMTP id x201mr4620515oia.129.1562109086426;
 Tue, 02 Jul 2019 16:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190701104705.18271-1-narmstrong@baylibre.com> <20190701104705.18271-2-narmstrong@baylibre.com>
In-Reply-To: <20190701104705.18271-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 01:11:15 +0200
Message-ID: <CAFBinCA5iZDanZ5f=y_J3PH-2bXOfKfjQDP9hiz1RSmKszMRPQ@mail.gmail.com>
Subject: Re: [RFC 01/11] soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 12:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the SoC IDs for the S905X3 Amlogic SM1 SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
