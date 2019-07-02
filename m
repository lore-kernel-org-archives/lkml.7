Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47658C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1752621479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W7O7NVqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfGBAJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:09:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36570 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfGBAJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:09:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so6762355pgg.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyYPV1zUp1CDzG3zhADVpKBs/ZxT7Kh02i96xmC7Rzw=;
        b=W7O7NVqRWTH+/d8jYL+xWrHVdDh7+iMMhrdj/CimFwLUj9u8d+I1G+RiUUz91+wZmY
         yArB3xj4AodjJ1YfRkoQAvTNTLUnJebDkjTlaYYgYECQPEeFp+zj+twi6j+nSOkla+RS
         +qA8Ld4iDfCHNEOUElJsEyIsqsn0+iaprUD/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyYPV1zUp1CDzG3zhADVpKBs/ZxT7Kh02i96xmC7Rzw=;
        b=Ov5lSj+euQhOSMk2ZSB72BXf//8HEey4jL/WIaM3Q//4rV97e61PZj/cCUwgtAXEfG
         TYs9YabCosDRSA8tO1GqZ6yP5fmRpYYCEz8vu8SdqrmS5791hHs57UIcUJ23/+QnJYDn
         89FYC2AjX3Y51lX/vXptjoLbpMNhNfixP1euzB/VP2qWKmbvGxg/0kbH3nqK3BH9aK0J
         0mo2CbLh/0QPxN/OvZioJl4wjjEYBXoEZjN0EiV8R8Bj27RHPPL0tIm+ylCuNQ/wF8bX
         HYl8h7YLutpGMzhgWPOvipAjagkkqnl+lP0ipNNkRbAzulH1XqlZ3+eGepwTqUBpMMPC
         8rQw==
X-Gm-Message-State: APjAAAXZ8/mQ6UNOwOlLgbLMq3JMkdqLk6AFApaVDbyKx5PA8hlb1LIF
        w2oti6cC6D2gx9l7LHdTqdDXww==
X-Google-Smtp-Source: APXvYqyPWuqQHIRJfCr/5/k9c5oSj6FIo9l4K3WY/UJBi8hfz5Yorr+fBinMFTC68NlS9NqK4/2amw==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr2155165pji.136.1562026167563;
        Mon, 01 Jul 2019 17:09:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 23sm13701301pfn.176.2019.07.01.17.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 17:09:26 -0700 (PDT)
Date:   Mon, 1 Jul 2019 17:09:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] net: phy: realtek: Enable accessing RTL8211E
 extension pages
Message-ID: <20190702000925.GD250418@google.com>
References: <20190701195225.120808-1-mka@chromium.org>
 <20190701195225.120808-2-mka@chromium.org>
 <20190701200248.GJ30468@lunn.ch>
 <35db1bff-f48e-5372-06b7-3140cb7cbb71@gmail.com>
 <20190701210902.GL30468@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701210902.GL30468@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:09:02PM +0200, Andrew Lunn wrote:
> On Mon, Jul 01, 2019 at 10:37:16PM +0200, Heiner Kallweit wrote:
> > On 01.07.2019 22:02, Andrew Lunn wrote:
> > > On Mon, Jul 01, 2019 at 12:52:24PM -0700, Matthias Kaehlcke wrote:
> > >> The RTL8211E has extension pages, which can be accessed after
> > >> selecting a page through a custom method. Add a function to
> > >> modify bits in a register of an extension page and a few
> > >> helpers for dealing with ext pages.
> > >>
> > >> rtl8211e_modify_ext_paged() and rtl821e_restore_page() are
> > >> inspired by their counterparts phy_modify_paged() and
> > >> phy_restore_page().
> > > 
> > > Hi Matthias
> > > 
> > > While an extended page is selected, what happens to the normal
> > > registers in the range 0-0x1c? Are they still accessible?
> > > 
> > AFAIK: no
> 
> This it would be better to make use of the core paged access support,
> so that locking is done correctly.

Do I understand correctly that this would involve assigning
.read/write_page and use phy_select_page() and phy_restore_page()?

Besides the benefit of locking this would also result in less code and
we could get rid of the custom _restore_page().
