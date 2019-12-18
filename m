Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE74C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD3C24672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cCfmWZGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLRSjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:39:45 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38157 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfLRSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:39:44 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so2565392ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 10:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qS07QetcqHopZvL0SAF8T87/ibXNrIwvAxwHVFARh9I=;
        b=cCfmWZGu+EkTY9HHCwEPsf8m9ckAewsbfv+DdyQ2mndIWHOIm5cPWNW6KA2eDILRbS
         Yp1/dohvrHxPAl+V3lkzpybQo/+zHsShotOBU5xVZT9n5tFDQQe3LfkSfaeEXTa1iav5
         Tw1T5zvpDld+JYMpSOSO8g4Wf2BGB/9CUvAas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qS07QetcqHopZvL0SAF8T87/ibXNrIwvAxwHVFARh9I=;
        b=q+ouHY2pRECuq4fMYDpDGTgCXOjpgH38gRzgKijTdO9BmKurmIT7QmYHS29jBoGI6k
         shBFpxBAPrbiPiR6yJaMdvNlXXtPU2vzj6oIBNg2y//fRW2Flu5t9jhDGbg8d4eYpigt
         EFi2FwF1Cq+P6XBOKWve/S3qYtKMgglicp401lIVMfiun6hq5T60/8dORk22FVjm2YEP
         rPLVsjuexOuGzctrc9b6/sImC9WbkAUg9PxOlLcEBQh/v2HoBWNk3xQY14RAbvF9hV8Z
         Qsf477TumSDYqH3jtjLWf185jdMCC8L8n3R61789XbfHfspj/bzata/prxz4mKxO848+
         qdNQ==
X-Gm-Message-State: APjAAAV1pU9un09b91ynQ8xXp27W1b3J0m9PvdVIi7Jws66eh7YOeAOq
        vi77HDyg9WavDJC+7OJjjmtc5ayofqw=
X-Google-Smtp-Source: APXvYqyaQxC712nvm4xBtAJCCl2Dq65sspJPdVCVViMylFuNeXkdOESybL1KSEyo1RWCQE/UmnLiYQ==
X-Received: by 2002:a05:6e02:4c2:: with SMTP id f2mr3117334ils.126.1576694383193;
        Wed, 18 Dec 2019 10:39:43 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id l83sm921715ild.34.2019.12.18.10.39.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 10:39:42 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id f5so2565312ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 10:39:42 -0800 (PST)
X-Received: by 2002:a92:cc90:: with SMTP id x16mr3278373ilo.269.1576694382002;
 Wed, 18 Dec 2019 10:39:42 -0800 (PST)
MIME-Version: 1.0
References: <1576474742-23409-1-git-send-email-sanm@codeaurora.org>
 <1576474742-23409-2-git-send-email-sanm@codeaurora.org> <5df7c855.1c69fb81.44dfc.29c1@mx.google.com>
 <CAD=FV=XA7g87vu_sNhn=z1cfe51c9cUT8MHUHi3PYC7bosb5PA@mail.gmail.com> <e901331b-456c-f3ed-6717-e5bf24778c57@codeaurora.org>
In-Reply-To: <e901331b-456c-f3ed-6717-e5bf24778c57@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 18 Dec 2019 10:39:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xg9UTt2xjerkSKiSKSZ3tP2Drqf36Mu5eFiSxmsgj6kw@mail.gmail.com>
Message-ID: <CAD=FV=Xg9UTt2xjerkSKiSKSZ3tP2Drqf36Mu5eFiSxmsgj6kw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings
To:     "Sandeep Maheswaram (Temp)" <sanm@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 18, 2019 at 4:48 AM Sandeep Maheswaram (Temp)
<sanm@codeaurora.org> wrote:
>
> +  "#address-cells":
> +    enum: [ 1, 2 ]
> +
> +  "#size-cells":
> +    enum: [ 1, 2 ]
>
> Hm... ok. Interesting.
>
> Use of enum seems to match 'timer/arm,arch_timer_mmio.yaml'.  ...and
> sub-device probably uses DMA so IIUC it's important to pass
> #size-cells of 2 down to it if the parent had it.
>
> Should i mention this as below?
>
>  "#address-cells":
>     const: 2
>
>   "#size-cells":
>     const: 2

No, keep it like you have unless Rob disagrees.  If the parent is only
32-bits it should be fine to keep it.
