Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E19FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE9207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNZqoQ2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfKHKg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:36:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfKHKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:36:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so5657638wmi.4;
        Fri, 08 Nov 2019 02:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEXF10pbCi/JcvJPKMBMyBQnQ1Lcl4D2c+JLZNuxiCw=;
        b=sNZqoQ2+uGWBWl+DRYbaEIpcLb25IAP7Ki9NsyghUtRK45xPt179v29LnF1z1XBaA5
         BHgtq7GtMbnyzx32HAKqjs8TBQjmLnSuQmF2xzcavoq55sJhFRZd/TH+MmdEK0CFy8vy
         bP/3PwVbqwnD6HygMSJXZCodVJ7HISVfZVVi2vtZ+OlyJTM7dbY7INyiBKIsPamNnmMU
         72w6BI79UTe6roi4VtX3s63fFqTTqBq/2WDzPKMxz/xMQXMPxV1TpnMlmwjNI+2HAvzp
         EkAfyUWz5e95ALSnlRBGwvwBQLEa68bZuok0dhGpcUInuOGuts14tu9dq4V4pSkPbnkM
         hw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEXF10pbCi/JcvJPKMBMyBQnQ1Lcl4D2c+JLZNuxiCw=;
        b=nr8Z24PYlSfi0DcALleM0JB9qHxmpGfzyA1WnArzxTCVduQ4Pbnx1SA0gDZUa+7DEl
         jjh6TA4j9X7i1VJfpTuZaubqdT7h66vAm4tyFJTfH9g13DIqk7h1luMieWW59Xev+FHc
         ua9XNaVqLHlZFtWDu8jfhO8h6g4DxvhN6Mk+ehG6A60eukJ2sCx7Rf97BoPSeJgdNUD9
         AGdmJGeAGywUfZNNj6Bwmhig6eJ7Dee4mfhwnqFyOCqx++LmzW9Mm3Vcd9vd9+whF/3a
         Fefm6qJvVH7GEmGSnUsoe78LRbFkrqSG6SAeB7r2eoYHNltaQe8A0KEDutA6ocWSjjKq
         Ctuw==
X-Gm-Message-State: APjAAAV7r+WO+OEvPJdVJyxBLaqTk3hstdO/PnBK2X69lR5iN/wmEdIO
        KhnHGEmT3mdu2G97uBg/FbN2ZM57/NVWB4zCR44=
X-Google-Smtp-Source: APXvYqzsGeI5MbddRtNTNzPUK53wJSBm/jWA4dTQNR21VUJUj6X5mukDJeWaZEPqd0MPzSFeqa/CCRkIUpSixPLluHk=
X-Received: by 2002:a1c:4456:: with SMTP id r83mr7248491wma.2.1573209414740;
 Fri, 08 Nov 2019 02:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
 <20191025102915.23677-2-chunyan.zhang@unisoc.com> <20191029214428.GA20706@bogus>
In-Reply-To: <20191029214428.GA20706@bogus>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 8 Nov 2019 18:36:18 +0800
Message-ID: <CAAfSe-uOj=uX16JK9PmDhSJma9reVsN=Rgvz-Vd27ogK_poh2w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: serial: Add a new compatible string for SC9863A
To:     Rob Herring <robh@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 05:44, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 25 Oct 2019 18:29:13 +0800, Chunyan Zhang wrote:
> >
> > SC9863A use the same serial device which SC9836 uses.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  Documentation/devicetree/bindings/serial/sprd-uart.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Should we convert this to yaml schema as well?

Thanks,
Chunyan
