Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30302C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5BD2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="DMhNanDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfD0Itp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:49:45 -0400
Received: from first.geanix.com ([116.203.34.67]:40390 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfD0Itp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:49:45 -0400
Received: from localhost (87-49-45-205-mobile.dk.customer.tdc.net [87.49.45.205])
        by first.geanix.com (Postfix) with ESMTPSA id A772D308E69;
        Sat, 27 Apr 2019 08:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556354910; bh=P+lqfGPdKGTrQEBdlyEl0qvxu0xLzcNTxZNenDt+Jf8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=DMhNanDlXK+VB1oPHnA3Oyodmn7CBa/vDd7izRiA4f+pY+y2EoXoA3qrFo0n0MwKK
         TMz/1Id+wEw/q6nO4GOLxpplSW18YSTM9jef4W4bukrBQxWIcfB+onbN7wzxTFLW8Z
         mzVqnal3TDFbCQT1f+m1ugQj1nKt1/nDXBz85BDbpzbdqGgpG2L9C6d8rWUnpWB9za
         d0MrysoystTQhrmQCDlSzc6mE+d9QUASg1ZJABv36Me9wC9vSky1kR9TNGT3c2t4+2
         NMePh0PpRz7sNy27o+8b5nmfZAFLBt+n+04hc3gndQUK7JQKje2GN5w0nbXxpB6l9L
         oKsunvIus4tKQ==
From:   Esben Haabendal <esben@geanix.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] net: ll_temac: Fix support for 64-bit platforms
References: <20190426073231.4008-1-esben@geanix.com>
        <20190426073231.4008-4-esben@geanix.com>
        <20190426114013.333e62c8@cakuba.netronome.com>
        <20190426205912.GI4041@lunn.ch>
        <20190426140856.78b786ee@cakuba.netronome.com>
        <20190426220226.GW4041@lunn.ch>
        <20190426153056.6c8f64ba@cakuba.netronome.com>
Date:   Sat, 27 Apr 2019 10:49:42 +0200
In-Reply-To: <20190426153056.6c8f64ba@cakuba.netronome.com> (Jakub Kicinski's
        message of "Fri, 26 Apr 2019 15:30:56 -0700")
Message-ID: <87y33val3t.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <jakub.kicinski@netronome.com> writes:

> Looking closer at the series it kind of looks like a soft IP.

It is a soft IP.

> Esben, is there anything architecture specific here?  Should we perhaps
> drop the dependency on the architectures in patch 6 completely?

No, I don't think there is anything really architecture specific here.
Anything with PCIe should be able to utilize the LL TEMAC soft IP and
use this driver.

I don't mind dropping the architecture dependencies.

/Esben
