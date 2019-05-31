Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165BCC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95D126501
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rlIw17Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEaH0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:26:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46318 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaH0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:26:04 -0400
Received: by mail-io1-f66.google.com with SMTP id u25so7329523iot.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMhkc6QKxghdSk5QTco54OGClXC9USq7mw8yEKC/dZg=;
        b=rlIw17SjQk8R5gRB5MCzkRmy9anIFsuVUiXk7m/NZFMBdboDLKm3UC/EtGvlvNcdZK
         qGrwLQGq2rW4HuRgbv+9cGw863TKwsqhFQ3op+bLbVrW+KqFhhIyI3Y7hEUaUbG4Zmu+
         +Nc3l161TPzewsb6ry+g5GAJ4yqIHiWfjEm/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMhkc6QKxghdSk5QTco54OGClXC9USq7mw8yEKC/dZg=;
        b=sMjDd1qWCAPAZOTFqolkIgxsqFcyZ8PT5PQOrj9gEickEahtFhKgHy7ipIcxnIaPbw
         kT4F2MoohjVZWgC91JchAp+uWWEzicJCppen8qaFQKUkcRZGNkhcNGhaHuYolBTEvA3Q
         qgTgPY1vMSSVeYnR+qp4gJ8ps0NEFHAjH8hoW33X7Crp4eU3DeuHhGsKPqzhmR8SJiRv
         Vm2mnPkSSXclPuuvWeCLtPtw5EdJNN2pszDs7VUXpfcv1f9e1ofEvnzFZ7s1Dz4Aagiv
         Zl43pYw36UyALMJP9xw223gHxMfsqQIBmcDaE0V5LlCKM9KgTdQQdXXNE9SoXX+FAiXU
         y7Sw==
X-Gm-Message-State: APjAAAXI7r7YRzLvaxa+6K13faFx7/UlleSWuBldLAIoiccMt/7MBjR7
        tOVkVnZyHUOZHbrL0RaRkL64QEgyieXCafxHnOAUdg==
X-Google-Smtp-Source: APXvYqy8YqHxgOmJ3DOFMi+1eQvArvIpx0esRPLJUvkl/uppnke9kcE464HrgsrNrktbD8QP8cudbV/NYCsIQU8jwCw=
X-Received: by 2002:a5d:9f46:: with SMTP id u6mr5396749iot.297.1559287563830;
 Fri, 31 May 2019 00:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190529105615.14027-1-jagan@amarulasolutions.com> <20190531065806.fl4y2kex427qtysz@flea>
In-Reply-To: <20190531065806.fl4y2kex427qtysz@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 31 May 2019 12:55:52 +0530
Message-ID: <CAMty3ZCfc=xh1cZrM0PST-=QNT8qFRLkjWb4B=7YtLitXo6MGw@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] drm/sun4i: Allwinner A64 MIPI-DSI support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, Bhushan Shah <bshah@mykolab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 12:28 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Wed, May 29, 2019 at 04:26:06PM +0530, Jagan Teki wrote:
> > This is v9 version for Allwinner A64 MIPI-DSI support
> > and here is the previous version set[1].
> >
> > This depends on dsi host controller fixes which were
> > supported in this series[2].
> >
> > All these changes are tested in Allwinner A64 with
> > 2, 4 lanes devices and whose pixel clocks are 27.5 MHz,
> > 30MHz, 55MHz and 147MHz.
>
> I wanted to apply this, but it wouldn't apply, can you send it without
> dependencies?

I can do that no problem, but [2] has dsi and dclk divider fixes that
would require A64 MIPI-DSI to work.
