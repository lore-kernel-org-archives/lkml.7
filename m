Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573EDC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35AE20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OgV1SYEi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9FroYBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfHLObX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:31:23 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60245 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbfHLObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:31:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1CE9910D1;
        Mon, 12 Aug 2019 10:31:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 12 Aug 2019 10:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=MaKylIMiNZvNJngSL+I7JUFSGoK
        LzwNMJz4BsUiEcH0=; b=OgV1SYEikA9Hmho0eEZ2lhtqRFoju56jz7dSAjNRtzI
        o2wBAxOuxN2+5eQvy4cqA9iUZSj8JeekWl5/Q4YX1E+wG9UXNW7vTCHFnBBSO3z+
        e8OzqnozaUNNgkqxrR3QDHmK4VhD5bhp5Q/oxxHB2X0HPanwWrBLIAtuUMYbmTO3
        tB5VIin5FYAw0dAiGZ0MoX9HmccJt2Ch13r3ZKqLfCvoW7oE+Apq7w5GEpTM3i+T
        i/UTDuTWFNGwrexFamLFT7QNZbnvFt8PhSCh/wDNKZRwy42ECeSTwTaHJC0eoezp
        I5tsl2MnMZQz0osvCJNIwPnkliWOYeQu1P4AOfWp6JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MaKylI
        MiNZvNJngSL+I7JUFSGoKLzwNMJz4BsUiEcH0=; b=Y9FroYBWR7kIN3BsulRVJI
        nR+ym8C6pBPdepllthzrfuQmPfcNB54BMxdfOPNtoXCY2Hp/BjOL0bzOh2FIEPyk
        A1Fzvg7dZ1KUzvl9Lps0pSbJnrGxzVVpSGv1bIGHmFfMEzZSvzQDJoV0ve/PdSW6
        C+ZO8aVNTTqcIKs6Zl6rSjxWRZf5a3zIv7NH0K6jS/osnZztNg3n/I0lK+qMFPye
        zaRJNhnY/RP84b22LpgbJ/TfN2y28iiHngNtXcAcAlhDbO8NWsO/bomwrBSSotrM
        xUItScGRx3bSeKn2Y5L/DjvLdFojDQjl1KVlAd9g5SNnB0a7jw2V7f4JMJuxm3Og
        ==
X-ME-Sender: <xms:N3hRXTAMXND5auInpcj70N7FBKo6qV_nPXc4huTMtKEETDZvNNMVNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:N3hRXQMioMizuty-1KS6JsibI1GRCKY3E7a73f9drSPB_i4aMJME2w>
    <xmx:N3hRXTCCLyHXwm2K58euEsPj7bGuEmAzEe0bS_0L0Ar13QNRaP9Vbw>
    <xmx:N3hRXT_dsaewNhv68LWDWNA9-Zn6u26F7ofyExk6vsME8Lu6hgZP9g>
    <xmx:OHhRXe2oTS_J6BgsjD3jbgyByz7GtyRq3CyayyXAJ61K3CLMFBpIRQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id CCCAC380076;
        Mon, 12 Aug 2019 10:31:18 -0400 (EDT)
Date:   Mon, 12 Aug 2019 16:31:16 +0200
From:   Greg KH <greg@kroah.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzbot <syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kirr@nexedi.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, lkundrak@v3.sk,
        logang@deltatee.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in ld_usb_release
Message-ID: <20190812143116.GA14068@kroah.com>
References: <CAAeHK+xZgjD+gP=pCkk0uKVkuPG+XZ26mgNQCGzw2ea5mqFTJg@mail.gmail.com>
 <Pine.LNX.4.44L0.1908121020180.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1908121020180.1659-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:21:14AM -0400, Alan Stern wrote:
> On Mon, 12 Aug 2019, Andrey Konovalov wrote:
> 
> > Alan, could you submit this patch (if you haven't already)? Looks like
> > it fixes this bug (and might fix some others).
> 
> I will.  I was waiting to see if Greg KH had any comments.

Give me a few hours, it's in my queue to review...

