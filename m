Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30AC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFC92070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZu9tlVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCDM3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:29:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36835 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCDM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:29:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id v10so4159953lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 04:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgxOZP+dFQBUPmSEDR9WfH52m7XyQaNgMzlC/Q0birs=;
        b=hZu9tlVv49i8EUfictk3sxX9NSdfhxtF6JwpGqTjGVCtqDrBsnLl3ParhWyXQzWgg8
         8LwN9FvowN3pgbMWVla1VDGTGvtb7Pal8paz4s0+1Yt8gP3jkYfJx24Pk0847kC2kOcY
         OKi5N6vLYqMdXXfd/euYJJjBuLw3OymL0hvvLa8isn9xyILlCIhef8rJ6zoFDEgbCm5W
         Dj3XpBaakqkvkQQXl3y0to7P1YHLA44pEq1TPQFc6y+Hta6oDaNha7PWGSYVlyqkpmh+
         J54b471LNq8ZwKYehc4//UffGvfVZFw8IEMo4GW+Cy/yoNVlgrvm0+cjKtynfQ+ig0+S
         rkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgxOZP+dFQBUPmSEDR9WfH52m7XyQaNgMzlC/Q0birs=;
        b=L4M9IPOhPVgLogqwCWpmxBZ8/j2LKZvZO5GBtFFCSGReN7dJf/s+cmFymqukADSUif
         fsNqZogMT9+DsaBqocTbOPSF+cz26CwZFIZc0oDr7yCYSMgBYuofcqRMdzj3iF7IICEw
         kvlSE2KKfKYDXXGhOkK+HhAzI/TjQBEn8Suq2IvXRL9GjFi3j8PSp9ijbYuE724en2sj
         C0ODcbNVLacSW5aUhDAvpQvOvfxHVwCPhaAJ4n3WVa0P+uI1IKEuXggJDfCYWQrSQdh3
         DCWkXLSK+kJhpiRA9iLP/t3P+V2WKC1m+HwHu5UmAAkPQYFzEQYWEl7NyRfjFRUWhLPt
         WsUQ==
X-Gm-Message-State: APjAAAUymbpKBpRkvsayJlrbmh9g08r3l5RHRnjhvF3d3VUbW51aDBTH
        P2eWrXIu9fq+56yuHSiKQrf4smT0B2HbNDvgU55oSA==
X-Google-Smtp-Source: APXvYqyRCcxE5/JHDMK7y8Rs7CXj1wxJ3SX/WwI4wHVUkEXfmNIrUVn4FdFrzzky24sHnlYZuHrfdhcCxPaq9L8v4oo=
X-Received: by 2002:a2e:9217:: with SMTP id k23mr512827ljg.159.1551702585121;
 Mon, 04 Mar 2019 04:29:45 -0800 (PST)
MIME-Version: 1.0
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn> <20190301155523.GA1915@Mani-XPS-13-9360>
In-Reply-To: <20190301155523.GA1915@Mani-XPS-13-9360>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Mar 2019 13:29:33 +0100
Message-ID: <CACRpkdb=E9_rm4_7DQV3dS5uOs1gozxEwN9MtWr0tTwmjcYe=A@mail.gmail.com>
Subject: Re: [PATCH 01/15] ARM: actions: fix a leaked reference by
 addingmissing of_node_put
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        avifishman70@gmail.com, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Xu Wei <xuwei5@hisilicon.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>, wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 4:55 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Hi Wen,
>
> On Fri, Mar 01, 2019 at 04:56:42PM +0800, Wen Yang wrote:
> > The call to of_get_next_child returns a node pointer with refcount
> > incremented thus it must be explicitly decremented after the last
> > usage.
> >
> > Detected by coccinelle with the following warnings:
> > ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
> > ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
> > ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.
> >
>
> We have a floating patch for this:
> https://www.spinics.net/lists/arm-kernel/msg694544.html
>
> Andreas: Can you please take a second look at the patchset submitted by Linus
> Walleij and Russel for simplifying the Actions startup code?

Andreas wrote a version of simplifying secondary startup in the
same spirit as Russell's patches, and it's merged and all
is fine I think.

If this patch applied on top of the current upstream code I'd say
just forget about my patch and merge Wen's patch instead.

Yours,
Linus Walleij
