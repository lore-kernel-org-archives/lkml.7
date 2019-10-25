Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CC9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0137121872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d7JuN3VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502538AbfJYMAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:00:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:37445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393571AbfJYMAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572004802;
        bh=QLKXtV17sfPFmWYlxFIwH+LjXFG47KnZbF1kx/5IACU=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=d7JuN3VWX5OlemphcXkYhq7uaMIighoycPKHKdXiWTk5JI4B8v9AXTuDRvo/+sycG
         xmSUGW6zSglxoXRlL7n+TQEPh6mhvV7/dW5F3zHy9B6EkpNGFXseCOi4IJ5CHzLE+M
         Zpa/dz9gAerPE8mu6ReMncCR9l93tvl0TDAorZWA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1igsYZ2xpF-00J1bu; Fri, 25
 Oct 2019 14:00:02 +0200
Message-ID: <eab6798a6081fba94353be71681fcd8c7dcf8011.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Michal Hocko <mhocko@kernel.org>, snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Fri, 25 Oct 2019 13:59:59 +0200
In-Reply-To: <20191025115038.GF17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
         <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
         <20191025092143.GE658@dhcp22.suse.cz>
         <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
         <20191025114633.GE17610@dhcp22.suse.cz>
         <20191025115038.GF17610@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L2t+JTSwqitjznGbUvYHd13raRoRwOPCm3kUjC2Vlflm80ujit3
 wY1czjQ6GvrAu7Bq1SX3fPBsVf3AtTjd021mjCSEZj2mo1rBBXgHlO5qiY43ZbUKCdNmHSL
 WueQLkLIm+6EUTuxZmnj74oTJ/2SAeOIGqYDHQ6Qoer49jdaPLWk0mjrSODiZv0UoulIWI1
 MKDYU/7rSP19+ArJ1/svA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:caOO7iEICsk=:Z99ZqXlGBXrIGF+94jMRzE
 McA/2bHBx1Gk6U1swxRMuZFFJLMcaN3mnjZoEM6jnRdhrMBb7gXNhWX/A4cPCz9TwI/jIxmr+
 bQeRd0QcTfRQqWtthrFx3rH5Mp477tk0YYZinCLdwSfKhx1bWMPHsHbpOielVSEhX04O14Pt8
 zruNAK/H7QxErDSfyizZclVljNJYh3NHCHCzpBLJrsIxTpiCT5n51+R9Yjd50FaKgvRqA9AFF
 ogNfa0DAZCerjSBs4NKIe/B//y1MVCMCzXk1Nwdsft25tj5VOV28OBf0Gh8+SrH8pZ5XlJ6kP
 2DQl7V4st3YUov0UvKcGzN93fcUEon07kAPNlqkvHJ/gCwUc9sV3mUsvf/YR+nZnYy3Ov5IRE
 fQVcWHQRt/5dbJ5zQAQuZREap4l1QQp3EpT23NLHGLx/DhVC/JwcAxWROuQVHaYGgEAO9fMZn
 q5YuHzFsDMazzHyAo57fjEIsFOZLkVtEAAUyhI1TEKZjHq/OBIcX9BSTNM41msK66F7M2ElpE
 PZ6FoStR3vCsW8qW0S9+HdPPyTXRPcNy6lrROw9J+IrhdvFukRCjrSEzW0iCLlkr9X5JQGKDE
 BPO98yhwNdTQhsxumUFU9fJ6K814+btUj7IPZRK08mFUf54o2rNDK/m1IJapeEj6UpSR0zAx+
 eOVzn4vuv3zUpZmOC+vwYM209QE6DISHVb8zJ5b0aIPq2hU1Qz/i8b6FIfmRU87dzFDxn3BDK
 MiDwkB/AHtxDe+akT/ROj5PQZ6IohBBruv9q4cYvpXV5c9FH0u3I6pApr36WrUUo3j0+8bfrA
 TUwW3QFalvQFnO5+hvJmIGl2SnJHlZBW+x+DDpE+mCZsMnU5dxE7f3opng/u2EcTU9ePC+ZOw
 qoWmztI/4DcPyucM7jAfJjVKkvIO8z7/g8kkXiP1vtj92VvlZaMN27YUvl8s5+n64z4MKruKQ
 UqpMGm6Yxg0TZBuq0fA5jMqbZmwSnrT+VWHEefwUP3So1/yEE7guUCd/46Sa1Tif2BKG8DbDI
 KcgoSJyOBlxOMKtv8ruvbwvcDPdE1kRqPh5Vnd4M6hrT5/s+EpHwmIkFJXNosZz3odFf+tXaw
 9Am7bspInS9T+lbbJlKs6I3uVU5+pJY5WQ8U785EIrr8xim+vQN+AmX6HGpIwVsOyS7Ybzj1b
 0arE3d+3PBoU4tZMJZ+iW44NvQLK6E7L1eYy/xGIJbZA1nkDTq8dharjDot/J9j5l2RPQZqPc
 NCXdBq+YqEeUIsmEepoWj6QT1su1nkBPO5NK9bA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 13:50 +0200, Michal Hocko wrote:
> On Fri 25-10-19 13:46:33, Michal Hocko wrote:
> > On Fri 25-10-19 13:02:23, Robert Stupp wrote:
> > > On Fri, 2019-10-25 at 11:21 +0200, Michal Hocko wrote:
> > > > On Thu 24-10-19 16:34:46, Randy Dunlap wrote:
> > > > > [adding linux-mm + people]
> > > > >
> > > > > On 10/24/19 12:36 AM, Robert Stupp wrote:
> > > > > > Hi guys,
> > > > > >
> > > > > > I've got an issue with `mlockall(MCL_CURRENT)` after
> > > > > > upgrading
> > > > > > Ubuntu 19.04 to 19.10 - i.e. kernel version change from
> > > > > > 5.0.x to
> > > > > > 5.3.x.
> > > > > >
> > > > > > The following simple program hangs forever with one CPU
> > > > > > running
> > > > > > at 100% (kernel):
> > > >
> > > > Can you capture everal snapshots of proc/$(pidof
> > > > $YOURTASK)/stack
> > > > while
> > > > this is happening?
>
> Btw. I have tested
> $ cat test_mlockall.c
> #include <stdio.h>
> #include <sys/mman.h>
> int main(char** argv) {
> 	printf("Before mlockall(MCL_CURRENT|MCL_FUTURE)\n");
> 	// works in 5.0
> 	// hangs forever w/ 5.1 and newer
> 	int e =3D mlockall(MCL_CURRENT|MCL_FUTURE);
> 	printf("After mlockall(MCL_CURRENT|MCL_FUTURE) %d\n", e);
> }
>
> $./test_mlockall
> Before mlockall(MCL_CURRENT|MCL_FUTURE)
> After mlockall(MCL_CURRENT|MCL_FUTURE) 0

I suspect, that it's something that's "special" on my machine. But I've
got no clue what that might be. Do you think it makes sense to try with
all the spectre/meltdown mitigations disabled? Or SMT disabled?

