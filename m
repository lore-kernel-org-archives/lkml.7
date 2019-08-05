Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E17DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F36520880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKcG7C6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfHEKNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:13:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35838 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfHEKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:13:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so78884628ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0o9vzM5z4tJmgkpiSutr2QB107dik0sdbw/V502WAg=;
        b=GKcG7C6ACp2Etc3oo6wga+/l3kdzBmg3lZpBaal36I713snq7hNrjuIJkGuJ8Dk2I1
         vDx9hmhpa+2qrSoDMHCoKprfxGZerQBSSC8oe0e8eDgqyAH1Lk4yu37D/jnTfFUIK6Rl
         o2lLwRD9hUMWW0UimQRqhSrSIyYHmxmon8I13jPlcRbcjnIXXBglnzq1QqZnx/uab4lJ
         D7+FSSsPrZJpedeu0i5T9EViaT2eZAkcsNQQN/8bQ8oBaetwOTTZkRLWkV50pPTVC/bA
         YTRtZRu2Um4G0LiTSHH1oVNF9RI9zrSdxI/skDejtRMWLXlHGeziyJSbgreKJVAph3ti
         we2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0o9vzM5z4tJmgkpiSutr2QB107dik0sdbw/V502WAg=;
        b=V1ZXvnKB6n0ST3O6bE+ykNLpdGdmc8ltNeSTVj7iEjCMQHXRLFb5dJadZ6DMwg+ezD
         0/CT/YF3HynOoTwvIb6hGPYGwms4R5sx1Nnfz3Qvxg00KoOeniu/XIgCeInWaC74ar53
         ZqYGR+49ke+yqBxcymSj/HKdZuzTCQAgyejzRB2TZH3sL8P2gDWOJvuoseOjsvQmJL+2
         yJBeTAY/8Z1475S4PyoQYmSBNvixr4yy+ZAuzpTKUprikbUIiNPFnPa7mzNRw8mBRZ3D
         bOBuNmIoWl+p0I93sjOTLMIMmXih27TGdlGX+1rwJxNGW0yzL7usTnEhU56P7sOhXtQj
         z8Sg==
X-Gm-Message-State: APjAAAXEB+26Kux67K3sahfb7Cw/nOO/JkMXfEocBWzXealnsHYFsLu3
        2d8Uk37jEMXaYALQn+v91f5t0ykRsVfDEzyYXdSs6Q==
X-Google-Smtp-Source: APXvYqx8LE5Y30KKQRhMYcdKori2YIGtrIflcpdOEq++H+ZbNgi7NdKekFUFKi4psMKkPwe3/wp/daoMsKr3AczUijI=
X-Received: by 2002:a2e:9048:: with SMTP id n8mr31240262ljg.37.1564999983775;
 Mon, 05 Aug 2019 03:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <ff410d312ed0047b5a36e5113daf7df78bcf1aa8.1564048446.git.baolin.wang@linaro.org>
In-Reply-To: <ff410d312ed0047b5a36e5113daf7df78bcf1aa8.1564048446.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:12:52 +0200
Message-ID: <CACRpkdb_sV8w74kTpdgpwBwRgu1xgKdzrpBZQydzdTZ=SvtszA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sprd: Change to use devm_platform_ioremap_resource()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:56 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> The devm_platform_ioremap_resource() function wraps platform_get_resource()
> and devm_ioremap_resource() in a single helper, thus use it to simplify
> the code.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied.

Yours,
Linus Walleij
