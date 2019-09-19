Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E5CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83C421907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Zw96cAcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfISBos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:44:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40572 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387626AbfISBos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:44:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id y144so1622563qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkMdRwP7dRIQntiL1DI00+cj3iNG/NEsiFgJ+PEO0gw=;
        b=Zw96cAcTE35uIKpBFAL0KSlDTqm4ScDPL9alYcLDS9Yf31Du08TU0vNhHURemYdcNO
         WOR53PoEvW6D4qCckjtUXvNzBZjuBkzv1aX7U9cbUNy03Z5ikhlBo2lNC/aq+xEbI/59
         eaIPkRgctTX/RVDoYCg9+XXiwnjLwZWrUntRrXgDnqA84Qxs5H45d5ZdDpntIV3debwA
         Yi7rxtrMCRUi9yEAxsXAF76t6P1TelPu96uB+UUnyF10SY9/fjYlueLgI9vnl/0D2azL
         bBFgmy/zlcPuMeeNWvztNnnnSsxuBwqMDaXJ0yuqvTz6ZV8TZzMqqAhNFQvG3cqI3Kou
         b82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkMdRwP7dRIQntiL1DI00+cj3iNG/NEsiFgJ+PEO0gw=;
        b=o9H9GiaCRrm/6O4w46nKjiQ8sAqQL37K/7rJOrPjaZru5PMUTIQdKKM3NSKHru+GnG
         KjivY8jD0raFpZLrASfauVShtC6DV4ZzI+1EMdI35kiw+Np1tIXRbhuucwmaGPAtjTW+
         KLFW4SJS28ZYyuf/2eYxZqSR8HB7oYP31RFtFRXIAywKJfYfUhNxDrMoa05sBoCI9q87
         2qe/d4nPXBXx0rQZRJKcVArCvlp81PHWrdPeP1lnr0Y4DTy4xYgL3Fudj4O4msK21vZt
         ppyPYzmnaRLcO58IlD701Vu4K/esqXO8lmFo8lpgTwbHRzZKwtlag6fAug3IbT0yFat7
         vIBA==
X-Gm-Message-State: APjAAAXJZCWZ3Vs7c7ZUZtDhZENcSdU4rR1OkCzwkoZC9g0j0IfKnB9L
        SCQE+Ch07ZSj7zG6UqsvQkPUH2E1BS54KGFKv2a6xg==
X-Google-Smtp-Source: APXvYqw3xhDJsC4KO6DBCGEOvw+KkzJfCRl9QjdJwDEkRsdKxsqZl3tYPpV1cMRJHB+rn+bVsMMar0AqTbD5Bnon6EM=
X-Received: by 2002:a37:b16:: with SMTP id 22mr498473qkl.220.1568857485567;
 Wed, 18 Sep 2019 18:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190911025045.20918-1-chiu@endlessm.com>
In-Reply-To: <20190911025045.20918-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 19 Sep 2019 09:44:34 +0800
Message-ID: <CAB4CAwcs4zn4Sg0AkFnSUE-tbkdrHE=3yYeF8g+-ak5NyPBkuQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: add bluetooth co-existence support for
 single antenna
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 10:50 AM Chris Chiu <chiu@endlessm.com> wrote:
>
>
> Notes:
>   v2:
>    - Add helper functions to replace bunch of tdma settings
>    - Reformat some lines to meet kernel coding style
>
>

Gentle ping. Any suggestions would be appreciated. Thanks.

Chris
