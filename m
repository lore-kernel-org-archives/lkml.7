Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F239C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EE122CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Br2XVbDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfH2Ohp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:37:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40880 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfH2Ohp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gCK1HkDqdyDaXZixXGrAX2dLIZ8vXSbAgDoN62z26bA=; b=Br2XVbDpw6aEsSRl4bc/3081w6
        wIPQVvk/pBq26Uvea11W62nFlT6Viszpg+Joh8hoRRFUhk0+RSzg2w7noy72xtHf6Vmd2cphZvzG7
        /miripZdS0WbMqpg8y3PQrxYmj1OpXur/acxT28n4vhp5nwuyxVfqTmiMdmi7uFJ6ygc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i3LYK-0002lb-AU; Thu, 29 Aug 2019 16:37:32 +0200
Date:   Thu, 29 Aug 2019 16:37:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, allan.nielsen@microchip.com,
        ivecera@redhat.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190829143732.GB17864@lunn.ch>
References: <1567070549-29255-1-git-send-email-horatiu.vultur@microchip.com>
 <1567070549-29255-2-git-send-email-horatiu.vultur@microchip.com>
 <20190829095100.GH2312@nanopsycho>
 <20190829132611.GC6998@lunn.ch>
 <20190829134901.GJ2312@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829134901.GJ2312@nanopsycho>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Wait, I believe there has been some misundestanding. Promisc mode is NOT
> about getting packets to the cpu. It's about setting hw filters in a way
> that no rx packet is dropped.
> 
> If you want to get packets from the hw forwarding dataplane to cpu, you
> should not use promisc mode for that. That would be incorrect.

Hi Jiri

I'm not sure a wireshark/tcpdump/pcap user would agree with you. They
want to see packets on an interface, so they use these tools. The fact
that the interface is a switch interface should not matter. The
switchdev model is that we try to hide away the interface happens to
be on a switch, you can just use it as normal. So why should promisc
mode not work as normal?
 
> If you want to get packets from the hw forwarding dataplane to cpu, you
> should use tc trap action. It is there exactly for this purpose.

Do you really think a wireshark/tcpdump/pcap user should need to use
tc trap for the special case the interface is a switch port? Doesn't that
break the switchdev model?

tc trap is more about fine grained selection of packets. Also, it
seems like trapped packets are not forwarded, which is not what you
would expect from wireshark/tcpdump/pcap.

      Andrew
