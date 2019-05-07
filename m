Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D8C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DC0205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jznAwWaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfEGRhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:37:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44188 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEGRhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:37:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id y25so5943259oih.11;
        Tue, 07 May 2019 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7rFP5HCgHx8H7Ab1m4RlZcKeQpsRgTbpXa86ApVmL4=;
        b=jznAwWaz1+h6XkFSKPJ8JUuHKDtojrwc1VIMQUkbeOnuLfA04Bh4drUJSQVjwTRLLK
         tpRN+k80EUcAFYURp8kW6oIR6A7W/dABaQ+vHCvB+PBXmOXDBhK4TtRl1bmNrxWvB/kQ
         tsfPhOzDtvNjrgONOygJhsfxDqEQe/D02brPS/tPrvZhd/A0IhuZWBSo2NWyBjk05XGU
         NzDxQUu9u67atekXYBHBMIK24wDmPrRaiI9jj8ftvAEcOsSmg8vhcWkWr/stardW5fVp
         Vdus8drJXa3uTlzkuSzGRWOW0+JRuUUS1Q6mRqMeHN56P0g2dZX9+XlNjy34VwmGcZYG
         NyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7rFP5HCgHx8H7Ab1m4RlZcKeQpsRgTbpXa86ApVmL4=;
        b=rHp5riBXEMfbr8707j+M8QZtsRdDbracgqD9NV8N+3ER+fAfrJjQROsV1kIAU8iFcu
         4yyZk246rPC0lPvmqyQ2kk6m0A30oEYsbk4dIpgCHuUjaimLtClxl9ozB1JqX+UI5dzZ
         PfbZwaYBTgfRULkBfT2thoOh9NjxFXEvaeCbuuwu6LuUD9Uidt9Z2BtjpRKilbwsAiFT
         0NOAtfnsf585+0eenQr2N0L7Ta29jMYdlWfqqf5PubYByFfYVzK4DJB6EIz0TfBlCR+h
         U9l9m31oPRpBKVth5BfRuKMcas0fMazXlvkvpwqJCq4SYZYuDxqGFCUXOmhgeC81PANM
         oxbg==
X-Gm-Message-State: APjAAAUK1r8qQCSem+10FdoRsyhMGz9AoIAF1kt/VO4MR5w9THcV1+1j
        Yj7ssJqgGMhKKTaGqXfx8TGUA+wYSNvsLRViPXs=
X-Google-Smtp-Source: APXvYqzovDy0Mb8VNCrV2ND+CU4kL4rfD7/PRqoAPGA9ilH4XNAxUQq05LTuTGAWxinmXAUUJyzTdAUM2/wiGQGZAE0=
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr910881oif.140.1557250633841;
 Tue, 07 May 2019 10:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190507115726.23714-1-glaroque@baylibre.com> <20190507115726.23714-2-glaroque@baylibre.com>
In-Reply-To: <20190507115726.23714-2-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 7 May 2019 19:37:02 +0200
Message-ID: <CAFBinCDXrr9gCsAu_H0LQec-k25YA3vo7zf4n5Nbzh=QKoKizA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: pinctrl: add a 'drive-strength-microamp'
 property
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 1:57 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> This property allow drive-strength parameter in uA instead of mA.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
