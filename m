Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8DCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E06C2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Q5W3TctA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4f8i0dd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfC2TrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:47:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52009 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729766AbfC2TrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:47:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D6DC21EF6;
        Fri, 29 Mar 2019 15:47:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 29 Mar 2019 15:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=KUZkqbMOavjGSFogsh72ZmNCQhi
        URfUGj/YR6ZogTxM=; b=Q5W3TctAMMGxmIipAwlo6hK19I7O01PakOMZtS4f3JG
        qUG1Ts06hRbK7sW71AHEHQTRXd3gcxb0xLp59ElnmhxPac/fHjWH9ITizxWp8OSB
        /4Iyb41UH+yaH3+qdg/1NmWcofj3kkw5zNUB/C0+tQn8B5KegpAmG4Gqd8HYfoIh
        mLfrclLl/c3MOBvJycqFHrnhPZ/7/3MPdLqi2KQpbroXB07jMnYjAzA9Tvgqtrzh
        DVDU5j7LzDsd0xjPfgmLPTsaZgNabzkyamHYHIqDoziXSXdMH1CkQCWsei0KFA6v
        FwbS5387i9Ltyf4PVvfhhA9v55Ot0AgkT8DJQ/t8VBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KUZkqb
        MOavjGSFogsh72ZmNCQhiURfUGj/YR6ZogTxM=; b=4f8i0dd873WIA3FgKaoBE8
        N2cD20b97cD8t8rGcmJwjkUTlk8LbQGJvFvgecMqB0s2nv68QsDVHYFF5J1tCALK
        5I6xpEmGgUbuUYpZvzD5xHhP63CCEe8im7JEQ1YFqc8vbOQTZkUQIe254y7/3Cb3
        J+UNDR4NnT+LFNdJllqrTQUphO5YThgMgVrPBFEgSJPW7opcrjxIYIz1+8WjGZJf
        TlhEsVjHbqN2Rtabnbqv4LXL0Bm+yMaj44XBAkXQf/4Bjg1qshVOViAaudB/UoSb
        PjofYNA1P11Y+wjT9jP1vY+fBkvZV6npxMQtFce2MgBZWvsmrnQMIHVJDt+YYH8g
        ==
X-ME-Sender: <xms:SXaeXMQ8uq8ARRIhsuYu9X6VlmojZ4xbyt-e6iV35qyGguetUfePww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkeejgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:SXaeXOaYwpZ5IlGvuzDdM_41DgU87e6hOvE1W7Ud1cHAUys1Y_MUAQ>
    <xmx:SXaeXB9V0ilb6toVwmj6lJ01srTQpwRardh1sJqOwzSXtyot8dh8uw>
    <xmx:SXaeXKImeXXyeVkFrZ-vt986_LvNTyICqrdxwEAmKCoFUmsV7cyYLA>
    <xmx:SnaeXAtKAej87KgsJhrOIB9qUa8hpuoQgFE_r45dP9we0gGtFs6u4g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60C7110390;
        Fri, 29 Mar 2019 15:47:20 -0400 (EDT)
Date:   Fri, 29 Mar 2019 20:47:18 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: Re: linux-next: Fixes tag needs some work in the tty.current tree
Message-ID: <20190329194718.GE12004@kroah.com>
References: <20190328072734.2093d03c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328072734.2093d03c@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:27:34AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   69646d7a3689 ("tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped")
> 
> Fixes tag
> 
>   Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags across more than 1 line.

Is there a script somewhere that I can use to run on my tree before I
push it out, much like I do now for the signed-off-by checks?

thanks,

greg k-h
