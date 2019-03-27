Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B9BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C692054F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WDv4wpdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfC0Um7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:42:59 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19199 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfC0Um6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:42:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9bdf160000>; Wed, 27 Mar 2019 13:37:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 13:37:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 27 Mar 2019 13:37:47 -0700
Received: from [10.2.162.144] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 20:37:47 +0000
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
Date:   Wed, 27 Mar 2019 13:37:46 -0700
X-Mailer: MailMate (1.12.4r5622)
Message-ID: <6A903D34-A293-4056-B135-6FA227DE1828@nvidia.com>
In-Reply-To: <3fd20a95-7f2d-f395-73f6-21561eae9912@intel.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <20190324222040.GE31194@localhost.localdomain>
 <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
 <20190327003541.GE4328@localhost.localdomain>
 <39d8fb56-df60-9382-9b47-59081d823c3c@linux.alibaba.com>
 <20190327130822.GD7389@localhost.localdomain>
 <2C32F713-2156-4B58-B5C1-789C1821EBB9@nvidia.com>
 <de044f93-c4e8-8b8b-9372-e15ca74e7696@intel.com>
 <33FCCD53-4A4D-4115-9AC3-6C35A300169F@nvidia.com>
 <3fd20a95-7f2d-f395-73f6-21561eae9912@intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed;
        boundary="=_MailMate_2BEEEC6C-1579-462B-8F1F-950E33DD9DA3_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553719062; bh=h36SjGYinWxbAr88VzsF+G4sIWd6jVLSJPZTBRLBtF4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=WDv4wpdPTmvMVsOp5DLAZLpm1eO2fYzW5JwqOM/b7eWwEP0/j4paEshOSfmkoAlHm
         eWSwPOBGBekT0YMn+yix5ksiQfFB4lxpo5K9NWCAUK9a9eM+vpRupSBX9KRn6BaM/p
         CSH7jrbSXyK8/N3g/1krBo36Z/Uex/gl7ekFeo29beNQXjcoc+OCfNnxpPmeC7pEpu
         51cw6tucUDRg1nxIJWVJ5uNcUyBmpa7qc2djucHG1bL8GTP2N6mxPXbsIIYxMuopaG
         y62jS5H5ZNnargM9K/r3zrgJd+9tMef49GIbFk8uond+joeC8MXzCOnR0byygSLv4l
         yhOapVQn6ypNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2BEEEC6C-1579-462B-8F1F-950E33DD9DA3_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 Mar 2019, at 11:00, Dave Hansen wrote:

> On 3/27/19 10:48 AM, Zi Yan wrote:
>> For 40MB/s vs 750MB/s, they were using sys_migrate_pages(). Sorry
>> about the confusion there. As I measure only the migrate_pages() in
>> the kernel, the throughput becomes: migrating 4KB page: 0.312GB/s
>> vs migrating 512 4KB pages: 0.854GB/s. They are still >2x
>> difference.
>>
>> Furthermore, if we only consider the migrate_page_copy() in
>> mm/migrate.c, which only calls copy_highpage() and
>> migrate_page_states(), the throughput becomes: migrating 4KB page:
>> 1.385GB/s vs migrating 512 4KB pages: 1.983GB/s. The gap is
>> smaller, but migrating 512 4KB pages still achieves 40% more
>> throughput.
>>
>> Do these numbers make sense to you?
>
> Yes.  It would be very interesting to batch the migrations in the
> kernel and see how it affects the code.  A 50% boost is interesting,
> but not if it's only in microbenchmarks and takes 2k lines of code.
>
> 50% is *very* interesting if it happens in the real world and we can
> do it in 10 lines of code.
>
> So, let's see what the code looks like.

Actually, the migration throughput difference does not come from any kern=
el
changes, it is a pure comparison between migrate_pages(single 4KB page) a=
nd
migrate_pages(a list of 4KB pages). The point I wanted to make is that
Yang=E2=80=99s approach, which migrates a list of pages at the end of shr=
ink_page_list(),
can achieve higher throughput than Keith=E2=80=99s approach, which migrat=
es one page
at a time in the while loop inside shrink_page_list().

In addition to the above, migrating a single THP can get us even higher t=
hroughput.
Here is the throughput numbers comparing all three cases:
                             |  migrate_page()  |    migrate_page_copy()
migrating single 4KB page:   |  0.312GB/s       |   1.385GB/s
migrating 512 4KB pages:     |  0.854GB/s       |   1.983GB/s
migrating single 2MB THP:    |  2.387GB/s       |   2.481GB/s

Obviously, we would like to migrate THPs as a whole instead of 512 4KB pa=
ges
individually. Of course, this assumes we have free space in PMEM for THPs=
 and
all subpages in the THPs are cold.


To batch the migration, I posted some code a while ago: https://lwn.net/A=
rticles/714991/,
which show good throughput improvement for microbenchmarking sys_migrate_=
page().
It also included using multi threads to copy a page, aggregate multiple m=
igrate_page_copy(),
and even using DMA instead of CPUs to copy data. We could revisit the cod=
e if necessary.

In terms of end-to-end results, I also have some results from my paper:
http://www.cs.yale.edu/homes/abhishek/ziyan-asplos19.pdf (Figure 8 to Fig=
ure 11 show the
microbenchmark result and Figure 12 shows end-to-end results). I basicall=
y called
shrink_active/inactive_list() every 5 seconds to track page hotness and u=
sed all my page
migration optimizations above, which can get 40% application runtime spee=
dup on average.
The experiments were done in a two-socket NUMA machine where one node was=
 slowed down to
have 1/2 BW and 2x access latency, compared to the other node. I can disc=
uss about it
more if you are interested.


--
Best Regards,
Yan Zi

--=_MailMate_2BEEEC6C-1579-462B-8F1F-950E33DD9DA3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAlyb3xoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK1UMP/1Pd0ozYIfrQ0JNoHBz4zGr3O71WjEcSr08P
CUb/SsBmh03a2LXJKCy5hcR89ihFzdXKQ+/iqhwagUyGZic0ocOzABh/KikFqnKV
nRtenfr3v62erGE955BWGZZxoKlzOeP3zkdL6qbKH8qXtB79cj835HTN+P9U+mUH
d1+0eCB8i3F0xS/BMyVn5e44p2mKuNOYFIY+vSjO2XISVr9lLjYJa7LiGTvIHqgP
R/QtPqP7wULvOS2xJ4HPAQ0TR3QDJs5obgekwJqjxHX+38B6FCLQ7bR5nsUrJyAT
4UDNEAl9ano9aZtaVfDr9My9zuAaZQwlHvwfhfmYhos+e+Vf2vjx9XZy3Mubo0eE
co0nrQUb9oKP88ACfaXI2Nqsa+/ctQQdkITiEHWxMQhtFvq5VcHwir5oBIG/Ylhv
6WwwYmSBlQoYC5TibSHMcpqjr1XGZU1UHEBtobqngrPlcvFYyuQrqqScoPYgi8vf
vFATQt1Goqwiky0+0vlazCmVzNIALxbZ4WqsmmDSY+SvoJ3QOtnaG26szOhgvGv+
0knzMccufS2QNwXuxJyiWzoKmlGpGNklkNcVQkPsSmMMXvdrwImn2aVII9MFoZ8H
kjDLEyYY29BzhwYLk28Yz0ijXb7zaNVD+DGS3WBf052aGMPwDTEbrETe+1Q9pzpW
HFCg5iF5
=lzxQ
-----END PGP SIGNATURE-----

--=_MailMate_2BEEEC6C-1579-462B-8F1F-950E33DD9DA3_=--
