Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0FCC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084C72077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hu5TaOq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfDZVJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:09:03 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:45675 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfDZVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:09:02 -0400
Received: by mail-vs1-f43.google.com with SMTP id o10so2711008vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COrw1bk0xz0JtM1iGmB/AMEMxzoVtmBK77QoBTn2PBE=;
        b=Hu5TaOq7YTSWA9JJQ4CSPdXvqky54zGnhptPy4zb3BPj40FussNwNPExIO3Ikt7qLr
         rCByDDyM4nZi4O9/XlHsrSj3bmH9zC5O0rundk6LL62O/FLuJx0GfviMZnBz7eMZDk/J
         FZLlL2sh6uA3c5gbbk6J9u92lgp4/sxk2QJsHlwH+5YtvZfntNlJPCTTfgHm6VPoGEl/
         W7jSPcadTZmUFa+fuKwKUbIBlL0sy7fBSxXv4D3sTzWuu/vaM3yhE0YemCiLnt0wqXNF
         mzJslNm6ANWn3lLCWm7DWpdKpSMWs7FOGcMgixd/FysWFfPM15O/HsO2xHzKyImLX8pr
         xu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COrw1bk0xz0JtM1iGmB/AMEMxzoVtmBK77QoBTn2PBE=;
        b=NRq8irN+nUvRQKcvRDfClaKMClsvK/0hwlhV3t5eGUe4qclPtHRSfp02E26ZxzYJz6
         dlb8yf7sG3gk2nqCAMSZOCNt6YZd7Wfrccs3lLHqJR4DwHtv2gtS/RvUt7D0FUMLzCLH
         7xA/3cf4zq2B6YT6u9XXX9WYCWcK2yDKbTl5Jofynbu5nv2b0yEUHb1YHyHXEJcE4czY
         3NeXE+e+JY8dqLep8pO28vNRLKjn141w/pmX/GhvYjiuJKSZnkUkfRKH8foSeHONtOeK
         YRmHn6SpIqETIW4mf6oSGOE5H2SLwvhYpkFWdBFywBy5nwhUIpih/ITXhPrqS3MGqYhD
         rHZQ==
X-Gm-Message-State: APjAAAXy+/BvPvAb15Mu9OEaeT3R9aNvaH72DweY4/KhiXMVk7XFxbnF
        /6UOxumBwgLS66tIVHOcNWKHvQMeniee17E+nbAOmlEW
X-Google-Smtp-Source: APXvYqxAg4TVn/OI2tyqWlWEeQA0SG8NkN7TDXtFzUHlTW+13vTNpEZjMw5Y7Nq/LgNoglMFe7q5my9ZbGv77ZOezJ0=
X-Received: by 2002:a67:d098:: with SMTP id s24mr24866889vsi.95.1556312941189;
 Fri, 26 Apr 2019 14:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553088982.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553088982.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Sat, 27 Apr 2019 02:38:50 +0530
Message-ID: <CAHLCerMtsBUi_suDKVNgG29GWHFxWd16ZbbWZoop2Wb+7B44DQ@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] qcom: pms405: adc fixes
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 7:10 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> A couple of fixes to the adc node in PMS405 to get thermistors to work
> correctly.
>
> Amit Kucheria (2):
>   arm64: dts: qcom: pms405: calibrate the VADC correctly
>   arm64: dts: qcom: pms405: Rename adc outputs as per schematics
>
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Ping!
