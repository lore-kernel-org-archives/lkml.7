Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B98BC282DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6825D208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ao2.it header.i=@ao2.it header.b="imluKER+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDHHeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:34:17 -0400
Received: from mail.ao2.it ([92.243.12.208]:40435 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfDHHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:34:17 -0400
X-Greylist: delayed 2161 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 03:34:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=bzYxMZfT5myZia6YYJj+MUEvZL+GXpdcny61CWF1K9w=;
        b=imluKER+OK5IMNSMfxS+DKfugaCRw1sOMVtTqNrshM9BqmW/KKJM/+X/V6jYoBvrBkXO9KXKuHkTpVcGcHNfwZkUaDXMUKYAxVgcsHVg3fSNEqN0LlgxuSTVJZaoAl82QExLFoYKTUlsXToW/Rip6gQsBhtG37Jt0lklBwVRFAwAICP4tztnuCo4cCqvfP+uMnO9NFWnfdxjZkkRAKzIYwNSARp4txcNSkpy8zvlAAhbN08FhJN9mRQw7WdMThHR29QXAnJ56znxdvjrT4TDqEddX/9keJ2N35G0Ow+XBdeQbY7RsKp4+ovxeL+ES0wvgJTK7eUJAd9rrcCCXeT7ug==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1hDOEG-0007DH-26; Mon, 08 Apr 2019 08:58:04 +0200
Date:   Mon, 8 Apr 2019 08:58:12 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Harald Welte <laforge@gnumonks.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: Removing pcap? (EZX support in mainline linux)
Message-Id: <20190408085812.db187b4a6f8ffc76d3d5ebdc@ao2.it>
In-Reply-To: <20190407140741.GE7480@piout.net>
References: <20190407140741.GE7480@piout.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2019 16:07:41 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello Antonio, Harald,
>

Hi everyone,

adding Robert to CC as he is listed as the current maintainer of
ARM/EZX SMARTPHONES in the MAINTAINERS file.

> I've had a look at the PCAP RTC driver because I'm removing a few
> deprecated APIs. While doing so, I've discovered that the driver has
> never worked properly because PCAP_RTC_TOD_MASK and PCAP_RTC_DAY_MASK
> are both missing a bit so every day would roll over at 18:12:15 and the
> whole the date would roll over in 2014.
> 
> I discussed with Arnd about 59ee93a528b9 ("ARM: pxa: remove irq_to_gpio
> from ezx-pcap driver") and it seems the whole EZX support has been
> broken for a while.
>

As Harald said in another message I tried taking over OpenEZX for a
while, but eventually lost interest.

JFTR some parts of the project has been backed up here:
https://gitlab.com/openezx

I should also have a git backup of the wiki somewhere.

> Is it worth fixing the RTC driver or could I remove it?
> 

I am not aware of any active user but I'd leave the final word to
Robert, IIRC he received some EZX hardware "recently".

FWIW I think EZX code can be removed if it is a maintenance burden for
anyone.

Thank you,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
