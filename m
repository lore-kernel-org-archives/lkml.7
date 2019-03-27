Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5283CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F22B206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IvZHSl+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfC0RBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:01:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17863 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfC0RBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:01:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9bac420000>; Wed, 27 Mar 2019 10:00:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 10:00:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 Mar 2019 10:00:52 -0700
Received: from [10.2.164.169] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 17:00:52 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Yang Shi <yang.shi@linux.alibaba.com>, <mhocko@suse.com>,
        <mgorman@techsingularity.net>, <riel@surriel.com>,
        <hannes@cmpxchg.org>, <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
Date:   Wed, 27 Mar 2019 10:00:51 -0700
X-Mailer: MailMate (1.12.4r5622)
Message-ID: <2C32F713-2156-4B58-B5C1-789C1821EBB9@nvidia.com>
In-Reply-To: <20190327130822.GD7389@localhost.localdomain>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <20190324222040.GE31194@localhost.localdomain>
 <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
 <20190327003541.GE4328@localhost.localdomain>
 <39d8fb56-df60-9382-9b47-59081d823c3c@linux.alibaba.com>
 <20190327130822.GD7389@localhost.localdomain>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed;
        boundary="=_MailMate_FDAFDC66-07F4-44F7-9872-93BE2994CEDA_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553706051; bh=Io+E5uEESZPp1e9HALilVFuhRQtmhI/36F2P/dMd/ho=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=IvZHSl+tgFV6D4idQxZTXdUfHMcBl+ShUvrE5uXkfGG4Db3DX2DHDQh17O39LV+ce
         Ufm4OpM6vpWU7wTDnsIDvtuihTe+yCyZWkJMVuXSaQii6g+GCdajD7ejGKrXwOWFvH
         R2Tun0CTNZO/Vkemb6HWBLBraOi3aIdjCFOLV4Cndo0UtQ8Nk7AxveDhV+p9tD2iqm
         /atJ0ZPWGg+7QVN+2YnXt/yrnwtHVUneUR+WzjMOoeyKie6OewIkspWPJkeuUCLiCo
         EDAoZJpQJlva3Fb6BtW0Obq1cnGuDCzePtOcgsTLGk6KA/RQvAzf2JCfjvBdh5q4fr
         7dbfuZb7tL7zg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FDAFDC66-07F4-44F7-9872-93BE2994CEDA_=
Content-Type: text/plain; markup=markdown

On 27 Mar 2019, at 6:08, Keith Busch wrote:

> On Tue, Mar 26, 2019 at 08:41:15PM -0700, Yang Shi wrote:
>> On 3/26/19 5:35 PM, Keith Busch wrote:
>>> migration nodes have higher free capacity than source nodes. And since
>>> your attempting THP's without ever splitting them, that also requires
>>> lower fragmentation for a successful migration.
>>
>> Yes, it is possible. However, migrate_pages() already has logic to
>> handle such case. If the target node has not enough space for migrating
>> THP in a whole, it would split THP then retry with base pages.
>
> Oh, you're right, my mistake on splitting. So you have a good best effort
> migrate, but I still think it can fail for legitimate reasons that should
> have a swap fallback.

Does this mean we might want to factor out the page reclaim code in shrink_page_list()
and call it for each page, which fails to migrate to PMEM. Or do you still prefer
to migrate one page at a time, like what you did in your patch?

I ask this because I observe that migrating a list of pages can achieve higher
throughput compared to migrating individual page. For example, migrating 512 4KB
pages can achieve ~750MB/s throughput, whereas migrating one 4KB page might only
achieve ~40MB/s throughput. The experiments were done on a two-socket machine
with two Xeon E5-2650 v3 @ 2.30GHz across the QPI link.


--
Best Regards,
Yan Zi

--=_MailMate_FDAFDC66-07F4-44F7-9872-93BE2994CEDA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAlybrEMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK/twP/3lcO6kKxaHl/38KpTngJX//h7UJzoANsSrb
le5gVdUnBGP9KnFWyltBDEbNggucShHm+U5hFBvrkDzY/fO8BJTM5ypXiPxDr7h1
5XyvCJuuBtSE24X5autv1xF4QKIHTb69N9uojoMy4WYyQmnuuuMTC6vFICUinQuL
pQHHtx2VxINXRVPOcW6XMYxBopW5+MuYyXtFRrT9+tEQvJ9Fw3Gwg0JwuiEZx9Sh
aUJhOrg+43Lfs0ES0i31Mw7KD+csr/uii+HVdOT/FBEtge8QvxlV2FxBnINkpHa6
xVo5cWoNbo++rdpobmnOsjQvJ01WWyoaTwvHOITU5zmH85IVraI0N7G5PsCMuexB
Hvvndlo+WNcGTvF3YgQgLb/0xRjqT77Jwli7rXMNhihXLyw5cZrGTwueEJV8saou
oXDw7WzLUokCPPuhdicKt8uQ+encxv20TxGxZrPCu9hL+7+s/DLZ3BhwptTkvhbF
TQeGbfbCKTlifJ3AqSi1041vwxTz2C0moUz5kWIgf2rZG/NlM8S6AwPv2hHTxzLZ
PEtY7fdJCEYLk5DPkkwBxpiH/JM/yyQLH0WOHYpbxWxtR/5CMnE+YR1JNL2hKs7e
kOalkTxRURDb/3+uGUAPWEY+VWOhzU5DIsO28zXopEQCWB+sVYinCLhUdgroRgAD
Bx5LaaKT
=HFOS
-----END PGP SIGNATURE-----

--=_MailMate_FDAFDC66-07F4-44F7-9872-93BE2994CEDA_=--
