Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED63C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B952084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SEyixP50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393206AbfIJMhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:37:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33312 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390519AbfIJMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:37:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ACZZVA024911;
        Tue, 10 Sep 2019 12:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zBKsoyvZW42pljgNs2qIOF6TztDTbsqax0iQzIQWQUA=;
 b=SEyixP50QAQYo5M3gec+LxdFGf4NLzGqW/txDjBSEhqaueyQtKtSGun/g8dp7C57LPNO
 n3lybg4J+mtaRdMmofjaDDRWcMajRoPpE6UMZFK1e6PfNTUgfLzqvzk+rQdt9RzbXZ4X
 GFn5VBBNNiPB3owH/N+ab8q1JEkv3xxeWTrc4ZNb0TbPJKdBqWX734u3Tb0fjDWsC+b/
 bW7dA1VQJz9CAaZXT9AEw1nofn5gSgek8PMsBxiOeHakOF3Nw+UKPnW/2ArvauePTo4t
 pOjjRKy9SzbMWqBlE33jSThJbDzT7hrYYD16EH+T4WgUYXjH+d9KX5rzGd3SCagFm8Rs NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uw1jy3290-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 12:37:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ACZV4P027035;
        Tue, 10 Sep 2019 12:37:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2uwqqdyjw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 12:37:11 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8ACb63f010683;
        Tue, 10 Sep 2019 12:37:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 05:37:05 -0700
Date:   Tue, 10 Sep 2019 15:36:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH v3] Staging: gasket: Use temporaries to reduce line
 length.
Message-ID: <20190910123656.GC15977@kadam>
References: <20190910061928.GA9623@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910061928.GA9623@volery>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=687
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=757 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

