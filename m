Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A6CC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC6208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSZE9Ui6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDHJLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:11:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42548 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfDHJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:11:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id v24so5913290lfe.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knCIHqOSCy6Gb+ywFDrlCvuMwcxt5qtF6l4vOq1t5FM=;
        b=NSZE9Ui6b3Iis22/fDtn8JCFkt4fBk7BO4y1lPBqyKNzp3gEXZ2Layh0NnpOvKt5Kn
         jDpWJORhLPR9nX3BHOSQlIKnW1yywDOAnArTMYUOvdAjSMvtZVVkA6XZVdKgsksGOuuO
         4t3uN2YkpA/jzW0Bj2VWdgAWukq/h6iy6TxUHzQaZJcqvVl1/4yD9KmcwKSqYteTipq8
         t4wc/Icon/8OmTTMvag+UVz3hgU/MbgQRwQQuSkpI/kchXKOpuRGEwdLYb2rH8Q+87/A
         D2zcsiAuGg4e+Z33JbPu8hWnac6O8GIchQj5P0McK4P2zjOXOnt8GScAAsczfpOhIL9+
         s6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knCIHqOSCy6Gb+ywFDrlCvuMwcxt5qtF6l4vOq1t5FM=;
        b=mJwluVm35ElTVLipyck32qHgIg2cMZmINvp3RAYwVt6JVNt7uXFzeM6MUYi/hEBr76
         W8F//b2xAC/1GDAtCErGln37ldNS+r5CL9mj7oaTpx+t3v/U2et1/SskvaQ+0Nykv0uY
         ZEU0cIGiA6ptqGBK+IxX/nDS5FcZi3cmsqaDKN1D8clki3T1om3mhE0OiJ8vU1pmcFs1
         5DQuXHz24dC2C4X9fln/MNOMKLFs68oxQBYtk3iJag1+o/oT1jgfkZV92W/6a64wel0U
         tu95GOaPgfIDD1KnFUtrf0oKSiWADK3gCZe3tLBh1wANm3Y4J1v3FtPa2GBj7AHRzyV2
         j+pA==
X-Gm-Message-State: APjAAAXInXyKdWqVscjZN6n4/32mKyalZ+jHLysAqE+UCr1sG/LKg8TN
        skQ625ZnqRk7IMzWOzPJC5DOnh3xZWU6GoLki+1i6A==
X-Google-Smtp-Source: APXvYqwHHGeAwRwclgpMfaJogjd5gYYg5mzN5HDkwUqbIVTNaZ3YTjnpv6mtNxCPH+oQIr8RvGCizl6HMDmERJT9IzU=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr3887892lfn.121.1554714657992;
 Mon, 08 Apr 2019 02:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 11:10:46 +0200
Message-ID: <CACRpkdbGhTjFffm7Co6YEBRm5CfTdOTTHFsxH32Ybcp+P-F=rg@mail.gmail.com>
Subject: Re: [PATCH 1/4] rtc: coh901331: set range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 11:10 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The COH 901 331 is a 32bit seconds counter.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
