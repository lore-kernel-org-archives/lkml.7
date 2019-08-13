Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F13420840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GlAYqIwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfHMQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:37:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHMQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wtblw5DMiv8Gnlgn4PWqNZAXZLQLw1HcbIrajbXo5cI=; b=GlAYqIwtKNpISSp5k3r1i6I1Y
        JWBe01rgK6nrrPMh88HfsyzQQH6UWsRAayKbki+T4341plXjyk7cEuQhQyd8iLXX9V1odSoe0YGnE
        Vkp/WCjZPhHZvpebEZTgUVGGg9gZhZfCZkmO2XCkstQV3G0ACQo76QBuyJSs3Ew67SXXtllZmu5cb
        y8ZSKJgAoGL6pEP+Qk+jCfGFbw6gRj1CaJOO8Wwj26S62ufsMTWuEFxmTwNbX0bUItelrxvHpTE7f
        w6FmCxr3lpP6aRlwxrX0sBh9TF8TDnPZ2BDqAix6MLkcPXBDJLGSHmluyQjsmKClRtIvLUzMFiXFR
        pcS25s5gg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZnV-00076Z-Gb; Tue, 13 Aug 2019 16:37:21 +0000
Date:   Tue, 13 Aug 2019 09:37:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] Simplify mtty driver and mdev core
Message-ID: <20190813163721.GA22640@infradead.org>
References: <20190802065905.45239-1-parav@mellanox.com>
 <20190808141255.45236-1-parav@mellanox.com>
 <20190808170247.1fc2c4c4@x1.home>
 <77ffb1f8-e050-fdf5-e306-0a81614f7a88@nvidia.com>
 <AM0PR05MB4866993536C0C8ACEA2F92DBD1D20@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB4866993536C0C8ACEA2F92DBD1D20@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 02:40:02PM +0000, Parav Pandit wrote:
> We need to ask Greg or Linus on the kernel policy on whether an API should exist without in-kernel driver.
> We don't add such API in netdev, rdma and possibly other subsystem.
> Where can we find this mdev driver in-tree?

The clear policy is that we don't keep such symbols around.  Been
there done that only recently again.

The other interesting thing is the amount of code nvidia and partner 
developers have pushed into the kernel tree for exclusive use of their
driver it should be clearly established by now that it is a derived
work, but that is for a different discussion.
