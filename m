Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9E2C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9979B20863
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="00xqK6Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfFSA6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 20:58:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34640 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfFSA6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:58:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J0rpbT196478;
        Wed, 19 Jun 2019 00:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hzLsLXnQDCzRT892OtX+mGG+e1ulRRdo9RadDaS/ZRc=;
 b=00xqK6ZvoG3QlAySdtEOr3x2i/ShdT3BfJswGBhWZwTpN3vVlSPEfkKdJUmU04ewLO3X
 D4Ma8AehooOIIpjs2bWGshhIF8ZAufh1t6FQGi2h+Zkn/2xMwrnJ0jM6dZ91dBSPay/4
 n9DpZnUvwX3A8QCLVHu/TfX0Zr6v4uXQ3AxrTeHsTWhRGZKKH9zaY2TvpiDjmmpwCQUo
 tTShZ7BoXeDy4voYjJBojWRg2BKZkin70rGu6XAGLnjCh9tFPiVtA6byRR+aw6XMpX1U
 +SpqxOxp7UKzNJ/A1nLsi7fncI/flzq8CmH7T1aBocnJBfcNbxd8f4TteUOUF92Z8v+F ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t78098f7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 00:57:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J0vkqd031197;
        Wed, 19 Jun 2019 00:57:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t77yn1uwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 00:57:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J0vpAo015233;
        Wed, 19 Jun 2019 00:57:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 17:57:51 -0700
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] scsi: mpt3sas: Mark expected switch fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190611150219.GA19152@embeddedor>
Date:   Tue, 18 Jun 2019 20:57:48 -0400
In-Reply-To: <20190611150219.GA19152@embeddedor> (Gustavo A. R. Silva's
        message of "Tue, 11 Jun 2019 10:02:19 -0500")
Message-ID: <yq1o92uxugj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=612
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=661 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> drivers/scsi/mpt3sas/mpt3sas_base.c: In function =E2=80=98_base_update_io=
c_page1_inlinewith_perf_mode=E2=80=99:
> drivers/scsi/mpt3sas/mpt3sas_base.c:4510:6: warning: this statement may f=
all through [-Wimplicit-fallthrough=3D]
>    if (ioc->high_iops_queues) {
>       ^
> drivers/scsi/mpt3sas/mpt3sas_base.c:4530:2: note: here
>   case MPT_PERF_MODE_LATENCY:
>   ^~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3

Applied to 5.3/scsi-queue, thanks!

--=20
Martin K. Petersen	Oracle Linux Engineering
