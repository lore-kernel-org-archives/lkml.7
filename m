Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CB1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2423E2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRkPMjzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437592AbfITHrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:47:46 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39570 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437580AbfITHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:47:45 -0400
Received: by mail-ua1-f65.google.com with SMTP id b14so1929818uap.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxglbnyqNsy9IrMeX1phK/aGWuTchg+w3X2HNfK/9CM=;
        b=mRkPMjzvPBVfAeCHVbJTYmrEh8uq38ZKVM8E8AFU6NzBMCkin/nd1eIBhx73UcvIPj
         hZ9cLZl7VRnRHz0r9b+vw/tUY5l1L8pgCBGOVyccwzB3loxNIAfhw8f57iYt1IVFHmMG
         3ihqT7adb8ixIuRyXLY28hq5ZvJnUjZr99BB8J0MuUtrXiFlrJAhlWPEp5EDSLnkwd6j
         gjJUOVRjbfeyDNz7/rz7jmEHiaLot6qL149wtDhUGZaREGUjVZZCucZTaTlcf93XPL/+
         tkpHNvmoPXhsNOFXcMyryFbNn/lRqf4ubcSr7Nk6ZF/pyAtrNhtGObkvcyf+0/vSpDDJ
         xc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxglbnyqNsy9IrMeX1phK/aGWuTchg+w3X2HNfK/9CM=;
        b=HHrGiCcmSpOzIanZ9/b9KkIZ3zRBnc+LKexEsdlRMfehaZPghPjILwjGj2xqO0zups
         zLNmqutQoAdrMiLmrZ+fJ4zZ8dxAavozfmCPGKipOIt9TGbonVcyETuKpmiT2KmE116C
         Yvw18pABJMZTkmbmlTSBCsfZFqhqUanONePKS1wgLwTJXToznWgDlhTXEEFGs/oizMi7
         BUb0mcVYRUJhSkOIdQrAW6ucIHDbbtvTaJJy7SLX4aCO+V8oqVZ0aBwpXanH8WWs7qjq
         ILCN0+O4mum06IQkfaSAutfC9bdN4Rt47JVMxWigFv0MUPWxcfLBsZAnXiw5nxsuMGAY
         rj9w==
X-Gm-Message-State: APjAAAV0dKNarUwG/ZMfNIrV+8pUcoTVp5oiwn9bQSTGfxiT3kImw58b
        ehr8JbLWs2x8BkT0UInY9juLsCqP+PnFsHqJUy0GJg==
X-Google-Smtp-Source: APXvYqyIPD8otiC6oiySJICKUArdhKAFf1jxKg7NkboCvLV7vKR9MnpHuTM4AuE9NqL9JQuhAM9Efy4otC84oobLXJw=
X-Received: by 2002:ab0:1856:: with SMTP id j22mr8516177uag.19.1568965664676;
 Fri, 20 Sep 2019 00:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190905122112.29672-1-ludovic.Barre@st.com> <940e3ce8-1a4f-7e03-dfec-25330051ea5f@st.com>
In-Reply-To: <940e3ce8-1a4f-7e03-dfec-25330051ea5f@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Sep 2019 09:47:07 +0200
Message-ID: <CAPDyKFoha6q1CmhLXREz8OAzd4UiBDKpHo46J1PLGMkf8CStpg@mail.gmail.com>
Subject: Re: [PATCH V6 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 at 11:33, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Just a "gentleman ping" about this series and
> https://lkml.org/lkml/2019/9/4/747

Thanks for pinging, I will come to this as soon as I can. September
has been a busy month, being on the road most of the time.

Apologize for the delays!

[...]

Kind regards
Uffe
