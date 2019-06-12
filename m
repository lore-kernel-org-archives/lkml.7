Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61243C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F6720896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWxwBLkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439073AbfFLMnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:43:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37579 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407862AbfFLMnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:43:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id d11so4145022lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6vkS5UR633RrFItkYoPggOLkHWdZUqhLnRcNcB2XtY=;
        b=DWxwBLkLxa7JT3I+1DgXWyreCPEz8X0Ha8jOv9NGq44hFVhu69D4kduMd/7uGxdh2B
         cIWRCPCq9jJl98wMSvk7YGohrJKFaa4PjW4Fvp5KM5MDKt+1PdvXIPoI1h4fZ95dVbD5
         TaGctVbxlPdhfCs4/YfxV6Yh9vakovpMQRAO+ShReg9Ik42y2oFyjfGBQwD8ecB8Mx9e
         KsV3DGPXKQnRi3XO26tvGXvahStPbVMpkwSPPBVvPQeeQqaFZ4WA11sLI2Sgc4bbOkal
         7zKsFLYwaJ1Odl/F1Puf5twxvAEC0IhjHtX4SrQulhoxhfrJpiA1XP+ZGVCT+3bexZAM
         SnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6vkS5UR633RrFItkYoPggOLkHWdZUqhLnRcNcB2XtY=;
        b=eUfGOUfSuf1Wa9svCtwqUGuBJs/R+Nko0aCf8RBnqLTnflQmEcHWgGQ8SYGeLB9/PK
         +Sscayfqn5KRkrWNuKcD5n3TuzWERmeFb8cMhKGal7e32kCCfWcWNfPTacQp0jINvc7p
         g6/+TLlFdZXeMinwBLQXZ8MWRI1tgvtKBhxAytoUMsMrDFQ9DIn1a0kbvR7H5PHx5nAM
         YzM6HUfLLq6+5//zywP5bxgZG6CgVXmAnWpzqJu/jUWF3EaQ9ldYBTzUBmgzumupZU/S
         REcCNWLX7IoZdGrN8alF2icEe3Q1PHQfbhe7SCXZem8mwnIngwSG2z1mH3TdjpI30NIW
         rG/Q==
X-Gm-Message-State: APjAAAVtoiHH17rrlfRY/yLMI8ePe0uHIem8HWsFGlHfPJUr7VOSAJe4
        YqmrVKHreKrsNe8YZZTKidibVSX6haLklvhHgeaVXg==
X-Google-Smtp-Source: APXvYqzdmDZbWcjzXKF4+qJgAd8KclcnVSdd+i4vFNoSgCTrLDHUk6WwujykW+79sxKgM6urEsZlcpEXfTd0l81tX9Q=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr28043288lfm.61.1560343386199;
 Wed, 12 Jun 2019 05:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190612122557.24158-1-gregkh@linuxfoundation.org> <20190612122557.24158-3-gregkh@linuxfoundation.org>
In-Reply-To: <20190612122557.24158-3-gregkh@linuxfoundation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 14:42:54 +0200
Message-ID: <CACRpkdYC0DJkasyLawUvLWuM4_hE7OWLxaXwwus11Ga8-2+Fdg@mail.gmail.com>
Subject: Re: [PATCH 3/6] dma: coh901318: no need to cast away call to debugfs_create_file()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 2:26 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> No need to check the return value of debugfs_create_file(), so no need
> to provide a fake "cast away" of the return value either.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
