Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BA4C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F62206DB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kzScDLeb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kh2chubZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAFJfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:35:48 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60817 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgAFJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:35:48 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 86610B6A;
        Mon,  6 Jan 2020 04:35:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 06 Jan 2020 04:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Az6842jCwBnlC75YpfmD47hgMm/
        fEpPSyC0cxuz5s9w=; b=kzScDLebOyUrdPpqvzrwdoYxq+UFq+taB9NTurVyeiK
        S86xICcEca9s27KD3g+Yl56cssDqpOViihmO46C8YBBq/YgUCL8M9Lg0CsUIFnHr
        Q9v943r5ZzSkveqnnBzGNaWHR1Gdh0CC7DuOkP0jEd8m8BspxOxhCk5s2Swr3Hsb
        Hf5FxBpKBOeUl68e6UJ8BtP/hc/S/BOHzN3ha6o9OwpAtHujwYouP8VW//XpA3US
        DDxDgXk0SOd+lrS8hKfAjzg/UHI8i8Vz2CBdywUTPPKD9gX6DP7jS8VCI1DPjGnc
        EnnIHbXR4ezDmQy/TM0SCGBR3gmFyTh1+HkBdecdbDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Az6842
        jCwBnlC75YpfmD47hgMm/fEpPSyC0cxuz5s9w=; b=Kh2chubZJUEYhmmKE+k6VQ
        MeSt0HWCXClLTPmNA+IulC1Tom/dJorN4zMD3NmTRa878y/Sz637Mr0LXybDBK+T
        sPN3x4xi0YtGx7b/wNOrX0lm8INO0CYMhmV5fnMgSnUCUAhTbCZDUfQ8nrRbYkqi
        KBPhfNVM5QqFO3DcYZHsidPtmzl5MpKo2NYgOPR0nJQMDdPK2Yi03U0mrIDIpB2h
        iTn6a0BoWGMla3X0Ya1D+Vp7LHlOpC4v+v7H5e95kSrIncRUiWaSgPwImQ0U4Iyc
        irTCGzBFKBaYbViIH5dqW6GwOD1sLInqhhMGNnHNbu0QKZdvQZuIEKm5g+Gjwlhw
        ==
X-ME-Sender: <xms:cf8SXpIA947rVvmHUPBysszxau7raxjqa_kD0WYq0rGaM0GlIk2Z-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:cf8SXoZyxCA8_Yv0eRB19xnOEQgYzhRkpcvv_VQ2fffGtbKFSdyOQQ>
    <xmx:cf8SXrKq2yKIRrhkX6SfgbS02ciFJiwIKaynzWtr4m2BRbpwrOdy1A>
    <xmx:cf8SXmAVXVUSWRBdo_agnlvNDdms-8IEP9aglXKIT8rE4DYbEKEjbw>
    <xmx:cv8SXgo1bpQ4NQlMnyvCcfqEANfylS-nP0m6lPlkJPN4MmW3i6PRfw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD67380059;
        Mon,  6 Jan 2020 04:35:44 -0500 (EST)
Date:   Mon, 6 Jan 2020 10:35:42 +0100
From:   Greg KH <greg@kroah.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 2/2] phy: Enable compile testing for some of drivers
Message-ID: <20200106093542.GA3125672@kroah.com>
References: <20200103164710.4829-1-krzk@kernel.org>
 <20200103164710.4829-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103164710.4829-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 05:47:10PM +0100, Krzysztof Kozlowski wrote:
> Some of the phy drivers can be compile tested to increase build
> coverage.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I've  taken this through my usb tree as this is needed to resolve some
build Kconfig warnings that now show up there.

thanks,

greg k-h
