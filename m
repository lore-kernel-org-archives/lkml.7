Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BD1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7728B20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTntqaoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfDXMjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:39:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33138 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDXMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:39:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id e5so14137685oii.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyXfa149xflFPUebzbBDNz6s0lUGYHuiRaKn3DL9Cs4=;
        b=VTntqaoByvKi4O60oIfPkpb91X5rmSYz9Q3BhXE8h28107pN+W8kpnWHQzAQvNjGGA
         dOaI53lntSNvaer6TNQoqeJ2F4Ndqc8MFoPtG2wlSgCudqwqV3IlAvpKqQX51IessjEv
         RUr9Sqsb6/x8EhdRucXIiWJkBWPL0NRKRkUn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyXfa149xflFPUebzbBDNz6s0lUGYHuiRaKn3DL9Cs4=;
        b=jUYpjVrxw93FPGCthtcFNOcH1DrErNiE3vDYV6t1AwYCXpmQ1FiCShvFsmeWPchmX4
         UZQeVmBxG9lemfI9QR+DPsfgxPZpawkMictdODQuD1OMO+2Enr0LY+nQcgIU82YehdJF
         PuhS3LVwmEB6PJhV93e5tqz11nNOu7qmkAwoQBPZ86cwBBmodlhm+lmZ993gfnY4f+B/
         DgcBXqdYepJY3m5+pwmLwy48kufYo9jF69ZnyorgEKJnLmYuq3EGl5l07kqGHQtc1bmc
         CW480J0qGOZxVykkkKoIJY9McigyvBC5+hjKZuT3Ki6koCDE0QPcEI2pitpx2ErXM5T+
         MhIQ==
X-Gm-Message-State: APjAAAVKtxFwkwOU1v9SoKVFqxDdWDJCqqbjiPLxwL5lbwD2l54Ay3I5
        ddl9PT3e1/q20gsKglvpFxn/qyEJDbQ=
X-Google-Smtp-Source: APXvYqxTFmBOqe5m3J5c+L6yQC0Uoo2dfz/lgP57a++/sptE1eGN+jTkqQIqTS0C00aovcfE17fUeg==
X-Received: by 2002:aca:4987:: with SMTP id w129mr5360246oia.33.1556109574444;
        Wed, 24 Apr 2019 05:39:34 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id t24sm7477789otk.16.2019.04.24.05.39.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:39:33 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id t20so6523649otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:39:33 -0700 (PDT)
X-Received: by 2002:a9d:6f90:: with SMTP id h16mr7097977otq.152.1556109572667;
 Wed, 24 Apr 2019 05:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org> <60b3efff-31c1-bc04-8af9-deebb8bc013a@xs4all.nl>
 <fe51ae1e-6d2e-36bd-485a-d85520ad2386@linaro.org>
In-Reply-To: <fe51ae1e-6d2e-36bd-485a-d85520ad2386@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 24 Apr 2019 21:39:21 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Co3G1J4+HOcjtCb7p3rhLcm+1E=mPr2d=AtdOSuF_eKg@mail.gmail.com>
Message-ID: <CAAFQd5Co3G1J4+HOcjtCb7p3rhLcm+1E=mPr2d=AtdOSuF_eKg@mail.gmail.com>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:15 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Hans,
>
> On 2/15/19 3:44 PM, Hans Verkuil wrote:
> > Hi Stanimir,
> >
> > I never paid much attention to this patch series since others were busy
> > discussing it and I had a lot of other things on my plate, but then I heard
> > that this patch made G_FMT blocking.
>
> OK, another option could be to block REQBUF(CAPTURE) until event from hw
> is received that the stream is parsed and the resolution is correctly
> set by application. Just to note that I'd think to this like a temporal
> solution until gstreamer implements v4l events.
>
> Is that looks good to you?

Hmm, I thought we concluded that gstreamer sets the width and height
in OUTPUT queue before querying the CAPTURE queue and so making the
driver calculate the CAPTURE format based on what's set on OUTPUT
would work fine. Did I miss something?

Best regards,
Tomasz
