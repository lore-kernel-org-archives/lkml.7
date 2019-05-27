Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B33C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD9C2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUZnJKYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfE0Glu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:41:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39427 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfE0Glt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:41:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so8533302pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/HzX52OrCnis302RqBSbBUi/NWy6HP0B3xr1wzhcQ8=;
        b=CUZnJKYHgsstejCHuJ8ei2HYYKLEj6wUCY30alqN8VUKo/mCmWo3+L7rVbDMh4sw4q
         v8iwsmxua/Th+KEucyLh5fxqmqztpo0EQxei3XfMhBlVXbzqCzVNGPYjJLVB4+c7WKEJ
         z9reMbZFOLgaEeSKJskbekD8zNRh5HY2IQVAWPLxAipgNQKYzuRHwtGLe2/OmioVhIsD
         Wm/3MWjlxOTkHXHqcmidEofzuXn+A+5lMLve8ymG4CCO5s8FzC/SB5oxPu8hOL7eIUuX
         mejV1fev2pVc6OK2AP2tETcyUAj0YDaJmnetzlZYQLqgLbwDEvkAHz4sJhKAlvsCuUWj
         Cv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/HzX52OrCnis302RqBSbBUi/NWy6HP0B3xr1wzhcQ8=;
        b=WS3WHpkyzvpbq7BEegpoMOlTkSPRrev2fuwycYgAL92JW4p/UB7UzeEWoK728odeMP
         IgQjFW8Z9T38Iff7P5dp1F6HGqzOGAFT+B2pmDUCFeohc4nzxm6otHB/vNMSVcfSAM28
         zE/+tFfz4vVgDtyuz9X53njJyqFgsVIRIDohHkkU2Ynvvke7lW8I+ARzYN+TVUVAPsUz
         UWuAb1lEIxNSCJKSo4qtODLHx+ltq16rtQReeGl9rYofmG0tFhBqqWPVVUtwqODA0POq
         1dZTwJJbXfU6eZDWEUWuERbCO4WUdbUujREB4DZW7yIqTsEa+eqFnT5ORgMznlAuglbc
         tB0A==
X-Gm-Message-State: APjAAAWSOrpHzvKEz3cZfGVJdXA1ZMZom8T4k4Gs/kaiTXc6cAbIlJlt
        DgIXv7w9F7hE9jGWfN3A43M2gA==
X-Google-Smtp-Source: APXvYqwzSNxf5xyNIrcxftAJlxeN28TQ9hDRBQV13SrKOT5EVHqD+LOv/Ty4GqWv18yx1qqkfLgLKw==
X-Received: by 2002:aa7:8dd6:: with SMTP id j22mr70066022pfr.192.1558939309070;
        Sun, 26 May 2019 23:41:49 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s27sm5379775pfd.18.2019.05.26.23.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 23:41:48 -0700 (PDT)
Date:   Mon, 27 May 2019 12:11:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: gpio: Convert Arm PL061 to json-schema
Message-ID: <20190527064146.5rlm2audk6uojdxn@vireshk-i7>
References: <20190514005033.15593-1-robh@kernel.org>
 <CACRpkdZabT3_vjkv0PR+GLC0ZXWzpMxfwJU6O9Y+omKJ=6zCaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZabT3_vjkv0PR+GLC0ZXWzpMxfwJU6O9Y+omKJ=6zCaA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-05-19, 13:38, Linus Walleij wrote:
> On Tue, May 14, 2019 at 2:50 AM Rob Herring <robh@kernel.org> wrote:
> 
> > Convert the Arm PL061 GPIO controller binding to json-schema format.
> >
> > As I'm the author for all but the gpio-ranges line, make the schema dual
> > GPL/BSD license.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Cc: linux-gpio@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Patch applied. As you know I am already a big fan of this scheme.
> 
> > This warns on a few platforms missing clocks, interrupt-controller
> > and/or #interrupt-cells. We could not make those required, but really
> > they should be IMO. OTOH, it's platforms like Spear and Calxeda which
> > aren't too active, so I don't know that we want to fix them.
> 
> What works for you works for me.
> 
> We could add dummy fixed clocks in the DTS files if
> we wanted I suppose. The #interrupt-cells and interrupt-controller
> things we can just fix, but I wonder what the maintainers of these
> platforms are up to? Isn't Calxeda yours, and could Viresh fix
> up the SPEAr?

I checked SPEAr and it is missing interrupt-controller at few places and clocks
everywhere. Missing clocks should be fine as SPEAr doesn't get clocks from DT.

And interrupt-controller can be just added, I don't think there would be any
platform dependent side-affects ?

-- 
viresh
