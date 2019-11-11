Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9E9C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3062A2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCmCH4ON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKKLod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:44:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37882 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKLod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:44:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so4591927wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 03:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pBYMKGdeC8uxl71BEDu8lTDLVYM52moP2vRHyLhP634=;
        b=tCmCH4ONJBtSz9KrLfPrqlbp5ENanTkQ9MPa6Ot4BeWo7hY9H99dPFyqc2z9D79lvP
         GJ4VcXKtSQQ/jB5R+tmw1JcOjgzoOeqx6x/c1VTFv1z3vTSU/Vh06PxSBPeYyXyoLkq1
         ABCiQBbM8ybqJYcm5S2O8oa+xuraqiN6oOl9Ubao+mI/qNyaZ5p5CGDyppkysz1d7n/z
         4ehlopU/doGFmsr8Z079zaZLxgvTIUeanbw8le0m2Hj4GIUwlTOFv5+JJtNUvTThCg5T
         oDAnpOcLOv8/ZGXLa1YLNcOvBzekfqoidcJW5s/qT4o2Bt+HfZQl20Qr7DAt6Kshv0ez
         C/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pBYMKGdeC8uxl71BEDu8lTDLVYM52moP2vRHyLhP634=;
        b=W6+B0PdX9TNBrPV6pK8qYz+vB6JkMOpkz4blnFq7WsQ83tPKpT+me1NLlQ65VTED32
         GhWqXQnJUvYUR5fnzJ0oVupaoYyzMRQf7RSQwLw6wcE8lU704HOfBHs39PmmQUgvcfTT
         /Hcnff7JzzvCIjpFVypSKiIArI0C5iMpbQrX5IbzRnjPN7ez5OSISsKusmuOti69TciV
         UsgCx9f/NwdidjOFRUzdtWzQBowN6hLNPi5S9lVUVuPiygGM18nmI3fC5P/AWfW2i2+E
         D2Tp7tTULaw6xagq4ocsRdHso2GWna0dJtzXjdtoffrc5AtANXoc/dmJnsYT1tq/52D6
         /Mjg==
X-Gm-Message-State: APjAAAWG6g/olBEtROHx4Z/5ZLz6p7ftxENXma+8YTgIsKm4pCH2MGpY
        DXmC3JpYOmkAszUEdn2PFbTFTA==
X-Google-Smtp-Source: APXvYqy3cV3J5+lGnGuLIWLtIACVWtH8IVzsbXMXLJ4UquBRUy44658weOkpodyltvzp44m/Zo1PXw==
X-Received: by 2002:a1c:a791:: with SMTP id q139mr19589497wme.155.1573472670996;
        Mon, 11 Nov 2019 03:44:30 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id q15sm6929500wrs.91.2019.11.11.03.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:44:30 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:44:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 01/17] mfd: cros_ec: Add sensor_count and make
 check_features public
Message-ID: <20191111114423.GN3218@dell>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-2-gwendal@chromium.org>
 <CAFqH_50q7y-sL0SyA3BDkZ9_YBX_FL90smtXt7v0Z+BW8nrw3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_50q7y-sL0SyA3BDkZ9_YBX_FL90smtXt7v0Z+BW8nrw3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Nov 2019, Enric Balletbo Serra wrote:

> Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dt., 5 de
> nov. 2019 a les 23:28:
> >
> > Add a new function to return the number of MEMS sensors available in a
> > ChromeOS Embedded Controller.
> > It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> > registers to find out.
> >
> > Also, make check_features public as it can be useful for other drivers
> > to know what the Embedded Controller supports.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> 
> Version 3 was acked and I think we can maintain his ack, so:
> 
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Also,
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Lee, how you would like to handle this? I think will be safe for
> patches 1/2/3 go through the platform-chrome tree without an immutable
> branch. Patch 3 thought still needs and Ack from you if is fine.

Please take the entire set, converting:

  s/Acked-for-MFD-by/Acked-by/

... and send me a pull-request to an immutable branch.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
