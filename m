Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF5C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2112077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576088866;
	bh=gHlCBn0ZHH3LHnMqSeDPjmDBICp9tgkzGh4pUIHCkno=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=TrJSIBLYJ7RLLwioJLD7EfG8klh6fYQxm0xpq6aMeS2LkQUAEHEdiITvulE+E/Noz
	 REtVwedeTg33glN0nKz1vRVYvEtvl7531bpj3s1dD05YRBBfaCbw+PDHfymypv2AG9
	 3v+44jbOo5Za0alkGWxIB9K199DMRC2UqqzfECm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfLKS1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:27:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39040 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfLKS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:27:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id v16so20245652edy.6;
        Wed, 11 Dec 2019 10:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ff7CQdMliIKDFZWCzAdUrG86rvuqf7GP0H4SQLsLeJ8=;
        b=r3g2M0sQFfeGY4gsIr9J3WhVNjQbv7Otg+2XlGUBUML2ETTFS6Jg0vbTasWuuIXXY5
         s1j5tGolNK1l7vGhuCylD7roW9TidmAZhKM8z6UAJAcqBvqq6hMLXa0OHei4mFBXS+0L
         +gKvd4QRYwIl7x6223f2WQfGa7sGU1CeyoeYcl8UfagdyGeGF9jWWDSoKjgYsDQT+nL8
         kD6wqj17tj6J+Y+1h8wAR8lYDem3i5sUm0JGvzFfi1SXM+VbtfP864kl+bdK/aPfFgEW
         YKUGzOEQk1ERKcHaCrz/q7TT6FWM3HmRcYFs7gMaNA+dMpQxNrQ76wOQjnQdXFPlFlns
         bqhQ==
X-Gm-Message-State: APjAAAV1LvXu4QlcRXgsUGE8hxVPShfmpuu7gvHDTOp5HKex/cgV/aN3
        tGllvvg7dS3fCdnmmi4toOs=
X-Google-Smtp-Source: APXvYqyJ7PblsCZH6vXzuWl2i8OZSvSR9RTMyV0zfdp9izG/UcT0/mLxk6V7A62vz392qKGcAPOvrg==
X-Received: by 2002:a17:906:a950:: with SMTP id hh16mr4812284ejb.75.1576088862984;
        Wed, 11 Dec 2019 10:27:42 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id x15sm64891edl.48.2019.12.11.10.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 10:27:42 -0800 (PST)
Date:   Wed, 11 Dec 2019 19:27:39 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: samsung: Enable compile test for build
 coverage
Message-ID: <20191211182739.GA6931@kozik-lap>
References: <20191209163937.8156-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209163937.8156-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 05:39:36PM +0100, Krzysztof Kozlowski wrote:
> The Samsung pinctrl drivers require only GPIOLIB and OF for building.
> The should be buildable on all architectures so enable COMPILE_TEST.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pinctrl/samsung/Kconfig | 8 +++++---

Applied both to my tree. I'll send them to you Linus later in pull
request (unless 0-day catches some build failures).

Best regards,
Krzysztof

