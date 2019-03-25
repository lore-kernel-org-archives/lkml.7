Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D60C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF8205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="r1rvW6wj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHFFkGDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfCYWAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:00:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60377 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729693AbfCYWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:00:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 18E2D25AF7;
        Mon, 25 Mar 2019 18:00:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 25 Mar 2019 18:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=U6QhMlb/WNmihfV9JJAwe1/emPv
        8GDBLCIX6hdWzMYY=; b=r1rvW6wjkctDOgkEXCCzoY40SCD00L5TOZ+Yh3oRpoc
        Blx97VYxBwLRXmCBSdYz7WtFYM8PcPl9Ozd82zBAfMW3tgW9cDq+iwZLi6VvFiNP
        P55pNT3Wlzvnv5PB9WpyOykBDkOADDTMIPVdH/dsvaR0ns/HIVmuxygPGMer8ceS
        2XLjkTzeWAiqgswpDH1l9DqRpQbQpB16ynE+mbiuVU//pPeyiDtkLxjAVcISjLwR
        T6gbfdpZ5ppFY3BHrbi5po58GfGv4eCCgrlX+O9RbF9BEWWjvUtp/r8StsPS5jPA
        RxC9SFnIphSmRqGOpBlM6dXVJR83egPnUUfqclfLmxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=U6QhMl
        b/WNmihfV9JJAwe1/emPv8GDBLCIX6hdWzMYY=; b=GHFFkGDGhD+LX/8MXJmjts
        PMlGXrGsozhXdJS2/JgR9oNhh69oBQX6833mKK9uG7ltLFf1p0fhYJvkRukEn/MJ
        MWjTLF+hBxPEsO6pkqV+kQA8CBdpavuZFAjUmNMV0cwx49ku5mqhyRI5bAkGIMsw
        ant+5WLJOY3Y058Y3Uil1O9s3C5WXNTsXos0VGvB8beM2ngTgQZsoGF/pYUALVRj
        rtBN4QXe4LxFwoLVRy1Ze/Xls8UXX5hVP2aKsiq+larrcIB7T817twrRUG3r8lsT
        UwC22ZHFtYxsl424pro1dUVsY6sER9peK/g6xKhKRVLo5uHuSS+2aBEbTyMIpZYQ
        ==
X-ME-Sender: <xms:aU-ZXIpOBkGKW74VYGs-7FwZIg8RRqrbS6lkxMTDTbrzK28mY0Kwsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrjeekgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrddugeelrdduvddtrddutddunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:aU-ZXMVM0xaKdms0qgXA7L-sHpRTnbBBWQhXiGR2JdqpWsgFR50Hbg>
    <xmx:aU-ZXFSVG5mld8dcXaJTcFMUcDTrhNGx-_XcKvKiwxlKcJMxtpWj4w>
    <xmx:aU-ZXITvyLUvRGPvuXkjoawbDTZE4jO79ZI_ZB1PorbXQ12UP9dJtA>
    <xmx:ak-ZXP9BbwSPuUSuEyACpXRuUt4-mnI6U_GzaKJWSfkG0fMh2KtMpA>
Received: from localhost (124-149-120-101.dyn.iinet.net.au [124.149.120.101])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7A4E710397;
        Mon, 25 Mar 2019 18:00:07 -0400 (EDT)
Date:   Tue, 26 Mar 2019 08:59:38 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] docs: Fix various build warnings/errors
Message-ID: <20190325215938.GA19088@eros.localdomain>
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190325103333.700c2772@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325103333.700c2772@lwn.net>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:33:33AM -0600, Jonathan Corbet wrote:
> On Fri,  8 Mar 2019 08:11:44 +1100
> "Tobin C. Harding" <tobin@kernel.org> wrote:
> 
> > I had a few hours to spare so I thought I'd clear some Sphinx build
> > warnings/errors.
> 
> So there were comments on various parts of this series; were you planning
> to respin it with those taken into account?  Certainly we're all in favor
> of fewer warnings!

Oh I thought this was dead.  I was under the impression that because I'd
worked off the wrong tree Randy had fixed all these already.

I'll go back and check if any of these fixes are useful still.

Thanks,
Tobin.
