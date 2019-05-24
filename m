Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A949821850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFjCJYE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbfEXLlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:41:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34644 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391005AbfEXLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:41:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so6913260lfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJLDwVfH5VJnZx8ZM8GCRIzVJV8WcHMD+lvgI85Fwb8=;
        b=tFjCJYE4s1Z94dMb5aFsdWecVIC3UQ9ZA0iji4fhIgPiEbpjNkp6PM+YSIl/F0zg/8
         v067wNSAoldwvwxNc12hzdZ1o+Ue6PunKG5AFaw6SVX+axaqR+H6XYobKIQ2AOZfRVDT
         2MSu12IVDZlJVYeaEXVBJ6u0fHu/T+hQ38wwb9HMSr/yWO0eah4xbg1CG4Yx04vpm/Gl
         5waRRmDXldlktA4Axy7Gh6TMSlIUN0TR5TR6qQnFCE/iDu+Yu3IwGLAbBiOQYDTZkcO5
         7PFePDllYZl7eMyl9c9S364wV1ARtv7+Ho5BblphuAKfQYr1mTkL2OPyj3M5EdvOFQ9r
         bP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJLDwVfH5VJnZx8ZM8GCRIzVJV8WcHMD+lvgI85Fwb8=;
        b=tqXV88Aecg5gu2h6sdQOHYWLSY68TUqwdseiLmWWcg5NdPqRR0PEw/xyuwf6rkAJGP
         QZ7uNVE9fhbuOTPs1yogUlH8N53OQKdJQLnrf4gB+CvBkT0hamDGl40amwiSrg/COhfP
         coJEwXhkjYAB3w5zN6J391IOp/XpciiaNOFOL75FcH/3vM1DMGqWgLJV2PBxobcimPuf
         +Rs2W8kG7+FYTQBuwhJ1KCQsMjcg7GvDUMmZ4lmwmyfuk5o+yzVyc4bAnW8PcQvPFaQx
         JkNDkKWEiEFGIpXG2nAAnWLoMYP5eYpiSomoJwXYYqKzWvr0rs+k5yo4V4uy0vgOFwQ+
         N/oA==
X-Gm-Message-State: APjAAAWr4ZdDSRE3Fnz/MGLCQ2kdxS1Xwd+hYYMWDpOm2/r6kj9ERbe+
        X/Ip6sBYsJY66JWc8pLx04qeqq6Znq4eo0EebA+QAA==
X-Google-Smtp-Source: APXvYqwlCU/Ve7G0DQMfQWyCLtGMK3SgbEDDMWwyMwxIxCdMA7wUKKKX4Ntzrp8svUCapzuA04ATKczG2IaW15wIr9U=
X-Received: by 2002:ac2:5935:: with SMTP id v21mr9226943lfi.117.1558698082036;
 Fri, 24 May 2019 04:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <1557503126-3025-1-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1557503126-3025-1-git-send-email-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:41:09 +0200
Message-ID: <CACRpkdazPrbzL-oo6rhfgDcLftjCE1hrgPQCMvtE2TOUUnorVg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: Convert stm32 pinctrl bindings
 to json-schema
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 5:45 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> Convert the STM32 pinctrl binding to DT schema format using json-schema.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

What a feat. Well done!
Patch applied with Rob's Review tag.

Yours,
Linus Walleij
