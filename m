Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DEFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AD420659
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kellner.me header.i=@kellner.me header.b="UA9NtX4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nxF4Wnpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfJDPWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:22:33 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48655 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389165AbfJDPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:22:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 58C124D02;
        Fri,  4 Oct 2019 11:22:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 04 Oct 2019 11:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kellner.me; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=mesmtp;
         bh=DGg/NPiJuxCMtUzYywJWwJZJ6z11qN/tjEFenTY84II=; b=UA9NtX4FgSGP
        Pji315adIMdVvtMpnYsFe0mfLXx8y7nW+Y95lyHSeApFtRwm6uLbpjGF+0mm0D/D
        D00lns1rvfQ5Z+kbYOf7Lh8PSH8vGAr9tGJNqDvZwLLbCNcS8eJuteMP6VTl2yU6
        Y84B4gFJJGCyyJxkCwlfEoAPrZwuk5Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=DGg/NPiJuxCMtUzYywJWwJZJ6z11qN/tjEFenTY84
        II=; b=nxF4WnpoLW8+3jvKIy8BqoPrMX4YUMKPZLXnbifmyGYej64BQTjet/dQj
        lL3KaVLKkN790I20Ub9Lpiaim6wijDd//T+qdNKX8Pmej2LfT4/uM+gHqF9lMW8A
        HIoXcC+pD7N/m1Z8/qkJeynR/U0NZ1POh62bO19RlWovY9pOvYOSttJ85mZT3MIe
        pbvEgWMV1XjgRfBl3f8t7h+Ly2Ihyt0A/1p3CnInOzLOBK5T3mdMz8GzDGdyx8DC
        LuVt/XJLloNUmWioTiqEQIGNEn1xdUlkTC4AsaTxlTJ2PxNV8LtDoHP1nxsJP7sn
        4q3msIB6ZT+CqXnxBVdIapHF/OWvg==
X-ME-Sender: <xms:tmOXXbc0mQBASt8PgYJZIyIeezr-BCvh6no6Vd8j_4S30Xu2zM_ARQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrhedugdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeevhhhrihhs
    thhirghnucfmvghllhhnvghruceotghhrhhishhtihgrnheskhgvlhhlnhgvrhdrmhgvqe
    enucfkphepkeelrdduiedrudehfedrudelieenucfrrghrrghmpehmrghilhhfrhhomhep
    tghhrhhishhtihgrnheskhgvlhhlnhgvrhdrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:tmOXXavIjENa3FZu_bsC2zU36ialf1z-ezu4Y8pWgDb0HCZmHM-r2g>
    <xmx:tmOXXcOLkFAc_it75QhNrM8-tpoBBE8WVrm_s98N2llbq5WOZq5Dqw>
    <xmx:tmOXXbzHo1gzO8i1C2wsQQeM5pm8XxQWeM2YLVa9p0wiMmxkManIHQ>
    <xmx:t2OXXREUwIILtjextET6QZM_ykFhe4e7O1YXFcBAvJSq6dJz32Da-Q>
Received: from hanada.local (cable-89-16-153-196.cust.telecolumbus.net [89.16.153.196])
        by mail.messagingengine.com (Postfix) with ESMTPA id A52938005A;
        Fri,  4 Oct 2019 11:22:27 -0400 (EDT)
Message-ID: <ec1e06404931e78f91d84f0cd8df9341c9cd74d6.camel@kellner.me>
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
From:   Christian Kellner <christian@kellner.me>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario.Limonciello@dell.com, yehezkelshb@gmail.com,
        linux-usb@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        anthony.wong@canonical.com, linux-kernel@vger.kernel.org
Date:   Fri, 04 Oct 2019 17:22:24 +0200
In-Reply-To: <20191004151621.GL2819@lahna.fi.intel.com>
References: <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
         <20191003080028.GK2819@lahna.fi.intel.com>
         <06a04bff94494da99c5359a7fb645d19@AUSX13MPC105.AMER.DELL.COM>
         <20191004075426.GA2819@lahna.fi.intel.com>
         <CA+CmpXsMkwZhCegGYPYQo2GwN6ROwDYbY3RVZTEeN+FfZ-PbMQ@mail.gmail.com>
         <20191004081951.GD2819@lahna.fi.intel.com>
         <CA+CmpXvoro+m-NZLguMtDq_r_Og8LAFQgPGosvA+WsjMhi6m1Q@mail.gmail.com>
         <332849ed8714496587251b6319a11b0b@AUSX13MPC105.AMER.DELL.COM>
         <20191004142110.GJ2819@lahna.fi.intel.com> <1570201357.2.0@kellner.me>
         <20191004151621.GL2819@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 18:16 +0300, Mika Westerberg wrote:
> > Is there any harm of also having the 'generation' exposed
> > as well? I like the simplicity of the mapping from that value to
> > Thunderbolt/USB4 standard version (e.g. I would show that in
> > 'boltctl
> > list'); 'hw_version' will need a bit more "interpreting".
> 
> If generation is the only thing you need, we can export that now and
> forget hw_version :)
Sounds good to me, that is should indeed be good enough for bolt.


