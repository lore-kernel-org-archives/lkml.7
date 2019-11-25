Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A9C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 01:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC67C2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 01:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0CMZZSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfKYBV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:21:28 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39591 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfKYBV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 20:21:28 -0500
Received: by mail-yw1-f68.google.com with SMTP id d80so4855878ywa.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 17:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YyJ1VR1edEPFGr7f1Rvpj3bxfKGaJt/XzYaaditupjE=;
        b=L0CMZZSNKy4EC3zHjWVVtEtzScdrqbEarwGtYrD/wzZo43TPeKPLRknHDO888u07nK
         FB4NbaSETotNJ+pm4ifFjJXL57SrVCkuVSA+0jO5JW1mJLviGDl3ZlABZ8QaA/kc6J67
         gV0jXe230C3aVGgC4YaXQbBViQ1VsHUMWBSHPpC9z22yqyvZaV/IgsstM8v0XlCYjMnl
         7wh89Xxh3UL+vkN9qdtKwI9sPSlpWIy2arSQiZNuqG69QB3Ej0j9Wx+hLtLSr9Hz4Kw3
         qH6CBVskxyjAMfHspXnhdW5NMov9oJZnrDqJd2PDUAqS8a+JAhYsyW4CSq8G462jIZYu
         S2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YyJ1VR1edEPFGr7f1Rvpj3bxfKGaJt/XzYaaditupjE=;
        b=lcs9zVMiCTz1Vd1Gm4X/GzdHqp8yr36ZP8JBmV2OepmkytNI3Yt9db6okh1ZwNLQSx
         yI4zeQcWb9JRDyo6pnxAq16dP/kd1Bv/zswLeAug4OT64PnccKMSBivz/C83+uIFKG2e
         mnPbSMuJl5+vyaq94tNmsiGaEAZWHF00EZ9axy+CWWR6n+41XS6qOwde3Q2LkjunxmfH
         BR0aBfWZzTwrJR1PLHyHTXhzXwlmN4lqnYccEqzus6f9gudP7w/kEqoej0LZa+rALqWv
         tTaftqB2mssOawWMPrVXDvaEyRTw3IIa0OuQatlvhBK+mS11F18K7teE3cpqRhu/+U78
         oqXA==
X-Gm-Message-State: APjAAAXGbF/EXcI2L4ixj5jpkTSZikQsrbk/fHVWi6h2ZvCUO+wKcUB5
        3UcL5yRmZxHXvA06vy4X4OouhA==
X-Google-Smtp-Source: APXvYqzvTeM7VZxhefQxQflut8iI1Dd7/df/CtPUfTacT0Piue1SPIhfmuYsOuOmjX2cP9jsVuNdKg==
X-Received: by 2002:a81:53c2:: with SMTP id h185mr18749895ywb.113.1574644887312;
        Sun, 24 Nov 2019 17:21:27 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li2093-158.members.linode.com. [172.105.159.158])
        by smtp.gmail.com with ESMTPSA id y77sm2893809ywg.75.2019.11.24.17.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Nov 2019 17:21:26 -0800 (PST)
Date:   Mon, 25 Nov 2019 09:21:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tty: serial: msm_serial: Fix lockup for sysrq and
 oops
Message-ID: <20191125012119.GA15822@leoy-ThinkPad-X240s>
References: <20191124154334.15366-1-leo.yan@linaro.org>
 <CAOCk7NoWR4cFepACH_r=tmZ+bX6uXsM4HWNr5uvm6CoRdQTw-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCk7NoWR4cFepACH_r=tmZ+bX6uXsM4HWNr5uvm6CoRdQTw-w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

On Sun, Nov 24, 2019 at 04:00:21PM -0700, Jeffrey Hugo wrote:
> On Sun, Nov 24, 2019 at 8:44 AM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > As the commit 677fe555cbfb ("serial: imx: Fix recursive locking bug")
> > has mentioned the uart driver might cause recursive locking between
> > normal printing and the kernel debugging facilities (e.g. sysrq and
> > oops).  In the commit it gave out suggestion for fixing recursive
> > locking issue: "The solution is to avoid locking in the sysrq case
> > and trylock in the oops_in_progress case."
> >
> > This patch follows the suggestion (also used the exactly same code with
> > other serial drivers, e.g. amba-pl011.c) to fix the recursive locking
> > issue, this can avoid stuck caused by deadlock and print out log for
> > sysrq and oops.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Shouldn't this patch have a Fixes tag?

Will add fixes tag in next spin.

> Was there a cover letter?

Okay, I will add cover letter for patch set v2.

Thanks for reviewing!
Leo
