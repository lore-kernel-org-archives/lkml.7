Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6993206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="tFEObTs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLWMcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:32:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43850 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLWMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 07:32:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so12574911qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 04:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=5v07SKyPaqffC8bgmTpkEvagnuvh7nvXwKsl6Tz/hL8=;
        b=tFEObTs8/qK+YCCxq6rd2xWJLb5qMY6jSRETUikApl3wF4s8YwsthzwPkk00RUqNtr
         xOCi/4YeetxUNLJnaraqe3fwNfeZKzdKrChvEvNTtP03YyTkE8tHw+wOzFwl6wBl1p3s
         2+IQSvguDAoWtrFVTiM97pUGw5XT6nNATFDl6p4oy1mSGFckJaYUyvOboMoh6iBReLeg
         Tc27pAPYvWPCX7BRmlq/6OFpFr3PuQjNlP6+5QbzdL3LnRSxkl6Lko+doqfT1dtT0Lfz
         SHJsVSvmKeJuyVQhq/EkIbLdYO+MBMAup+l49cmargA+jDKlef0FoOfphoiLBLEqc4+K
         9ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5v07SKyPaqffC8bgmTpkEvagnuvh7nvXwKsl6Tz/hL8=;
        b=gT9NWo1rB78HrQUtyyjvEeSl9leasDiFU/QDBtcYEHl/dYKWtHEMCd6BWTbOvnB8vo
         z+nn1VwcRMj+eCNyKryjmTLGSMhwnHFqKy2XryPiYNrN4WxXckyy+tVXwaBUHW6OUEXZ
         834xbKr9OmiVonFcUqfooTUvk2398kw+pr5ajqy+g4EzCqZSg+J4SUpsl8mf2h0wXKwv
         F1SxmHSe5mzUQfDgWUiNzM0CiTLoE4zkZnLL56ANz2iPVTa9LDKrMRVNClnLk2XMia1i
         jUpDLf9OgiQj0SgHFAx0e2IylmlVt97O128gVRfVishixOPRgJ3a+yNfGhqy0LqrZ5HA
         O2LA==
X-Gm-Message-State: APjAAAWtmmt3/7E2PeGclzoUPBijehYRMPfcO8VNdpQSSkbImcFY5SCH
        5NK99ZI5/uSB3dxVI1Sc7IuRvbb+c38=
X-Google-Smtp-Source: APXvYqzomcqE0md8Wui8VaPZ7yD3QLDSggZQbK8fs17J1q5ZqSVle38Zt4wXVU70LiGdk2yXOhAAJA==
X-Received: by 2002:aed:22c8:: with SMTP id q8mr23370747qtc.133.1577104372593;
        Mon, 23 Dec 2019 04:32:52 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v5sm6253417qth.70.2019.12.23.04.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 04:32:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM panic occurs
Date:   Mon, 23 Dec 2019 07:32:50 -0500
Message-Id: <2B938D94-FFBB-4A3D-AD07-D7D04A4D4161@lca.pw>
References: <20191223113326.13828-1-miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
In-Reply-To: <20191223113326.13828-1-miles.chen@mediatek.com>
To:     Miles Chen <miles.chen@mediatek.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 23, 2019, at 6:33 AM, Miles Chen <miles.chen@mediatek.com> wrote:
>=20
> Motivation:
> -----------
>=20
> When debug with a OOM kernel panic, it is difficult to know the
> memory allocated by kernel drivers of vmalloc() by checking the
> Mem-Info or Node/Zone info. For example:
>=20
>  Mem-Info:
>  active_anon:5144 inactive_anon:16120 isolated_anon:0
>   active_file:0 inactive_file:0 isolated_file:0
>   unevictable:0 dirty:0 writeback:0 unstable:0
>   slab_reclaimable:739 slab_unreclaimable:442469
>   mapped:534 shmem:21050 pagetables:21 bounce:0
>   free:14808 free_pcp:3389 free_cma:8128
>=20
>  Node 0 active_anon:20576kB inactive_anon:64480kB active_file:0kB
>  inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
>  mapped:2136kB dirty:0kB writeback:0kB shmem:84200kB shmem_thp: 0kB
>  shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB
>  all_unr eclaimable? yes
>=20
>  Node 0 DMA free:14476kB min:21512kB low:26888kB high:32264kB
>  reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
>  active_file: 0kB inactive_file:0kB unevictable:0kB writepending:0kB
>  present:1048576kB managed:952736kB mlocked:0kB kernel_stack:0kB
>  pagetables:0kB bounce:0kB free_pcp:2716kB local_pcp:0kB free_cma:0kB
>=20
> The information above tells us the memory usage of the known memory
> categories and we can check the abnormal large numbers. However, if a
> memory leakage cannot be observed in the categories above, we need to
> reproduce the issue with CONFIG_PAGE_OWNER.
>=20
> It is possible to read the page owner information from coredump files.
> However, coredump files may not always be available, so my approach is
> to print out the largest page consumer when OOM kernel panic occurs.

Many of those patches helping debugging special cases had been shot down in t=
he past. I don=E2=80=99t see much difference this time. If you worry about m=
emory leak, enable kmemleak and then to reproduce. Otherwise, we will end up=
 with too many heuristics just for debugging.

>=20
> The heuristic approach assumes that the OOM kernel panic is caused by
> a single backtrace. The assumption is not always true but it works in
> many cases during our test.
>=20
> We have tested this heuristic approach since 2019/5 on android devices.
> In 38 internal OOM kernel panic reports:
>=20
> 31/38: can be analyzed by using existing information
> 7/38: need page owner formatino and the heuristic approach in this patch
> prints the correct backtraces of abnormal memory allocations. No need to
> reproduce the issues.
