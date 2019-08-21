Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CA922D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kb9Iejc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfHULmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:42:51 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:41478 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHULmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:42:50 -0400
Received: by mail-vs1-f41.google.com with SMTP id m62so1071343vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGyJtTdRFEqrfXqlhHseje+wrcJeJ3BPrV0Pr+186RM=;
        b=Kb9Iejc3aTv5oxkmyGuITCztWfUGPcLp0qYQDkpvrCScPhVepU1Nhce3wbo0aSvO7G
         SBA2CAP1X6hkIlUWFziruhTlXHUWyZiTUnmK/joBDv+TYcVTneD/YQDvmExYkwEakKMX
         HJz9bAedHmmeGtmaTLK1HWjr7N0v3TgubaqJNTrdWl/mGk2f+wEaPmBe4akWDiUczsHT
         i/YUsONP8n7PshYjYtNL++MO0BSdUw5tYLJKPXgI4TPoAYQmRSeOdDd21uBrKc9zn+RE
         zwsNMooMNwA1LRkC6BB+jV/REk768CEh7DW2MGf2hNHc0fOltOEYuntnDac1BSZ8BSI2
         o8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGyJtTdRFEqrfXqlhHseje+wrcJeJ3BPrV0Pr+186RM=;
        b=USC/qCgqggq31jhMZCg/tHU8KFRUhXqwiwYeSPxIig7gMI99d3Rf9VH0JoPJOwalRC
         xzhplH890QaXF4COGTYzuRkfxDLTbROCAHy4NH+cuvfZ0Osa37rpNOKDE0k6qO6v5MmK
         g0JKnEwcIIa7wkctGStCz9BI8QYgbtVYZjO3HF16uZHB85kPHoj8iFT/vls8RJkCpC99
         FIhYxloYCr3VawgxRGAVXMjkm8HgBKkqUlpInk7zKckJSdwyMYAgxBduHzNGe/FjpM3w
         O+NDD54J9MMTSZLGrgfpX0wxcn6pCpYhHtEBx7p6cHYRqIDUMjGkFFH4h+a4QDASRCm1
         IEQA==
X-Gm-Message-State: APjAAAVnTbJtWubqb7nSeE+rLyTD1tjVIEeqgOTlxH0WCtnPfTNG2m5F
        oKlMEpnILn1Up8o9yC+hWzogz6IpS3Bef25xNfHIwA==
X-Google-Smtp-Source: APXvYqwukXTXyD7zal5XQi8m2++c8cKveD53MZ7qIhHK/oDyxwZA/K9VkjT3fOHYqV+UCsM6hwzGuAn8QAsEAdd2gsU=
X-Received: by 2002:a67:e287:: with SMTP id g7mr20330343vsf.200.1566387769610;
 Wed, 21 Aug 2019 04:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <1566252529-5074-1-git-send-email-shirley.her@bayhubtech.com> <3003d633-ac5a-be61-585b-02f96613c070@intel.com>
In-Reply-To: <3003d633-ac5a-be61-585b-02f96613c070@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Aug 2019 13:42:13 +0200
Message-ID: <CAPDyKFp9Sba96NO8O085BCZofqc3X_Z2prOsesrCdWRiS5NkJw@mail.gmail.com>
Subject: Re: Subject: [PATCH V7 1/3] mmc: sdhci-pci-o2micro: Change O2 Host
 PLL and DLL register name
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "max.huang@bayhbutech.com" <max.huang@bayhbutech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 at 13:21, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/08/19 1:08 AM, Shirley Her (SC) wrote:
> > Change O2 Host PLL and DLL register name
> >
> > Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
>
> Please do not prefix the subject by "Subject: "
> Please put a space after Signed-off-by:

Also, I recommend to run the checkpatch script (scripts/checkpatch.pl)
as it helps you to verify that each patch are formatted correctly.

[...]

Kind regards
Uffe
