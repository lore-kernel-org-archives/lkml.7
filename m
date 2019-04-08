Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C2BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0590E21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ao2.it header.i=@ao2.it header.b="wzZPJEDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfDHV2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:28:02 -0400
Received: from mail.ao2.it ([92.243.12.208]:41212 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfDHV2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=6tn3a5W+Pj5iM3gBwNexXy5ExguX9MQcBywLFY/octU=;
        b=wzZPJEDhdQ4JfPFP2MvDnXwb3QGwm77ypgfUh3l+ggv+f9VC5qiSnbFY9EtRNktYBdRzLSP0+0m1dJlOGf67qvV6pRXFPTtZZpmrGTb3TV2tgnWPo6iRJG3dMlufu5zimD5sG8Z8iHBepRNFa7rSaJkDs4ReCtt50RVrUBL3hXcR/Yk5AAn5IQa9zGfslRNDAJ2ophU1VPcH6Xr/8ydN9NNUCGRZerdLS99/2GO8xglfofKaD6z1FV7Wqiv/SiuK+79JAFtdT4mK7C+wlClOO/CMGOWOl1FiPbbEzHWlUzpHhjFaXnXoqc4YpOSqScdvWbjKPUQaA1jXphGF6B/GNg==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1hDbnw-0000mc-4K; Mon, 08 Apr 2019 23:27:48 +0200
Date:   Mon, 8 Apr 2019 23:27:56 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Harald Welte <laforge@gnumonks.org>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Removing pcap? (EZX support in mainline linux)
Message-Id: <20190408232756.db3a074ef0b09f1101f9fec3@ao2.it>
In-Reply-To: <87d0lwpavv.fsf@belgarion.home>
References: <20190407140741.GE7480@piout.net>
        <20190408085812.db187b4a6f8ffc76d3d5ebdc@ao2.it>
        <CAK8P3a0TKUQC7GkYsWrJGFaRsvK5AQjPn74AnkRcPioXUFef-Q@mail.gmail.com>
        <87d0lwpavv.fsf@belgarion.home>
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

On Mon, 08 Apr 2019 21:14:44 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Mon, Apr 8, 2019 at 8:58 AM Antonio Ospite <ao2@ao2.it> wrote:
> >> On Sun, 7 Apr 2019 16:07:41 +0200
> >> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> >> adding Robert to CC as he is listed as the current maintainer of
> >> ARM/EZX SMARTPHONES in the MAINTAINERS file.
> >>
> >> > I've had a look at the PCAP RTC driver because I'm removing a few
> >> > deprecated APIs. While doing so, I've discovered that the driver has
> >> > never worked properly because PCAP_RTC_TOD_MASK and PCAP_RTC_DAY_MASK
> >> > are both missing a bit so every day would roll over at 18:12:15 and the
> >> > whole the date would roll over in 2014.
> >> >
> >> > I discussed with Arnd about 59ee93a528b9 ("ARM: pxa: remove irq_to_gpio
> >> > from ezx-pcap driver") and it seems the whole EZX support has been
> >> > broken for a while.
> >> >
> >>
> >> As Harald said in another message I tried taking over OpenEZX for a
> >> while, but eventually lost interest.
> >>
> >> JFTR some parts of the project has been backed up here:
> >> https://gitlab.com/openezx
> >>
> >> I should also have a git backup of the wiki somewhere.
> >>
> >> > Is it worth fixing the RTC driver or could I remove it?
> >> >
> >>
> >> I am not aware of any active user but I'd leave the final word to
> >> Robert, IIRC he received some EZX hardware "recently".
> >>
> >> FWIW I think EZX code can be removed if it is a maintenance burden for
> >> anyone.
> >
> > I would prefer if we could either keep or remove all of the ezx code, but not
> > just remove a particular driver. Removing it all now would let us skip that
> > discussion the next time someone has a problem with another device driver
> > for it.
> 
> I'm on the same page here.  I'm not strongly either for or against EZX removal
> (which would impact AFAIK 6 old Motorola smartphones).
> 
> If I can find the wiki archives to cross-check the mask issue (especially
> PCAP_RTC_DAY_MASK), I wouldn't mind seeing a patch on that if it is kept.
>

Just in case, I uploaded the wiki backup here
https://gitlab.com/openezx/openezx-wiki

> If I can make the EZX boot (the one I got from Antonia), I could even test
> it. As if it's worth it, I'm not personally an active user of this specific
> platform, so if no one is, one less would be less maintainance burden.
> 

Not sure what the mainline status is. The last time I checked, several
years ago, to have an "almost" usable experience some
out-of-tree patches from https://gitlab.com/openezx/openezx were needed.

The repository is a topgit repository. feel free to pop in the #openezx
channel of Freenode for any details.

I reported this discussion on that IRC channel to see if there is anyone
interested. Let's wait a couple of days and then decide.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
