Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F5EC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F170621874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EUVRh8HO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wsMAY3t9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfFSO4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:56:54 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37633 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbfFSO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:56:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F113021B82;
        Wed, 19 Jun 2019 10:56:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 19 Jun 2019 10:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=1skUKVQ9bmW3rSJdzRaTjgtPz/f
        qbeFJVQAQli51q/Y=; b=EUVRh8HOgyRCl53y6fMuJmFU4Gz4+OvnCOx1/0H3+7S
        7hVgJVm/tUpP+isCRFgAhVoC24cWx62WQuZyP/5KsJFCIaKLZrYVICaJjVVtceYZ
        aJecnQy+QH+wwTFtjtnUFj3Db1zpsJUdnGQsDnIc8r5c3YCuEEyAiZZK+ek7NzCS
        /5ABf9cqRDyu/BV2X3QNEoNPwMRqVTUyZxtvwZXZee/e5ND/yq8CMpeWpAlbYOYW
        GEwbBYerNK9vq9IVuB4+H/rW8cLeimkWFiToNXDTyAKwdvFqeIl7DA/JTPi1NFYi
        IqyLMHj1a040Uf9XiGsRplS0DXF2QlA5n4/Wma4xWsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1skUKV
        Q9bmW3rSJdzRaTjgtPz/fqbeFJVQAQli51q/Y=; b=wsMAY3t9z9lHchM2EMb/+C
        fCOBdf4dhjWBGfYav+c5IWi65ZuymfKYe+SzMUZMXy8BwIrHtxxfeG5DAwwD9xAf
        D8BJokGh+iA+tLJAKBiD43fmkktHfPbNpPNsMfhoY3URfVxRtrHaw+hF2O2Z8jZZ
        BrI/Ea8oEk5DjO7B8IhMVk/qgzlQkYUribM3xmr0lOJSaz7pOpnEiEuuqZSOWTjO
        p/CYolOYwv+iIZDv0vxAY6GOr1F0junzCbbKuDQvl5QutbIxoLBkeiMHrSylk2qA
        +4hxz3KKneuvKvaB/VL8ztFPlyd/yvOskcxgSCK8MaL/iSwgg3ExBwza30NqTlXg
        ==
X-ME-Sender: <xms:NE0KXWa4OuSHx7IL_lpTSz8cxCbuL0uEhCJHGxEinLpPTGv4wIT2XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtddvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NE0KXem18ohBX3Eaivrul4tgCkaQpzyUFTeekhv0jnopc4HpAFQBgw>
    <xmx:NE0KXR3ISgCFai1n9wmaXzZos5eQHzK6BUzI2HSSGkhss7XTvYHy4A>
    <xmx:NE0KXe2SIHNpDdYKQ7CI8Lh5m-xHikmIbDi63g8ZIp7N21IjTawLFA>
    <xmx:NE0KXf7iO68BA68rcI9LsjNS-0f5TsJWDg99UXc7b_3Iryc_EjzSdg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A78448005C;
        Wed, 19 Jun 2019 10:56:51 -0400 (EDT)
Date:   Wed, 19 Jun 2019 16:56:49 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <20190619145649.GA14207@kroah.com>
References: <20190619164351.6c3f83be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619164351.6c3f83be@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 04:43:51PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> In file included from usr/include/linux/usbdevice_fs.hdrtest.c:1:
> ./usr/include/linux/usbdevice_fs.h:88:2: error: unknown type name 'u8'
>   u8 num_ports;  /* Number of ports the device is connected */
>   ^~
> ./usr/include/linux/usbdevice_fs.h:92:2: error: unknown type name 'u8'
>   u8 ports[7];  /* List of ports on the way from the root  */
>   ^~
> 
> Caused by commit
> 
>   6d101f24f1dd ("USB: add usbfs ioctl to retrieve the connection parameters")
> 
> Presumably exposed by commit
> 
>   b91976b7c0e3 ("kbuild: compile-test UAPI headers to ensure they are self-contained")
> 
> from the kbuild tree.
> 
> I have added this patch for now:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 19 Jun 2019 16:36:16 +1000
> Subject: [PATCH] USB: fix types in uapi include
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/uapi/linux/usbdevice_fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ah, good catch, sorry about that.  Now applied.

greg k-h
