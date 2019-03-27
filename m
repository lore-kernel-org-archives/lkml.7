Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C144CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E8E20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UhwgKwT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfC0K0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:26:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60506 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfC0K0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:26:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2RADnu4043952;
        Wed, 27 Mar 2019 10:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=VcAQbbXDBqTw84B+zk/fFVeuAnEQor5PVMnQNwxDWss=;
 b=UhwgKwT+elL7PbO6otWVV9GJzz3Q9ltcXMUC6Cf3ioGRjVBFGcnvLXlcuhUCjuFZB+MQ
 YB2TcIERHKXLaC1JgFHC2k8MWxW6nZueL4/RzPPt9Eoih4yVmxbhCr2GCmgtSIPfLjEA
 lTunQBwIqbEd0+z9bPet0xzW5V6aj4Nx0NFZXLk7lxTfgEFIyQc2TvGUmWu8Zrpl44Jh
 fRrtntiTv2YCgBPKT/LdV+QReAclg9X/2Y4wjVd0Fn7kTTXKFkhLFdPjn/wLPogrv8Zj
 mosjket86+TbqZGY2rZxdMmSHpjWucadXUJdJE71QhXk11rwjjfm7D/lVhLTeRrPEE98 ew== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g0ymwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 10:26:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2RAQ9BS009230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 10:26:09 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2RAQ8EE005484;
        Wed, 27 Mar 2019 10:26:08 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 03:26:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CONFIG_DEBUG_VIRTUAL breaks boot on x86-32
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <dca61136-db66-a89e-e79d-679ee2281d8d@linux.ee>
Date:   Wed, 27 Mar 2019 04:26:07 -0600
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AF9E4BD-58F0-4D12-A495-6192978790B6@oracle.com>
References: <4d5ee3b0-6d47-a8df-a6b3-54b0fba66ed7@linux.ee>
 <A1B7F481-4BF6-4441-8019-AE088F8A8939@oracle.com>
 <f39477da-a1ef-e31e-a72d-8ea1d5755234@nvidia.com>
 <dca61136-db66-a89e-e79d-679ee2281d8d@linux.ee>
To:     Meelis Roos <mroos@linux.ee>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The dmesg output you posted confirms that max_low_pfn is indeed 0x373fe, =
and it appears
that the value of phys_mem being checked mat be 0x3f401ff1, which =
translates to pfn 0x3f401,
at least if what's still in registers can be believed.

Since that is indeed greater than max_low_pfn, VIRTUAL_BUG_ON triggers:

    VIRTUAL_BUG_ON((phys_addr >> PAGE_SHIFT) > max_low_pfn);

Looking at the call stack of

    copy_strings_0x220
        __check_object_size+0xef

that looks to translate to this sequence:

copy_from_user(kaddr+offset, str, bytes_to_copy)
    check_copy_size(kaddr+offset, bytes_to_copy, FALSE)
        check_object_size(kaddr+offset, bytes_to_copy, FALSE)
            __check_object_size(kaddr+offset, bytes_to_copy, FALSE)
                check_heap_object(kaddr+offset, bytes_to_copy, FALSE)
                    virt_to_head_page(kaddr+offset)
                        virt_to_page(kaddr+offset)
                            pfn_to_page(kaddr+offset)
                                __pa(kaddr+offset)
                                    __phys_addr(kaddr+offset)

so it appears the address is "too high" for low memory at that point.




                                   =20


