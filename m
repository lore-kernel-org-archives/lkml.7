Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C756FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E222178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c6h9rDXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfKHKGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:06:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfKHKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:06:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8A4x9I001795;
        Fri, 8 Nov 2019 10:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=lC6Rkjy3TVUxRx/UkJEpYp4pAS/Xsi+0+ID04N6qrLk=;
 b=c6h9rDXpTZeTKMt/UAHRyxcJCa3LmlwbmCwd3WfWT2FHiYjk9b1XuIHdE+Q9e+VWtEa9
 cBwQJ90CMjAzOilomMcgaXlZM2CcAhKXaFG9Nu6xmT/tGj6fBwqh1H908Lk6OwrZs7zU
 dUE9VNd2TVaBl1NGzbdqQV9MgRyaagI1EnQyq2rooCQroHr7kutic8477Jnb3E9gPOcI
 rha2gZSs2A8wjG0Uk011O0sGiWgX2KX/Y899/tCLcEcTkhmVjhqVSj4WhUMMiUqrtuZR
 s7I1Ydxoioxw7fFsMY0pYFCL1iHSK8Z0Dyz3QD3KVgQOZLnkjq/VgTk3S18UJZn8+Ao6 KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w41w14btb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 10:05:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8A4Iq9024070;
        Fri, 8 Nov 2019 10:05:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w41whcqwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 10:05:55 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA8A5rF7005134;
        Fri, 8 Nov 2019 10:05:54 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 02:05:52 -0800
Date:   Fri, 8 Nov 2019 13:05:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yabin Cui <yabinc@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] coresight: replicator: Fix missing spin_lock_init()
Message-ID: <20191108100540.GQ10409@kadam>
References: <20191106115651.113943-1-weiyongjun1@huawei.com>
 <CANLsYkxKAC9FLYkFjuehj_oFHTVyd=8_R8bAKjPxTXQyAGkwYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxKAC9FLYkFjuehj_oFHTVyd=8_R8bAKjPxTXQyAGkwYw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:47:11AM -0700, Mathieu Poirier wrote:
> On Wed, 6 Nov 2019 at 04:57, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> >
> > The driver allocates the spinlock but not initialize it.
> > Use spin_lock_init() on it to initialize it correctly.
> >
> > This is detected by Coccinelle semantic patch.
> >
> > Fixes: 0093875ad129 ("coresight: Serialize enabling/disabling a link device.")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-replicator.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> > index 43304196a1a6..e7dc1c31d20d 100644
> > --- a/drivers/hwtracing/coresight/coresight-replicator.c
> > +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> > @@ -248,6 +248,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
> >         }
> >         dev->platform_data = pdata;
> >
> > +       spin_lock_init(&drvdata->spinlock);
> 
> I have applied both patches but removed the "Fixes" line since the
> commit is only visible in my local coresight next tree.
> 

Unless you rebase the tree, then the Fixes tag will still be valid.
(Probably local implies you rebase it I guess).

regards,
dan carpenter

