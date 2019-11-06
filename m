Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB6CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B18020659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VfbIjgWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfKFL0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:26:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:46875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfKFL0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573039588;
        bh=imhuNeOeyEB3Sv0ab3Oz6+zYm6EYzRjis2vgs8K/+LI=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=VfbIjgWoS3D8iXifZN+qskc7cXx1o3NcIKeEGuoyz0YDWKvusyC6iMgeiCViFtqlO
         s02OmJRUSI4N6/2EFgwgBugXSJerokGNqSJuznVA2Z2YbGegA8pX50xxWKEnr819/4
         KdTH49ijNqFMAxXRZ1rgjKKs+sjsBLbnnVNnb3G8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear-2.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1iIlCA3whZ-00PcSt; Wed, 06
 Nov 2019 12:26:28 +0100
Message-ID: <b0a04e9953b0e714ec906fbee38f36b08e58da8a.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Wed, 06 Nov 2019 12:26:24 +0100
In-Reply-To: <9072e55e97f0c4f3b286eb57639c4e9bb4223dfc.camel@gmx.de>
References: <20191025120505.GG17610@dhcp22.suse.cz>
         <20191025121104.GH17610@dhcp22.suse.cz>
         <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
         <20191025132700.GJ17610@dhcp22.suse.cz>
         <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
         <20191025135749.GK17610@dhcp22.suse.cz>
         <20191025140029.GL17610@dhcp22.suse.cz>
         <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
         <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
         <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
         <20191105182211.GA33242@cmpxchg.org>
         <46c58487acc05aa3c4d5d1e72b95cd84a5dba47b.camel@gmx.de>
         <9072e55e97f0c4f3b286eb57639c4e9bb4223dfc.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G0VjFm6GBw69gQ5IoHqUXMfFp2XQYjNitP+T7hpmuS69I780Smr
 UE3LiQzE0MSAvKdo5CIZTIsW51UK0n1Apwx7lOOBH/EjmwDPgzs6qIgPokitL9TlpZRyhbD
 gYCJCnaMeqB2e4h6Jwv/9Uvlu+Nqwzo6JLa+YrRkRqR80Ikpds1nWk90aQ1uzwJMIYeQDfx
 XWe9Vn+koh7SeJbM9YVTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FKTN6yoNAVg=:+8AyDg8PYJxQvme8x0rflN
 xevNjyUtI5vI9TOaSWmz6Kt24rg/agmsvRNUjPkwmXlej9wJtKJZOEmsEXQHiYpEHIKwcuKtK
 YzTj3fAR9kB3k154cJF0xhoZ5kKyBQbKVppImhhilVBG8grKFu1JKWcb3OIZEsVNB2BqNnA8e
 Aa0rXgI7bN8DmUKtdD5mQunr3AcmBOkYZWsO+z+c6xew6GIWaDlIAh/AmeWDsJPIgeadgkFQq
 4+xadON/q8c1AvBYk0L2SfCbtqyC3l2GBrWalZnsjcAPCXicQqls+kGC/Cwx0+E4ATnF75TPC
 EInqKyWHNvs3FoczfNl1Oms42pXe5y1JqhIQyiWxlRKL9uIEB7O2Jre8H+aU0N5nyc1njxdW1
 CKLEjIunCTJnqClDIQgQQFJaQ7VKMOU79t7G2+Sea69IVjFB2h13HIpWO6R61pBtG6iOehPfm
 dOiyrgj4LgaJ5c083ziZEgY2ihmulWdJq75Nvi0ARbEvA1A4Owo33JIlzrk1D7hQUrCA03ZEU
 UyMl+Q0tWyEzvFutg0BMWPOR698Z2CBNOHa0P2c2GWH/UAKvctN/c/A9TeqG3FFQUtNYJe+24
 s1b9QZbto4NviegeKLa6rT8efILYVnHQn8tPKNLjeWCQxnkwaE599X+BIDDW6qZDZxfY+VprA
 V2XUy9TlZ58f1IWTwbuSTbCmnFHveGObGvmQwwjN7f+ZkGtF9Qb4OKooUb49G6y64OEblpjTz
 3ZLRS28CyhZ21Ov5VfNCIMR7k2vyK+7SJdoSadS06RagKr27andPKnWza7kyEoK1P/xwdP9DL
 +Nc70ZQ1PYLZyrFp1C5hUrPOTSSkmU3lnC2LfLQa3V/lmIEdOgmxBaGiHHRD6lu09EuwYEza6
 +0dQZqcf+Niz9kiD9vR7BYkxyqVt4Xem6eiO6YeUyKjsASWFzogIP2QktRlvdAIr66H/yWLfr
 W3wRScyGeUtx2SHBQvN4pEem3tVnvoY7IzFbL/lCvxEtQmFWNK8XXAzLneqENQ95rp3Toi385
 5QBWixfHVGGLXrnA3UE0Yv6GhDn++08SYegfiQKQBvbCkE8sQzyPgSVZeTUawQDTdapEDJ3iH
 l3bSTrHOMeOVT3JBc0JHPXkJxhHcM4a5ceZAscEw0umrm5MqkmAJ6LjyLCPckSGhHHTVgow9e
 qYX/YAE5J2yrqkF4o7Z6eIkP4XE6DOpDvX3aulbd0BOfw4zPPhnrcelTxjZr9Z7tx0SIaSLs9
 y/+XB+lT/vq96za805y0YVxaofh6iim6sFVGg/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe a native and wrong idea, but would it work to call
__get_user_pages_locked() instead of __get_user_pages() in
populate_vma_page_range() ?

On Wed, 2019-11-06 at 11:25 +0100, Robert Stupp wrote:
> Here's one more dmesg output with more information captured in
> __get_user_pages() as well. It basically confirms that
> handle_mm_fault() returns VM_FAULT_RETRY.
>
> I'm not sure where and what to change ("fix with a FOLL_TRIED
> somewhere") to make it work. My (uneducated) impression is, that only
> __get_user_pages() needs to be changed - but I might be wrong.
>

