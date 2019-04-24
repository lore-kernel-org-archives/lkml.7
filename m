Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6ECC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36314218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="c9yHI+eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfDXBZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:25:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32960 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfDXBZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:25:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so9886852qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 18:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=iEeZgL0VLnAFC2YaL3OKxz1fZYNN/AJX7WfyiHQRd2c=;
        b=c9yHI+eo9azROJYdTqJXAZ12f4+oRqiVSL3JKSjX/2aIvNqkrsd5ZoZd38FU1SKi+b
         Jw+EyoFhKlTRuJzu4xx4Pkxr43qViXxqX9tZqwfb5WGitY7UgvJTWG8IXcFzxV5v/W/+
         EiFCK5TY5YXUiLLHg4MFHMZGFacnIOH6Ccmix7rRyiHrA5ien5jJINTa/TZyYDt9udYd
         oKdEzXrYWC1ArHqVIVt6TOWQdCtHmPJ1WzVCPd3be+Tdyy/nSOC7jS9zZf4DIxLBLAs5
         3ynK4dBy9lXhhTY2a+YFWpgdTawoKsNTpLfTGJ5hGL2RNgAU3waFJ1H7Fh3VOP7oXpIb
         pJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=iEeZgL0VLnAFC2YaL3OKxz1fZYNN/AJX7WfyiHQRd2c=;
        b=cmh9dDtE27hSIBetLsgz3pXOF+p8o4Pq+H961x5NFLnTUsqDP/bFFVCcRtxScblvDU
         Kz0pFKkTqPZNtDdcI+ezAWS6CXIAuzDtgfF5RXaArxUvEz8c6QYwzyTvh83S4Gy3A5Zm
         t84JrLEp73HQz13VG9Dxp4YPuDY3le6ROkSInG2k5OQ/MxCe0ndVWkIPvg64A0AUVfBZ
         Ms2ZLNNae1Hr3OYfIWvaURvaS/WVaP4wb1rFd/H96SWV8YqvR14/3cgYV2K1H01zErpI
         ksn0++BFK7nGjFn1MK7GXYGkQcYmsnPAELwHxp/C3s5JC97oLU6omHZ8/6EFhSLdjMHT
         ysvg==
X-Gm-Message-State: APjAAAUOpFX/ZsnX9ooIipYIjqnOkPIilctGUE/+JsIUv3zMIbprJxxL
        4WaEExlkMbk9u2nDPph1AkQ4mQ==
X-Google-Smtp-Source: APXvYqy9cpqCoo3NZxMDHXid22XhjI0797hHPARLSj3YZXEDWX6Qrtus5svvzsUaaEXAoyvRjfPj1A==
X-Received: by 2002:ae9:e506:: with SMTP id w6mr22900147qkf.167.1556069129964;
        Tue, 23 Apr 2019 18:25:29 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s2sm8275350qkg.67.2019.04.23.18.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 18:25:29 -0700 (PDT)
Date:   Tue, 23 Apr 2019 18:24:50 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Tao Ren <taoren@fb.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Samuel Mendoza-Jonas" <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net 1/2] net: add eth_addr_inc in etherdevice.h
Message-ID: <20190423182450.27b403d3@cakuba.netronome.com>
In-Reply-To: <2b3935f9-fbf9-6baa-570c-dcd6382518c4@fb.com>
References: <20190423224138.1295-1-taoren@fb.com>
        <20190423161502.5d3e9c36@cakuba.netronome.com>
        <2b3935f9-fbf9-6baa-570c-dcd6382518c4@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 00:59:52 +0000, Tao Ren wrote:
> > Please see:  Documentation/doc-guide/kernel-doc.rst
> > 
> > Here we need:
> >  - "()" after function name;
> >  - no extra line between function name and argument description.  
> 
> Thank you for pointing it out (I didn't know the doc-guide). Given I copied the function comment from eth_addr_dec(), I will also fix the format for eth_addr_eth() then.
> 
> BTW, "()" is missing from all the other functions' comment in etherdevice.h, so maybe we should fix that in a separate patch?

Possibly, I'm just trying to make sure the new stuff we add follows the
official guidelines :)  For the old stuff we need to way it with
potential merge conflicts and muddied git history so the case is not as
clear cut.
