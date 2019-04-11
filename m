Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FA8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013652184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+rqHzwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDKNis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:38:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36766 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKNir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:38:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id u17so4752497lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E36OFR8CxgH13e701yYmWUl4SOEDNsmJuaGF5YN2y2s=;
        b=i+rqHzwoRZVuWLdV1Nmq/Um9BbqFu6GYetiZuBdcjM4kkIWzp4eT7hq0DwIVMhi75T
         ATuO2PWb+Fshard2r8I6WOBtbFtZW7qYUZ6UGc/GBCqEDdVn1npLzdRA6hZlRdtqimhc
         I0FoRkwi27wHO2ZY7p/lbRlcSd7vbW7PDSjKIWEfIcqaYfA0j1WS4Pyc8O/wKKgPrulC
         asK2l/3W6Pcn/VZwwXKMkgkbJBRWGxKWmJQHqH3kEG/mgCGbzNY1llLCeQRVqujHOyUL
         xx3d88mgLDpN0ObMSSo1sbK3jADzLjZH9FA9fJ3l5PNDYz+egoHJYxANHsAEV36iWB2L
         dvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E36OFR8CxgH13e701yYmWUl4SOEDNsmJuaGF5YN2y2s=;
        b=i+mVeBzADyBBPqWoPwVYgZ0Cdktbbxa5KIOCdz8E/BrP48YTqLuCxZ5VvEG4kKF5n0
         Wxdd/X7O9j/oSfMKN16DYFeaH+efh625e68LPtCxm9Tcsp07A4XtI5GWdRAJ5bsB20zB
         GUYP75cUiP0N0uH+Zu4K32HF612AxxsPWHs1jKoDz5r6GLwYFPhOpk8qeH8Vins5XfGd
         wKJujtEppPZNemmYAvivioCyPhBnBJmAQyL5vO48ottob5xaSStULHl1yYK7BH6S5EJR
         jxwHcjqrzzQyaYOo+UYh9Scx0vP0aaxpLQDyT9tsAM7OaL5whj16Nk0xxvT7mM7rVsdt
         Ecyg==
X-Gm-Message-State: APjAAAUDEJ1UOjs1t3/k8r0JLmg4JXWHiBJD7UyC51bhpKlZdeI+Mx29
        5Gjpi6WJ7/bGhlzaihQMJXgKQ6xgKeZ6o5P9YQSgGg==
X-Google-Smtp-Source: APXvYqzvEjC/5vkC8/9hFjBrPjvVEuFSo1c858ZDcqzgun9rcYddQXH0tqK22YZjrRIz9a1XGcCfnxNOEq59AUNLf/I=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr15596737lfn.121.1554989925475;
 Thu, 11 Apr 2019 06:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190409195945.20725-1-alexandre.belloni@bootlin.com> <20190409195945.20725-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190409195945.20725-2-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:38:34 +0200
Message-ID: <CACRpkdb4P_8T5Yf18cThq09SwBbvQMk1Qs_VZZGf45UbHfFy-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: ab3100: use .set_time
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 10:00 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use .set_time instead of the deprecated .set_mmss64.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
