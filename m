Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F123C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E274920863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nleJfhwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfIKKH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:07:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59718 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfIKKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:07:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B9rbKe093930;
        Wed, 11 Sep 2019 10:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=wxw9BbTHu4AzXJ1XStoEfZ/9Z/QWrwvMgzyBlvyAEQ0=;
 b=nleJfhwGNVh777tOd3R+piFAF4/W8h/P5lZeAoY44+thF7HCP0zDwh8uV+c58rEY9wDA
 AloFcUMauVRnCp4J5SbyeB0jAvHPB5CuXI0WiKaoMezzngUGN7kJJvcPeu6JBYYOoiGk
 euEYyAM9DWPpAFRYkIJ3kIKKsQl4d6aLz9xcfiHyvoMjDkqXW8PNLcwo2TtgSVC5PEn3
 hDCkvjoeXi3NxaD1bgg4maD2rxG/tmfDw2cTgrY4AOXSlsBgUA+lxJPC9yun9Qleih9p
 mPJjGy6uGq1Cl+Wh0xJcKi48hRIVE3H2mhRmSFq+kiHetEwxfIf1WUAS8aw5mlcvJ8JC jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uw1jy8v8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 10:07:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B9raDu131313;
        Wed, 11 Sep 2019 10:05:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2uxd6dx7nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 10:05:41 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BA5XFi022907;
        Wed, 11 Sep 2019 10:05:33 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 03:05:32 -0700
Date:   Wed, 11 Sep 2019 13:05:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aaro.koskinen@iki.fi, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: octeon: Avoid several usecases of strcpy
Message-ID: <20190911100526.GJ15977@kadam>
References: <20190911091659.GI15977@kadam>
 <C1B40FAD-9F8F-449D-B10C-334BAC76797D@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C1B40FAD-9F8F-449D-B10C-334BAC76797D@volery.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 11:21:44AM +0200, Sandro Volery wrote:
> 
> On 11 Sep 2019, at 11:17, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > ﻿On Wed, Sep 11, 2019 at 11:04:38AM +0200, Sandro Volery wrote:
> >> 
> >> 
> >>>> On 11 Sep 2019, at 10:52, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >>> 
> >>> ﻿On Wed, Sep 11, 2019 at 08:23:59AM +0200, Sandro Volery wrote:
> >>>> strcpy was used multiple times in strcpy to write into dev->name.
> >>>> I replaced them with strscpy.
> >>>> 
> >>>> Signed-off-by: Sandro Volery <sandro@volery.com>
> >>>> ---
> >>>> drivers/staging/octeon/ethernet.c | 16 ++++++++--------
> >>>> 1 file changed, 8 insertions(+), 8 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> >>>> index 8889494adf1f..cf8e9a23ebf9 100644
> >>>> --- a/drivers/staging/octeon/ethernet.c
> >>>> +++ b/drivers/staging/octeon/ethernet.c
> >>>> @@ -784,7 +784,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
> >>>>           priv->imode = CVMX_HELPER_INTERFACE_MODE_DISABLED;
> >>>>           priv->port = CVMX_PIP_NUM_INPUT_PORTS;
> >>>>           priv->queue = -1;
> >>>> -            strcpy(dev->name, "pow%d");
> >>>> +            strscpy(dev->name, "pow%d", sizeof(dev->name));
> >>> 
> >>> Is there a program which is generating a warning for this code?  We know
> >>> that "pow%d" is 6 characters and static analysis tools can understand
> >>> this code fine so we know it's safe.
> >> 
> >> Well I was confused too but checkpatch complained about 
> >> it so I figured I'd clean it up quick
> > 
> > Ah.  It's a new checkpatch warning.  I don't care in that case.  I'm
> > fine with replacing all of these in that case.
> 
> Alright thanks. Can you review this?
> 

Sure.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

