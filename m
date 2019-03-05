Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B424AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BE620684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="umHSlhFe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PutSnnGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCEBOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:14:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35013 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfCEBOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:14:16 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B3B023147;
        Mon,  4 Mar 2019 20:14:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Mar 2019 20:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=J8YnpTjRuGYpJgQexk+hQ0iDOgd
        CxTXkbcFcUambKyg=; b=umHSlhFeibCUEbMNf/UB4x2lb7YEdIGeJAoLHPdjYkk
        D0LHxmG359+gW6De8ZK95Bd7t3QlgcgGTq3xBTM47wJ5t6/UOgmPXSeEipwOV1MN
        gNIZ3o3lrKxmSAF/CnMLgS8PkA7p0QCWxI/Hr0t/JME57s0jGAApJpjf2YSq9xvz
        pzjnecchkpBw1zsulJW1p+BmAewL5CPl0bX9yN/2ouzisOG/o4MX8gLBYaZSPSCF
        53jQNwbiZNQy4wPxfdCVwqF6yYwDNeykt8Df9O9Y12DD6fodZ7EgGUW+jWjDFCWZ
        2xprTZUDhzxyKeEkdzFStuvwpqqypALiljcxIH7P4fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=J8YnpT
        jRuGYpJgQexk+hQ0iDOgdCxTXkbcFcUambKyg=; b=PutSnnGh7kfPBi7Tpp5Ezu
        4llMSGaj7SlzStLBInsTt2IuSThJU0MTOHkPoTbFR6FEaLAcWlicqHbLNqPrVw4U
        VXw34iteri19bjHRXkrrXCczbSMv2gWBzgnRyO5ZsIOSoDOFEtfXURz1805bZiLs
        T7kyLrKiTUwQT7hQ+W/+6bLVTiG66SDjnsO6pQt11agXgkkBpOmjxJdT2R5RGHjE
        l/0MaSCbmKZoJcn82bfl783lPl7mtEIcZUsl5iSl4lVFdUgsKlsNtRkFMdIvZaot
        i2M23sM19u64ralEaSlCS7SlmNTLS5fyi7cUAeJM/VudupBXL1/pdTpKlJE9Zdyg
        ==
X-ME-Sender: <xms:Z819XHtYKoxokvFg5VPpBhuQq7rwdGZwEjATQP2xTpwPZ9XGvFyTaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhepfffhvf
    fukfhfgggtuggjofgfsehttdertdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfj
    rghrughinhhgfdcuoehmvgesthhosghinhdrtggtqeenucfkphepuddvgedrudeiledrtd
    drudegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Z819XEe43CHoQzsl47Dm-ReBqkWE_dwdSpfqXm6oegUxfYUUj3zVaQ>
    <xmx:Z819XNYDskwUQSGwN049hIOLWlvsjXwPnTpt7bCqRkiboAfpDLZj-g>
    <xmx:Z819XEaux-XW3ftRcKSzvsR9WuDARfrM-aOUbdw-udG66xI7R7c1CQ>
    <xmx:aM19XAI3oTOdi_rtZtdv0DXrHDTz91qb4T8Wov4Jtd-UqX2N4mxYuA>
Received: from localhost (124-169-0-14.dyn.iinet.net.au [124.169.0.14])
        by mail.messagingengine.com (Postfix) with ESMTPA id BDE4BE44A5;
        Mon,  4 Mar 2019 20:14:14 -0500 (EST)
Date:   Tue, 5 Mar 2019 12:13:55 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Subject: Re: make modules_install install is failing
Message-ID: <20190305011355.GA10576@eros.localdomain>
References: <20190205060053.GA309@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205060053.GA309@bharath12345-Inspiron-5559>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:30:53AM +0530, Bharath Vedartham wrote:
> Hi all,
> 
> I am unable to execute make modules_install install. 
> I get the following error:

Could you show the complete commands you are trying please

thanks,
Tobin.
