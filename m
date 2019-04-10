Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273FBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52E42083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lrrRR8hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfDJGqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:46:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfDJGqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:46:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A6YEcr084530;
        Wed, 10 Apr 2019 06:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=mir6tMGBE9jGK9cEzmvJu1kw5SgfkHI7OD6ZTd+4jHo=;
 b=lrrRR8hWySFK819A9J3evNGUef4FwT7B8OtTexOeeptbwebMQeWks2Goltx0ZGsMbwtr
 1+Vaj0RMXnvvKEFRPXyIoASqcSE7oIAf68H8/CajKrSYKDmy81S23YtPCrDXPY7cyFwQ
 XdX1Hb36G16kXJpKwGivO2D/QTZfFiK6Gr73MT0FUaBWNElg33USNaWdenJNwSHaLePL
 ookdM27HiSHvcSjaoJvqrZV76yz0H7MkPy8Fo2CftR096ciA8Nmfqf4SsKfYBUr4RnN/
 ZXq0TAquglDGRKkIwFtGd3a+IOqkmq5Ub7l4/7lNf2n7mPWFDkm8f2BAXb3G0pUX+9wk ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rpkht15jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 06:46:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A6jstH122052;
        Wed, 10 Apr 2019 06:46:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2rpkejqy66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 06:46:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3A6kPLY021115;
        Wed, 10 Apr 2019 06:46:25 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 23:46:24 -0700
Date:   Wed, 10 Apr 2019 09:46:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     walter harms <wharms@bfs.de>
Cc:     Colin King <colin.king@canonical.com>,
        Karen Xie <kxie@chelsio.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: cxgbi: remove redundant __kfree_skb call on skb
Message-ID: <20190410064615.GD6095@kadam>
References: <20190409133819.21127-1-colin.king@canonical.com>
 <5CACAD57.1030703@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CACAD57.1030703@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100048
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 04:33:59PM +0200, walter harms wrote:
> 
> 
> Am 09.04.2019 15:38, schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The error return path via label rel_resource checks for a non-null
> > skb before free'ing it.  However, skb is always null at this exit
> > path, so the null check and the free are redundant and can be removed.
> > Removing this allows the original goto's to rel_resource to be cleaned
> > up; the first can be replaced by a return of -EINVAL, the second can
> > be replaced by a more appropriate -ENOMEM return since allow_wr has
> > failed go allocate some memory.
> > 
> > Addresses-Coverity: ("Logically Dead Code")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/scsi/cxgbi/cxgb3i/cxgb3i.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> > index 75e1273a44b3..5a4387f437d5 100644
> > --- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> > +++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> > @@ -979,14 +979,14 @@ static int init_act_open(struct cxgbi_sock *csk)
> >  	csk->atid = cxgb3_alloc_atid(t3dev, &t3_client, csk);
> >  	if (csk->atid < 0) {
> >  		pr_err("NO atid available.\n");
> > -		goto rel_resource;
> > +		return -EINVAL;
> >  	}
> >  	cxgbi_sock_set_flag(csk, CTPF_HAS_ATID);
> >  	cxgbi_sock_get(csk);
> >  
> >  	skb = alloc_wr(sizeof(struct cpl_act_open_req), 0, GFP_KERNEL);
> >  	if (!skb)
> > -		goto rel_resource;
> > +		return -ENOMEM;
> 
> I would expect a cxgb3_free_atid(csk->atid) here. Did i miss something ?
> 

Yeah.  I don't see that cxgb3_free_atid() drops the cxgbi_sock_get()
reference so we would want to do a put for that as well I think.

regards,
dan carpenter

