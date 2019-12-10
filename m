Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA0C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1835E207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AuawT6Mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfLJRpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:45:10 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41775 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfLJRpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:45:09 -0500
Received: by mail-io1-f65.google.com with SMTP id z26so19708790iot.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s6PdFrRQnx7SzGv98D/hXCGEbh47W792wAg1h//fM4=;
        b=AuawT6Mj8mrvWP8b/48YgIEtZKfz2N00kND2g9zLXj126JqCyPKltrUJb+YGgldS9z
         8ZNm1rZez/YoUNrRd19EzaBSR7Hw5FAN832y4IXw5rZeuF2Wwx19ZXvjUeGJPIqjoyEX
         /4KbFy5Y58GNjX538KsJ3sKAqDiKZdTjWs1Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s6PdFrRQnx7SzGv98D/hXCGEbh47W792wAg1h//fM4=;
        b=Ibgtxk1FVNmF9gT+42005R2Ur34Dq74h3Q0XoBVXXCY7alkCRq6QNFADL7vjSBKGtn
         WwfRojQ9rDn7dfVj8ZoOt0uEcN0s65FWSPCUhoWSKxQAoPYCETuoPqi5M6Vji6quO6Jl
         XE8oJc3nnSR9QyDjxlZxFUvJBsYvZO2+cL5V0KEKn8rb/kWAZImX2fM5NZgM4FeOPLqo
         iocoXAWPjs57aeUvTFN9txgL8iYG+jAYuX29/uJ6OsbvHHkO1HhU7/luBdsrHND8hXEs
         DFAut0OuhBf2zMjNfileqSjIyFZNIC8DosRFRNQJc2CDs6Bu8ywGVJ1BqarOph6Abs9z
         yo0g==
X-Gm-Message-State: APjAAAUiYmwoFDQheYH7h1J87nh8h7wtgJikBu7jMctDVxhMwIg5DYkV
        RlYqbABlk+Pw5Ox0vPAI5vFMBI3/R84=
X-Google-Smtp-Source: APXvYqyeb+58ex/QouEDFhNs4ZszkcmpSCPEBe/V7eirWLDQyIYgPkyW/WKLEPG3O2C6Ph9dw6ioPw==
X-Received: by 2002:a05:6602:d7:: with SMTP id z23mr16471204ioe.146.1575999908781;
        Tue, 10 Dec 2019 09:45:08 -0800 (PST)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id r2sm1047741ila.42.2019.12.10.09.45.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 09:45:07 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id t17so16840860ilm.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:45:07 -0800 (PST)
X-Received: by 2002:a92:1547:: with SMTP id v68mr3619598ilk.58.1575999907357;
 Tue, 10 Dec 2019 09:45:07 -0800 (PST)
MIME-Version: 1.0
References: <0101016eef165cd0-26845355-ff75-416e-99a2-0c4434e18b76-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eef165cd0-26845355-ff75-416e-99a2-0c4434e18b76-000000@us-west-2.amazonses.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Dec 2019 09:44:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XAhSWOOPrHpuhjObi0UpKaeaD4TX1yhTh64cy39E1wyQ@mail.gmail.com>
Message-ID: <CAD=FV=XAhSWOOPrHpuhjObi0UpKaeaD4TX1yhTh64cy39E1wyQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sc7180: Add new qup functions
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

On Tue, Dec 10, 2019 at 1:14 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> on sc7180 we have cases where multiple functions from the same
> qup instance share the same pin. This is true for qup02/04/11 and qup13.
> Add new function names to distinguish which qup function to use.
>
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-sc7180.c | 60 +++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 20 deletions(-)

Two overall issues:

1. I think you also need to update the device tree bindings, so this
should be a 2-patch series.  Those list all possible values for
"function" so you need to update.

2. It would be nice if you mentioned in the commit message that this
will break i2c usage on these QUPs for anyone using old device tree
files.  That shouldn't be a problem (AKA no need to provide backward
compatibility) since I think the main sc7180.dtsi hasn't landed
anywhere yet, but if anyone pulled an early patch from the list it
would be good to give them a heads up in your commit message.


> @@ -976,8 +996,8 @@ static const struct msm_pingroup sc7180_groups[] = {
>         [3] = PINGROUP(3, SOUTH, qup01, sp_cmu, dbg_out, qdss_cti, _, _, _, _, _),
>         [4] = PINGROUP(4, NORTH, sdc1_tb, _, qdss_cti, _, _, _, _, _, _),
>         [5] = PINGROUP(5, NORTH, sdc2_tb, _, _, _, _, _, _, _, _),
> -       [6] = PINGROUP(6, NORTH, qup11, qup11, _, _, _, _, _, _, _),
> -       [7] = PINGROUP(7, NORTH, qup11, qup11, ddr_bist, _, _, _, _, _, _),
> +       [6] = PINGROUP(6, NORTH, qup11_i2c, qup11_uart, _, _, _, _, _, _, _),
> +       [7] = PINGROUP(7, NORTH, qup11_i2c, qup11_uart, ddr_bist, _, _, _, _, _, _),

You probably have a more complete document than I have.  ...but the
one I'm looking at shows that for pins 6/7 only i2c is available, not
UART.  Said another way: I see QUP1_L0[1] and QUP1_L1[1] on Func1 but
I don't see anything on Func2.  Of course, my document also doesn't
include "ddr_bist", so maybe it's just incomplete.

-Doug
