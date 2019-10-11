Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FE6ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2024921835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570818952;
	bh=A5YOLiudlL0Gvx464VUE58c30d6rI4J9IqV4RnnkINE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vEDu0wu3GBOVKNzBdXumUmhCNJF8X677cYO6afIm4nb4wxIQDMaCe0TPga3XB3+fx
	 YoeqMVQvfYmlB081BeU5EqRfiVg+4j+SEdKGVSHmIO8PybARBvZwxCpxnYah9xu/Ng
	 L6uVfqfYI63Hb7N4kIyGIkle9AIvU+6FO+P6mkuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfJKSfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbfJKSfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:35:50 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC426218AC;
        Fri, 11 Oct 2019 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570818950;
        bh=A5YOLiudlL0Gvx464VUE58c30d6rI4J9IqV4RnnkINE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j2Jx140EfZQIJRX0dYyL3J6GOIkXmJ368acn55TvtSBODydawj8Y0KD0mlX9UzyTK
         7ffpydWRR1A5SxdNtOZTgttoO9TXOQzK8iGZHBDpF+Y9kEwnkG7coNzNpYE99dsd+E
         RIGMEiT/MBcLwi6f/XX4XzYcYyotPgnNrmas27OY=
Received: by mail-qk1-f173.google.com with SMTP id q203so9807912qke.1;
        Fri, 11 Oct 2019 11:35:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUrfCAlabxgKopE+9YmCzHYZwIH/hrHPCjekdWvQfr1aCcqEDN7
        2IujGkfFQ3LS9qXWiwUcLEE9ZhpgRdzu2vvfVA==
X-Google-Smtp-Source: APXvYqwlcinnHLXWLenq8pR6e91BSf9cbUBSFPZzD4ss00JlOJSDW7Rcbsj1Vl/qGAwEzfHWNc9WXzuxsF5qr3W+Uc0=
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr16942465qkl.393.1570818949084;
 Fri, 11 Oct 2019 11:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191002152253.16393-1-benjamin.gaignard@st.com>
In-Reply-To: <20191002152253.16393-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Oct 2019 13:35:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKcvPNAL69WRgFbbRmLLyVpeCOarcnMY=wJR-hgVD06GA@mail.gmail.com>
Message-ID: <CAL_JsqKcvPNAL69WRgFbbRmLLyVpeCOarcnMY=wJR-hgVD06GA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: Convert stm32 timer bindings to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 10:23 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Convert the STM32 timer binding to DT schema format using json-schema
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/timer/st,stm32-timer.txt   | 22 -----------
>  .../devicetree/bindings/timer/st,stm32-timer.yaml  | 46 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.yaml

Same comments on other conversions apply here.
