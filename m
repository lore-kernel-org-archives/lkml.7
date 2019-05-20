Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B2C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829E42054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwSEtpG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391981AbfETOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:44:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36221 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfETOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:44:24 -0400
Received: by mail-io1-f68.google.com with SMTP id e19so11249312iob.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HsQVgglgMq1psBbmdCp/J5du6WO5ck+uTZsUbAD0TTs=;
        b=QwSEtpG+HlPcpMvr+jaK+zM2t1ivvQaI74KMgcKuhBZ6xzeJ+Utr3UXY2sqrVptD6L
         fyCdPT6rEUbO1RQZYIsLrSB92GNnXUIs+iQ12ulkiMxjGOBrykwvs0xi8PsVRL8jbj89
         1f+tXLaxeObXCWOmlCZ0QfPwDzBz2qaGwllIBgwWcqm/MNU+U1XvzivVOk4Tex4gS2io
         J/CZPy16AUj8VP4YOeSTh9EMFmdRR7ZYziICk7S8wk4RE+HNYWky/cU1AxpTj2NlRDkk
         phpc2RJqGnStBIDydur0ws6WIQYkKY9rQyKYrPsbywd8L/BT30cOR491szyoG6/i1Qga
         b8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HsQVgglgMq1psBbmdCp/J5du6WO5ck+uTZsUbAD0TTs=;
        b=kHt6MF9mpZrm1zo13tbpESbf9QFnqtJczOoabmTBmz35g/JkmciQCSLWOZ2w72jE6+
         XF8kuDp1EUhNYB7Gzy2GG42DfaJqHXs5JIzm5cdzHo4Py1pgUB9Qb70gunETDGd1RCbj
         aG5fOVoA1CFS7pVCm2kX15bRjIwzUAQf4v7JumgdE1KdJYONSLv+7DIPrZ4lALTWzpbz
         /3OATRwbHfc9zO6zGRplERuJ5ssBlcfpU0WKjTlUfSYBep6Ls7CMoFhAiwFt6j+Nr6tg
         CaRe+ZoQqLhWS+iAvwDJXlt6Aj6qw2x+2TrBSvxt0rE5B6ORDL19d1bDKsyvDi6wNHkA
         RUIw==
X-Gm-Message-State: APjAAAWQGaQ+xu2bMfmQuNbbQTViYxPYr3mu+hO3Q91qkbiHrVG5fZI4
        XA2BOLVFxmRvF3C99gShm+FDO3y5s9c=
X-Google-Smtp-Source: APXvYqzmLCjwDYUNPQbPu4wuBcjc7xMYR7/qQWebH8hWpZ5iUuE+KGmOmGElpi++MFpSaPGKzr9zLw==
X-Received: by 2002:a6b:5814:: with SMTP id m20mr41477359iob.293.1558363463516;
        Mon, 20 May 2019 07:44:23 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id w194sm5025733itb.33.2019.05.20.07.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 07:44:22 -0700 (PDT)
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
 <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org>
 <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
 <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org>
 <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
 <CAK8P3a0FfSvTF8kkQ8pyKFNX9-fSXvtEyMBYTjtM+VOPxMPkWg@mail.gmail.com>
 <d3d4670f-eb8b-7dcf-f91a-1ec1d4d96f67@linaro.org>
 <CAK8P3a12+3a-p2pNuQrJu01dOJJuCoQ4ttt=Y0g97wTtBmQO5w@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <8040fa0e-8446-1ec0-cf75-ac1c17331da5@linaro.org>
Date:   Mon, 20 May 2019 09:44:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a12+3a-p2pNuQrJu01dOJJuCoQ4ttt=Y0g97wTtBmQO5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/19 9:43 AM, Arnd Bergmann wrote:
> I have no idea how two 8-bit assignments could do that,
> it sounds like a serious gcc bug, unless you mean two
> 8-byte assignments, which would be within the range
> of expected behavior. If it's actually 8-bit stores, please
> open a bug against gcc with a minimized test case.

Sorry, it's 8 *byte* assignments, not 8 bit.	-Alex
