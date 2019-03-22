Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A93C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29C4218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCVIyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:54:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34946 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfCVIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:54:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id d6so1014330eds.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ga7qFmOSSfck85VxLyZbYduGoYdimv/MHPY3tgcfX8=;
        b=chHa4jv0nM01BvlfuriKS98nuODxkAebAI8Ck55ibbive4D7nzTzNzCOjKBCHZcHpc
         TSjelGL8zXvabKZKGcS/Kavjutpmp7tTUOFSUFFoOvibwTJfj40tNCgG9pTFzyjv5nPU
         /72bUhq+6kYjl64hRAowsbp2JuoeBxeKo/HiWQcPpzyQKVcQ9RTflV6IdJ3VD8oR5QB8
         wV6QfFn5cCK02Id1/J0796iTUibhqw7ypmgTYWT/ZOZqk4NjlYARv4190vp3O9UWNqdK
         JN3wuP/kRPd88Esy2UMH+OqFCzPcrNqFwJvgc4QMCCrPEPi6VdlGUsyMRBDmq/1V3Vv6
         s41g==
X-Gm-Message-State: APjAAAUkeQj+Z32k/bFB7UXN3iXB2XHncR476hgM82SIwlzvGtfZU2QN
        ZkYmiNqdhrJZ1X0vDztbU3zPsqv0N04=
X-Google-Smtp-Source: APXvYqxn5+Zl5U7tcGTGB9h/mawjzRuaM9frgqgXlfHVMWRhLlzh8dEL8+rjJrdYoSBwjIQ52aVzeQ==
X-Received: by 2002:aa7:db04:: with SMTP id t4mr5420591eds.173.1553244846051;
        Fri, 22 Mar 2019 01:54:06 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id s49sm2570330edm.34.2019.03.22.01.54.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 01:54:05 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 4so1303716wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:54:05 -0700 (PDT)
X-Received: by 2002:a1c:2394:: with SMTP id j142mr2155161wmj.111.1553244845126;
 Fri, 22 Mar 2019 01:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190318125548.24851-1-maxime.ripard@bootlin.com>
In-Reply-To: <20190318125548.24851-1-maxime.ripard@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 22 Mar 2019 16:53:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v64q5LEPdtk098c-urwUfPfDSoYwZK=WX4x_+CBd6Y2kPQ@mail.gmail.com>
Message-ID: <CAGb2v64q5LEPdtk098c-urwUfPfDSoYwZK=WX4x_+CBd6Y2kPQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: axp20x: Allow the AXP223 to be probed by i2c
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 8:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The AXP223 can be used both using the RSB proprietary bus, or a more
> traditional I2C bus. The RSB is a faster bus and provides more features
> (like some integrity checks on the messages), so it's usually preferrable
> to use it, but since it's proprietary, when we want to use the PMIC in a
> multi-master setup, the i2c might make sense as well.
>
> Let's add that possibility.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
