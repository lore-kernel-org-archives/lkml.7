Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBF5C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE36218B0
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KcUUMxUr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FwEcrlj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404169AbfHBI20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:28:26 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:59267 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404153AbfHBI2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:28:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C7AC5381;
        Fri,  2 Aug 2019 04:28:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Aug 2019 04:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=lXKpENl8wyg6SU2P0UYyhWDjFJG
        fkJ1PSJo5X7cF/QQ=; b=KcUUMxUrK5sVDjjJ97JC1y3cj6v4feq54L0gIxp4/B4
        4tFDm/NPqY6M1PaYJ8yrXaktSMw6qWAg7QYcVoeXlYewNnttgV6tXQDNT32Vo200
        w/rqm7jh+8hw6IQvui8WhzgPmDJurtA/SOqlX55yMJBjd+DEiXzKeAwGHl5WPRYu
        6wmvKjUGO6/v4tsDVYvN5hVqHWA/IsSzlhcTBF+zDKAzN9fm9lc1iyzHsThEKM4r
        hf9y2rrqOM0A7FakKucxFlBb2+Li2yXeB0xAbWJaXv9tS19OlHiJbNTNM24Vx2U0
        ke6jHYGhs1DQQ3b3M+ndWgyX/1kDS7jSn3V+9khrOVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lXKpEN
        l8wyg6SU2P0UYyhWDjFJGfkJ1PSJo5X7cF/QQ=; b=FwEcrlj5oyDSLS4wwC0wPn
        Bmh3RGOlt3Xk8HlNqhCdu31NYmptPtTME3IVrrASKVfZdAFjQA7r1QW/DUa3pMu5
        LG1eelF3dHH4xyxBV9gp8tX1Xigj3/24KsZszOynOQy5smlsaNSlgfBBGrpjaeBH
        AzULZXRqXH+72DU9xv+eRh8sKRhe6rdpmzHDvENwBqG3mlmSuka+ZKSu9couCHXS
        EWTidfR4qB252UF+O23h33gcs0H4LyI1xaiWPUef2ZyKkAJurTR249reqIIozgmB
        +tRX8p2ODFjXd6YGOq9P1Wx+f5+lqERBi9kPXr4Zl1+eWdNLlCvl3bnr4zhPdofQ
        ==
X-ME-Sender: <xms:J_RDXW7j2qt8NB4CHo9meH19pvwJCs2pvGPA4U_UQ6auLOO55hYyxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleekgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:J_RDXeXGgH-czWHc_AuIQRrz90rsF61fRYj7SiJtWwwwMTudw1u-6A>
    <xmx:J_RDXYEdch3gDTkuCHKWzhrAXf7WXOwIhg3My-hFWGjbGqszZpFKCQ>
    <xmx:J_RDXeeLeSssjnzebQ8u_viHC4hELuke1_wXJ19vpbQllKQVXvzXWw>
    <xmx:J_RDXT-sw3SS9AgiqaRvJQ3fUtXMDdkQ24uPKukaONmvGai06aE0Qw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9732080064;
        Fri,  2 Aug 2019 04:28:22 -0400 (EDT)
Date:   Fri, 2 Aug 2019 10:28:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        stable@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.9.180 build fails =?utf-8?Q?wi?=
 =?utf-8?Q?th_gcc_9_and_'cleanup=5Fmodule'_specifies_less_restrictive_attr?=
 =?utf-8?Q?ibute_than_its_target_=E2=80=A6?=
Message-ID: <20190802082820.GA30928@kroah.com>
References: <259986242.BvXPX32bHu@devpool35>
 <20190606185900.GA19937@kroah.com>
 <CANiq72n2E4Ue0MU5mWitSbsscizPQKML0QQx_DBwJVni+eWMHQ@mail.gmail.com>
 <4007272.nJfEYfeqza@devpool35>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4007272.nJfEYfeqza@devpool35>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:17:04AM +0200, Rolf Eike Beer wrote:
> Am Samstag, 8. Juni 2019, 14:00:34 CEST schrieb Miguel Ojeda:
> > On Thu, Jun 6, 2019 at 8:59 PM Greg KH <greg@kroah.com> wrote:
> > > "manually fixing it up" means "hacked it to pieces" to me, I have no
> > > idea what the end result really was :)
> > > 
> > > If someone wants to send me some patches I can actually apply, that
> > > would be best...
> > 
> > I will give it a go whenever I get some free time :)
> 
> I fear this has never happened, did it?

I do not think so, I'm still building 4.9.y and 4.14.y and 4.19.y with
gcc8 because of these issues :(

thanks,

greg k-h
