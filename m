Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209CEC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FC820409
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muIVQgmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfLKSAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:00:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37128 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbfLKSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:00:14 -0500
Received: by mail-io1-f68.google.com with SMTP id k24so23601271ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zw8ToasYb8/laTLFqP1g55dqKVSS0xO4pMqGOs5Lio4=;
        b=muIVQgmKlRQQMPU+Jeeyvy8/9sXC3w7NT5fymLadIwje9b9OnbN5ClDxwE8279dvoE
         spwJu8EmwWQkXCJk50n4AhPIlogG3r7l4JpwoizFRBnCNls6ZL5nRadADjzSUVUQtYOF
         hLfTNe36v0MhAjt+3HNQ9L3QJiSHydvtf2gF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zw8ToasYb8/laTLFqP1g55dqKVSS0xO4pMqGOs5Lio4=;
        b=ejlC66AP4vGHeKiQ04ALDOKt4n6cumdylLtJQme0RSBZ9aK9qbn8KaXKCls7JUrk3o
         WYhqVuUyswEXi+WhkmiFrAvBGZPzQbG9asJgQE082bAucr6gO1ZkHK+t4TmIL8h5Q7SJ
         wFVPAfg1k8o/FmplnN7belXWMUt9gyUFrAFRnzIFJpBMthf1QvZkvYd2BSHf1Ky14w5g
         PPqEcX9hxsY9KYyDd75MNJr8qJAu2+47GwfGMYnmkjSZPjW+KYZ/Yr+hQcER5NKxbVg1
         UqZANXe3jVnq4bALVnYVzaaCuR4Qc49jgQF/7V0irayuNSy29gf13/1TUiPbjmtbXMPO
         2vQA==
X-Gm-Message-State: APjAAAX4j9+b3NiVHqcwyH2xRbqlJYhjXz08FmOI+2Xv109GGfjw/P4y
        plZRD3sQXLvunxn8cJB/LPipjGlwaOs=
X-Google-Smtp-Source: APXvYqw7XK1dZhW64uhglCUCe1+4O+7qjRFRn0YXoahvQfkAGDsMvuFPmiTvo10dfacvcPnD3of1nw==
X-Received: by 2002:a05:6602:cb:: with SMTP id z11mr3551891ioe.53.1576087213654;
        Wed, 11 Dec 2019 10:00:13 -0800 (PST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id r10sm668667iot.28.2019.12.11.10.00.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:00:12 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id i11so23553779ioi.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:00:12 -0800 (PST)
X-Received: by 2002:a02:711d:: with SMTP id n29mr4090645jac.114.1576087212191;
 Wed, 11 Dec 2019 10:00:12 -0800 (PST)
MIME-Version: 1.0
References: <0101016ef36a5bbc-82d31857-9d9b-454d-82e4-fed407e17443-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016ef36a5bbc-82d31857-9d9b-454d-82e4-fed407e17443-000000@us-west-2.amazonses.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Dec 2019 10:00:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WQN4okN8HVrVbwoFA+thagm1w6HkD6WRp_HOenCOBgcw@mail.gmail.com>
Message-ID: <CAD=FV=WQN4okN8HVrVbwoFA+thagm1w6HkD6WRp_HOenCOBgcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add new qup functions
 for sc7180
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     LinusW <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 10, 2019 at 9:24 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Add new qup functions for qup02/04/11 and qup13 wherein multiple
> functions (for i2c and uart) share the same pin. This allows users
> to identify which specific qup function for the instance one needs
> to use for the pin.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
