Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE917CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BDE21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYkvSCff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfKDPEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:04:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35339 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:04:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id r7so9306795ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKf43Xtd1wEHNciZoBlwFOJ82a1QwEum0MNhO8xHxVU=;
        b=gYkvSCffYZJYwTaXZaDFIUqPk5ipBdl+XNhc/jsUSWqBPohl+dBdezLtdddkCLi0Q8
         AvwAFjZhKC1VLxRvNBbptKhKNAVavvPtMwppnk0QI+Blez2n25Z+c/Q6zTUKyNugN8ET
         kv/TqNeC2PtzHIJihbw8M8j675n8j1VIIL0Cs6ZrprNkWZntmUSHUhcFnb1A1O7DKcZn
         xyjf6eULq4FBeqaMEcu4kUVYfqDf+MZLp0kkmy30Au2zIlv86uv9CbgWRnTqaX9s8Z23
         0ZJqK/MWG988Lvu7mWZnKldNwoTswgpH1txIxNtvTYAEOJenrM18U0Y6+q6/TabMtw0B
         Vtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKf43Xtd1wEHNciZoBlwFOJ82a1QwEum0MNhO8xHxVU=;
        b=Rj0/XxckqqGhZZ6pWBGFUL0PUIuwqjT8eHzFIv4UV9qAoEX+Jn+bJYIHVgCr+uR8qR
         9Nk0sT+xx9PnQZuL9032v2SmjnOM9h0sxfdpjSrEnub+demq/WCB8/IPcnE/AAy+RazT
         ZmDYuZFboeFH/VpkD4ACLayV4G1/ea441pxwAJRa4fM/trtRbYWd2c/gS3ygIzwbZmA/
         msT7qO8GjHI6lrbQ4LEKq+kE9aaiXCLVzUcOxlmnkjceYnNg5573y5xw8Gz6WBF3e+q/
         L5le0Xk/yv+hXk/OpLMylCWnpJLe2AvIowZpONfk15TACC/XlgNT4iksV6hxUt8iFWfb
         esUw==
X-Gm-Message-State: APjAAAW0yAT50k4hHoE7HsPTxuM9O03dNsSLH77RQEqDph+YUXEcesjc
        1+mBfyDU7j25WTI2uzSihS1SwIm0HSv11KBgcZogRw==
X-Google-Smtp-Source: APXvYqxy6M2YfqlgiosgMtrEMRGPVh5BipMF3g7VDZcsoZie0Iue5hC6m1+U1vgt2pyXgw8xrRe/9wm4ygBXT7/F2Pk=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr18696588ljj.233.1572879880204;
 Mon, 04 Nov 2019 07:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20191021141507.24066-1-rnayak@codeaurora.org>
In-Reply-To: <20191021141507.24066-1-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:04:28 +0100
Message-ID: <CACRpkdYFZ3V87kWFaMdMf6vGdr-=dR4=0GiRAQyY-=2uEwNLyA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sc7180: Add missing tile info in SDC_QDSD_PINGROUP/UFS_RESET
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 4:15 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> The SDC_QDSD_PINGROUP/UFS_RESET macros are missing the .tile info needed to
> calculate the right register offsets. Adding them here and also
> adjusting the offsets accordingly.
>
> Fixes: f2ae04c45b1a ("pinctrl: qcom: Add SC7180 pinctrl driver")
>
> Reported-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Patch applied with Bjorn's review tag!

Yours,
Linus Walleij
