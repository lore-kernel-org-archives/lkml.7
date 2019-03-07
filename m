Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B84C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B7820449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCGTU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:20:59 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:58733 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfCGTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:20:58 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h1yZS-0002WZ-W7 from joseph_myers@mentor.com ; Thu, 07 Mar 2019 11:20:47 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 7 Mar 2019 19:20:43 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1h1yZP-0004QY-3c; Thu, 07 Mar 2019 19:20:43 +0000
Date:   Thu, 7 Mar 2019 19:20:43 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Lukasz Majewski <lukma@denx.de>
CC:     Zack Weinberg <zackw@panix.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [Y2038] Question regarding support of old time interfaces beyond
 y2038
In-Reply-To: <20190307085329.2b6cbeb7@jawa>
Message-ID: <alpine.DEB.2.21.1903071917120.16241@digraph.polyomino.org.uk>
References: <20190305162351.5aadde66@jawa> <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com> <20190307085329.2b6cbeb7@jawa>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019, Lukasz Majewski wrote:

> > 1) We should be clear that most of these will continue to be supported
> > as C library interfaces even if they are not system calls.  Some of
> > them are obsolete enough and/or rarely used enough that we might not
> > bother (the older ways to set the system clock, for instance).
> 
> The question here is about the decision if even the old time APIs shall
> be supported on 32 bit systems which are going to be Y2038 proof (like
> the 'stime').

The glibc API should support the same set of functions both with and 
without _TIME_BITS=64.

I think it would be reasonable to obsolete the stime function in glibc 
(meaning turn it into a compat symbol, not available for linking new 
programs and not present at all for new architectures).  But that's 
orthogonal to supporting 64-bit times on 32-bit platforms in glibc.  If 
stime is obsoleted before (or in the same release as) that 64-bit time 
support, no 64-bit version of stime is needed in glibc.  If obsoleted in a 
later release, glibc would need to get a 64-bit version (and both versions 
would turn into compat symbols if the interface is obsoleted).

-- 
Joseph S. Myers
joseph@codesourcery.com
