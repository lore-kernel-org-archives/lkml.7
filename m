Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C121C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5F620868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xj+2Cqjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfFGVLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:11:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40169 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfFGVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:11:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so2623990lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPc4uqgBsBwvM/V5yLC3GgSCS1qEGuH2AgCesOfjZVs=;
        b=Xj+2CqjydRXkCSQdyY7hh8PknmG976aSmUGB6M0CXKwV68YBSlt7lEEc+0Q42HLwWz
         Kra3lWvzcZx8eZY4JLM9mGD+VkNWxtwDyVXjTFTgP11NG2vkLXXXisA4gdEpta8GgDB2
         yxGporWlOf2R6G+iU1qVE/dS2KcDdPsOgzlWsQScxqbH7f/eMvtehgLWrh/1s1mMzjg1
         BK/0CrHmik6HkETFYVX4kcOMMJv106KemH4Z0D8fzGvw9Y3KVrowv8NuJWMIEnm7Eorb
         QD7hXFsgXb7V41En3COZDajj/mMY4wVVGLQ6hrmrSsj80bmLgb4VTYAq4+CJUHOuV9ia
         B5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPc4uqgBsBwvM/V5yLC3GgSCS1qEGuH2AgCesOfjZVs=;
        b=e40R9+2alxT+EabVBAaKDXy5J3kaqlsU1hrwjrF476d8o23ntoF4T9lPvLmAIrdtK1
         TNHGp/DrhROUFlykPTlPxcCFtzQeHFhlQHhBQsqonUE/C/Tk9OpOZ1sH6IqGXjlbQCDC
         9xoGtnLrNsrg23YABUnmVEDsC3X2++VuXELgL0n9rmQkvup5JgqAMWoDtndoH+wRz4Dx
         IgGy80W2nBzoM2NicSfyWpANkh9j+kg+EqfTyvUjotBZvaF99s59hNPuW3NKASkyQDCo
         2YDptAm0IYQPmlCpw0Eutfj9WjtdQVj5pTQQGSuBU0Dejv0cXWWz3tWlji1f0iM0bo1F
         H3WA==
X-Gm-Message-State: APjAAAWfW++BrtD/nHI44K0hjDA94iCpiNVmzRddZTD4IzzdGgKRIGvz
        VDxhcATLqWEHa7YQDWv0Cqb2kTTTaeGf+BAAhQSbBn+k
X-Google-Smtp-Source: APXvYqwLMWoxXQVxSrAqsjepyHJHrlxKQondxww0aj1IMUZLcbBmaGIZOjMLnDuUtqzxjWJr+xi7qFr48fEF7tdb+eo=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr26200028lfu.141.1559941866676;
 Fri, 07 Jun 2019 14:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190603010455.17060-1-masneyb@onstation.org>
In-Reply-To: <20190603010455.17060-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 23:10:58 +0200
Message-ID: <CACRpkdYP2C1cUN9w9uguSbXV3vkCDrm3o84qNbpTiaD9TcdMog@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: qcom: msm8974-hammerhead: add touchscreen support
To:     Brian Masney <masneyb@onstation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, frank.rowand@sony.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        absahu@codeaurora.org, MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 3:05 AM Brian Masney <masneyb@onstation.org> wrote:

> From: Jonathan Marek <jonathan@marek.ca>
>
> Add support for the Synaptics RMI4 touchscreen that is found on the
> Nexus 5.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
