Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5C9C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32EE21721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBgHa7BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfGEPZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:25:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50319 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfGEPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:24:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id n9so9481155wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=776FeSmsIvO9BAuOMfeYFd0GoNy4MOugdcwM/WuTqsg=;
        b=PBgHa7BQApvEk3m/50z6wziaw2Yv01CO3uBItHINnz4ARhdSYZX/h/XULODQ7roknM
         NqXltRZuqAO6z2id1WpdesjpwtCY04gypErUOUmV5gKFajMA67bCIZ3vA1AB5OqhuK3N
         HgCHq9gQwesyRZ3Ov/OjAyMct5QUJeHySzX6dhh+f/WPco6uM/3JWEehGRyry/l/1TLL
         wqS2IauQSempUSqAoOw4K9yN+wepHNjVmxhAka9uBfUfOlpSSoqYEFb7Z1CASVzNAc8h
         XPIdkNm2jMJplehxOjzNqY4i4WKqYPR6DDfU3Aj1paFwNKVSAGg8xVdf6eEw3uKDSMOs
         CjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=776FeSmsIvO9BAuOMfeYFd0GoNy4MOugdcwM/WuTqsg=;
        b=a/wObIZ4rZooMy3Z75BKh5YPOaeREqqzWrvDe7AEWR4sg2S3J9LYM/PyC13DmxJ0zm
         3JcT+pDcHQZv/vTOovBWPnpTtwniHFjzSf8Cogx6mKv9V0VeVRtpzmF2/8bl221QUQAF
         1Vx8Qd2/oexWMtQ9uhgk1Omii2mYqmZ7/OhlGKFlCIZpJUwHh7Jf47ewBkXBoQXRK7ei
         SjJGBGeE0ez41TiFzcorc2T3C9Nx96tZj7mTQEu88lLxMh5dPTzffwQMEhpkcwMVgAA5
         +svIYWCirq6VKxkcuTwZFyztfc8YXG1Th82aY/KUdSHaaFLt1AoDY8peRG0hOmJggDPp
         tkvg==
X-Gm-Message-State: APjAAAXLMV0rayQSVtlKmD5uG0iYh3n9pchXmYAVjkDryBiHn/YzZqjJ
        +bWgx7b+HDt1aM7acGE+oMzw1A==
X-Google-Smtp-Source: APXvYqwIn+CAMTXhiaR2OhdbdPqYr3i7rcxaiDbB1iTdnKqBy7Yo87Yv81S7nEiWLwHuACvpF1sKxA==
X-Received: by 2002:a7b:c84c:: with SMTP id c12mr3851618wml.70.1562340297200;
        Fri, 05 Jul 2019 08:24:57 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id c30sm789893wrb.15.2019.07.05.08.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 08:24:56 -0700 (PDT)
Date:   Fri, 5 Jul 2019 18:24:53 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Introducing support for
 Page Pool
Message-ID: <20190705152453.GA24683@apalos>
References: <cover.1562311299.git.joabreu@synopsys.com>
 <384dab52828c4b65596ef4202562a574eed93b91.1562311299.git.joabreu@synopsys.com>
 <20190705132905.GA15433@apalos>
 <BN8PR12MB32666359FABD7D7E55FE4761D3F50@BN8PR12MB3266.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR12MB32666359FABD7D7E55FE4761D3F50@BN8PR12MB3266.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose, 

On Fri, Jul 05, 2019 at 03:21:16PM +0000, Jose Abreu wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> > I think this look ok for now. One request though, on page_pool_free 
> 
> Thanks for the review!
> 
> > A patch currently under review will slightly change that [1] and [2]
> > Can you defer this a bit till that one gets merged?
> > The only thing you'll have to do is respin this and replace page_pool_free()
> > with page_pool_destroy()
> 
> As we are in end of release cycle net-next may close soon so maybe this 
> can be merged and I can send a follow-up patch later if that's okay by 
> you and David ?
Well ideally we'd like to get the change in before the merge window ourselves,
since we dont want to remove->re-add the same function in stable kernels. If
that doesn't go in i am fine fixing it in the next merge window i guess, since
it offers substantial speedups


Thanks
/Ilias
