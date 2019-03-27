Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E7EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A03920651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X98tPKAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfC0Rs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:48:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8577 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfC0Rs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:48:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9bb7640000>; Wed, 27 Mar 2019 10:48:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 10:48:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 27 Mar 2019 10:48:26 -0700
Received: from [10.8.0.10] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 17:48:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Keith Busch <kbusch@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, <mhocko@suse.com>,
        <mgorman@techsingularity.net>, <riel@surriel.com>,
        <hannes@cmpxchg.org>, <akpm@linux-foundation.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
Date:   Wed, 27 Mar 2019 10:48:24 -0700
X-Mailer: MailMate (1.12.4r5622)
Message-ID: <33FCCD53-4A4D-4115-9AC3-6C35A300169F@nvidia.com>
In-Reply-To: <de044f93-c4e8-8b8b-9372-e15ca74e7696@intel.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <20190324222040.GE31194@localhost.localdomain>
 <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
 <20190327003541.GE4328@localhost.localdomain>
 <39d8fb56-df60-9382-9b47-59081d823c3c@linux.alibaba.com>
 <20190327130822.GD7389@localhost.localdomain>
 <2C32F713-2156-4B58-B5C1-789C1821EBB9@nvidia.com>
 <de044f93-c4e8-8b8b-9372-e15ca74e7696@intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed;
        boundary="=_MailMate_DA82EAD0-1665-4A6E-B1C4-471399DCFEE3_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553708900; bh=3uC4woD28mUbj6hka+LT/3mMwTXJ9j6nWGLKp/z7ZUA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=X98tPKAj4hWpv3TDBg8/pHxYNSMGqMi0/QaE8gplerWMfZSBIc5ZnYiexlpuTHm0o
         Gh8qlMZOGrJxuIQZ3EGawHq1OGSdGasO+R/gupi7qVvTIhjIl+p9dfY89xDP/sY+4c
         xGVQs5HisiJNKQN5WonEb10vr7v7TAKurUWE/CMSjtrZh7cY69nvcxrOfqAXURsXbx
         XZI0IzLMkN7sGzSybiFTccCD1qpfY2xYl0nHJ4vDv3GBYcg6ER3xLdFpKs8QeqkvaL
         PllnVqu5PE39ToT7MgShFrCpP1u9SxCgny8QpPf7jWiUCpCG3+CFGnNK+v9nzfOV6M
         ZoZToMd+wPGKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DA82EAD0-1665-4A6E-B1C4-471399DCFEE3_=
Content-Type: text/plain; markup=markdown

On 27 Mar 2019, at 10:05, Dave Hansen wrote:

> On 3/27/19 10:00 AM, Zi Yan wrote:
>> I ask this because I observe that migrating a list of pages can
>> achieve higher throughput compared to migrating individual page.
>> For example, migrating 512 4KB pages can achieve ~750MB/s
>> throughput, whereas migrating one 4KB page might only achieve
>> ~40MB/s throughput. The experiments were done on a two-socket
>> machine with two Xeon E5-2650 v3 @ 2.30GHz across the QPI link.
>
> What kind of migration?
>
> If you're talking about doing sys_migrate_pages() one page at a time,
> that's a world away from doing something inside of the kernel one page
> at a time.

For 40MB/s vs 750MB/s, they were using sys_migrate_pages(). Sorry about
the confusion there. As I measure only the migrate_pages() in the kernel,
the throughput becomes:
migrating 4KB page: 0.312GB/s vs migrating 512 4KB pages: 0.854GB/s.
They are still >2x difference.

Furthermore, if we only consider the migrate_page_copy() in mm/migrate.c,
which only calls copy_highpage() and migrate_page_states(), the throughput
becomes:
migrating 4KB page: 1.385GB/s vs migrating 512 4KB pages: 1.983GB/s.
The gap is smaller, but migrating 512 4KB pages still achieves 40% more
throughput.

Do these numbers make sense to you?

--
Best Regards,
Yan Zi

--=_MailMate_DA82EAD0-1665-4A6E-B1C4-471399DCFEE3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAlybt2gPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK2AIQAIRQiK8keuvId46x28T0mxfxbYEnY9JeawL+
A3wFyX7orcvpKhU34luIwqi1cidMS64yzUj6QImSMvHTbUJS94BAXUFXE3iEhvTo
tJlB8OvVsB0y6rItgU0sNelNw0cjI5zl4/Z0950ljRGrFAB5eLSpadsXSkQRzF/n
dUrea31T/Lw7nK1DQY0Zd3U7hIPXdB3N9And5zIm9L3SEC7dgIULYgfm6x09Q7fr
9ylKEFlXne3RPaBXbGkfBnS7GkqlLzpLMRfzIFvV1aVqOVS75IR6hYg/Jli+X4UL
5svPHFnaxnTEE74fkEIKpVYiZDot3wc1UjGc/EQ7TTC5ZOOtp9bZROoEGQKgraAs
aRGB4yeLKac7LHD2sa0YI6mUtTl7mXscsSH1j7DM8LnX+svcZCk4lPpsW21DMYtA
s8lg13dBs2Y4oIV5MC85McxTfJj2w39c7kpgUxkZH49hJnZA94YSETS3SvdYZr2j
cT3uDMX6Kt/zQkWjcTZjiUp38ZNhg1NZtvrODf6SeVVXR+KSPxPp4rCd99MKDfT7
AiTlHYsE2dHa2JTp8CMZUw61RVpjjvy97C/uNiWTGquzKu69yvyD8ooCgeXtIi3b
AYCxDjlEITvVG+CSfZBwj4eDdeBRcar20dQNss1ZYxNy2bSFwiDOH7HLx/NqOg4y
0Cm+F72l
=Zvlc
-----END PGP SIGNATURE-----

--=_MailMate_DA82EAD0-1665-4A6E-B1C4-471399DCFEE3_=--
