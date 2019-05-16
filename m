Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7646520815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Joug+VR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEPMlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:41:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38758 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfEPMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:41:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id y19so2526471lfy.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 05:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1X4AgGfxt3hQwDE5huGGHXpI65Z8aUP5RYNXv/j5IHI=;
        b=Joug+VR6S7QUmRqv9ZAHEOFpjfAahMBKgIpazqWYWz6ynTF3C9MOTrTDxr0AB9h3De
         iN/iKELVs3GuPOTdJArPHJVlOeORKsGkyWa71jIYNL9AFu1jk32PTuRNVuAukyLMX30z
         XExeQ3qj4YaSZqA3BbmGqD++IFURL1NTCFTDL07M52r5Lo2514Ufhq2yOv1ldamRybKx
         GkBnXbIck4VxJAz9e3w0RRbL+pTQ8QVI3CSMBf14OImWWJ7UgtWDN+RIcfQ33td2BdCI
         HTJbqItsHImJJjaa3G0de13spI/i3uiePNnydMD0O5eDzH8UmFunSBNJw2RwauyrAmOI
         Er1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1X4AgGfxt3hQwDE5huGGHXpI65Z8aUP5RYNXv/j5IHI=;
        b=l3wAKJYA621dm4GB8Kjg+h8JFJL90msaX+PdZ4g/1eXx+adqxvOPxrhqY1K17zfwVv
         wheVszYmq8xUQXFLQOqG1brqaXu/GzRx/eSqGMT0ib424qbI13K8HAteQaaRySKiJmph
         Z3LwXdw1RR1H8pkACJD7uYJYtZXYq1EATMvObfYx3ymJwAYwIZUp5SgkIRUHfDlEanMv
         BLMKNFq2zG3t8OJfk/QyBLhIoj/NAU/HYDtaBRTon1vSo0f3v2I/aiZGA+e+lEuo6wLm
         u2rmjsoMWOPUnklurYizNMx2vA17jSLkVlWwc8Z4ROUShUwWbbY5PUnhZQtNFShfucWQ
         rFBQ==
X-Gm-Message-State: APjAAAWu8sEymyAYmXn9NcVJXpdeXKOINSDnmtvojqSj5LbbqlaIiLkv
        F0UVndQOuyHdC7ltwktniq3ylnvdR43XLuop1cTS4g==
X-Google-Smtp-Source: APXvYqwL0nOCeQ1S6udzXuh+ghhU4LjIum1XX4LqTvNH88uWDV+w/yIFM1p6yvSYTYxnOgbsBAEGbCkhSzweHbwigtE=
X-Received: by 2002:a19:cd82:: with SMTP id d124mr11996894lfg.8.1558010465952;
 Thu, 16 May 2019 05:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190430101230.21794-1-lokeshvutla@ti.com> <20190430101230.21794-7-lokeshvutla@ti.com>
In-Reply-To: <20190430101230.21794-7-lokeshvutla@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 14:40:54 +0200
Message-ID: <CACRpkdaEJ_2bmkgcbRW+zWm16+EV9-b77xFVZiBbu_=M2sTt5g@mail.gmail.com>
Subject: Re: [PATCH v8 06/14] genirq: Introduce irq_chip_{request,release}_resource_parent()
 apis
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:13 PM Lokesh Vutla <lokeshvutla@ti.com> wrote:

> Introduce irq_chip_{request,release}_resource_parent() apis so
> that these can be used in hierarchical irqchips.
>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
