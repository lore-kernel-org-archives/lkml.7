Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 14:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F15420870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 14:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EpZPQGHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfCaOdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 10:33:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44563 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbfCaOdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 10:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tSXTLWkNBwQ+7OxDnCw3ne+xa4SgHozyZ+1qD8tiba0=; b=EpZPQGHBGNDQdLDT5NDCd03FOO
        trleJG4YHqN1dZL8dcnKnsJSueB442TC05tDCcDs2W61Xz/IIEma++ODmgVe69hOvdxxpbXBEV9q7
        vhlIhQAGWcmNiQ13A6xkdAMighyL31qdI5aVtBt6VSTNJu18Aom682lfKcgDqrRi4jmo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hAbWM-0005lI-2G; Sun, 31 Mar 2019 16:33:14 +0200
Date:   Sun, 31 Mar 2019 16:33:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Colin King <colin.king@canonical.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: fix negative loop bound error on for loop
Message-ID: <20190331143314.GA20636@lunn.ch>
References: <20190330214241.15311-1-colin.king@canonical.com>
 <3723042a-88db-fa87-02ec-4ff231bbaff2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3723042a-88db-fa87-02ec-4ff231bbaff2@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 03:25:47PM +0530, Mukesh Ojha wrote:
> 
> On 3/31/2019 3:12 AM, Colin King wrote:
> >From: Colin Ian King <colin.king@canonical.com>
> >
> >Currently the for-loop using an unsigned int for the loop counter
> >which is problematic when comparing it to the signed int count
> >This is an issue because if the signed int is negative then
> >the negative loop bound is implicitly cast to an unsigned int on
> >the comparison to loop counter i and will yield a very large value,
> >eventually causing an error when memmove/memcpy'ing outside the
> >allocated region pointed to by ndata.
> >
> >Fix this by simply making the loop counter i a signed int;
> >
> >Fixes: f2f2356685bc ("net: dsa: move master ethtool code")
> >Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >---
> >  net/dsa/master.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >diff --git a/net/dsa/master.c b/net/dsa/master.c
> >index c58f33931be1..1b659647a303 100644
> >--- a/net/dsa/master.c
> >+++ b/net/dsa/master.c
> >@@ -87,8 +87,7 @@ static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
> >  	struct dsa_switch *ds = cpu_dp->ds;
> >  	int port = cpu_dp->index;
> >  	int len = ETH_GSTRING_LEN;
> >-	int mcount = 0, count;
> >-	unsigned int i;
> >+	int mcount = 0, count, i;
> 
> This looks fine but why the return value checking for the negative will not
> be good here ?
>  count = ds->ops->get_sset_count(ds, port, stringset);

Hi Mukesh

Is there a return value check for negative?

   Andrew
