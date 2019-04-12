Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B653FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EA721872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555053180;
	bh=cUDRUvfw7fqVRmcYqiL+aO4CkbjdbUW/EnMoZrGCRKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dib+3ZyH6plU0vpSmdDygCNxX/Lc/oe+Xhwm0TuxGu5vSWL5yp6T+cGsOdgc1uXGN
	 2dISClsBuaTYEJnWFCQWhPuIga1kFoYJqUd+oawp0Iljynw/62mbDU18fuBIIlwQ9/
	 a6711g67NFGTxxAuJTuyVl0J33YMc2t3M7QOkg2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfDLHM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfDLHM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:12:59 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFF52082E;
        Fri, 12 Apr 2019 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555053178;
        bh=cUDRUvfw7fqVRmcYqiL+aO4CkbjdbUW/EnMoZrGCRKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G9/FVv217tAuNqtbpbaTOBZaQpwd/0V7RuiAQiQ4WEZkd7Bc51pHJv2J6nsilGeeh
         HkjHEfovD9WgX8kP1SshShu4xDNuttLcAILrGo03AqFzGpRxwrS5WApkGpOuxwdvI3
         RG3KTC9tKHCBRVGGRHh+YpLdBwBokUfYJoz8exBE=
Received: by mail-lj1-f175.google.com with SMTP id f23so7911079ljc.0;
        Fri, 12 Apr 2019 00:12:58 -0700 (PDT)
X-Gm-Message-State: APjAAAXSPkf4SQNoUp3E7REnY2kj+0LuE1IkVgSFMfVofzKwnKPCcnrE
        Moto6zsvsUzfN4WwrMbcvON2NQZayS280DtsQnM=
X-Google-Smtp-Source: APXvYqwTYS4RZuVj1M9zJZDlRcWM6wI7KyzDvtMWmb2a/4VN/zH8TB799yS4hwjDjLybX0IBvUd66BW0Gf7qlrulH5g=
X-Received: by 2002:a2e:74f:: with SMTP id i15mr23842825ljd.156.1555053176438;
 Fri, 12 Apr 2019 00:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn> <1555048943-39589-5-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1555048943-39589-5-git-send-email-wen.yang99@zte.com.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 12 Apr 2019 09:12:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd3A102=S+U57-tQLPpBw=8j4f0t0-LP7SOp-47jXavMA@mail.gmail.com>
Message-ID: <CAJKOXPd3A102=S+U57-tQLPpBw=8j4f0t0-LP7SOp-47jXavMA@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: samsung: fix leaked of_node references
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 at 08:01, Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./drivers/pinctrl/samsung/pinctrl-exynos-arm.c:76:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
> ./drivers/pinctrl/samsung/pinctrl-exynos-arm.c:82:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
