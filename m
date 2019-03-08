Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561ED21019
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DI5k8NJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCHNO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:14:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46085 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCHNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:14:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so17306671ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lVOVxSUrodB+BhbXqXifr3ny6IlC43KfilfGitM/t8c=;
        b=DI5k8NJHBOAMrzcJ8dtyoII+D+lqXXmcEnc+kukuE1WJ0fRsuOioTQHhBmfWr1h9n5
         sgKK4zhO5Dp/eaDHUw5VJ5tjTs4TREXQQA41qwL5HxaiF6McBDgNn3pSZI9WwqYpVC2k
         CZtHxydnpuaYvlS5rcOUrWbXU3OEtR46oqL9MN/eaPns6iP0kCDcEZZ6tDdTVaI7JLaK
         NUgY+uMfOXJv50h6viw+JCbavfBmUpzomC+Xhe1vZg18yqYsS24x8Ie+lLW+WA5YbFPD
         OqWD+tcdMMLU5NjvQgp08d01s1MFh3GKFJwaHBf0YvwG2kT20QdgFUiRrr+mVM2hyUw8
         xIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lVOVxSUrodB+BhbXqXifr3ny6IlC43KfilfGitM/t8c=;
        b=LXiRVhdMdCxijLyFtermIr+wP2Kh+afns5GkANtlcSHGT9Hy6EyseVbzO2bIr+EQYw
         zOiq5KEOO30DsuA8ULqzWYGBBjoMItqA0wSLYOJaCkPyxz9SNIf2B3Kvj/jRMO2F1bao
         HP7diMICP0NuudLLZTXZZhQ3A8iuWNspeoDrDSfgnU1LK7stz1b4JNGMOJ6uHJu90A3K
         DF7XKm8RKdjle/gz7Mm15JOd0P4C/8bWDEqSLI0Bpg+F/G1Q3DZAjKEbf80P9GwUPSPW
         GN99guNiPSOHbbvzX5C/2XpWuDnG1lxNvm4DrOCT3kUC8EKtnLX/X9HJirIm/FPNaCvc
         a1eg==
X-Gm-Message-State: APjAAAV75ymOciXDN+aW2gGOwg7EGxSXSB6MdSILhfhpeGo1MJjeY3bc
        RYFnkSj/TTrJxIxopEvgkW6Eu+wGV6z0VuqsF9O5lg==
X-Google-Smtp-Source: APXvYqyNxoTh0eAQQNL9mLJ7aHgIKxc0mQdBzP8FJGbcwTw/rUr87fGyrqXGXcu0XV1ZUCE+X3z3FG2if+G3EWKlc+A=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr9677882ljk.105.1552050897469;
 Fri, 08 Mar 2019 05:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20190307125251.724-1-marek.behun@nic.cz> <20190307125251.724-4-marek.behun@nic.cz>
In-Reply-To: <20190307125251.724-4-marek.behun@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 14:14:46 +0100
Message-ID: <CACRpkdb0WUa=Sh+idQUBnCHg4=oD0AFU_FRLbp_7xs8L5UsP4A@mail.gmail.com>
Subject: Re: [PATCH v4 armsoc/drivers/bus+gpio 3/5] bus: moxtet: Add sysfs and
 debugfs documentation
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:53 PM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:

> Add sysfs ABI documentation for the attribute files module_id and
> module_name
>
> Add debugfs ABI documentation for reading input from the shift registers
> and reading last written output or write output to the shift registers.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
