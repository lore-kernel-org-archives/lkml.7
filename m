Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD18C17449
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84532222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgMaQEuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfKMOrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:47:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40931 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfKMOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:47:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id j26so2178601lfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQrWeWf9QtOi7M1gxxpS8uzFCUgWpoqL5CQthXBahco=;
        b=FgMaQEuSftBWtM2x6N/r8zpt6IzKUvIiO2+PdZgXmtmk8Kvp7kjRJOjg9ItQ0UfS4t
         YgjvVb8ImGI1+6Ez4nlrKNAYqBndmxNvN0uthRUbrzm+YcxT2jyAxAmsiwt0Ny0Vw+pW
         84aPL66ZhxRk7EuwOKGi64gKwvdGH3cgOSh2hMqk0qk4q/8lLCBxVmvR4yYSTNIK51Wr
         1raZQylTVt2BEAd02q4hIEblkJ5PfDVsHESHLYOwaOKOaupbB0GqJ53VwBWLDZQ4z3K6
         EaIAe9cgXJq2COIq+2VX1yubuS7ph6Lrt8SD0UPdEC41xH1eHf6BdR2W28vJ1YH7BUoQ
         GhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQrWeWf9QtOi7M1gxxpS8uzFCUgWpoqL5CQthXBahco=;
        b=p4aiel5iGDMwOO1XGYXCMJHZRjqmQwbiGhHLt7zteOVxGgGOSIPK+ZOY/Ubjx7xMla
         bNNSZcE/V5xPx9oAO1w5IeyCUrmtgWZ5NZhzMisYX65lm8dEOZyw6AHR0GxMW0tjIva3
         ed0iZlGot6YR7/6hiGrrfhVfhNFwvZbftiNjJ9PO08k59UrDjWjJRhycGe/dGaREeQg9
         /cHI+e0zyJS1hHKGPaI9oUJ257jqQo2kctc7e9FJPSE0g1bBYF400gBbmWQBXoIU+5+k
         dh8FrgBixygr+vu9n9ioS6hjLthspwY7/OJ6/kHwAKxgtVb81U0NEWPD+PzriRlfFxUN
         FLMA==
X-Gm-Message-State: APjAAAVodNDjnW/izALmn8Nlz0J/5O7R+eyFFPSj22f8kgr7ANCf9RdF
        vvzpKG6kjLvVbo/Kw6+lyKmrtk9hQDL7KTUUC5Necw==
X-Google-Smtp-Source: APXvYqy4Gs+cn1O1Suko5LQ2TXf5Cr45y80cAOlgn3FYsa6mb1dny3EgoAAMi616HeC1eO4Iz0GaDLxmFchKxY7Tcg8=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr2850516lfn.86.1573656418885;
 Wed, 13 Nov 2019 06:46:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573455324.git.rahul.tanwar@linux.intel.com> <96537f8702501a45501d5a59ca029f92e36a9e4a.1573455324.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <96537f8702501a45501d5a59ca029f92e36a9e4a.1573455324.git.rahul.tanwar@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 15:46:47 +0100
Message-ID: <CACRpkdYhy1KLyZd4MNSODpy0Q59_SAcc+wkofrZr4b4N+rYDxw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: pinctrl: intel: Add for new SoC
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:11 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:

> Add dt bindings document for pinmux & GPIO controller driver of
> Intel Lightning Mountain SoC.
>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
(...)

> +properties:
> +  compatible:
> +    const: intel,lgm-pinctrl

Just noted from another review where Rob noted that this name should
match the internal name in the datasheet for this hardware block. Is it
really called "lgm-pinctrl" inside Intel?

intel,lightning-mountain-io and similar are perfectly fine if that is the
name it has in your documentation.

Yours,
Linus Walleij
