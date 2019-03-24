Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708CAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC952147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd9EbLt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfCXRXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:23:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36117 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXRXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:23:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so6668545wml.1;
        Sun, 24 Mar 2019 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VNt7l5+VWi0XRfJBxBlcdQKQzBExlbpk0rX49ypfAus=;
        b=rd9EbLt82zVGU1yaxLJgWzcLRzT62RSCIqZXCeyd4cBflJ7RKVwrALTuephAZ1dHPT
         Bs/R0eb50ocesOFcRE1xXyrBMdVeRblkxLBJUHrB32J8YfVDf03+cFaYDtdFNljVKRM8
         UTzb3uXAMo2YeS0/u8ay3InvdlY1RYNP1588JMoD4e3odqGMC17rn7hcRNDXlfylExVw
         Qiuw+D9XGaRgL6rWnzUT1wLjvq4x9UB9XPP+iEnxg9NPzVDytxEUBrXCmHnbkt/cL7Pm
         n4iUiIjmMwMQP87ZAwaVBevsbJ+oSVM6Rzw0CDfG3IY+FhZdRtmPWgqyatnblWE1I901
         BrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VNt7l5+VWi0XRfJBxBlcdQKQzBExlbpk0rX49ypfAus=;
        b=akVV8d6/tIXb6b8dmfY1GYlhf5vPrucHVHLlXmDRiZvCDnRJo5Hx9CPi7cdGXp18wL
         V/6aQZoPIwyUKEMVo8CwkvbrirtgLxg6CHTfc+8YtaaESDJplRnk92siKvTomnr0Iwfp
         LVvFHL0OGOFVR8hgKgzxw+Y47HVoEfR5KnD0j2fq0DIbdwtRVu9ZrgqWCaOu7dOPG4p2
         RodcXSKEAyO2iFekhEMRg/1RM/3qHY2kPtI/D9i6wUPyFKypifZqeQZ1SMiVkEUbZ0cC
         EYuRL854rMd/fdOKvdJ9quKcGj40P1VqVI73myMzzWJLXbYpaxZ25SA2TNQEHkMpuUCp
         zvLQ==
X-Gm-Message-State: APjAAAW1oxoO40Yr6SuCfqUtGw0ARoW6eF8SWvskmxmFAuOml5Qas02m
        jSYQigfdRyKrFcdUTfuM2krtLUKcnKU=
X-Google-Smtp-Source: APXvYqwh9FT830lWLt8Ubr2nPBrAg9+4WJOx1OB8Pqaq+hbGLZkyP8MfFpNVtYarBnZr0jz+fVRJLQ==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr2900117wmh.127.1553448189358;
        Sun, 24 Mar 2019 10:23:09 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id k15sm9690641wmj.8.2019.03.24.10.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:23:08 -0700 (PDT)
Date:   Sun, 24 Mar 2019 18:23:06 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] staging: iio: adc: Code refactoring and bool to
 bitfield change
Message-ID: <cover.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553366098.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some source refactoring, parameters alignment and camel case clearing.

Replacement of bool to bitfield in a struct, but not found
the population to check if it is done correctly.

Cristian Sicilia (5):
  staging: iio: adc: ad7280a: Tab alignment
  staging: iio: adc: ad7192: Converted bool to bitfield format
  staging: iio: adc: ad7280a: Avoid precedence issues in macro
  staging: iio: adc: ad7280a: Adding temp var to improve readability
  staging: iio: adc: ad7280a: Remove CamelCase notation

 drivers/staging/iio/adc/ad7192.h  |  14 ++---
 drivers/staging/iio/adc/ad7280a.c | 109 ++++++++++++++++++--------------------
 2 files changed, 59 insertions(+), 64 deletions(-)

-- 
2.7.4

