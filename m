Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39551C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBD121655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyKoqtCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfG2VxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:53:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39312 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388937AbfG2VxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:53:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id v85so43109008lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hr9lqY2qIqoidNcb1If245IBNP+0DnlTQyMBCAdK+Ik=;
        b=HyKoqtCfFxuQVsAb5+vFCCMS0YilOQ1m3ow3QG9i/222LTjAwb0dTsHGlPD+wgv5xz
         yxGmG2uQ+GXy8aVfTb8iVnwyvC/tFZrzdYTE/IZ4sxhoD+JyDgZyLo7es1i3GvdlHBsQ
         9KgXU0BH2XWgII/r1JW3XwxEm3xlRUdaD2PMugZ8eAgETdmbyqtgWltBwZADfZ/JOgK8
         KGO+bVSe18/XMctvQdt5o+uFkTKAodeWoduSv9MReky4YEXExt/yAYz8vY8G82yiywnH
         zQxG63/KMWFy9NT3upE0a37RA41t81MOhYrxs1P+JPFnQ5o1xJWIKRx+3guc5NFy4d/Y
         LVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hr9lqY2qIqoidNcb1If245IBNP+0DnlTQyMBCAdK+Ik=;
        b=TIn4xKemmLq8dYaeMZbj2hpx9jKyzk1l6z1PZHSItpu02KnD1qz2Kxd5LonmbzDPWG
         WpeaI82HIicZm/34LzljzirkDw9FeEe0Abwts9L4ZvRtuIN4ENWO8Ld/avsKoj/WGjgQ
         yLxWzGToOh+ARaic1MZRy2mKUBsF6KLnhSHQpbNOJno3ET8x/BKXkZz16HBIrFa1zH+p
         HN0ZFwu0EHEFKeEQfqsY0ZTNt5JTOk46q8MyztW1cqcjv6UFP1CFJvb3erisYDawcOyE
         g/+p2t1ceWviNUaj7pKl1OXd3Q7ajgrdn/9AimxQ6XATQBVO3IvJ52YE6J2gaAEqAR6F
         GO9A==
X-Gm-Message-State: APjAAAUeGRcs/ltgkgQ0dAZjD5i9/XrgN/jQXfOhiljNC9746I/BRfem
        XqrBcMlXUKACKs6j0KkOEtdz/1ze0FemWnehcsXUOA==
X-Google-Smtp-Source: APXvYqxrcwQ2xt2eOrJdooqGsibkSjjLkGu0LUS1zOLSFKz3m+Xi0j4+Rh01BXuTGe2jOXpQKVloomM4o+1wiK44pnk=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr42403912lfp.61.1564437196737;
 Mon, 29 Jul 2019 14:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190724081313.12934-1-andrew@aj.id.au>
In-Reply-To: <20190724081313.12934-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 23:53:04 +0200
Message-ID: <CACRpkdapypySGPrLgSMSNy1fzkca2BfMUGzf3koFWQZ-M5VOvg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: Deprecate g[45]-style compatibles
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:13 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> It's probably best if we push the three patches all through one tree rather
> than fragmenting. Is everyone happy if Joel applies them to the aspeed tree?

If you are sure it will not collide with parallell work in the
pinctrl tree, yes.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

(If it does collide I'd prefer to take the pinctrl patches and fix the
conflicts in my tree.)

Yours,
Linus Walleij
