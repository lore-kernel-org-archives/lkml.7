Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67047C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3892073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyH5SEa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLJMUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:20:55 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37340 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfLJMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:20:54 -0500
Received: by mail-ua1-f66.google.com with SMTP id f9so6776444ual.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 04:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GXCkz0A083CnW2Auy3zOSjwo1M0I1o2oKHeSL9F3ck=;
        b=KyH5SEa3abXaiGToIC3ZdQDJPjQz7ehlNHa1ewyHS05ElloLcTSWUH0+HHxGSpmv35
         0zlWrNuW20o6rR7byo5kwkQGHdbqOsjtqAk71j96a9o1pdQ8ZalAOazL9CCburkIWQg3
         QHXevI2feYkETt3mDJ6WQBTmj6EZ2zjN/PiP6GJdTkujIbnhuW6Vce6LMqVPlCwGIfJt
         E8byyo1vnZ1FiSNFISAIBbopXvRnZtV3tsqzNmLNKEya3TQpuE8vYslVfw1+wssR+kLR
         KxGH+irE1aFPt39ROF9djLlen7lWYJ9nXFdNXFLZ3P2/XbWfdiiOcvpQVQe4QFLEAp4n
         WPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GXCkz0A083CnW2Auy3zOSjwo1M0I1o2oKHeSL9F3ck=;
        b=Vj3zA0rTI2HqSjy30RyH2q1+WOWJWw4LHXHAzjef6HcfV03D2mjyYGzud0FOoXR8J9
         GIkRBNYuJJFcgwXUJFRfTYQ5EX7hDQMjrx5sgJbf4CJWIWwkoI8Q4wCpCcAChiQkorj0
         1O+3MjR8YgPLPH7B1+gVAKwCiS5m2CsxoAMjTuTfxH/9t+VYtiijw+/fB/Hlj4P3Nc3p
         /Iqj0Xs58rsv2nhWj7ZCLQV9QRCQA+kBsMlPNBQ0ysdHEuq1OiKR61tFXKt/FBqKflvX
         mw9wpx4VBEJMBgP2/AT+g325mUY/OdH7Gg6cVBqJZgGLO6pKnsei8s5sVqhbvxm6RP2a
         RYbw==
X-Gm-Message-State: APjAAAWuJNALUmG3+m++E3Mp4WXG5HevGlsbtMxTQFf8ypw2lE0NPj7O
        c7l0Ja4645vC2StHfC94HxyVhQcf7v0yHMOV+VIsOg==
X-Google-Smtp-Source: APXvYqyXodp8MezisX2Ogin4ZbF5PMroS3cE2mukEBRUXULiSnp8AsW1NNU4k9XYdJLiuEsKDM0ea9YUPKV0ekMZ3NQ=
X-Received: by 2002:ab0:4ea6:: with SMTP id l38mr29080701uah.129.1575980453850;
 Tue, 10 Dec 2019 04:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20191113172514.19052-1-ludovic.Barre@st.com> <CAPDyKFooSJUn6UCE6QkFmJOCovm00ehz_nAPbiNQM3AcJT_bJQ@mail.gmail.com>
 <c8311933-d129-4618-b81b-aa627b7b6de0@st.com> <e80f76d3-0414-4f65-c2eb-4b09aaba3840@st.com>
In-Reply-To: <e80f76d3-0414-4f65-c2eb-4b09aaba3840@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 13:20:17 +0100
Message-ID: <CAPDyKFpkkqb3nr1wm7hjMqJCxH7QHArxSm_oWV=M55ga9+0FKw@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH 1/1] mmc: mmci: add threaded irq to abort
 DPSM of non-functional state
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ludovic,

On Thu, 28 Nov 2019 at 15:06, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> just a gentleman ping about this thread.
>
> small summarize:
> This patch return an IRQ_WAKE_THREAD only when the variant is
> busy_timeout capable and a datatimeout occurs on R1B request.
>
> So the threaded irq is called only to treat this specific error.
> Normally, there is no impact on HW flow control or for legacy variants.

Yes, this should work.

>
> In your previous message, you seem to suggest using threaded irq to
> manage HW flow control (pio mode). But Like you mention below, the mmci
> legacy could timing sensitive.
>
> For the moment, I prefer to use the threaded irq just to manage this
> error. If needed, the irq threade could be extended later.
>
> What do you think about that?

Yes, that's fine!

I have another minor comment on the code, though, but posting that separately.

[...]

Kind regards
Uffe
