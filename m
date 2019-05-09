Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C3EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FB820675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="uomjopXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfEIRoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:44:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35604 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfEIRoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:44:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id a39so2689430qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KjRnhmT+ofw1ihG6SycN5lJ13JxUfKm8g8u5Be8I8Jo=;
        b=uomjopXeSyPp4+goRblIzyFYhPJ4zmqIOy56TpYceJvIpwT+rnmxd9HvpB/krKNKfs
         Sv7vRlWipz1gRLd4JQSrQFlGcHUymmpXxVsvz8AQOolH3GZZWnO3JYdrKy67o49WarrQ
         j4PlArhgDzW2JME7TDKzTzj8yQgigREEUYs8uQgrylFHubqZEHi308YKXKyY4vlwMCO9
         eaUAcAiekxEjD1foayuBNpnqmn/N/xLyJ/P6bBXntqUh5Qw7XmgGERmrA1DojqAvclNR
         GQ7ZtGL2bAgKWPMfYfGqIGGiE0vM3hia6lZzus1/oSZQzlX2Y+u9lrSolLW9HTrNbL31
         ObVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KjRnhmT+ofw1ihG6SycN5lJ13JxUfKm8g8u5Be8I8Jo=;
        b=E/Py3UxZLAyrK6HRAX+8PK8juLlAQXoThEy80Pm8iVoXjHTEW5pjB9bJXQBvPCDBZo
         b072woV1S7jKqPkUkSzAVc9oyalAhnB0MlNItxxlEO68lPLRZLkqIJFxH2UsDZnjtJbJ
         PW4c4TxCiIbEIneH7ssDveX9xIsD884WFqanFBCI0JxP32VbAUuPKIuPz4X1HbttZxKP
         3/4xFcvlQ5Ux8VYTTANpS0S9vct9N4xKfhoO7B0mRRpbULA5fBxj1YUHtu2hGCQvhF01
         yVtRzfxLsCNQu34dhEXxVDfUuuvrwuPK5NGtEuJCZnLRBrXBJRM1tkT57Sr0a2VpTMuJ
         9B+A==
X-Gm-Message-State: APjAAAWL+dX34RxpX7YW8mb2cg5zZcquNQH4cSSPELE6MFVTvMNgMasS
        lz4x0OILLpTF3+A4HXIC+w1CLUucUt0=
X-Google-Smtp-Source: APXvYqy8pkXWNSmKg05Fcgu3sFtOScfyZSiZFqRa0Emtapg8Z3/pjH8icrBXOqxj9qzj8Kyny9y/AQ==
X-Received: by 2002:ac8:2aa4:: with SMTP id b33mr5014097qta.127.1557423856714;
        Thu, 09 May 2019 10:44:16 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k65sm1545538qkc.79.2019.05.09.10.44.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 10:44:16 -0700 (PDT)
Date:   Thu, 9 May 2019 10:44:03 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: mvpp2: cls: Add missing NETIF_F_NTUPLE flag
Message-ID: <20190509104403.64c9c45b@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20190509071408.23eae42a@bootlin.com>
References: <20190507123635.17782-1-maxime.chevallier@bootlin.com>
        <20190507102803.09fcb56c@cakuba.hsd1.ca.comcast.net>
        <20190509071408.23eae42a@bootlin.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 07:14:08 +0200, Maxime Chevallier wrote:
> Hello Jakub, David,
> 
> On Tue, 7 May 2019 10:28:03 -0700
> Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> 
> >> -	if (mvpp22_rss_is_supported())
> >> +	if (mvpp22_rss_is_supported()) {
> >>  		dev->hw_features |= NETIF_F_RXHASH;
> >> +		dev->features |= NETIF_F_NTUPLE;    
> >
> >Hm, why not in hw_features?  
> 
> Because as of today, there's nothing implemented to disable
> classification offload in the driver, so the feature can't be toggled.
> 
> Is this an issue ? Sorry if I'm doing this wrong, but I didn't see any
> indication that this feature has to be host-writeable.

No I don't think it's an issue, I was expecting you'd flush all the
filters when feature is disabled (remove them entirely), I didn't
expect that to be too hard.

> I can make so that it's toggle-able, but it's not as straightforward as
> we would think, since the classifier is also used for RSS (so, we can't
> just disable the classifier as a whole, we would have to invalidate
> each registered flow).

Ack, I don't think disabling the hardware components is required.
Just remove the existing filters, and don't allow new ones.  
But no strong feelings here, feel free to repost with:

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

if flushing the filters is too much hassle.
