Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F4C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53902190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gandi.net header.i=@gandi.net header.b="hUgpDR+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfJJQt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:49:59 -0400
Received: from mail12.gandi.net ([217.70.182.73]:38897 "EHLO gandi.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfJJQt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:49:59 -0400
Received: from khany.gandi.net (unknown [IPv6:2604:3400:ca01:cafe:37f:7dbf:3d1c:67d8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandi.net (Postfix) with ESMTPSA id 0628F16056C;
        Thu, 10 Oct 2019 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gandi.net; s=20190808;
        t=1570726197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DeXtYrkrdQkJZhVXf0iMcEIahsDtnLeEBSa5AlWLq6g=;
        b=hUgpDR+RLtuqOjyRGAJvIPEt9itArMuOSGMoIhcvxuv4VQb2JEcUAXFORNOl9nWg6VKPSq
        IuJqs6hmrTCv2QQYbQztlO6YlajQNaNjN48agi/TawuLK86uJwHXWxBb1Idk4poK9XA5X2
        xc7HYh5YgbsDPRgiKPAr86zz4Mpy7h9H8alkeSyyrcjUPmwkdKtM5IM6byR++g3g/9KWtn
        bjGNQJUw/pnt2wv1bKy+UB1BR4p+sAo8WKDqwLIxb/9hpwF4MxfNJXIPEGXUmn1eD2xVS1
        id3YdZGZOA1CBGJurySe+Oa7asnPqrMkGxQ/4mduhXkSOM82dxzyY+j3l25ksw==
Received: by khany.gandi.net (Postfix, from userid 1000)
        id F09FADC020B; Thu, 10 Oct 2019 16:49:51 +0000 (GMT)
Date:   Thu, 10 Oct 2019 16:49:51 +0000
From:   Arthur Gautier <baloo@gandi.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20191010164951.kr2epy5lyywgngt6@khany>
References: <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
 <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany>
 <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
 <20190218215150.xklqbfckwmbtdm3t@khany>
 <20190926095825.zkdpya55yjusvv4g@khany>
 <20190926140939.GD18383@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926140939.GD18383@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 04:09:39PM +0200, Borislav Petkov wrote:
> On Thu, Sep 26, 2019 at 09:58:25AM +0000, Arthur Gautier wrote:
> > I think Andy submitted a patch Feb 25 2019, but I was not copied on it
> > (I believe it was sent to x86@kernel.org) and I don't know which fate it
> > had.
> 
> I guess we're still waiting for Andy to do v2 with feedback incorporated
> and proper commit message. :)

Hello All,

I did not receive neither the patch Andy provided, nor the comments made
on it. But I'd be happy to help and/or take over to fix those if someone could
send me both.

I'd really like to have those problems fixed

Thanks!

-- 
\o/ Arthur
 G  Gandi.net
