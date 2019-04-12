Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806B2C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470692084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wCTrf2lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDLNla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:41:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56292 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLNl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:41:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3CDd6a0167177;
        Fri, 12 Apr 2019 13:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vMrJ91GMO1CD+aMStdBznA5LKGeM9s5PCFnZKiLM6Zg=;
 b=wCTrf2lW/ltVm6am1oC7YcZ6e+TyQ0HDeUnwH42rNVmejj2RcnRKPelriyU1FK6SuKrb
 m8AkOWqR8iwXMznEpFL2CxTKR1yu7OqjL/V382sFehgRRNAfE1wAauOQkqcwBkjPJ46j
 PEpOas9MPJ1nt82n++8hEkgnqmJSwyX4mBEuI+GCuC8qTAbr0Zppdll6F9outyZDkvCL
 pBge+IrH1Cm9MztWZ8i2v4KTOBdj7j5luFb0KuaNA9oohRiUZqfu1PxDlMYf5ekVMVmf
 bGxjvmRXj+kOjHLLewKt4lGKIJvVpzxcFeMxPBkSCPNbLSL6EOzyYaqgVyiqAAzz9KK9 iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmexpqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 13:41:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3CDdi1E081740;
        Fri, 12 Apr 2019 13:41:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2rt9uq5mxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 13:41:23 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3CDfLjn020463;
        Fri, 12 Apr 2019 13:41:21 GMT
Received: from kadam (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Apr 2019 06:41:20 -0700
Date:   Fri, 12 Apr 2019 16:41:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Karen Xie <kxie@chelsio.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V3] scsi: cxgbi: remove redundant __kfree_skb call on
 skb and free cst->atid
Message-ID: <20190412134114.GJ6095@kadam>
References: <20190412083301.25503-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412083301.25503-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120090
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

