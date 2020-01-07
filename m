Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE9CC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E93207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4W09e6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgAGLzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:55:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33020 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgAGLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:55:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so46392672lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 03:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srVCYWN5C5Eufk05htqMAJUHJORyKr0Vlz9Det0daS4=;
        b=x4W09e6W3tYzPFUA5L3cocu4C28m1vu8wvfPIVtcJZVrttySIpPpOBOxScCKjuNNRn
         OyhMcUwnM45j1nxRiN5G0bCuRyxa4OO8QJEjgJm87+mAfYD5ZXWyADDY2k/7fKinA+yq
         x46qgZYWT1cXuXTxyoTLqtgueith2idAaQl0QpKpm9DWWQXeyE7d7v7jS/oNr2UiSKNN
         m6C7X0ok2d1rKs8X7I64wx/UnFvv/rjXO0HEkKEWuEkCZIwA3EBJDQUcZWPjo67sFJae
         VO0hAUkUiwdg8Mxsg7FFAMxrzsisTkn3tAyhmQKML6FQVwKQY2O4oh24yPneCrUoCJYv
         UMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srVCYWN5C5Eufk05htqMAJUHJORyKr0Vlz9Det0daS4=;
        b=Foaa8IVu08Fd+tOy7A1METksMP6+EP4XDBWtHTRe2vPm3siO+clmeX5grE1dA+BfVA
         /O9TbAILllZ8NtchzxU8BYR0hq4yNNxTi3DrxUwQs0+C3wXJyFM+DDZANcwfnBp8ypRo
         jkDnEMll4fPS7MJhnhJmkTLk7KasLexUos0OquQTKAQzlaZpSFfPuHW1zZI1VkxYYJ2R
         6Z0HV2kwSMj+8WM42Jtu+XpLQ5w8WoWLTqsInOWBXsvSpba0FgHaWh6L15aKKiKj77jz
         HuusPqoVGfbZmUULogsqSwtB3z9WtZ3On5FAE+AsF9/a0rW1YjubSgXlVjHFMZmqqkw7
         qcOA==
X-Gm-Message-State: APjAAAURcaAsgUOLXQgoyf/xVbdfUbWCwt2DsIac/Djh+ehZ/+NNumtg
        rDaEc8G+6tnMm3CSh0sDtipOaMTuLCKjV2wrp96DXA==
X-Google-Smtp-Source: APXvYqzkyD6g7/9CDAlHtA5mKWWnMz52PVnTB6MFjhAOLT8GCecy17Mok8VzpbjzK10JRhbJp55ZQJQKlRcjb1WeUVc=
X-Received: by 2002:a2e:9587:: with SMTP id w7mr60523035ljh.42.1578398130000;
 Tue, 07 Jan 2020 03:55:30 -0800 (PST)
MIME-Version: 1.0
References: <1578052177-6778-1-git-send-email-sricharan@codeaurora.org> <1578052177-6778-2-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1578052177-6778-2-git-send-email-sricharan@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 12:55:19 +0100
Message-ID: <CACRpkdbjjzwdEgsDV2tGea0t3AMM_FRSd-Um3+2BrYDTGKoNxw@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: pinctrl: qcom: Add ipq6018 pinctrl bindings
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, sivaprak@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 12:49 PM Sricharan R <sricharan@codeaurora.org> wrote:

> Add device tree binding Documentation details for ipq6018
> pinctrl driver.
>
> Co-developed-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Signed-off-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Co-developed-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  [v3] Fixed the example dt node, inherited properties

Once you are done with patches 1 & 2, can I merge these
separately to the pinctrl tree?

Yours,
Linus Walleij
