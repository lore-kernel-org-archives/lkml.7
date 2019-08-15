Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66164C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304A6208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hTvydnEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfHOAKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:10:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17989 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHOAJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:09:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d54a2d90000>; Wed, 14 Aug 2019 17:10:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 14 Aug 2019 17:09:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 14 Aug 2019 17:09:59 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Aug
 2019 00:09:55 +0000
Subject: Re: turn hmm migrate_vma upside down v3
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190814075928.23766-1-hch@lst.de>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <8e3b17ef-0b9e-6866-128f-403c8ba3a322@nvidia.com>
Date:   Wed, 14 Aug 2019 17:09:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190814075928.23766-1-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565827801; bh=UFE11LA+ZDd79e7Fh4F3PTQQo4YwL9Cl4D835Utwz2E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hTvydnEs0xSSVJWPajFZPOOuonANGrVb61PcnHEcdZAa1Izsz9/gKb19ZA98X8SzE
         AvqduFk9EUWUOqgXmyGPSL5MQbVY4v/pzouHJDVQk9niKC3bZiG1TXDZv99HcXZFeO
         JNO6B/xaf/pGhk5df1D+EvN7msxDZUFjg01SoQ7+73tpn3RJ+XwxPfvKKCmivQeIsy
         dDWNjuOZOKhNMMMStclR1bhAFqwIy8eXpTgWYcWh6BlSWM44vpQgH/OgbRe24ZBOcA
         yfx9TUJlXzKMfQWSJDMBK+DLGwIcpX57KXDaDNMZN21bi3WpHUr2NJY0xjwWi+KLja
         gUC703gAIO5Ug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/14/19 12:59 AM, Christoph Hellwig wrote:
> Hi J=C3=A9r=C3=B4me, Ben and Jason,
>=20
> below is a series against the hmm tree which starts revamping the
> migrate_vma functionality.  The prime idea is to export three slightly
> lower level functions and thus avoid the need for migrate_vma_ops
> callbacks.
>=20
> Diffstat:
>=20
>      7 files changed, 282 insertions(+), 614 deletions(-)
>=20
> A git tree is also available at:
>=20
>      git://git.infradead.org/users/hch/misc.git migrate_vma-cleanup.3
>=20
> Gitweb:
>=20
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/migr=
ate_vma-cleanup.3
>=20
>=20
> Changes since v2:
>   - don't unmap pages when returning 0 from nouveau_dmem_migrate_to_ram
>   - minor style fixes
>   - add a new patch to remove CONFIG_MIGRATE_VMA_HELPER
>=20
> Changes since v1:
>   - fix a few whitespace issues
>   - drop the patch to remove MIGRATE_PFN_WRITE for now
>   - various spelling fixes
>   - clear cpages and npages in migrate_vma_setup
>   - fix the nouveau_dmem_fault_copy_one return value
>   - minor improvements to some nouveau internal calling conventions
>=20

Some of the patches seem to have been mangled in the mail.
I was able to edit them and apply to Jason's tree
https://github.com/jgunthorpe/linux.git mmu_notifier branch.
So for the series you can add:

Tested-by: Ralph Campbell <rcampbell@nvidia.com>
