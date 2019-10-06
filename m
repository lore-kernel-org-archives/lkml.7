Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D19C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C1B2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hmh.eng.br header.i=@hmh.eng.br header.b="mHHW/VKL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xrKbdHsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfJFUk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 16:40:58 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:49041 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbfJFUk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 16:40:57 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Oct 2019 16:40:57 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 2110C3EC;
        Sun,  6 Oct 2019 16:34:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 06 Oct 2019 16:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ejeoZ3ISdZsRr54JCVMXEDJt/1V
        Fp4bSIyHVCBG50b8=; b=mHHW/VKLracUbzT5k/Yt/2zRfz6PcGuqBRiKbisrLOy
        YtyOjbUfAq/9fJ2ZoRWnMBBouN+CtMbptke0sdVkzxgNfXNK4fXr5NwU2TCml+CD
        Gou69jWnyqS+XBOfvhKRU2kD05KF9oMt+nDyI1osG8dEh87GchKnAKVX0nRiOoKm
        sxjrfniejyMc2Ueh8gmQSGqhPXBOU24qLLkA3s7FyWMEhz2gIefsaJA2lLSTtP2h
        Lpyy3Pe5qQ7U01c4eyi4jLiFlRYVFo4McCUY4tSjsj/YPAtNqs+8U6R4FpaZgMUl
        8oGfzelTrlI0KuATIjokWOXZ+CObcXMQFKvxYUxTpng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ejeoZ3
        ISdZsRr54JCVMXEDJt/1VFp4bSIyHVCBG50b8=; b=xrKbdHsWlLiTRqHDsYu+te
        DiSiarnwMVNrf6IHi3Up2h6zQhhJhpn8haR3Gq5GO9iil89OWjBzN2aYNXKkxdac
        glWTIOoHbfKXNQc8IEcNgyUt9dCulbHizKaEHIBJ3IFHbsuIRafEDxNeomAWP3bB
        8ZYdDkafQAdN3YG+Ntf76ClDXtqAsErAPn6uUSY0nhUuEklyKT+m2t8iN1MuwWUS
        7M6UElsmFH1H0hgHNJtXQwz8swjBa5uTQzJpXpRz9PKWCc2kwIxboDKiUHaN2kNO
        pgrHPQfJ/XaVwiClqz9eipCUVXN7wPGFU1VadWme6yt19An6NxweIDtNJilO0w3g
        ==
X-ME-Sender: <xms:wk-aXeN_yLb80W7gM2wn_PJMPNouOSRQlLYjstQOY-Mn97lujsbvxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdttddttdervdenucfhrhhomhepjfgvnhhr
    ihhquhgvucguvgcuofhorhgrvghsucfjohhlshgthhhuhhcuoehhmhhhsehhmhhhrdgvnh
    hgrdgsrheqnecukfhppedvtddurdekvddrgeehrddvfeegnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehhmhhhsehhmhhhrdgvnhhgrdgsrhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wk-aXZGUKg6qynH5oJ4TvGBM5oMH6MRebWq46ZDPEpHpFGW-t3oZLw>
    <xmx:wk-aXRHUkSVMld3VXmDDnbPWpW5wwNgLL3yjxkWFpSJB_ufBARi72g>
    <xmx:wk-aXYAsp9RiCDTVfl25ei7mAZmx1QiUjikdouXhFSgI19j-qB4C8A>
    <xmx:w0-aXcIlO3TIXyeKDXH7Dx4X5hbWwtpfb0RCaoJbCBvEf9ONWW06z1vw6p4>
Received: from khazad-dum.debian.net (unknown [201.82.45.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D971D60057;
        Sun,  6 Oct 2019 16:34:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by localhost.khazad-dum.debian.net (Postfix) with ESMTP id 06BA2340015B;
        Sun,  6 Oct 2019 17:34:09 -0300 (-03)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
        by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id imtwoQQbVsa9; Sun,  6 Oct 2019 17:34:08 -0300 (-03)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
        id 10243340015A; Sun,  6 Oct 2019 17:34:07 -0300 (-03)
Date:   Sun, 6 Oct 2019 17:34:07 -0300
From:   Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mat King <mathewk@google.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191006203407.GA14301@khazad-dum.debian.net>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <20191002094650.3fc06a85@lwn.net>
 <87muei9r7i.fsf@intel.com>
 <20191003102254.dmwl6qimdca3dbrv@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003102254.dmwl6qimdca3dbrv@holly.lan>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Oct 2019, Daniel Thompson wrote:
> I guess... although the Thinkpad code hasn't added any standard
> interfaces (no other laptop should be placing controls for a privacy
> screen in /proc/acpi/ibm/... ). Maybe its not too late.

As far as I am concerned, it is *not* too late.  And you can always have
a driver-private way of messing with something, and a more generic way
of doing the same thing.

thinkpad-acpi will always welcome patches switching to the new generic
way (as long as we can have a deprecation period *for long-time-used
facilities* -- which is not the case of the privacy screen, no
deprecation period need there).

The privacy thing is too new, feel free to design a generic one and
send in a patch *switching* thinkpad-acpi to the new generic one.

I would ACK that.  If the subsystem maintainer also agrees, (and nobody
*seriously* complain about it from userspace), the private interface
would be gone just like that.

-- 
  Henrique Holschuh
