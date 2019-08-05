Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2954C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD4520679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPAg1QRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfHELe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:34:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34790 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHELe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:34:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so79018973ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gdt6jaSxfozMzDqzJt3/RN8BGk3uSUmYERQCMQQrEU=;
        b=dPAg1QRXa/qBwYjTW2z4itUlMq9B3ieWItaKFvalHRO1TfCDSlJ91SuT8R2pSHyHAJ
         1RvSa0wqG2s5zI2uw+rM+Vj7A3DF9EvYjl/WKqP3tjOAznfGjXCBjVw58oW3hyrxyi5m
         NkZUeZBhJ4131f28RWRamzpCgzckZKnRQCE4L59kU48F8wn0pTVLgq0pYTLEr6ETplM2
         gLVFiq1UPc4d+pL9jCwMk2COHXObYWW1To4exD6R6g7dfviWaEvjB8qynCLNB1qOK2vg
         21x71nOSW+nKSByp0EpSeO8bQlnJYr1dY++yqo2bxMnhbx1VzucWS5aqdpuwn3fUlYQ6
         Tmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gdt6jaSxfozMzDqzJt3/RN8BGk3uSUmYERQCMQQrEU=;
        b=WC8DiTSspaLTG8LTdKhP3ZMZ8UgOST6OtS+D/C9sB0eupOLjraRfxbs4BDBANbgeEV
         w6Il4BSRj6DJ2xwND7MWa36peRwZbQOGa5uHAyEFqCsO/zlyIAMy7lp//84VZtC1jO0c
         C+9fDxLYnTH91+Z5TaY7/VrpSonIQ89hh2hI0VxX8Yxtpp2lNVZDhNv4Gvoqg8nPORIX
         F1g7UPnUaGyKwcslyeEby0c7bQLvxRfaRq1LWZVex765mAJf8E6nKeAPPcLjPQhskK7R
         dDpv5N7onsz/LDmB+jjjo2iVdPdNMwqGHBtUJhyIxgGNp78coGUoYoyloIVPvHh4VkCv
         M0Jg==
X-Gm-Message-State: APjAAAX37HdkO4b0SHgsFXRi+qA2zLCPb7nuIU3syewY7sL1k28tcDek
        ryAP2UoldPnCoZVsO+MlPIpdypr4toVrp6IN0TRPxw==
X-Google-Smtp-Source: APXvYqy4d5dyA1aBlM4kQVXGe/WqL/1bnttB2gPsTGhKzYzfk98c7+dk2rkdM6qZpTA/hFAdpbiCmKgQcjPdNls67OE=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr9878940ljg.62.1565004864085;
 Mon, 05 Aug 2019 04:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190801100717.23333-1-rnayak@codeaurora.org>
In-Reply-To: <20190801100717.23333-1-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 13:34:12 +0200
Message-ID: <CACRpkdYLb-WWSEL8yG3yy8Qq7bOKP9JjUGV51mY6=aEwrQAJvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add SC7180 pinctrl binding
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jitendra Sharma <shajit@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 12:07 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> From: Jitendra Sharma <shajit@codeaurora.org>
>
> Add the binding for the TLMM pinctrl block found in the SC7180 platform
>
> Signed-off-by: Jitendra Sharma <shajit@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> [rnayak: Fix some copy-paste issues, sort and fix functions]
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Patch applied with Bjorn's ACK.

Yours,
Linus Walleij
