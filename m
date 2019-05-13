Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4950C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8577C208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPF1vTnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfEMISm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:18:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35100 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEMISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:18:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id c17so1010376lfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzxwE8OQ4c7+4wEW/7vEZjPCoKsrHHZVrP6UrqcgUq8=;
        b=lPF1vTnBMNpymRG5DbEK0NzzXAE+TMQiKGra5kWmoyz3HpQm9RgsvReFi0MuP86mIj
         35LTG7Jyt0nLrVE6XdU3VSNbZQWhWhamTAjEap78MbhILeb/xamCmS1Wl8le+QtSY7gL
         qLyh0mTouyPO60I5AKsHeSkPOibLDX2krDMQdUPXiJj99R3UBa/yOxKj/T2+TeoGHTfN
         3oAzBWCCE/rR+XLYbBfax9yDTPvJxG3HMBHCPRjVfCfq0rBud0DnegVN+z6WFuk+P/uu
         rH/Gf+0nKLn2ibgIvA/eeL9wKmettrcgy1vXFlAzhnYc5SMZNiXZDGm78/3cPx0tT0I4
         82IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzxwE8OQ4c7+4wEW/7vEZjPCoKsrHHZVrP6UrqcgUq8=;
        b=CNdBG+nD6jxVN6beTPDN+M5r+TkQt6VYn7yNa55adBL3ikhSZ3K85e62ZUd/FW8BAW
         VqJOfdAszXPchPRqdm2pgw4rkNBrgzNEdjfZK04C6kM1N6qoCRLFm14owKedpvB2O2tE
         POq9UdYA0/F4/0aV13Mbj415DAZbgxQ74JRpjhpye9fSGxdz7PiP+Z1cE0Yf726RHvyi
         I3NlDry0ofE6x4kUcSaCAqlIgfFInf1iPfQX7PHdpI4i11EN+5uzGIdbNhmigDCwn+yP
         NFod2Cita0u+hKPjy5KrZCMwCfbSznB14SZMVbzF3bzT/DGW0O6czLgLQB1mBnAftG+8
         buhw==
X-Gm-Message-State: APjAAAV8OOvlD5ocjj+wdZU5Uz7FAMNGLnw8aqd3eqYlDG+8UUR2DZ4K
        hG71vYqLpbaFMPKtTwTS0vsRPQSUiwK8jwViFQm0Mw==
X-Google-Smtp-Source: APXvYqyx/wAotvOY/06DClsed491rPyWm4VfXj0EqhU44I2W5fFspfxbUvJjecxNVuFkMZjsZJlpFg37jwMlH2NySYM=
X-Received: by 2002:a19:ed12:: with SMTP id y18mr12598314lfy.130.1557735520224;
 Mon, 13 May 2019 01:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190513073429.12023-1-lee.jones@linaro.org> <20190513073429.12023-2-lee.jones@linaro.org>
In-Reply-To: <20190513073429.12023-2-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 May 2019 10:18:28 +0200
Message-ID: <CACRpkdasb1ARQeFzDujZgBgBG0Ti0vnSp3gGKdYMT-RbDAFkjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: stmfx: Fix 'warn: bitwise AND condition is
 false here'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 9:34 AM Lee Jones <lee.jones@linaro.org> wrote:

> drivers/pinctrl/pinctrl-stmfx.c:441 stmfx_pinctrl_irq_set_type() warn: bitwise AND condition is false here
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
