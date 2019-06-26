Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623DAC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337B220B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4n+hEZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFZHzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:55:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45258 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:55:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so873324lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxdb5wlFiHBkF0SzBr5FCoS6f7qiRJDmJ1nDITQi0Dw=;
        b=m4n+hEZBjSl7z0DhNNkX163BSsqoZWM4Vv+1gORRGXGEyJ7mgvy8Zc8GCjHlf4UKZz
         SzMf+PwcnfQVBQlF5KWvIDwyzUIxJ7y8dF0ZlSMbLEux5PVwVzK4/wbX9p4C8vgQ/cLs
         OUbHAOtvtatcVcy7T1n4ClVtN3VfJxaFeTz9bcmjm4NswEVlKTTEOdLN3B2cSJv7ML0f
         dvtb1Yp4GYrbdmAvQMxiXVkk1qnZ3vPnuwsJuJsMmiLyQuiZlld8WbxJpyxD51HVUsuJ
         2K7Yy6aTQwOkloLhCUNTijNxeAkHbkDQA7u5SUW/B8m94CyiFyIogZRFeit4jthgmS/Y
         vi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxdb5wlFiHBkF0SzBr5FCoS6f7qiRJDmJ1nDITQi0Dw=;
        b=Qym1wd4aYC39ZLTr6AAETb6jYN0MNUnnsV0tdc5ngfECThrHaNB29Y3l+7zJJxr//i
         Kra//EL8AnNZsbVSKf6th0US8ikCIKptENTMv/aCZmk2tgZjKThUPuXeOkKgRA1I5t2A
         Um3jsx2wR1f4t17n5FaH3I6W5/f1sa0EJ1LbxEBAUpHUssDPGVdLcF12xPGjdaTCpxvK
         5kV/7q8XPS7j3eiUL/62HiG/PdOgs3ePnRQtPvKUiMN8pjA8v5jggodtUnzHlYaS6UOJ
         Op+IWJv9BpqiW7mz7slrG/Cvy6J/LOCkibyz+/S04LJlfWVKSm3TapDo3q4kdiKArKTK
         mMVA==
X-Gm-Message-State: APjAAAVz7HNwt6y3+VtBkO9WBF++FGlU9xZX959RO37EAOYvGEejhy/m
        rJaLDKZVoi00RX/Y/Ecgd7/LpnPZO+8Br6p5vvNsVyGD
X-Google-Smtp-Source: APXvYqzo+qALg1dJHN8BZKGNryj1b2QPxrO2/Ylr70oC8XJ11Le0Cn/eflBCqD0MzHpKgDWXJ6rrs+q++1xhp5JnKPs=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr1916988lfm.61.1561535701468;
 Wed, 26 Jun 2019 00:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190626071430.28556-1-andrew@aj.id.au>
In-Reply-To: <20190626071430.28556-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Jun 2019 09:54:50 +0200
Message-ID: <CACRpkdboxjMmeb8feffyG5JJ7fGPR6hqC8sc+XV5We3TC__LXg@mail.gmail.com>
Subject: Re: [PATCH 0/8] pinctrl: aspeed: Preparation for AST2600
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 9:15 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> The ASPEED AST2600 is in the pipeline, and we have enough information to start
> preparing to upstream support for it. This series lays some ground work;
> splitting the bindings and dicing the implementation up a little further to
> facilitate differences between the 2600 and previous SoC generations.

All looks good to me, but Rob should have a glance at the DT bindings
and YAML syntax before I proceed to apply them.

Yours,
Linus Walleij
