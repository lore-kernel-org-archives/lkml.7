Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40AEC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4599215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xk9x5ffa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfJDVhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:37:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39060 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:37:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id 72so5438645lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ce3x7KSH0pYsuXm37iytKyn2HOMPOAXSnbAQ/QFaPBo=;
        b=xk9x5ffabqWz4gnsopezWJWtbhnfmkRmyaoteqL0Tb3I0kpN2/0ShNyHmkYndvZ7td
         j2frhivq4Mtp7ruUowc8Hm3Bm/OLGVdXO0NBH4Yrzrv7UQYtxITwYq3kt+t3Fv0XcY87
         ljlrSQ05DQe9wts+tAnYm94cF4NUcOwrjMiIX1uBPL3tYreQukjNLl5naQSsJtb5+Trz
         k5NBV3JBFdekRw8Ma6GEh1gZoXAXm7pDwmso7Yi3PkkByEut/1c0djfEKHMJ1l9REunq
         N0wcHIizgSLdWl4VbUyXoL6Mf9zeMOdPp0AwmRPaBSps+FZwsRBZeSq90WGUVbB7mnQN
         IMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ce3x7KSH0pYsuXm37iytKyn2HOMPOAXSnbAQ/QFaPBo=;
        b=jumiB4tX/9h1jvjD7Z91B11m8d2QhG9kHILBsKsKb0lp+VJEFLq/BIGLp0yiM52ljB
         CbaygzEoQTHibKGXoEgm/dZhAHkGltQE6r8oTzJSlf+FCeilqcBqjJuhsGrOWVPaiLEA
         cXkDHagg5u0w3NDY2xxSVA3OJMGN4b8l8Ljr8AypPqE8SuSPApdfjgQE5vd10NwNkYAw
         KKJMlRh4kNF3htmseRuDF/0Npw41B7DmxLMohHloWK0pfzfTlTEhpJyGHSQagmuNSiaw
         Zh5o/AioHnMKYh1GkOxPJBrBuQ6n1B7xPWbFaTed8hUUiPIJ/iI9jYRpT8ua+/gO4yZk
         UHPQ==
X-Gm-Message-State: APjAAAV7yL0V70td6xiqRLU5Qq2V8grwenSTwBlVaYNTBOmrNIgweLII
        aJwQi5WNpotk8qPkCfXqK4nUx9uyVKYjknvf5apRLQ==
X-Google-Smtp-Source: APXvYqy4xOAHwIaDtkz8jFtwY47sxQ2nokwcrjmKxbf0EZl8xzeuzKeGyjDOtURFQTzmmkuSB5zJlXy15mbRmL0oGYc=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr10152902lfa.141.1570225019432;
 Fri, 04 Oct 2019 14:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569572448.git.baolin.wang@linaro.org> <c3070351e137bffd2b4b639fb14b1baa19df5641.1569572448.git.baolin.wang@linaro.org>
In-Reply-To: <c3070351e137bffd2b4b639fb14b1baa19df5641.1569572448.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:36:48 +0200
Message-ID: <CACRpkdYNXcL3StU4sX2Yyvz5zH1RFr5E6mvAm+1dJFOC5ophxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwspinlock: u8500_hsem: Use devm_kzalloc() to
 allocate memory
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 10:28 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Use devm_kzalloc() to allocate memory.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
