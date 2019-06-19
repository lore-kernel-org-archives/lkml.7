Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D40BC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704F720B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xdp6jmAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfFSGDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:03:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48726 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfFSGDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:03:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J5x9E5005962;
        Wed, 19 Jun 2019 06:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=fPuaHyuoIZdDjft/e+uZtMrJ1AQaUg3H7A6qexguayA=;
 b=Xdp6jmAIDA9gQIaHvu7BwfB+YVlf6RCzPuoJGagELUGOF8qqQ+2SmaQxYY2vnu0vfeTa
 AW1u/aH0WvN16qt56kJ97K9hp6a3u5v1twzbIE9yKHTajlDWLGIw9oUgrdROyrcspip3
 iLXR3IIyLD1ri564nFrCHARhMeH3rygRcj7NonC3gJUIwB5net+tiiJJV2BhacwwHYrX
 MLY7Ph51+CahFF1l5btLy+zcphFtL2t1M6HGV7ZrdVvy3PPojDeG10WmENmI+BhDAh+D
 YMahWKm2jkv1mIJ64HP+23tj1nP3MW6AZLhIeRpDk5t84r2Q3X3Ce9yAgL0n04wlWRxU /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t7809987f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 06:03:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J618QG126352;
        Wed, 19 Jun 2019 06:03:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2t77ymvqtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 06:03:00 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J62wxS019790;
        Wed, 19 Jun 2019 06:02:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 23:02:57 -0700
Date:   Wed, 19 Jun 2019 09:02:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] NTB: test: remove a duplicate check
Message-ID: <20190619060250.GH18776@kadam>
References: <20190619053205.GA10452@mwanda>
 <2f4dea74-d78e-8b53-8dec-df8dc032759c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4dea74-d78e-8b53-8dec-df8dc032759c@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=941
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=994 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not a huge deal obviously but your commit was a6bed7a54165 ("NTB:
Introduce NTB MSI Test Client") but you know that if I had sent a patch
called ("NTB: remove a duplicate check") people would have correctly
complained because the patch prefix is too vague.

What I'm saying is we do this all the time:

[PATCH] NTB: add a new foobazle driver

But it should be:

[PATCH] NTB: foobazle: add a new foobazle driver

Then I can just copy and paste your patch prefix instead of trying
invent one.

regards,
dan carpenter

