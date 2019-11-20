Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD54C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D274B2251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BnWKQHq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfKTMmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:42:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:46239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbfKTMmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574253753;
        bh=ktPNJbo11jAFf09HBqox2cKDac801mq4F4OHypBVxGQ=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=BnWKQHq4iQv/xHikVEqi4Jk+I/KO93sgAGu7yQS30zu6X9GfnGwtXe3NPgCzuSw8S
         i8ZfXJacu0l0Y/gjejKj8yHyArEtgWIt0b00cKQ18sei0e58L2qSYopTaMQMigItHz
         /5fPNifun7W1hB4C56bOI9lOSpY0v2CP09U8uGT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([79.234.67.220]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1iYVm93EvU-003PRx; Wed, 20
 Nov 2019 13:42:33 +0100
Message-ID: <9621c697a6af55422f8c89087e73dc1ba2098154.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Wed, 20 Nov 2019 13:42:30 +0100
In-Reply-To: <bb7bac8adfce085cdcc080f8f26cbaae2fe916e0.camel@gmx.de>
References: <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
         <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
         <20191105182211.GA33242@cmpxchg.org>
         <20191106120315.GF16085@quack2.suse.cz>
         <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
         <20191106145608.ucvuwsuyijvkxz22@macbook-pro-91.dhcp.thefacebook.com>
         <20191106150524.GL16085@quack2.suse.cz>
         <20191106151429.swqtq2dt4uelhjzn@macbook-pro-91.dhcp.thefacebook.com>
         <9f6b707c69ceb34e3916b1d47f2e2fa6a4f025ab.camel@gmx.de>
         <94c71621a0245db763db9e289286b79056cc9bc5.camel@gmx.de>
         <20191106172520.GF12685@quack2.suse.cz>
         <bb7bac8adfce085cdcc080f8f26cbaae2fe916e0.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c2z0reuhmHPQE6P+OOoRo7l9Ge9xmBIfqb5k89iutFiVnyp+276
 l0a2COapDUmx2LkITh+e2gX9o1yjqio5MJG98kggthJFfh73FlKGNV8LU8x3RUkLnkOLIkN
 8oDWS/R0dk4R+v3PlgBk/pW7yqRqzQu7Wz26dCK2sKl3CoVtvhOl7MyC/zn5QoW8RV9wIvB
 u1+1ZvcFlkx9n2scoraQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gq5FGJg3S7I=:EPzvxHr4tIAJqvgbOFbwm9
 b4HJaOWhwkcjSKiU0S1i41mBiziVFhQYhcW/f5lG9x87nikBP3QeK5SY4IB3ezukWVhElwdB1
 dhME2femUjg4jf26iTDnd7M0cMZv53srFdjEhE5U5hFfQnPWI31Q+4/TiJVydVnKW9NQWkwMP
 U/eWagpD7EiDKypPuJbtzWo4UNJhIPDS89n3X7iq2dSwgCpUZzjQYK6LeRLCid2LcKaMHJ4NS
 Oj/ZNQx6N5JzoIbFgMnoRcEwpisp/RCISRY9C3GM69t86rFytktFYtxFUDqefE71vXcwbWjOt
 5pWxfh9rnS27MGApHjuI5cYzI1FUkhxFbdAhHwZ9Be4rmuAfUrcTx8xR5SUlxyYg8LvumgOOm
 9lcMOT16Jy9whYS0DvfeGPCQwZDXr71EFTisMeZhNlKTuR65PVXeVa7ejpl4+/j9yyFR45mxo
 uq9xjLW3cXE3A1At+MhKKc5A9Dfn09ZJt9Ik9vZkBgWJ881UTrCy667fljQKm9PwnXqLnwRVK
 qDVo+GoN6zHHt2VRtALhfo2RL2Njsv6VgNcm5KP9S9iRWzgxc1d20jp8fqje0x5TOz91HzdBB
 Cxb0Yz6SY2TXNnItI7ZIbgWwwvAvv+UbXQEHYPHmfdHqFiW3KfmfGLI6Gwi/EXLjx3D+4AXM4
 8Ken3y1/bskFJygFuNE5Gvqg567Ec2VphD7yYSfTvTxLhvCl+YDRQGOa+wed2V+Mp8pmA8+z+
 87147qCbiZ21Sq1Ztyx5na/UfAZs+xGtq4K3elwQ3K9O4wXvL8KC7qV/8YWa0Wwtmu0NPUDK0
 wMGQlHPbRO+QbTZVo8f94XIlpyl1Q+jEe1CXfXYAyVoPlzaxNfDdBloOBSyJJFVt4tcUQOxCh
 k2rK+3MDbHXblkISpmY9Es4PGm3amB4Zn9A0HdfFYMrUu+AkkHaLxT26R/YZUGt1EeZEB2Mmn
 /OO4OULWhi7ER0EKOFNAVQ5xDRQheLBA8Fc84c23bZEixLtJ/E0DZYELXZyDEgTY0kCMbZ2wT
 mS2XahS8hcZBo2KbUm9BTQ2xiZiEpyz1R3VfRAcaseB5RWBlWYwXxsztD7/dvTMZacRrfCmO9
 37/IzYXxrQFUyxroKn41c0613j6emOTGAfbs1BrD1ubH4M8aL7lmAsileyJ3MBLxreFVf1eUX
 VCY1P3NR9NiF4/dRjt2EfIuax6SULzDR7Pz7/OT21695EoM3P6VwtYjYbgppxtYBzY+pug2FI
 I6o8BxWv9ZcMxaIqyK/WSLZWNccgoU+GmpYna2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any chance to get a patch merged?

On Thu, 2019-11-07 at 09:08 +0100, Robert Stupp wrote:
> On Wed, 2019-11-06 at 18:25 +0100, Jan Kara wrote:
> > On Wed 06-11-19 18:03:10, Robert Stupp wrote:
> > > Oh, and I just realized, that I have two custom settings in my
> > > /etc/rc.local - guess, I configured that when I installed that
> > > machine
> > > years ago. Sorry, that I haven't mentioned that earlier.
> > >
> > > echo 0 > /sys/block/nvme0n1/queue/read_ahead_kb
> > > echo never >
> > > /sys/kernel/mm/transparent_hugepage/defrag
> > >
> > > That setting is probably not quite standard, but I assume there
> > > are
> > > some database server setups out there, that set RA=3D0 as well.
> >
> > Ok, yes, that explains ra_pages =3D=3D 0. Thanks for the details.
>
> Ah! And with these settings, a fresh & clean installation of Ubuntu
> eoan (5.3.x kernel), hangs during reboot.
> And if the VM's booted with these settings in /etc/rc.local, the
> mlockall(MCL_CURRENT) is reproducible as well.
>
>

