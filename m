Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE1C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6852133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H94StjHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfJCND7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:03:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46101 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbfJCND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:03:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id d1so2625158ljl.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XioN7puVbcYRckEVTHmiB34pXF9Ej7EG9KjZda45NBU=;
        b=H94StjHmQA5TRSAC4/Abc0WwiGKQyKwCI6pdiTuyEJXIa3nnrlCVWv1OfoqEiZeATy
         4rZPkzd75ThGs8M0AIqY9Wvu3A9FcnYfOU4mOUbVNGCKmx/1uzJ8jnSiX6zIp5Z36COi
         8WmP9tmekQx+0CkLz3OC5EmxRSpVr8YOW7KbPDumSoW075JjFSIcd5R/jxX6YspjsWw1
         9qYL7XV7RHxSa6PoCa322+GkEVjjXxGqk0lHLgwL71qsXwx0NgdwR5gtckiKyeW8nXxs
         jPCUYskSLjqw4MJQ2ILs6Hsk+8qXt/PsDnwV0QlLxvOOdnw9jgYr/rY9xIsVcaqtCCUt
         49Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XioN7puVbcYRckEVTHmiB34pXF9Ej7EG9KjZda45NBU=;
        b=Y/X7rjc2r/GCNsw3uds1XJkomcIrg+utu3FI0kDODs6K9t8ZhNbBZ9NcklQ4m9j4DT
         gspzKHnpNgkLzpBDg0M0lKv7oiyOxOQ9UB0wSVNl5Jf/sf5+qylnEPyFql6fQswo696i
         oZKLzJxPukCtGnXFVX/YA+LVcVaw2SvLL2+oxC88ICIqpEJhVariBs9m8UuRvBoQKybg
         Iszt4E5Zs2TLUxP9qV4jLYKoGoqsJOJE7nSLdUFeoVbxuMpjNSWJTx3sQh2B+OCVNrSD
         cp2/qdF4MXnokqkLoh3k1fAx1TN7H3DiBFLP1youoGP1qDirjQ6Rmr0irUp/VhTGa6tL
         K4lQ==
X-Gm-Message-State: APjAAAW76m80aqRDomObnTdItEG4nl0Rr34Cw/Kr46y9LUScscIGJexv
        tB/DKfhjrayLil85WhRWDnLm8CZ4duVZDwxVBxxWCA==
X-Google-Smtp-Source: APXvYqwLTqJ6PluifEhLN3LXeppRw6SC+TULeLNjobndGDebZcb+fp7ss3iiSIMMyr4V9i2taRe0ub66NlmSxoi3y7o=
X-Received: by 2002:a2e:6e04:: with SMTP id j4mr5309093ljc.99.1570107837087;
 Thu, 03 Oct 2019 06:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190914111010.24384-1-masneyb@onstation.org>
In-Reply-To: <20190914111010.24384-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 15:03:45 +0200
Message-ID: <CACRpkdZeKbNRqC+2Qs2tvWjWYDFJdg22YQ8mxMNu18n9O8cyig@mail.gmail.com>
Subject: Re: [PATCH] qcom: ssbi-gpio: convert to hierarchical IRQ helpers in
 gpio core
To:     Brian Masney <masneyb@onstation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 1:10 PM Brian Masney <masneyb@onstation.org> wrote:

> Now that the GPIO core has support for hierarchical IRQ chips, convert
> Qualcomm's ssbi-gpio over to use these new helpers to reduce duplicated
> code across drivers.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Patch applied for v5.5. I didn't have time to test before the merge
window, sorry, not it's in!

Yours,
Linus Walleij
