Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555D4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1142086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erCRbeIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfJ2OPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:15:45 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43034 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389285AbfJ2OPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:15:44 -0400
Received: by mail-vs1-f67.google.com with SMTP id s130so4946431vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CJkMB8W25QC+LmwHZCR/dC2OeYvdCpp2yKraECtwkc=;
        b=erCRbeIBHUu53eIreClKHV+uY6SMssROpbDKJZMSC3l+mDep04YpyeFnPKet5PX5N1
         K6d9GL7q+TBbHhpf38xASFO/TXfXIgOnQd+2jwtbABwkUzNKRv4crlJCQ5sm33YkfEj4
         u0npQzAAraEWJu+naiJKHKuW/DZPeUOAf7F1bBLeNGslfkb7ZIPfYWSV9H/PfDxih3hV
         coNmtYtFiskJu7ap8vyMmzTx37J9AxaFbD9LknHJc/hx3PVruIT1Bbo9+aHjnSy/QjoV
         6LB1xAnri/kSOeQaJ0PsMW1btfvx/BA9yOxpu4tBlBCWlPodHSRXiAFe8R7+Kv+9rPOU
         vfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CJkMB8W25QC+LmwHZCR/dC2OeYvdCpp2yKraECtwkc=;
        b=qZxQ8tcUiTXJVm8dnbrmvAKx5RIo9g4Q/TMeikz06UsTd4s66Ab9qgXhe3C+13swBQ
         PymaRLxqQxeToY26bcIk+24DuxRFaba83ELW/twEaXw2We1DVUVLGhI8+3ZaRdRiB9yA
         2k4BMwTGCSvl+jTDH3egfaMLLJHO35Xtf+g7jRhhU23wWXwvKB89G/QLRn8vo1GArlL5
         TBR1ygCxk1vcxIpvVj+ETYuss6KFFxSVCrAV2esfQiNCT+azwqcnXiu3QbLWRs8k8pdb
         Z4SBrDofhoilke4W2Rwx+YXMQlcrbM5ukdW6GZpNff8YXMkd8Hij13xF2SUDRvzauxcD
         rlGQ==
X-Gm-Message-State: APjAAAXcTqKxh8JSDO8eR8JBzTktGRvxcyBV8TAEIyYNl6v81oRx64T8
        YhuGk0OrRYsOmJCMFZA9MzI6YuK6VcSrSnx3t3jmxQ==
X-Google-Smtp-Source: APXvYqzrRPTOdVe3rVj/q8mFjvCWiOOTxiTZFSQn4yLUcuktimo2dgWY3hYMbxvwByEex6FdTHrCbR8bcgRkCp0CTm8=
X-Received: by 2002:a67:fb5a:: with SMTP id e26mr1980049vsr.200.1572358542448;
 Tue, 29 Oct 2019 07:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191021064413.19840-1-manivannan.sadhasivam@linaro.org> <20191021064413.19840-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191021064413.19840-5-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Oct 2019 15:15:31 +0100
Message-ID: <CACRpkdaZFr+DAthpoEeJgMeqhQfMbDNcd9dVQOEhqfqP6MmP=Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Add entry for RDA Micro GPIO driver
 and binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:44 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add MAINTAINERS entry for RDA Micro GPIO driver and devicetree binding.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied!

Yours,
Linus Walleij
