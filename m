Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E6FC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419B0216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SIA99rrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbfI3Nqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:46:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54488 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbfI3Nqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MwogyXtzP30qqSg8Krvf2WUMszyfL/MxA1RY0E6lYWM=; b=SIA99rrSZ7/5jFcId9jm+tB4Ta
        UH0JlYISGTAI1X2cSwOelq1gC/zGtisKMx7hgPzSwnBzVYvMpzUBMr5xNBJgNXXFqLR24WFobTfJK
        g1ZwDhHexUChlsXzFesb/yOdT/6EfuuOjfl5/TQZbrfxKCQfWKBU6R+pziqgbAYtHk8M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iEw0j-0003x0-G5; Mon, 30 Sep 2019 15:46:45 +0200
Date:   Mon, 30 Sep 2019 15:46:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net] net: dsa: qca8k: Use up to 7 ports for all operations
Message-ID: <20190930134645.GD14745@lunn.ch>
References: <1569488357-31415-1-git-send-email-michal.vokac@ysoft.com>
 <07dda3c6-696c-928f-b007-8cda9744b624@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07dda3c6-696c-928f-b007-8cda9744b624@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 03:34:31PM +0200, Michal Vokáč wrote:
> On 26. 09. 19 10:59, Michal Vokáč wrote:
> > The QCA8K family supports up to 7 ports. So use the existing
> > QCA8K_NUM_PORTS define to allocate the switch structure and limit all
> > operations with the switch ports.
> > 
> > This was not an issue until commit 0394a63acfe2 ("net: dsa: enable and
> > disable all ports") disabled all unused ports. Since the unused ports 7-11
> > are outside of the correct register range on this switch some registers
> > were rewritten with invalid content.
> > 
> > Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")
> > Fixes: a0c02161ecfc ("net: dsa: variable number of ports")
> > Fixes: 0394a63acfe2 ("net: dsa: enable and disable all ports")
> > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> 
> More recent patches on the list are getting attention.
> Is this one falling through the cracks?

Probably not, it is missing a review-by, from somebody David trusts.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
