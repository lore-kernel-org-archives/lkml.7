Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F4C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF0021955
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WU2eFWp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfGWBLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:11:06 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1836 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfGWBLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:11:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d365ea90001>; Mon, 22 Jul 2019 18:11:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Jul 2019 18:11:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 22 Jul 2019 18:11:05 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 01:11:04 +0000
Subject: Re: hmm_range_fault related fixes and legacy API removal v2
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190722094426.18563-1-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <7e1f33d4-4d3b-7927-38d1-b98b22ed4d78@nvidia.com>
Date:   Mon, 22 Jul 2019 18:11:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722094426.18563-1-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563844265; bh=kscjS9D5ks2yd1t6YQtphh4j4hyaf8nJbzsPpcUAaRc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WU2eFWp8VxG3UTGHueSY5tPs9QU3Wq1Nhlz7guFIcl97+4qhR5QlTL95yfCf6KxaI
         zvG+wvbWkdeVrOlsvcu9YwOHFT+WhYBVxi0yTHTWJWeWbv6TU9qyGLhWAtsIkPPaUh
         awR6kqifuiaeIQAF50GonIw3mX+YkzyT++89VwOOVQISWEr4pkMmJrnIHmsaUNvtoH
         2zoQh8J+5RREkogqGWoKWu0eSqZGrb3UTIfWNNhJ6ZMui5fwrfv3d5fUl6WLQXvfdN
         gouWM4XU2Cp0eWulPvR6IKD/vQGHTorAA3LK19GR8gPJFxIuXdMCgf+trx2P/b7oT/
         xtykT8kHaBN4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/19 2:44 AM, Christoph Hellwig wrote:
> Hi J=C3=A9r=C3=B4me, Ben and Jason,
>=20
> below is a series against the hmm tree which fixes up the mmap_sem
> locking in nouveau and while at it also removes leftover legacy HMM APIs
> only used by nouveau.
>=20
> The first 4 patches are a bug fix for nouveau, which I suspect should
> go into this merge window even if the code is marked as staging, just
> to avoid people copying the breakage.
>=20
> Changes since v1:
>   - don't return the valid state from hmm_range_unregister
>   - additional nouveau cleanups
>=20

I ran some OpenCL tests from Jerome with nouveau and this series,
5.3.0-rc1, and my two HMM fixes:
("mm/hmm: fix ZONE_DEVICE anon page mapping reuse")
("mm/hmm: Fix bad subpage pointer in try_to_unmap_one")

You can add for the series:
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
