Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D0C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D840321738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW+DzFqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfDESjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:39:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbfDESjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:39:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so7787358wmi.0;
        Fri, 05 Apr 2019 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=mnvm+9lesrHyZqhSf2DoFjOXCqh3DHNocnRafDoBvnU=;
        b=fW+DzFqFbD0upjz5OkgEDADjshaXIn/BqDQfjGmGCp0SyMyNq+tUgh1wDQOQQJOCAv
         ux5g8dkXO1zIXUoYYPvYXWM4PcldnpGN4qZnGDK1fimCYWf4O0QWDPNa+l43Sg3SeFRp
         vSSxUk49v7w6uFirCi69WEk9bkSUiqHH2nSAqcI2VAznXYI3fsrnv6Cw2QZT2cpHonxf
         ocCqGdPdmGzAS/9cLCyfXo3bO2U6zilGt6h01b0CWidL+mShhd53LNE45cEokGdfutlW
         iH6wDl5q8kYPoUL8ITA5Aa+Yv8nWJePWTwduUQsnnH8EVDyZhvwg9jU2JU+9cfgTloxd
         9CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=mnvm+9lesrHyZqhSf2DoFjOXCqh3DHNocnRafDoBvnU=;
        b=iVnI2Eq5BspUtHNv3cWAgmggRAg9pGeJxwRJQsVp2ZRzmoOUJK+1zyU5Y44Yf3ieBz
         hSyQTmcUj5OPtvCjxEHAacdHg7bmsvhzsxucRzgvI+6Vm6tW3qdqhQ9bF3gX3NgiGnAl
         D23uxyd/qlU8h31Ls9JTfBU9xoo5esKMGaMJshMyWkBfnITQ6c2BUVaBeQMPabRrh69G
         HxwU7yYhKM4f3V6JD4IsVhvvHNXShNMmTObGI44ZwQoz+H6b1A4p7qCfUh8wi4bLIbBk
         PzRvnuSU1+ShpkjxunFFEeveP4ATBL3/ldJi2lrfHug+3sVodBW0Buf05gfuCdKk8Rta
         fQtg==
X-Gm-Message-State: APjAAAXfUz9ltdOdGk/1gxJ7j6sBU82Pu8KWZrVAlRAScVwqpDlfu3au
        GTRPtNxXUNi+s/KR0ZEoZaU=
X-Google-Smtp-Source: APXvYqzd32h1p6+liIpTJLGKdw02MqhYo0FSBEMYzOa7UyDUwduaaOWFBxvy9zOJLHzHpX2uhTHdRA==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr9086912wme.91.1554489542281;
        Fri, 05 Apr 2019 11:39:02 -0700 (PDT)
Received: from X555LD ([2a02:85f:510:b900:9cd8:5174:23da:3e1d])
        by smtp.gmail.com with ESMTPSA id z13sm30968302wrw.36.2019.04.05.11.38.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 11:39:01 -0700 (PDT)
Date:   Fri, 05 Apr 2019 21:38:57 +0300
From:   "Leonidas P. Papadakos" <papadakospan@gmail.com>
Subject: Re: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>,
        Christoph =?iso-8859-1?q?M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Message-Id: <1554489537.1199.0@gmail.com>
In-Reply-To: <85c1d945-d49b-3350-6ff4-a058c5a8c1d7@arm.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
        <1554305721.1328.0@gmail.com> <1554306954.1328.1@gmail.com>
        <c863f88a-65e2-4093-7cc1-f37e4443b871@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B44985F@DE02WEMBXB.internal.synopsys.com>
        <1554488052.1193.1@gmail.com> <85c1d945-d49b-3350-6ff4-a058c5a8c1d7@arm.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> What's your overall setup? So far with my RK3328 box I've found that 
> with an IPv4 link and an MTU of 2000 I have to dial PBL right down to 
> 1 or 2 (with no-pbl-x8 as well) to prevent Tx stalling, and with the 
> MTU bumped up to 3000 it just won't play at any PBL setting...
> 
> Robin.

I'm using a Libre Computer Renegade with RK3328 SoC(maybe it's a board 
specific thing?)
I'm using txpbl as from what I can gather, the rx has no issues, no 
need to change it.

When it comes to rx,
running the server (iperf3 -s) on the Renegade and iperf3 -c 
<renegade_ip> on my laptop,
I get about 940 Mbps. It's always been like that, satisfactory.

When it comes to tx (the one all the fuss is about)
I eventually find that just with snps,txpbl = <0x21>, and no other pbl 
thing set I get about 905 Mbps on average sent to my laptop, now 
running the iperf3 server.

I must say I haven't touched the MTUs but I never needed to as the 
issue presented itself in normal usage. Simple iperf tests will fail 
after same kilobytes if no tweaks are applied.


