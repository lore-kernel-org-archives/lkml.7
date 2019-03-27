Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146D72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1/0SjnQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfC0Jv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:51:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40222 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfC0Jv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=C2M7XfpVnaKC6q2LLuPi3SVsBeVZZFaSm3Y/SueYprU=; b=1/0SjnQWJG4xr3FKUKMcNQ/6KT
        oPXUd3KZN3dIQ5YGolaQ8AiHPaQd4PFj+UPBnn0keBmALrhfa7ZdzOMONZX9vMT0eoi14eoU6+Z+X
        t8wKeSS9rEoiglz3I9QRGJODWo+154kj4M5sM+0j4xjNvztgwhyKeO0gw6lQqB6RIEwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h95Do-0005e4-MP; Wed, 27 Mar 2019 10:51:48 +0100
Date:   Wed, 27 Mar 2019 10:51:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/22] ethtool: support for netlink
 notifications
Message-ID: <20190327095148.GE15396@lunn.ch>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
 <20190326163400.GC4958@nanopsycho.orion>
 <20190326181720.GO26076@unicorn.suse.cz>
 <20190327093843.GB6979@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327093843.GB6979@nanopsycho>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:38:43AM +0100, Jiri Pirko wrote:
> Tue, Mar 26, 2019 at 07:17:20PM CET, mkubecek@suse.cz wrote:
> >On Tue, Mar 26, 2019 at 05:34:00PM +0100, Jiri Pirko wrote:
> >> Mon, Mar 25, 2019 at 06:08:18PM CET, mkubecek@suse.cz wrote:
> >> >+void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
> >> >+		    unsigned int cmd, u32 req_mask, const void *data)
> >> >+{
> >> >+	if (unlikely(!ethnl_ok))
> >> 
> >> Why do you need this?
> >
> >If genetlink family registration fails, ethtool_notify() can be still
> >called from other code (e.g. the ethtool ioctl interface). In such case,
> >better bail out right away than fail somewhere later (probably after
> >preparing the message which can't be sent anyway).
> 
> Again, haven't seen this in any other gen netlink implementation. Why do
> they not need it?

Hi Jiri

All other gen netlink kill the machine dead if they cannot register
the socket.

    Andrew
