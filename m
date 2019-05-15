Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55870C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252A420862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfEOIVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:21:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36637 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOIVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:21:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id c14so961298qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUjyEFeqd+QjPBUNU2YrKXDEwz3vbLbdOTBiTizkBWA=;
        b=RwaFktaqL8jUY/vBEqucW/Jh7z8ZTtTO9QPFQnIMKjJAoqNtQvW5Sj8Begjj2XY83R
         0N8E5KbQEtpzVxLgnm6W/suIlynG+vhqmUE1ZOff1GBfYR2kYKlpJsOjgTcg4A4XXMCn
         WVKIp6oFOAOQrdtYXd4+jzqZ3AFZBEozxvw51/ynF1N7lIIL2RhCXbiFhZzPpHcS7yPG
         SUoYUh3mPbUvXdHR6HHZ7M/w0ERXTH00jbCO/GCwSC7VCxV1xS3dNVQHudYd/YK0KAPj
         Hz2vz789syiXgMiYFBKL9BrEbOWvkVv/qE/ECTdgUKXQYvoMX4Ww7jN6zEBshOXExI8T
         aSiA==
X-Gm-Message-State: APjAAAW1zQDTXgHiMbXaqmoO3GfEvWqgroqUSrNGv3/snqs5TYcHM4e2
        5foGWum/LgF4szlN8WdP9j4vfXwTnHi+h7icTbg=
X-Google-Smtp-Source: APXvYqyPzMeIMLSw6cg1s8dCEB/CGN+U3RwpliDOupresIqy+B9Kd9uUZtRBKmKO2YD9KUO/bvbxtAivAQqImr7xvDQ=
X-Received: by 2002:a05:620a:1368:: with SMTP id d8mr9912228qkl.107.1557908508028;
 Wed, 15 May 2019 01:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-14-elder@linaro.org>
In-Reply-To: <20190512012508.10608-14-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 10:21:31 +0200
Message-ID: <CAK8P3a0WW6B3fASNB9th_ncPine7X0OfhJD139yUC31UQiGQdQ@mail.gmail.com>
Subject: Re: [PATCH 13/18] soc: qcom: ipa: IPA network device and microcontroller
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
>
> This patch includes the code that implements a Linux network device,
> using one TX and one RX IPA endpoint.  It is used to implement the
> network device representing the modem and its connection to wireless
> networks.  There are only a few things that are really modem-specific
> though, and they aren't clearly called out here.  Such distinctions
> will be made clearer if we wish to support a network device for
> anything other than the modem.

This does not seem to do much at all, as far as I can see it's a fairly
small abstraction between the linux netdev layer and the actual
implementation. Could you just merge this file into whichever file
it interacts with most closely, and open-code the wrappers there?

      Arnd
