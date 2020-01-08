Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA3C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BB220882
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578493200;
	bh=V+duQn/VKovNadbJEjkXvzNpkeGqObGQMkiV1LDtHjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XwwfTS42CRdjC3uffUqFp3VKbuIpgiltOHf36ZQ2XG5ghvd3QByZrlrMJkjrAMl5J
	 mW/fgkAZ7yaP3e+3SoQnm+Zip/KqUd6ueS1nI8g41GXp8HyJrsalQH+bPFYbDy15VY
	 WiZIBwjQjruSrEDgjlkd/uHtO9kUa1gLkS84zZWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAHOT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:19:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44646 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:19:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so2698363oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2PhRz0nUJob4vAB21QqyJ21zXO0DDwIbBt2aXu/jUhk=;
        b=LTWJg3c+wnd6GoR7XigcYrtGq3eOZj6UfOCbpSbOJjBSngV6A+J4q5u5iC9aiOXsEK
         KsvBt924zPguUL7buLd2zi+LAVI8ebnR+Ur+eltHCCSgAiSt6SY0xINk8eusT2/BHUt8
         ThSjAEI+qpkkrarn6WxWh69LQsqGfNWrbofplYw7awwj50rYTYLHc5HVwzQCg3iqy69z
         FInrNHiMymiTBUefeZijB53ZcsnC6/Nif9WTDZREGjKVnjT8QyAoLveU/ojbEj0XRocZ
         ha6rdsSed5z0h2SYGaWqlVmBy/gIwfzM2m+bdunx/WSGjQ7/CnVMXOlTDlPsb1cxoLdQ
         I5NQ==
X-Gm-Message-State: APjAAAUXcvI3p0QxbOwOxXNeqrMat3kPT5+kqIMTOHcs5Z54bK7lTgru
        ooUhYyEf39Ho5Ig3ZQm3kNxY3eI=
X-Google-Smtp-Source: APXvYqxg8NdLphx+QjQAf5nsckSp/yjvPhFup5cPPgH80yHdHXbyzOZCp0CWGXrtRfIah2bSiuZXgw==
X-Received: by 2002:aca:cc55:: with SMTP id c82mr2992450oig.165.1578493197736;
        Wed, 08 Jan 2020 06:19:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p16sm1122711otq.79.2020.01.08.06.19.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:19:57 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22001a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 08:19:54 -0600
Date:   Wed, 8 Jan 2020 08:19:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 1/3] dt-bindings: Add vendor prefix for Chrontel, Inc.
Message-ID: <20200108141954.GA4574@bogus>
References: <20191220074914.249281-1-lkundrak@v3.sk>
 <20191220074914.249281-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220074914.249281-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 08:49:12 +0100, Lubomir Rintel wrote:
> 
> Chrontel makes encoders for video displays and perhaps other stuff.
> Their web site is http://www.chrontel.com/.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
