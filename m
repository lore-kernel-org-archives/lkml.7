Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD10C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4217C218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rSA4j7D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfGZAzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:55:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17949 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGZAzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:55:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4f710000>; Thu, 25 Jul 2019 17:55:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:55:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 25 Jul 2019 17:55:05 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:55:01 +0000
Subject: Re: hmm_range_fault related fixes and legacy API removal v3
To:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
CC:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190724065258.16603-1-hch@lst.de>
 <20190726001622.GL7450@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a07dbc3b-7a54-e524-944a-b7e4e49b2a93@nvidia.com>
Date:   Thu, 25 Jul 2019 17:55:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726001622.GL7450@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102513; bh=ZQ1jv0UqwPmyi2RPWuaB3X1EU0IchBq6t+yb1fsAdJ4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rSA4j7D/xNb2bkL0Vko/F5CDOw23LnvAQ9X4DTiY7zQS3PiAsqw2fzljmrhRjSyBN
         4X3+94583ksRVxxOzb4rj3LQNLiQxzqNjNyzesErehEFqBsooYKLAg/6fe8WILNsKM
         Xr0M1AvN11D0pFDeVa9NIi04J+6Xn9RViB3w/Xj05ZxX6hpsr0f8ZB6QJs2eJXsNN6
         ttQj2VXTgfGFRU0syqQpO7ddPAhhik56aRFDYDMQRLAVAQ2EnplEBlWLmgGBf7zqPq
         oMGDywdYOAXCAq0xaRkg8JQMI/T5f0db79g5qEltRtKCCl+kLC+9f5Lq1eyKng0xeq
         T07CsoiXv06rQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/19 5:16 PM, Jason Gunthorpe wrote:
> On Wed, Jul 24, 2019 at 08:52:51AM +0200, Christoph Hellwig wrote:
>> Hi J=C3=A9r=C3=B4me, Ben and Jason,
>>
>> below is a series against the hmm tree which fixes up the mmap_sem
>> locking in nouveau and while at it also removes leftover legacy HMM APIs
>> only used by nouveau.
>>
>> The first 4 patches are a bug fix for nouveau, which I suspect should
>> go into this merge window even if the code is marked as staging, just
>> to avoid people copying the breakage.
>>
>> Changes since v2:
>>   - new patch from Jason to document FAULT_FLAG_ALLOW_RETRY semantics
>>     better
>>   - remove -EAGAIN handling in nouveau earlier
>=20
> I don't see Ralph's tested by, do you think it changed enough to
> require testing again? If so, Ralph would you be so kind?
>=20
> In any event, I'm sending this into linux-next and intend to forward
> the first four next week.
>=20
> Thanks,
> Jason
>=20

I have been testing Christoph's v3 with my set of v2 changes so
feel free to add my tested-by.
