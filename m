Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8ECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E9B21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="EYQtMpA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfJWNV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:21:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34214 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbfJWNV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:21:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so21105011lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tmx5gEhg/rV15X62Y7TZ1CogrmbBsOoHsWDyD7ZEELM=;
        b=EYQtMpA57tbRW2i4nVgg8fEUUiSniwZ4tVsaPAjqV3Cq1fcyb92kXhh+xAYwJsowf0
         QBVHcFpoiyAblEAT+06FrDcnHhyHx7XzYYmuASb68k3puobXIn/6YhJQl1PdnsnmXuwX
         VfghGmoxyB2tWhyTrb8v9iyBfb72ZPN7v5keo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tmx5gEhg/rV15X62Y7TZ1CogrmbBsOoHsWDyD7ZEELM=;
        b=VqKRw8Js3JIsnBNwgzhMZ19hi491MH38GbkNXWcFHg68Cm/FWiT+lFh8YwFMK53ruH
         4GglUH0UjyU+PmPLv91Cg+l1zPRYf4klZ5Ezx+Mjo4j4Ooa3waas3x+ghdNM7LQ6OPPQ
         htLS1picihOAWqjpqOyPU+3Km9aZakqlCDC/lhLLVBZ9WPWZwM4xM773Wz0/GiqQ3bsj
         pEw72tUx5olbt7x4ff3D81uDfk29Okd+0AcOiMEL0cjKPE/QEGzlXByet1sAlUIy6Lm4
         r0cD3kb10goJgNZtAkEmOlz4iQEf/kItH0LbCjr6ZceFWx1tAXk/YgKnE+PuluantTiR
         CJuw==
X-Gm-Message-State: APjAAAUoLv6xV1mwe0QsERQ1gqeGq5/RVe21JdhqOHzNeQZIt3trKB8C
        rXbdnHrD7BDkIn85yr0W+ZYWvg==
X-Google-Smtp-Source: APXvYqxovozIKcFB/iwVUR0Jq4TIkN06naNvK43Tktje8kUYfpkVfLxHu1Iax9zW7MeG3W34+OAn7A==
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr22257044ljk.17.1571836884568;
        Wed, 23 Oct 2019 06:21:24 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t8sm9289994lfc.80.2019.10.23.06.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 06:21:24 -0700 (PDT)
Subject: Re: [PATCH v4] string-choice: add yesno(), onoff(),
 enableddisabled(), plural() helpers
To:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Vishal Kulkarni <vishal@chelsio.com>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>
References: <20191023131308.9420-1-jani.nikula@intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ab199f9a-844b-47e5-b643-2bf35316d5ef@rasmusvillemoes.dk>
Date:   Wed, 23 Oct 2019 15:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023131308.9420-1-jani.nikula@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2019 15.13, Jani Nikula wrote:
> The kernel has plenty of ternary operators to choose between constant
> strings, such as condition ? "yes" : "no", as well as value == 1 ? "" :
> "s":
> 
> 
> v4: Massaged commit message about space savings to make it less fluffy
> based on Rasmus' feedback.

Thanks, it looks good to me. FWIW,

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

