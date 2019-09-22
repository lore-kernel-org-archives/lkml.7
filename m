Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E798C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 11:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BDD20820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 11:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9tMKkjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfIVL6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 07:58:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42252 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIVL6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 07:58:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so5187185pls.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UGdx2m0S9QvAjbLqOm0Zf2PfBlC/QtEdACG0CQOJwK0=;
        b=R9tMKkjt52lMyoWS0mV74URoW/69+XRJR/oqc5JgX2RQMytKvyXgtNPVnrVJ6I6+l4
         XAvExaZNc0+zJt89nuw5Yap4zuazPHWq72DSxRz9uZpMW7QT9w7zcJkjWqDdgMEF46Rt
         1zSgWRJcTIKS2trbqaMO1b+znvxRvOqGiGFa2jqqY8VDHA2hiIjrUogG+o8DvG5QAOyq
         3X19xaHjkYdu0BeSENHWLLxdaQnZCZJEbEzEuylk0s4kI+HJTGw/vLjZvV/Ro6XGVKlP
         Nz+FixUaWcJDdxhmtXIYM0LAofjpRF8XUNjZ06lZ9NS5dIw9YFWwzAKT8PPqnsGJhpag
         URDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UGdx2m0S9QvAjbLqOm0Zf2PfBlC/QtEdACG0CQOJwK0=;
        b=KATHO+tgvXm4HiT2xllr6uWb/vjJwV3bhph8Oz7BOzQ6M6zAuPxTntzg8IzX93YyCH
         FZz1wmegPNPwtv8u+WJsFYUDybMUZ8CenylLPLYIA/9Lf1rxmuCoi3DBDT9f0JaDmKpR
         Ma9/5AfbdevyUxjWmedISn3ol6C6EmNHOK9A9zNGszESvEayC1wAXXAv3kl4MSxlrubK
         U0dj62ydAmW20pbjsusYzSvdk/GDIPrJCS5nX9t3auOHaNdqcj4UzsDW9PnMETrjVqxV
         oHNiKdd8I+xy/21AJTSDlRTkHq3YWoVKmgfed3VfZpo91049I81w3OIjQzowxJuhl9Gd
         snIg==
X-Gm-Message-State: APjAAAWhPlOi5fm0SsJmw894526ztMZxAZzAslo/vRrE9/il/+oPJaMD
        uhcM2Xz4g71nBxOzeK7W6iaH4g==
X-Google-Smtp-Source: APXvYqyBJW/4SsC7h3u3M+rDEMxUB3WaSWiImps5Ji3MU/V6D0jzqn0+POaMcZjYR3fXKq0Gb7I6ng==
X-Received: by 2002:a17:902:8c8d:: with SMTP id t13mr5502257plo.3.1569153481876;
        Sun, 22 Sep 2019 04:58:01 -0700 (PDT)
Received: from holly.lan ([12.206.46.59])
        by smtp.gmail.com with ESMTPSA id 26sm9198858pjg.21.2019.09.22.04.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 04:58:01 -0700 (PDT)
Date:   Sun, 22 Sep 2019 04:57:58 -0700
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Will Deacon <will@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb
Message-ID: <20190922115758.jbouheoztxkndyvc@holly.lan>
References: <20190920104404.1.I237e68e8825e2d6ac26f8e847f521fe2fcc3705a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920104404.1.I237e68e8825e2d6ac26f8e847f521fe2fcc3705a@changeid>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:44:47AM -0700, Douglas Anderson wrote:
> I'm interested in kdb / kgdb and have sent various fixes over the
> years.  I'd like to get CCed on patches so I can be aware of them and
> also help review.
 
It will be great to have you on board. Actually I was already
contemplating informally pinging you to ask for review some of my clean
ups in the upcoming dev cycle. I'm very happy to make it official
instead!


> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I'll get a PR together for this shortly (busy with travel this week).

In the mean time at least I can offer you a firm:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
