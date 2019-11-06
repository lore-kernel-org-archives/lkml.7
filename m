Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E196C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C452173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RCQB+6NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbfKFRDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:03:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:54297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732275AbfKFRD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573059793;
        bh=DXiFHcDw6sm/LXNoMrhS8D2YEJLpr2IJCcrUXxItYpI=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=RCQB+6NMv5g9ZdYK5Iz/40FbLE3/cceoFtn5ztQCmHG0B+NRRL1dT7o3NzTkNwUK6
         AggznjXfZxCHAYeD/lZcA0rYw3nlrbqD107nrCMbhZMO+6jKrsilJxicLvtm6UvTUq
         f4puFjvXN6rIukJgTUEu/iRUua8oysYnb0XjR6Gs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf4S-1i1HN52O9a-00ioUh; Wed, 06
 Nov 2019 18:03:13 +0100
Message-ID: <94c71621a0245db763db9e289286b79056cc9bc5.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Wed, 06 Nov 2019 18:03:10 +0100
In-Reply-To: <9f6b707c69ceb34e3916b1d47f2e2fa6a4f025ab.camel@gmx.de>
References: <20191025135749.GK17610@dhcp22.suse.cz>
         <20191025140029.GL17610@dhcp22.suse.cz>
         <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
         <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
         <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
         <20191105182211.GA33242@cmpxchg.org>
         <20191106120315.GF16085@quack2.suse.cz>
         <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
         <20191106145608.ucvuwsuyijvkxz22@macbook-pro-91.dhcp.thefacebook.com>
         <20191106150524.GL16085@quack2.suse.cz>
         <20191106151429.swqtq2dt4uelhjzn@macbook-pro-91.dhcp.thefacebook.com>
         <9f6b707c69ceb34e3916b1d47f2e2fa6a4f025ab.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CO6OVHDAphAzpdeON2DyDlN0DNDvfNBBjl0vWS0Fl5ys175/BtM
 oEIGiB/sW+wj5915kNPhHjSK4Ll9v/QMTfkLsI7/4bNT3ruvZTs3+SpUxJm0dFR7O7s8Ty0
 S9VmHfDK7spIzKMuxiveXyx4hhS5GV/bc24mLXMI8zlgSEfl21n3ygVjTOuCxVFrEB0k17W
 FCdfP+1hY8ULEcfhwrYnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:faxpn5ZK4iI=:YiOAj8DrU0zyOERP3Z4K+Q
 jHn6zZlJf4UHxjzNE78LtMENDs15LfQGRYSDxVwVHljgvzIrfzBWz1/PpSxDrTC5enre92Ovv
 vDzv1nVP4Ls/CmQKTRJXysomnPSYdeUYmeO1mOZiNi+huD1EtT/j5A9vSNTohmpUpcRTmUfes
 /V6qW5D7pSjJ07cuiLlH/RsmmDwTHkgGSn4rJuE69+KhcK0DJtjIIhz2wf6WCsn7d+Q6F8QX4
 qbaoM4ihW8tk95qJiytAql/7l2sa7tfbOYqEN3vpdUJuW7+mTXHI3q+LD5X9XZdJhN35RNcSh
 Y4bwcxajOZALxLYHKpj02UQq91yG0VuRBWNIEyl6re3V7S+J3wi3rVz8YGxj74Ft4j2LaQojO
 xftEds4jB/fUnB/C4EZfDQHVpoUBzVufNb+arZoBiZl7lkFlQkPZtj14JXgbSwhKmGyy3hOZV
 4nElKlX0S+ISePIitLzjtZbd23c9+F5SeVXQEAMDlpoldXyXOoQz3W8HxTpG22w92wdjiT/pV
 v4ec508owQzQCS9nJIu2xidOgbgrS4/Zu01+n6mGMuz11boICCGhcaWdEaxoj/Ustnl/CCc0V
 U0HZCC547BPu5teaHbvqiCA6THshIm15nlFz5cJ2A+dav+dIFgy+/UO51HyVGBEeIQxpZt4f0
 Qs9SB13gXlnvJA40rYdfz7nDSVDXqY8/enKaT3qx/t28RaBkw6G8WnnkguA6JEuQFhejRz8P/
 Ex+/RB7wlaCa4Hw8dkYSmJWVJWcTXTV76fVO7XUfAbyBDAEP2SfehyPm0RR8UGbvEPJJCzljv
 0aKzbeL34sKBPJxIfD8W9JesEAwxUVyF18a9i/jrecc55T0egMdak0/wVeyZUeDxe0jduBAsS
 smIGcCht1qNIdI4rbHzZHJrWbrodTMD1ZVv5A78pZ+xK4OiYnVj5KJ7aL16tDmqP7T2nGkNq6
 S9jw3L+UHXTFexbooyFHsK5Fs5d0LNFKKWTY87NoFrS9rrUAIqecUjiGvq5/IEWl/BCjjfF+c
 5LdpvNgD0FmzgcMl7ln8oRr05buxXfw6vZECFkuOBJrS2lq88XFWjs3C/ys8jzqGBvTK3f6P3
 k63aghjaPqE4dYvOezlJ8/bedqnAwogYGrOq7jqdNurScej9YZmGOYUUmKAZ5sL3H0H/JcIln
 ay+CLVXZcsqWDhZoCfGLIG2mVtbJG+hqIg2Td6BSCxieGG3wHnYthNHob0KMHFXYS0bj4yyMh
 4g1kjX9NJbXrzvYDcbTO1jdnYJDtYdp07FXHX/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and I just realized, that I have two custom settings in my
/etc/rc.local - guess, I configured that when I installed that machine
years ago. Sorry, that I haven't mentioned that earlier.

echo 0 > /sys/block/nvme0n1/queue/read_ahead_kb
echo never >
/sys/kernel/mm/transparent_hugepage/defrag

That setting is probably not quite standard, but I assume there are
some database server setups out there, that set RA=0 as well.

