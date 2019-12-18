Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB197C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9808B206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJl6QakG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLRM6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:58:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38700 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLRM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:58:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so1631599lfm.5;
        Wed, 18 Dec 2019 04:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASaJPJBN2HsLsWsnypB+YwvWOZn53+hOnwRBL7yClhA=;
        b=aJl6QakGTEpkgYfnwTBX+EpZvbBbFiD/CQzxwCdrl6X+oh04/Fy9goYwK/q3tYGxOJ
         Rh7b5z/o3O9XOx+eDrGR9vdmWxyYv3kgk4WfinxfEuxO7ackbVes4l8JDaG8jLv2ZgZX
         oOF9PahEj2lX1fgHe+xeXt/6IvibAVwQlUrSAcdeAdNr/oskhIGiqYzEIqVVkHO4zQ4N
         iSod6mBf+IF32cMHkYKDxh2mDCOuI65px4Y/nJ8ohRhsNuCoSUinmLOWICYX4BHnEggO
         ww4ZsEsDnhaGqQ3f766uFnwm9Ju0VG4SqKTLue7Qo6nV+z+EfqWqa2B7UmCnFdbXoiPX
         j6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASaJPJBN2HsLsWsnypB+YwvWOZn53+hOnwRBL7yClhA=;
        b=WneIq+yCa/zJE1t0qH2N/9nIeDhKv864Fi/jCiMYvgBLZ2MR1/HIuAnmHOmD8ZHcxm
         NAYzYe5xk+9RibbGZen+8tzsaUarerE7BFcHTVhTHSqqJcmcfw75At8+BEDiG+qnbYlg
         lO0L7h19K4ueLQ+cJMp3h8pZlsWMQmAgsIcEjBNyzXeGqVjwdRfctnLNee1ocvfjzkvI
         YbcPHfvYiL/G1rDZSR4Bdti87PY4ADVZikD3w2JjjLCtqgCEXSRzRwnS47DCFLdzbC8j
         aNPn+zPjdY6NUG/5xOm2YWLyf1xHhEyS16GE27dL801cCzOCqtj5IxN8mKzAlrQ/eEde
         WNkQ==
X-Gm-Message-State: APjAAAW0ef3NORg3hFlFBtJepOYebl0AhDUHfAS9q+5L4TP1lxs5Apob
        VAqC8AJ1GF/43OPYfRHi+AN41rVFXW5V6uVSZiJF596F
X-Google-Smtp-Source: APXvYqxdBG2m0DRFHWFtNL//RQAZyHCVqNW3CGx4IQTidfrdmSIHPvSAFMLHrzeGQkfOEEiU/OMLRsvyIK8fNwchn1g=
X-Received: by 2002:a19:c648:: with SMTP id w69mr1643668lff.44.1576673882326;
 Wed, 18 Dec 2019 04:58:02 -0800 (PST)
MIME-Version: 1.0
References: <1576672860-14420-1-git-send-email-peng.fan@nxp.com>
 <CAOMZO5DeA24EUjr-E=V=tGNaZ7UkOEi+F5-kEBqEB288DSNSoA@mail.gmail.com> <AM0PR04MB4481B3EAB2DDC42A137E8AAB88530@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481B3EAB2DDC42A137E8AAB88530@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Dec 2019 09:57:57 -0300
Message-ID: <CAOMZO5BK0Pa6Aw6n7Tf+C6+Fg15WNbEUOzKCQTaWqTUu6yoPjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mvebu: armada-37xx: use use platform api
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Dec 18, 2019 at 9:53 AM Peng Fan <peng.fan@nxp.com> wrote:

> Please see:
> https://lkml.org/lkml/2019/12/4/64

Still think it makes things more complicated than simply returning the
error code directly.
