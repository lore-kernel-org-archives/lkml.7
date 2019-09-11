Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D0C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790512087E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EymCVzZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfIKKtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:49:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40180 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfIKKtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:49:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BAmu9L140801;
        Wed, 11 Sep 2019 10:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=A0EQ0ucC5Utn4XuUW5I4qgdwre2fMdk+hXIPmS6ZuSk=;
 b=EymCVzZMbEUhHasDk7R6Xke5KhrXVT1sy1ccx9suCoRrnXaRIGoOia7jfzNKe20gllQA
 bkdrZ+j5ZrdWsKhvyql5bPz48jfSASc9/zgCY+0/3Ma08y3/+kGcKjHGDXSf6eB8hFXO
 NaDwiX6uZ4uME1vo4vpVa77RYgE62ckOyS/9V5w+cvqWY12X2kglgDwbssq8/awYLMJD
 BYFZLzveuT/LrxPLEm70zYDIbI/VCLhMEW4bClDl3iPaUgCsNvciYZwT0F2XJ1A4HLL4
 ev0eDWBHSHQucLuvTiIEwpfIcXgXYuFMUy7X3xdNacx3lQHBNU1xzPthvV7xQOUvStg+ qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2uw1jy925h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 10:48:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BAmaxS176312;
        Wed, 11 Sep 2019 10:48:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2uxj3jf7aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 10:48:52 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8BAminO016854;
        Wed, 11 Sep 2019 10:48:44 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 03:48:44 -0700
Date:   Wed, 11 Sep 2019 13:48:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        valdis.kletnieks@vt.edu, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2] Staging: exfat: Avoid use of strcpy
Message-ID: <20190911104835.GK15977@kadam>
References: <20190911100616.GH20699@kadam>
 <EAFF08E1-747C-4084-BFEF-A89465A6F9ED@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EAFF08E1-747C-4084-BFEF-A89465A6F9ED@volery.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:24:23PM +0200, Sandro Volery wrote:
> 
> 
> > On 11 Sep 2019, at 12:06, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > ﻿On Wed, Sep 11, 2019 at 11:42:19AM +0200, Sandro Volery wrote:
> >> Use strscpy instead of strcpy in exfat_core.c, and add a check
> >> for length that will return already known FFS_INVALIDPATH.
> >> 
> >> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> Signed-off-by: Sandro Volery <sandro@volery.com>
> >> ---
> >> v2: Implement length check and return in one
> >> v1: Original Patch
> >> drivers/staging/exfat/exfat_core.c | 3 ++-
> >> 1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> >> index da8c58149c35..4c40f1352848 100644
> >> --- a/drivers/staging/exfat/exfat_core.c
> >> +++ b/drivers/staging/exfat/exfat_core.c
> >> @@ -2964,7 +2964,8 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
> >>    if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
> >        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Delete this as it is no longer required.
> > 
> 
> Yep, saw it from Rasmus response too just now.. Dumb mistake.
> Will fix this this afternoon.
> 

Or you could send it tomorrow.  There is no rush.

regards,
dan carpenter

