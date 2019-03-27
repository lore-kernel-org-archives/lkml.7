Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A0CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A372070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="icksOHHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VfSH5+0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391939AbfC0S2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:28:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38689 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391727AbfC0S2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:28:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 85CE522007;
        Wed, 27 Mar 2019 14:28:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 27 Mar 2019 14:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=gx/rTPpu7KzA10o0da+DogBTVof
        GyTK+1hUyGMpDE3I=; b=icksOHHN2729BU+W/j9E6S4im0cuRCkf0/SwmExzoSq
        Gg5OY2YGcJ1Imlr9Y2p8ULrMpdsCEkVex/iVYRAQZD2ngZQv7jIwCiMqIUeko4NH
        IjGVKTS4ZXbg/B7oYNWeNQUytGrCS6uf0Zy9oizyIsKF413qx/bBxRORIDZzg/bk
        meQhX4zSEfTWtGxfzfWelahbd5s46ySmHOmRiQZMWVjy1O3rDMbKsyb09HWp9A55
        RMwO2XZZzbCmNqw/QTG9EQRL/uOi8Bw/iHc4205lUabOYrqU/5wLoe8vpTyCVI7v
        eamGGcTClYX4bIDy0ZpZwNbdxEERiYKhlRkvfZiUVFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gx/rTP
        pu7KzA10o0da+DogBTVofGyTK+1hUyGMpDE3I=; b=VfSH5+0IkBl4GpUcLELFjC
        9bO7M7KHh0mz8dB4KMrH4SGZhHYo4DBlpt/53XDvLaxJAkLPNxzDqVq98W3UMv++
        9efu+O7l14mpZ73IdcTws8EQmnbJNhHBEwpzSwB8Oh0zpvLK8Q6SsqEauz4Ex02F
        rCc8sIhgCAtRV73EiPqmxS6KUNU/mnoSKR3fFnD0YZUUzMKoYojuI+QTmvL53Zem
        5g+dOsuuSObNDZ5wL/9Z/0QP5b663bSDTdKnWMoO70oZn79TdpdbWHQ5IAT+NaSx
        wRbFuV84RljYGHwBrLBplzGuyoftxi0vm9wIUYaYKgsjbRTWccTl5tdgbh7FAisA
        ==
X-ME-Sender: <xms:4MCbXNYSVI-qtJ20FkChRVLnXd-8wLupumuzFvHKGfDXw2KDCxXo-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedvgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkph
    epkeekrdduvdekrdektddrvdeffeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghg
    sehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:4MCbXG11ifL3w0T6bHtYGmOT-AoKlzNgD7qxOSSPjA2Y1szEYcAwQg>
    <xmx:4MCbXNrOt5cJXf2ZKnQ3lmHcNDe_BGYMOwGSQhsRhLjq6AIc-BAPAA>
    <xmx:4MCbXKzf-fBlBgndiUtPeRYOMBx3FLZFdRtgrTrF6oXxIPJHlz0Nsg>
    <xmx:4MCbXDoRyQDtGsWRNsuW2hWYbEMg2qVp3uFIUWSEm8lXZyjMPxtueQ>
Received: from localhost (unknown [88.128.80.233])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7DF431031A;
        Wed, 27 Mar 2019 14:28:47 -0400 (EDT)
Date:   Thu, 28 Mar 2019 01:53:17 +0900
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Mariusz Bialonczyk <manio@skyboo.net>
Subject: Re: [PATCH v2] w1: ds2408: reset on output_write retry with readback
Message-ID: <20190327165317.GA3137@kroah.com>
References: <20190318092737.8170-1-manio@skyboo.net>
 <20190318092737.8170-2-manio@skyboo.net>
 <10244730-36A8-4DAC-95E5-AD7BDEA32F43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10244730-36A8-4DAC-95E5-AD7BDEA32F43@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:18:27AM -0400, Jean-Francois Dagenais wrote:
> Originally
> Reported-by: Mariusz Bialonczyk <manio@skyboo.net>

That needs to go down in the signed-off-by area.

Also, please resend this series in a way that I can apply it.  You
didn't say what the order was for the v2 patches.

thanks,

greg k-h
