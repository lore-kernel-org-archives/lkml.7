Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9BEC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1A42086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HiozRSV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF0L0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:26:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35832 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfF0L0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:26:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so1331267lfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yf/4QsQz71xnsufXmplIhM5PQjWjtA8iRNvCLywUsCI=;
        b=HiozRSV9jjoEd8lgVneXDXnUBP1+IEYIg+jfVj3yu3YE2rDCh0mQf6PCltXafOZuRQ
         wgzquUBxyhWo7PDBS9m/LWFwnCANPBpvCZrQYE2oHj20GZq/2E9ThKk3E8NPw81Lz1IR
         6wqLETMA8WyJzKNmXnDzqbNY6sUIuKzxUMVE+GnlYNfor+m9ZCB+VLKecag/t5wKJ6Jd
         T9zmH0RwA2Aq86TTmuzE2Qjhpw0IXYMX8T1nY+VIb685SluVHK84SiGlfHixp33uk0NX
         kmZSALvd+oLO52Ab1ZdDT5vg1sdlJ8tHsJXVo/3VFxdWskcobVYms8f/hqACvEI3a+uf
         LmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yf/4QsQz71xnsufXmplIhM5PQjWjtA8iRNvCLywUsCI=;
        b=Y9U4aCxxXjLP0hm0oOKbFvYZVlMGgx3w7jpY+Mvb4Yi4MfzsU469ayaPbnrI+yVc3X
         dEB+W01zpWXWHP5iWGELhmCVSlICpQcM4C2F2hqHcWPBOsU/XjDY55L5a67j3dIDovM1
         ax1FtvRkq8DHC0Q7edoe6U0FHk3g9OgQmDVrgZQm6r+imkFyYpyb6UB2xzoZ+9615y0+
         ZO9CN2PS8bAXQmlug648ll9okG9xVcC3fiZm5WZYv4ZcuSMHDRr7ubSG7H3zGw4bNxf1
         Owdt3lD890hhN1ZPFE/ioRU7IN3YXh0UENTjLEtNa3epU2Lk8rip9i8TI0ARjc45uo+F
         0csg==
X-Gm-Message-State: APjAAAVJ/3pKJ3OsDstvLZ1uCUUq0qPEQ+WPuYlVrdhtSRc8kt5QcLDw
        +qtAZHgCHIIdnGVA/I2XW4Vt15pJ1XORT+HLdoEzBw==
X-Google-Smtp-Source: APXvYqzeLT9m0qZPhFXMQe7bGeM0G0YNhFKZNBdroL1getpvV13XvxWgav2h1PfavnIunwZFc7NAtBe9miLt5qxA34s=
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr1687908lfg.152.1561634781537;
 Thu, 27 Jun 2019 04:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190626071430.28556-1-andrew@aj.id.au> <20190626071430.28556-2-andrew@aj.id.au>
 <CACPK8Xfdd1ReAHr9f6zRbZ-WJRquDJsTdUQeT_JuEBhOzS8tig@mail.gmail.com>
In-Reply-To: <CACPK8Xfdd1ReAHr9f6zRbZ-WJRquDJsTdUQeT_JuEBhOzS8tig@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Jun 2019 12:26:10 +0100
Message-ID: <CACRpkdZtTy-HHu2O4aOaqV5ZdxcYYPFRuxK2jjnw+_O1xcF1rg@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: pinctrl: aspeed: Split bindings document
 in two
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 4:32 AM Joel Stanley <joel@jms.id.au> wrote:

> I think we can use this as an opportunity to drop the unused g4-scu
> compatible from the bindings. Similarly for the g5.
>
> Acked-by: Joel Stanley <joel@jms.id.au>

I assume I should wait for a new version of the patches that does
this?

Yours,
Linus Walleij
