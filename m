Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D2CECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46A9208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OCiXsUcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfILIeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:34:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45986 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfILIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:34:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C8JBTh021612;
        Thu, 12 Sep 2019 08:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=6DO3cZ/C+dKYPej/qzrFPSWCEgvugiX6kxk6zUsvZqs=;
 b=OCiXsUcFVUG40Tkg9mPHRciwJg1/GADCpjRH4o1HFMbGXs+Gu2V8iN5eUMZ2vRl5bash
 +NStBguTmeN3D8UphxUB4ZNjaAI4EL6ncCHrgxzrr1xzRZvqDVlpQg2szDftOBCDDoTB
 Fk5QOojvIz9s+6J/BEt7cYh+7T1cCG0J5pse4kfKPHBHUkdtg2JXKxB1vmdeU7w3bpQf
 UetqJcwxygqiwjtso5UrfxOekIgE1EjayF272St4luuzr2JhUBCvtOFi2lR3R+ycM3HS
 +wbhuYez2TELpynwenZZ76B6nSt2pdYOyEbQvv98LuIyvHTgnS33q0bvYkwci8Z670hJ Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jyevx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 08:34:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C8J3QJ013733;
        Thu, 12 Sep 2019 08:32:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uxk0u3t14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 08:32:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8C8W0O3002104;
        Thu, 12 Sep 2019 08:32:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Sep 2019 01:31:59 -0700
Date:   Thu, 12 Sep 2019 11:31:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v5] Staging: exfat: Avoid use of strcpy
Message-ID: <20190912083153.GN20699@kadam>
References: <20190912082559.GA5043@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912082559.GA5043@volery>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=864
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909120090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=934 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909120090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You did it.  Well done.  :P

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

