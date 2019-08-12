Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25763C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF14F20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nz/9gOYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfHLLvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:51:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52857 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfHLLvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:51:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so11887974wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RBO3DRjOTnD2wLqgKm2sOWPkxUiw82Gd++GtZ0/46Pk=;
        b=nz/9gOYBm5f41AVteysD7l24n/Fd0CiOd3001w0L8BtaHes0R2oAL3pINo1E67hDqy
         LYLZYDx2CxxVwMBSRwITxQ7LBANizanIV8XLQDJPMvsJ77m9tES+HS7jSPuaZNNf5zLH
         nJNC3fbaSgk6TIwPbEkvXAR9YMr4uaJGNyujl8nkgLPC2ajuplKaJMLBVMygaRw4mctr
         v9K4EXL7KXzp3RsqZvOuNFZZIBgL3EH8ok18K9QCfbZD0XeauBkGNU8sGb/rdBD+mhii
         VoucQhke9qSJVeBDCh/U7CT6nQl1GGi3bHOV9kBWWjJvjTkOKetcXv8rzrMZAI1jwibq
         JScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RBO3DRjOTnD2wLqgKm2sOWPkxUiw82Gd++GtZ0/46Pk=;
        b=V9CRDhH9SJD1Uxx0HUILkTSQjNn6iNE7ua5CrA9chagJokObVT8CviAGqvKjqw622T
         1NvMlOM5FNBwjtSWxgRTXAxxqUtZeqEk7PYEoGGA1qsQlSJXZmZq7cssKxiTyok+HYyC
         kkDeFin1MF2sq2PNHL9N5FN85+xSabXggqd1TjjFtm+ky575lMeI34331bHAnzac5MlQ
         LKs3i0+4oEaS0GAPdu2t4z2dvoCGTOgLJhcmcy5ODQkw7bHD9kGVb5EeLFkcZhhS+yAj
         vP0UrZMl154yZ+oLDjeGg9d9ksUTYTvlrx6WyXi6jnfrcq3FSx5/5Mbtgv0Z89mEhA6q
         jOAg==
X-Gm-Message-State: APjAAAWI/3gQRQI0vVASPZPtuXqvES5qSJL1qKC1z5XXpJHPBVk3RYqM
        M7Ey5g2eObP2ADX8ibqeSKxt5Q==
X-Google-Smtp-Source: APXvYqwV9aoRqyXcZZQN5vuglpU7Un+RzXUmxodwxoqrNtY4ZzQnftXwr2r3/ozL4duHxbq6J6RM+w==
X-Received: by 2002:a1c:a985:: with SMTP id s127mr26790055wme.163.1565610711038;
        Mon, 12 Aug 2019 04:51:51 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id s64sm22246982wmf.16.2019.08.12.04.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 04:51:50 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:51:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: Re: Re: [PATCH v3 01/10] dt-bindings: add powercontroller
Message-ID: <20190812115148.GT26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-2-frank-w@public-files.de>
 <20190812102035.GH26727@dell>
 <trinity-a6c06411-16d3-40ab-a4fb-3494131c8ed6-1565608221532@3c-app-gmx-bs80>
 <20190812112507.GR26727@dell>
 <trinity-738d59ed-ecac-4025-a729-0888eaea1f95-1565609875829@3c-app-gmx-bs80>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-738d59ed-ecac-4025-a729-0888eaea1f95-1565609875829@3c-app-gmx-bs80>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Frank Wunderlich wrote:

> > Gesendet: Montag, 12. August 2019 um 13:25 Uhr
> > Von: "Lee Jones" <lee.jones@linaro.org>
> > It was an example (hence the "E.g.").
> >
> > You will need to adapt it depending on where the file ends up.
> 
> i saw the e.g., but i wanted to know relative to which directory ;) your example mentions that it should contain the dt-bindings-folder and i think it should be relative to current file...
> 
> have applied your suggestions to my tree
> 
> https://github.com/frank-w/BPI-R2-4.14/commits/5.3-poweroff
> 
> please take a short look if i don't miss anything

Just resubmit them.  Doing off-list reviews is a slippery slope.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
