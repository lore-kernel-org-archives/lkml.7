Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA77C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6F52071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOZ61pA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfKZBXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:23:45 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:38492 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 20:23:44 -0500
Received: by mail-qk1-f171.google.com with SMTP id e2so14711305qkn.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 17:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsDRk4EAML9Y4QvMYiS6ndyIoyHisqLZs8klfxC7Kas=;
        b=UOZ61pA+asCGex6uSWl3urkfZd9i0Q8+XGw4W2qdom7jSVsEQzUNTSu8Z1RMwHChs1
         PCaLOzYuIZHseBv2x4Hz0cjO6qShOiWPNSCJ92/BGCCEdZ95xlithNLjOG/WZCnxkX5A
         WHTrH50+23kjz0ckchWblfzz5qC76xnwgLOQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsDRk4EAML9Y4QvMYiS6ndyIoyHisqLZs8klfxC7Kas=;
        b=uTvSLe6S4drHLXoSFbSOR2qCmXVMKXgVOPND3wVztihgzoX3qkpTLVGxd+JSK4AoK/
         NMuRXHaF92KVqH7HbI0z+VZMt5uTD/M6WoyNS17wgjV5LMA+x+p51mjnwPvg2oMd6i1Y
         1/0JeYG1Rmj4gKqCiZM0YLPonToPy5joCPzKmbUr/Zok3CTyLcKzSk2D3JQZE5qfFkR9
         uuNp7kR+8+UFtCkOwoopxQx01fRvPGGmSr47uSaeXcGR7d6UHWrQbPC/14ue7jEjv3wL
         5LQYXwwHpSUT++ZrcctQkpWmZFoWJXgz9CsrWbn9B18liVkhpeRO8Ct1j0qLn3w5AwkF
         KDbA==
X-Gm-Message-State: APjAAAUvbVh0mr+1MBY22QpBl6T5WwG/d+dH1OzYab5um4nbDUoXE/fi
        KqVbR5b2YE8XH9dBbfSH/11kje6SN10=
X-Google-Smtp-Source: APXvYqy/Ugnn6j+MQ7R7XIlsPXXFK0I8Xq8bjEbIQ52xfip20A8Chgc/S0ycYlVtU/VDCCkK5Id4Ww==
X-Received: by 2002:a05:620a:13e2:: with SMTP id h2mr29713396qkl.114.1574731423118;
        Mon, 25 Nov 2019 17:23:43 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id n21sm5112977qtn.33.2019.11.25.17.23.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 17:23:42 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id w47so15471229qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 17:23:41 -0800 (PST)
X-Received: by 2002:ac8:53c4:: with SMTP id c4mr18110935qtq.305.1574731421193;
 Mon, 25 Nov 2019 17:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20191113005816.37084-1-briannorris@chromium.org>
 <32422b2d-6cab-3ea2-aca3-3e74d68599a3@gmail.com> <20191123005054.GA116745@google.com>
 <115a9e13-c7ae-a919-b61b-0ea05ed162d7@gmail.com>
In-Reply-To: <115a9e13-c7ae-a919-b61b-0ea05ed162d7@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Nov 2019 17:23:29 -0800
X-Gmail-Original-Message-ID: <CA+ASDXO_-ZZ5iwDMGgaT9Ah3L8P63O2kwYO9Dv8erwQmYXKEGg@mail.gmail.com>
Message-ID: <CA+ASDXO_-ZZ5iwDMGgaT9Ah3L8P63O2kwYO9Dv8erwQmYXKEGg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] r8169: check for valid MAC before clobbering
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Chun-Hao Lin <hau@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 1:59 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Realtek doesn't provide any public datasheets, only very few leaked
> old datasheets are available. Only public source of information is
> the vendor drivers: r8168/r8101/r8125.
> Check the vendor drivers for where they read the MAC from.

Thanks, I looked it up, and IIUC the chips I'm using would fall under
the vendor driver's 'CFG_METHOD_21', which does indeed check the GMAC
registers as a priority. (It's also even worse than the upstream
driver here: although it reads out the active MAC register first, it
doesn't end up using the value and instead just clobbers it, even if
the GMAC value is empty/garbage.)

So I guess the vendor driver "always" failed me in the same way, and
it's just the Coreboot authors who were misinformed. :(

Thanks for the pointers,
Brian
