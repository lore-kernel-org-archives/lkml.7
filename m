Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185AEC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E380421842
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0Z3b9Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbfGZR6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:58:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35156 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbfGZR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:58:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6QHrRdQ070868;
        Fri, 26 Jul 2019 17:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yeCMaN4K2ZO7buQVH+UC6UxQHTwLlHucEGyTiE6T/j8=;
 b=V0Z3b9HcNgBLGK896nLr2lpPLZ3t1rvtynwo15NBI8+Rb9P+k8AH9iYWd+kfaPmp8Lnd
 0a2r3afMlMyIHnVJK3DO3MwMV3zYSN7DZfOLLhSHkgIOj7F/pqIbhehWBukF5lfyQytt
 wudHYssGhgewTAGbbkiNjL3zXo5a0UeOyJKooPUuHbCTDKoqAhelFGKSn+tAQgnqbKg8
 EUHF/9KD9mK+AG+orSGaqCT1LXFUd5Hyw/zUgnC1WgHaxkUixgPrHyD9XdcmGYoDBlkt
 OqguUQqE+9zgFzfUuLOrF9LXUBib1fbRrmKsgxTHwSnkUMgb3UUbN73fX3Qu52yi7jvb pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tx61ccdbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 17:58:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6QHvSiE095495;
        Fri, 26 Jul 2019 17:58:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tx60ymgxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 17:58:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6QHw4SK007947;
        Fri, 26 Jul 2019 17:58:04 GMT
Received: from [10.154.133.139] (/10.154.133.139)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jul 2019 10:58:04 -0700
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190625143715.1689-1-hch@lst.de>
 <20190625143715.1689-10-hch@lst.de> <20190717215956.GA30369@altlinux.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <14242f6d-e833-c5b7-3748-458f31039b84@oracle.com>
Date:   Fri, 26 Jul 2019 11:58:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717215956.GA30369@altlinux.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9330 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907260215
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9330 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/19 3:59 PM, Dmitry V. Levin wrote:
> Hi,
>=20
> On Tue, Jun 25, 2019 at 04:37:08PM +0200, Christoph Hellwig wrote:
>> The sparc64 code is mostly equivalent to the generic one, minus variou=
s
>> bugfixes and two arch overrides that this patch adds to pgtable.h.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>  arch/sparc/Kconfig                  |   1 +
>>  arch/sparc/include/asm/pgtable_64.h |  18 ++
>>  arch/sparc/mm/Makefile              |   2 +-
>>  arch/sparc/mm/gup.c                 | 340 ---------------------------=
-
>>  4 files changed, 20 insertions(+), 341 deletions(-)
>>  delete mode 100644 arch/sparc/mm/gup.c
>=20
> So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> (thanks to Anatoly for bisecting) and introduced a regression:=20
> futex.test from the strace test suite now causes an Oops on sparc64
> in futex syscall
>=20

I have been working on reproducing this problem but ran into a different
problem. I found 5.1 and newer kernels no longer boot on an S7 server or
in an ldom on a T7 server (kernel hangs after "crc32c_sparc64: Using
sparc64 crc32c opcode optimized CRC32C implementation" on console). A
long git bisect session between 5.0 and 5.1 pointed to commit
73a66023c937 ("sparc64: fix sparc_ipc type conversion") but that makes
no sense. I will keep working on finding root cause. I wonder if
Anatoly's git bisect result is also suspect.

--
Khalid

