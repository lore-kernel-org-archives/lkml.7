Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AF8C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3192175B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jHtVNZux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbfGHRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:30:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19911 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfGHRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:30:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d237dcc0001>; Mon, 08 Jul 2019 10:30:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 08 Jul 2019 10:30:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 08 Jul 2019 10:30:56 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jul
 2019 17:30:55 +0000
Subject: Re: hmm_range_fault related fixes and legacy API removal v2
To:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
CC:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190703220214.28319-1-hch@lst.de>
 <20190704164236.GP3401@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <41dbb308-fc9e-d730-ffb0-6ce051dff1e1@nvidia.com>
Date:   Mon, 8 Jul 2019 10:30:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704164236.GP3401@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562607052; bh=uAosH4rcWhCpsYgdv7tD56ho8lbt2DTohfs/exVueGE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jHtVNZux6j3btAC9zECxouW2X2X+bK1i9oF4C4A/Q9DWBR6i+sgDlWhjq9OHySob+
         NKYQ+ttlZ144MP71OeW7R8RFbx3dpzYZtDFxJ4U8MMtirXaSFOMFf5Wrr/ALyvn0NV
         ImhfP70z7sKEnSBaWwJDHhcwMQ7Lzp2xgBPbUa5ma7/wScK0abV/JFCWJFKePtyEiY
         3wz80LEdu5nuw/rDGedPWDuwfuYUC1cP3J4H+C0Ewt3gXjrcCe8fQAHRVFUUmKBA3V
         pPffYKMqtSM0gysCMdxQnW88TizXrXplVyoXYIzb8LYYAAFg8PE1kZsaKHw5TlXlOl
         tHpsXfTMIiEcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/19 9:42 AM, Jason Gunthorpe wrote:
> On Wed, Jul 03, 2019 at 03:02:08PM -0700, Christoph Hellwig wrote:
>> Hi J=C3=A9r=C3=B4me, Ben and Jason,
>>
>> below is a series against the hmm tree which fixes up the mmap_sem
>> locking in nouveau and while at it also removes leftover legacy HMM APIs
>> only used by nouveau.
>>
>> Changes since v1:
>>   - don't return the valid state from hmm_range_unregister
>>   - additional nouveau cleanups
>=20
> Ralph, since most of this is nouveau could you contribute a
> Tested-by? Thanks
>=20
> Jason
>=20

I can test things fairly easily but with all the different patches,
conflicts, and personal git trees, can you specify the git tree
and branch with everything applied that you want me to test?
