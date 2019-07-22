Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC10C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0A21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1iF0Hdnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfGVWyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:54:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42240 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfGVWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:54:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MMhw3W162619;
        Mon, 22 Jul 2019 22:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=pRmdzS9FvbplPYn/pmuIE0u50BDdaNqnjGOZR5C4gAo=;
 b=1iF0HdndRnRKrJS+GukMAaRu3s7i4Spap6W4l1oi/2f+39+ekwiUZCbaeAe/utEgnTDb
 uyNEJQHuydqvviynMVPvoh/tuWJ6NXGDIkAIiQTruQ5LrdFwufOY+N5E9ftjjkHlkhEq
 tSiT8nBJpS3Cudp04hm5RzY/FK1/Ws6Q2N1qq8eX43Z/nzYzTdN8Wk4iUIvU/fWyiKw7
 Ih254PzPhFBTp10Us6HgO33iilGTztV3EiTtMte5VFXXLCpJ1SN/SNW0CJMlDQJKRjLT
 XXrapx0iCAd4efzNWfGisTOvgghjahk9Lw12nlMxTZ3LQUv7NDUOSEzNChBfSgGLuQuw cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tutwpa6bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 22:53:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MMh27Q109480;
        Mon, 22 Jul 2019 22:53:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tus0bstuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 22:53:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6MMrsWk015176;
        Mon, 22 Jul 2019 22:53:55 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 15:53:54 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3566.0.1\))
Subject: Re: [PATCH 2/3] sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190722175022.GB12278@bharath12345-Inspiron-5559>
Date:   Mon, 22 Jul 2019 16:53:53 -0600
Cc:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org,
        ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <58D68134-E068-466C-AAD8-FA69596E8C26@oracle.com>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
 <1563724685-6540-3-git-send-email-linux.bhar@gmail.com>
 <1BA84A99-4EB5-4520-BFBD-CD60D5B7AED9@oracle.com>
 <20190722175022.GB12278@bharath12345-Inspiron-5559>
To:     Bharath Vedartham <linux.bhar@gmail.com>
X-Mailer: Apple Mail (2.3566.0.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220244
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 22, 2019, at 11:50 AM, Bharath Vedartham <linux.bhar@gmail.com> =
wrote:
>=20
>>=20
>>=20
>> In all likelihood, these questions are no-ops, and the optimizer may =
even make my questions completely moot, but I thought I might as well =
ask anyway.
>>=20
> That sounds reasonable. I am not really sure as to how much of=20
> an improvement it would be, the condition will be evaluated eitherways
> AFAIK? Eitherways, the ternary operator does not look good. I ll make =
a
> version 2 of this.

In THEORY the "unlikely" hints to the compiler that that leg of the "if" =
can be made the branch and jump leg, though in reality optimization is =
much more complex than that.

Still, the unlikely() call is also nicely self-documenting as to what =
the expected outcome is.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

