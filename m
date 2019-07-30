Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD44C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66232206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="r21Nkm7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfG3KBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:01:02 -0400
Received: from mout.web.de ([212.227.17.11]:58055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfG3KBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564480843;
        bh=EtuMB5xC3CZJDxVHY/O5OcOMAYvorEX1VzzjKU1EJ7A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=r21Nkm7aQxlrQBybIHE3xkePnXrEJw20HIVMC8wDQIKgAgsrV1CSqLSXDb8tN5CXy
         eKFsjgBH8tBv/rwPbZuNHrcaja2UmOCT5Ecsl9QuI4KRpo7mvq9pFK+wB0xgzxEl+V
         GmLqdvYoBr3AuVe8Jv6d0XnfKqdus8frUGhj94e8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.24.141]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Lg-1iiG1u3H6S-00pvLy; Tue, 30
 Jul 2019 12:00:42 +0200
Subject: Re: [v5 2/3] treewide: Remove dev_err() usage after
 platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190730053845.126834-3-swboyd@chromium.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <328b98da-7e76-145f-0684-a8623efe2cc4@web.de>
Date:   Tue, 30 Jul 2019 12:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730053845.126834-3-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:5PZ4f1YojEeMCv0NuBWZcPTI/kCpNB5Y3XcBefURvLSwl5c6Nhr
 p17G9N/xCUPPhYyRswqw8OacqPJkr27KEycSNBMmKGF5GNRSDXnpTgYckkRlU8V1Zpu61ti
 37AnTYNV1ltxUptwtX11fag/HeEKFTydsg9IvJBj+hLteS2p3PKo8HFSgxn0SkB2UdnV2Eb
 W6q6YcWrTRDJRWqHw6vcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gGGHj1oRDX8=:nq1W/Tv6iANrDRLtTqhrN2
 Vw1nxA6ajWyaL0UezK9HDJNZHk+UjQIJqFxmvMhZAfP0IDVolyOpTH+TnWQBci0mtlMJ7NR1g
 011iVknUkB9Ft3bxiYYKanekx6S6+VgRYpLxuac56QMJX/j8YyuUFKufGaNNf9HCpxyePPsUy
 T927G6W+8iEaUHOSeD7tSzL53qyvCmx3LtpFgfJyzhCzyjF4SpKqnfLWL1ukTdOwir4oq987q
 hr0PjqtmPQ/VVEDQqWmIFMUqogddbH1gVGKwuaBSyxfeqGVrKtQD1YVcRBrHy9ftDwi4p2qkG
 gH0wqhIU+zEhgj7qjvb560Yt/rAHRKlAreCUgcv6zND1OrYyt+3c6JAW54jycqVSLHh23KW2g
 oG23youmykPt7Vqr6kAHOU9/aweEe8gX3L4dAu8GvmyeQ2s5jNzyrHchpo9AwbKiTTMUgB3Ol
 6JNVoQNlg8O96or/oXDxTo9svf8t4xuwycbIqstjfAIa2QhgVk+sSlkYBBH17jgqGTr1sLNEQ
 ZasXfa3/NrNELrAkZSJ5J2AFFdCYMco7nKyDgKQ7Bde1twLhnRj8QNwCmj//4QNrfumOCNzVc
 VrC+qXRY/Vvp8oPua302rfQesRt9ajAYfoPUwU9OJL7FQV2+1xCfwp+iE+0dNAkck6NDFhCv+
 2jcArLmBhs4mx2RthDbwpVYmAGNUhvHSHnu52m3LEdIISbFyGQiCi1HGWnRr6Xf1Ud05HY2Qm
 K4Xw0ZmSFS+5Y10kosZaYo2syj//WfbyDK5VSG0s4pn0XNHmVxISz5hF+vw7sLBvNZbph7cK0
 b4D1RYmJgvAGAHqqbDzCNYwxU00BftbB2jG+tWPify1ReUT96oZ5TOedaZZKjWOMJ4I2gQ2Hf
 AOhGrNCyQ7QgIC4hXFbngup6woGrxOQLC6B4IXGK7GkVscw9cujYssvkzH9zHcmTiUsm7KXjh
 gjWclTPnIPIbpMTTCpdwegLERfEYtfaKMqD/BdzO5gMuW0/B0Acbu0IHERSsB5hO3Bajy5SI0
 bKdH9LKRw2xLowiu8xS8SsIB03gFdy3/qD9SVmUoHzRYE2mZeCxRG9GwvYPDufranSXlIlEi9
 SF7uBl/iJKZBvOoSMWMc0Zb+A34ofhi24tk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.

Will the current patch review result in adjustments for the SmPL code
in the commit description?


> While we're here, remove braces on if statements that only have one
> statement (manually).

Would you like to reduce manual change efforts any further for the shown
source code transformation approach?

Regards,
Markus
