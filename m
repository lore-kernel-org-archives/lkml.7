Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DDCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E340214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cxYr3lqJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxEmNfoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCLNRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:17:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42639 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbfCLNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:17:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 94431302A;
        Tue, 12 Mar 2019 09:17:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 12 Mar 2019 09:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=iFmDDWv75mX5SIpwHsrd7hwCjTl
        8BOKXmZbSwr3L8es=; b=cxYr3lqJVJEExNN2v+hif2GZR4DeaIt/7SLpnEea7C8
        OKdC9dAIBitnRrUFeXJ23z9jmnkGW7Fh9QfTvzKoDHMUvoxprMe66XmohzvdPmuR
        PvFRlIqAXmpxSMocCVpeA6E4DFQRFysASEgqWvhDUKlzSkggeHWZhBTjFdDrxHT/
        Q4bZFaVVfli9IMX38I7bawnkqyHnmJzht8FXQuRlnqpxL8yqrXkICxhDrjCnTukG
        0G4sZVTUVvsYnzT6O1Mv2n+Xszxrxa+j8C1G9RjinsLgptUwoLWLmo5buXl07/Lu
        noi/ghpNtlZCwD/EZyUT6NywfTF1b1IBMS6ykcPnvzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=iFmDDW
        v75mX5SIpwHsrd7hwCjTl8BOKXmZbSwr3L8es=; b=qxEmNfoir3fHuPaOXyveoM
        syqHXhSa1rxW6sIap/2ioul/bSQPneyL4CLhlFaRPcvJBmkFynsJKc6ZmFPOSimH
        ifT9w2zKYw1gSCRUtHLI2kg2LKTIhqFA1EvLILIFkWaL5wOg9KrjxvCWmxtuNDAg
        68iVGymMdkMB9o2cXHG0GUD3vTc5YRPEQl3KZfKxcBwUg5xLnAteYEt4a28KDU+Z
        TxvebC1fURdf2+i/9n+3mBuRssa7V2M2WaodnJEymJXfd2C4OEAVyNP3oubiHgyu
        pwT7EuuBnbSe2ORBQ8GQ7LITdXn3pR+RvtraetmTmRL7Tr/1nOw8PpJgcsSwiZxw
        ==
X-ME-Sender: <xms:eLGHXB41RY8PT5HdglIxTTnnirBIp7X5mdbwOeih1xFIg-Q5hN240Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeekgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesthdtre
    dttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necukfhppeduvddrvdejrdeihedrvddvudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:eLGHXAeO3_KCAmwSty2wjvEuEDE402jN-qOsE4-wHhvVMgjh5idw_Q>
    <xmx:eLGHXOypCbu9pXjwPi3Crw86xjEWZisWbozEMI4xvdCmK04a3Zrq8g>
    <xmx:eLGHXF-a_RKIDoW3-WQsYuxZcRRFKYC-REWG922f9ISlyLcNIs6eIQ>
    <xmx:ebGHXMLnNuNItXCa_G5xVCDkXb_rV90l1GkfaFOnWLVMwWwGVMBgrg>
Received: from localhost (unknown [12.27.65.221])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C95D10335;
        Tue, 12 Mar 2019 09:17:44 -0400 (EDT)
Date:   Tue, 12 Mar 2019 06:17:43 -0700
From:   Greg KH <greg@kroah.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] drivers: uwb: Kconfig: pedantic cleanups
Message-ID: <20190312131743.GB18103@kroah.com>
References: <20190306192608.GB29080@kroah.com>
 <1551908624-15081-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551908624-15081-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:43:44PM +0100, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so just
> take damp cloth and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

There's no need to put your "what I do" in the signed off by line, this
should just read:
	Signed-off-by: Enrico Weigelt <info@metux.net>

It's obvious from your domain as to who you work for, the only reason
some people put a company name in this line is if they use the same
email address for different companies.  And even then, I don't like it
and it turns out my scripts just ignore it when doing the "who works for
whom" reports :)

So please fix up and resend your patches with this change.

thanks,

greg k-h
