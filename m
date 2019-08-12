Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A9C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4082087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2iYir3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHLHZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:25:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38180 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHLHZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:25:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so6771982wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jm5iipipw1gULEoeYJWUMHjSpuH+2bpNG8qdwuJcTSU=;
        b=E2iYir3yzyJNS4Eeu09uGq4X8fI/AKNv0/W6WcOcsWKqY697iZLF5/v+6vFnWv0dxh
         gcsrEYaM87fUHxUKlqglLGU9ofrDR9ARp0abzEDIqbPL4Z6OaAAIKUS4dqpYGsUkEGTr
         LItZG10byqS8NxdrnRB8MJ4tePtWFSnayl1xNe5sv10bBxDhcDuzw+TGzkd9XSX0lF+R
         TcU2GAMHUAU1krKPYWIr5xH/ZJrFAFNLDFZ+ItO3XFMYY7jfWKJ0fmRN4n718C6SKDxZ
         ZHXrbWYk70RVWJBszg4DbpUQsz3rN4l10XLLaoMDayu+eqy/1cFqM9b/Vz6faHPkTFY4
         rGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jm5iipipw1gULEoeYJWUMHjSpuH+2bpNG8qdwuJcTSU=;
        b=DM2+qpRr+2eROsEsshigJzjMfUStBuVg+m4gIw0dGez3ohUIvA1crrmTF/vVTD+MJg
         G7mE8bKmJ7DBiuKiBz9asa/vUFfEtTQSnWO9SpWgc5SUBmOFODipId1Uhmgj3apXlp8b
         QxqD0xR2+ThtwyDlXEyg6+VQe+OwJIwCJmrEh0ODzvLLTwWhwhFxPl7gF8gvS5xgv6QB
         zd2Ya/tj4SZAQ1qqCNLhUtZOn2Ale7BhafScvBPlUB/09JDaGphbZ2EMe2TBdJAtrI/q
         oGd4+tpG28uns+DJs16wBXGyHmmxZrJUAHzqPzub7J1jfAu9U3zw3duN+CHPxWAbeBer
         vFTg==
X-Gm-Message-State: APjAAAXe1RONQRhMGEggQAOpnvq4RmcHkcwCcjkJtdMT0t89GXeQvi3S
        fEtZUI6fAi0ZsETr3ZHSMpy+3A==
X-Google-Smtp-Source: APXvYqzsMPYnkG292d11ro16pQUDhDT0nlW45rZFbdUEq7iZviU6CufVVlxzf/HdEiOl9rE3KO6fgw==
X-Received: by 2002:a7b:c5c3:: with SMTP id n3mr26161265wmk.101.1565594704593;
        Mon, 12 Aug 2019 00:25:04 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id z25sm2351507wml.5.2019.08.12.00.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:25:04 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:25:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 04/11] mfd: cros_ec: Switch to use the new
 cros-ec-chardev driver
Message-ID: <20190812072502.GH4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-5-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> With the purpose of remove the things that far extends the bounds of
> what a MFD was designed to do, instantiate the new platform misc
> cros-ec-chardev driver and get rid of all the unneeded code. After this
> patch the misc chardev driver is a sub-device of the MFD, and all the
> new file operations should be implemented there.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mfd/cros_ec_dev.c   | 219 +-----------------------------------
>  include/linux/mfd/cros_ec.h |   2 -
>  2 files changed, 5 insertions(+), 216 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
