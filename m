Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F0ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BA420679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PoYxF+L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfJIS6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:58:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfJIS6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:58:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99ImqCW142489;
        Wed, 9 Oct 2019 18:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=P+/ghBe4HEy3gT/gHu/XLIQ7wMnVX6Y2sBI1mZRANTs=;
 b=PoYxF+L2FSYq/4fntDJ+pUMOqr7X/igLOyqhcv9gmAcueiiFUBKR4R4CCC5qLlUh3LwZ
 QhSA9pGNREiLsxD4iJmG9JyE1UlsmJTvn1NSGEw+FOhUH8DXSPy8qlcMiR9lHWtZ9/Ii
 7sLLObGyby5kLWkWM64pW7tV9UcPnxqQk3IW036zJJpWnKQH5S3N29f4/1fuBHt+/7i5
 +RbgIhe9uh7R4UKx+iNESuiTxJCsuDO6x/Umx5iOAkwia82+Px2SZKoUK5tl2XZ6wLyh
 gWoGw2wjCrAiSDyAu7qJLzWqoJ5ylpb57kPd5p/JfvXtjb2hAauszv9Tqc+niAFVSdMT 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vejkuppur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 18:58:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99InBPk069950;
        Wed, 9 Oct 2019 18:58:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vh8k1atss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 18:58:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x99IwEMv023925;
        Wed, 9 Oct 2019 18:58:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 11:58:13 -0700
Date:   Wed, 9 Oct 2019 21:58:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Fix various compilation issues with wfx driver
Message-ID: <20191009185807.GB20470@kadam>
References: <20191008094232.10014-1-Jerome.Pouiller@silabs.com>
 <20191008151046.GA2862250@kroah.com>
 <6487016.ESlEkJNu7c@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6487016.ESlEkJNu7c@pc-42>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:13:14PM +0000, Jerome Pouiller wrote:
> On Tuesday 8 October 2019 17:10:56 CEST Greg Kroah-Hartman wrote:
> > On Tue, Oct 08, 2019 at 09:42:47AM +0000, Jerome Pouiller wrote:
> > > From: Jérôme Pouiller <jerome.pouiller@silabs.com>
> > >
> > > Most of problems are related to big-endian architectures.
> > 
> > kbuild still reports 2 errors with these patches applied:
> > 
> > Regressions in current branch:
> > 
> > drivers/staging/wfx/hif_tx.c:82:2-8: preceding lock on line 65
> 
> As I replied to Julia, this behavior is intended.
> 
> > drivers/staging/wfx/main.c:188:14-21: ERROR: PTR_ERR applied after initialization to constant on line 183
> 
> This is a false positive, as confirmed by Dan.
> 
> You may also notice:
> 
>   drivers/staging/wfx/scan.c:207 wfx_scan_work() warn: inconsistent returns 'sem:&wvif->scan.lock'
> 
> I also consider it as a false positive.

Yeah.  I thought it might be.  The beauty of 0day bot is that normally
the warnings come really quick after the original author wrote the code
so it's fresh in their heads.  I suspected it might be a false positive
but I wasn't sure either way and I try not to spend a lot of time
reviewing those warnings.

regards,
dan carpenter

