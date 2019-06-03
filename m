Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAE9C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C5827DED
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoWqRLOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfFCJDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:03:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46380 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfFCJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:03:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so5894561wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=a1mkYyCrc83Bv+zphH07Gxd4PhX3LAFjUYuUVnAFGYo=;
        b=OoWqRLOmDPj+mmfUzNKkgrBa1E+ijOzEbzhu5ES63kGonC2+w9C1xHgRl/W/MdjyQB
         XvMHc6AXeQAWOTbVT/oaZZbrxXorwdeM0quSC7VEcxmcTCzlEQuLSQhGSuCN45Xmhg8L
         mopTvWxvFVt3zkhzxu5H7sueSAJbCkGw1bV5LDHrhRQ/YfjMA769es6a8zMwL4CaCz76
         ZZc/5mEUvw1ERXRow49PggplOBB2aNF8nD62x69CfjFidi48YDz4zimyI86UkfgnE+My
         8JFoqUi2uW/FG7o0zbMX6h9FzVfeyzo4xeoBPWFNHnF/ZA/Okb3uMRVygXWjYM6CxnH3
         QXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a1mkYyCrc83Bv+zphH07Gxd4PhX3LAFjUYuUVnAFGYo=;
        b=kjmwx4fRe2/MjiFEi1OjvyJ2Tcy4Nwfrm+ix9DSkPWVF4gwnWI0JPJHhmRBj4bkrTV
         BFL/nGT+qiWPn6PPEf+7P6SuVc0y7DEGhn0hD98LHnst1pR2dDZFvQhCEchiNzAVb2LO
         u7X7QgDgssymj+E9O1r20GJmxNNfBc9JgXUrS9LyB3Rf1mXn29rtZKSbLn70cHShu6SI
         yTLlMsRcFezzaJYOEVBrtAGuRtwHBOuikdVnjWgg4B2HvhG6JHWSBQk2aSytTmyolaxO
         VX9rNRbIqNtx9kzB6I9350Fqbc9HLiHhKQWfW1+a2bXvxnaRdAOTXVJcMRzKE++IsPhI
         bZMw==
X-Gm-Message-State: APjAAAVkeBfAdNWiKbgQxguHtmDq6XayNrhm2st5FmovOKf8KoaX57ZF
        sZJdnq01+ulRFoGFZUmGXDj0JA==
X-Google-Smtp-Source: APXvYqwFDCLsbQ/QRNN1gOWGbULHl5E+WHYuirmI65LmDirQ7atTzHodX99UNEbk9EtG2HUCL/9C0w==
X-Received: by 2002:adf:9cd0:: with SMTP id h16mr1539930wre.211.1559552600653;
        Mon, 03 Jun 2019 02:03:20 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 65sm28726567wro.85.2019.06.03.02.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 02:03:20 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:03:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: Re: [PATCH 2/3] mfd: lp87565: Add support for 4-phase lp87561
 combination
Message-ID: <20190603090318.GI4797@dell>
References: <20190515100848.19560-1-j-keerthy@ti.com>
 <20190515100848.19560-3-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515100848.19560-3-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019, Keerthy wrote:

> Add support for 4-phase lp87561 combination.
> 
> Data Sheet: https://www.ti.com/lit/ds/symlink/lp87561-q1.pdf
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/lp87565.c       | 4 ++++
>  include/linux/mfd/lp87565.h | 2 ++
>  2 files changed, 6 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
