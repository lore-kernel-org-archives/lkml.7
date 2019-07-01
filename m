Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D474C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5B32064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjoJbGBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGAVcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:32:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43635 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfGAVcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:32:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so7165172pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0X5jiAvybtGT/loYYHyiQvKoV7rqikrQaBhLQSGbp8=;
        b=jjoJbGBa9GzeNgQ3WKQDcqFI3qHbmDaSRISWXWi5agU39APN5qW/NevphRSzkpKX2K
         LW8ntAaMTXlZgX9NTCrRCgjUyTd4lEDag+fWRV7IHVSxIIsNBbo7GspgUQNh+U0UpBO0
         gt5zy8Ym4peEewD43T2gz6Gy0WIlf/jYhN3ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0X5jiAvybtGT/loYYHyiQvKoV7rqikrQaBhLQSGbp8=;
        b=Qhhk71P/qcG4eCkjUR0kVKGerJdK9D/ZTbMo13nQsPnnLzNT9AHNTcdhnPoCVxkpsQ
         3X5TA0+T/I7cpz7bnpT3E0ytY4a36cyMC34/+aY7V6NIpK5rSxDuGqOR0pj+u9CxsyjV
         l9xv1Z+NREdyI9FJSk3+Z+YS2Id0FRK8bNloWCfZA3kh+Tl8RP5JZLUV365GrXRuDcKG
         xF6rY4SjaF9dhFy7ybk+E/kJ8gj2X2HNKwFv91dW1qwjsjgvz74CR3V5YI0pWuPrqFSx
         tnAwd8T70UBokgl52Hrbkk9/aLdoyGSb8Dul4v4Basc4aKpTnnTPwKRTwk2gbsKYkRKL
         +ZHQ==
X-Gm-Message-State: APjAAAWpVtt+zmYm2oHh3ahYI9eFNkcKG/iUA4m+OYQ8LNDgn4X1MFlz
        pQkbzJx6toW5iwgV6KHqIikN1Q==
X-Google-Smtp-Source: APXvYqwkzkzcV9PbHxj/QnYdd5yERCuo0JSsX2rAk8NaM2SJlwiKj/eA3KncDCGFLbDSAnHU0k+Kkw==
X-Received: by 2002:a17:90a:b78b:: with SMTP id m11mr1548372pjr.106.1562016758601;
        Mon, 01 Jul 2019 14:32:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q19sm13254119pfc.62.2019.07.01.14.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 14:32:38 -0700 (PDT)
Date:   Mon, 1 Jul 2019 14:32:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] net: phy: realtek: Enable accessing RTL8211E
 extension pages
Message-ID: <20190701213236.GB250418@google.com>
References: <20190701195225.120808-1-mka@chromium.org>
 <20190701195225.120808-2-mka@chromium.org>
 <d2386f7d-b4bc-d983-1b83-cc2aa4aec38b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2386f7d-b4bc-d983-1b83-cc2aa4aec38b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:43:12PM +0200, Heiner Kallweit wrote:
> On 01.07.2019 21:52, Matthias Kaehlcke wrote:
> > The RTL8211E has extension pages, which can be accessed after
> > selecting a page through a custom method. Add a function to
> > modify bits in a register of an extension page and a few
> > helpers for dealing with ext pages.
> > 
> > rtl8211e_modify_ext_paged() and rtl821e_restore_page() are
> > inspired by their counterparts phy_modify_paged() and
> > phy_restore_page().
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > This code might be applicable to other Realtek PHYs, but I don't
> > have access to the datasheets to confirm it, so for now it's just
> > for the RTL8211E.
> > 
> This extended page mechanism exists on a number of older Realtek
> PHY's. For most extended pages however Realtek releases no public
> documentation.
> Considering that we use these helpers in one place only,  I don't
> really see a need for them.

I see it as self-documenting code, that may be reused, rather than
inline code with comments.

In any case I'm looking into another patch that would write registers
on extented pages rather than doing a modify, if that materializes I
think we would want the helpers.
