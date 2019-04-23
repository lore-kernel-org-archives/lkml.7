Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B62C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742422175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGXluoZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfDWKev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:34:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39632 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:34:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id d12so11338123lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qm/layQEeNMZON1puf4iHr3x7Hf24MoU7f4K04cY4mo=;
        b=dGXluoZ8Y0po0bHsIoAYNRLARfjayexlOIYdVe64eoSQDZzm91h1ctzH7DtMMw3aIW
         9dzUT1tiLq6V32i+D+9lUhH8G1wSnU4cUmK8ni7ylo2Q2RWbXeoqM4IncAVzwYBk/IcN
         B82V5eTWyvV4DIpXaakXk+/FB/PBZJMr9mvbk+BFF1umHlo8f5nUMJ5NPQPrf80C5MEn
         wZ2ZQ16L3dyUVXR1vMI0t9u0eSe0XBaBATGgpBwtE66Pa1Aj1ikYiiWB3DR+wrqEmJ+2
         gfMTOTiSBwwEQ5MRtKCKQKuDYmZFYC7I0SgZ9gNp7Kf8k4QyPJQD3FOJs8ZPNttypOyX
         /4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qm/layQEeNMZON1puf4iHr3x7Hf24MoU7f4K04cY4mo=;
        b=OHgTXPlo1SPTxILCj38uu+gLQpEyYNcsMW9FmtZHnpFLsSMBWj8mJyRpmbVXzLV5rt
         3+FttPOA1SUueo8tYXNR2ZBq/H4WvW77wLXEXt5teYciR+JCKlByHUNo7hRqxSEpSkw+
         Jji5HnbiwtSCkogS0w7F96zPayI7H44dOItjM5H3unKOvzx8DNw5Y+Jw51Tj9o8y2vNJ
         zn6B38EVPqR+9CK5j4eLWtcZoBEBq4X6RIBEtZUzXekN0P0JKFcr3gQaF+jCit+BFwCc
         rB/WI/TJ+NClMuuMfZSAud2cxiljHa9QX9V9X1eiMr3hWHFPfgJBfScxJZ1AHuNCNcNj
         z7qw==
X-Gm-Message-State: APjAAAU0daMngCIOAdJRPsmRR4NbSj+09H94yFJXFYOMa4iB/G453WLV
        tTXQZk41RC/px3UdbYchdqqCZ5WbHMwqKDFibqi//Q==
X-Google-Smtp-Source: APXvYqwnVGfA3zPp34Tb8mKsWHVGRaFVPi+OtbgUJo6G58rl/IpcUblV9KavxSBU35cxkDldSKHTcHQ2Hu/SRw8G0Ew=
X-Received: by 2002:ac2:4647:: with SMTP id s7mr13098149lfo.168.1556015688504;
 Tue, 23 Apr 2019 03:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn> <1555048943-39589-2-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1555048943-39589-2-git-send-email-wen.yang99@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:34:37 +0200
Message-ID: <CACRpkdaC8rK8CA9QPmmWwEu8UGrfAgxUw73TVUBsj69YKsj0xA@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: pistachio: fix leaked of_node references
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wang.yi59@zte.com.cn,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 8:01 AM Wen Yang <wen.yang99@zte.com.cn> wrote:

> The call to of_get_child_by_name returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./drivers/pinctrl/pinctrl-pistachio.c:1422:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1360, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Patch applied.

Yours,
Linus Walleij
