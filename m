Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC0C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9730220449
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBOwuvT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbfFXQFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:05:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50299 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfFXQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:05:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so13363151wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xouu44fqjlv7JQDT+qbIueXk9S6w+hQkAwhhVNFigiQ=;
        b=rBOwuvT2XaPBwzjuEWGnNam5nqc8sk+jcYFMhnw9L37guSIWOCaPY9fVew+yAckovQ
         36AWptOryF9Hc2VeBPxX2+uyNAjeZp7Zkoa6cHtb50MPIbSKZ5+29vmdv799BNy2lexd
         jEtomRMUtMq/Ha1ahwLGFwGTAR9dHRUF/EFy/cvPo/irf/CNOf35RcuqNkA2CvNbWk5w
         uxYFSBc2+EhCHMF85bloi/3GqxI7dmtr2JC0/LpInOBW6BQs+nGXedCzCFr3vfAxMONa
         t6MnjSvuLR2z9LSMZGktm4rPITdUOhQ265lru5ZVg3Y/aEtsoTDO9UsrFrdTYk8plvdK
         amdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xouu44fqjlv7JQDT+qbIueXk9S6w+hQkAwhhVNFigiQ=;
        b=GpzxCHK4uw4KBXtakYJ4HKgSQHRygamz/WjbRsxHKGN+DHvROIEal9zZwv6GsERsQn
         2HCDcTNAA0rd67YMd8nsdc4T0Roq4d4Pm1i593cPr2HAaX4iC1jG7c+qfa7UKwb5qOYV
         +U2vR1oUnlI/QmXnQwPAeCzFP25o4/jcHJXr2tk/549vA/S2tf30fan0C0M2GbCsA6Zy
         oUpAXCWujU2rf9XAgUWUk8BI3rRW91y54ZY1G0k7TPWTBuJqe1eS0Erx4MxKdc+fHwgs
         kLxPelxT+Ds50AoO5zzHbLlAA+GGvPbWWZOg6xAWYFAONmW9SLx5vWnZR/bTAdoRNZly
         hFwQ==
X-Gm-Message-State: APjAAAVliZLOqHrX4OZiRQT0IXorBAIVPElOpYut1pZAENQSdbOgMOGx
        Q0WB0eriu4tV1rLkYBdwo5ESI8ErBE4=
X-Google-Smtp-Source: APXvYqz1LwStXFafT6XoFqGlXha3P3A2v96+uUg6eeEc7Fvxuy8sIer+WwACTkL4bekJe0CfcvlHnw==
X-Received: by 2002:a1c:c6:: with SMTP id 189mr8028605wma.112.1561392322852;
        Mon, 24 Jun 2019 09:05:22 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id f190sm4296255wmg.13.2019.06.24.09.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 09:05:22 -0700 (PDT)
Date:   Mon, 24 Jun 2019 17:05:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MAINAINERS: Swap words in INTEL PMIC MULTIFUNCTION
 DEVICE DRIVERS
Message-ID: <20190624160520.GA21119@dell>
References: <20190211105710.37800-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211105710.37800-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Andy Shevchenko wrote:

> Swap PMIC and MULTIFUNCTION words in the title to:
> - show that this is about Intel PMICs
> - keep MAINTAINERS properly sorted
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
