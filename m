Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D122AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A8420830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1mG7PKb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfCZIXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:23:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:23:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q8Dd8S136621;
        Tue, 26 Mar 2019 08:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UHNBNcX0HEJaGr+V/UvWgEwrFhSzcj0cGntEFNhf42U=;
 b=1mG7PKb1zYG+vKam6EDlu129n/Tjk/C8wEV1n8ZzTEc9Zt9n+Vk3ZA8K0xtsEV3+6Jnp
 OW2haXmWSi+wDbPueHuJoD3G3YiSi+PTa7bEjFYLPUlfioNYmzjzfbjVylq9dBlVLwN6
 DYwPdEAbMeZL6YfFYh2IRGAPs2vD6EjTU1zB3CBYOF5ej+IGone7A9KTliJRJPV+Hhza
 PKAV9mzn+VbgIKRpacCRkpGKYiOp1PjSmbWxJQvn/G1i/maXLFpfgeNGNl7hWfrVNkJm
 eucTuKBYTU4ddBPE3Ujp8Bw/GbDQlBV8tbkYNKVngP9RZBW1dAtV79YNBbp63uGqSkxM RQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2re6dj8t3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:23:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8NV2U004246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:23:31 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8NUDE017339;
        Tue, 26 Mar 2019 08:23:30 GMT
Received: from kadam (/197.157.0.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 01:23:30 -0700
Date:   Tue, 26 Mar 2019 11:23:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Kangjie Lu <kjlu@umn.edu>
Cc:     usb-storage@lists.one-eyed-alien.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>, kbuild-all@01.org,
        pakki001@umn.edu
Subject: Re: [kbuild] [PATCH] usb: sierra: fix a missing check of
 device_create_file
Message-ID: <20190326082320.GG32613@kadam>
References: <20190324223920.961-1-kjlu@umn.edu>
 <20190326081831.GF32613@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326081831.GF32613@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:18:31AM +0300, Dan Carpenter wrote:
> 32fe5e393 Kevin Lloyd  2008-07-10  193  		}
> 32fe5e393 Kevin Lloyd  2008-07-10  194  		kfree(swocInfo);
>                                                         ^^^^^^^^^^^^^^^^
> 
> 32fe5e393 Kevin Lloyd  2008-07-10  195  	}
> 
> break statement?

Sorry, for some reason I saw "complete:" and read "default:". :/

But the warning seems valid.

regards,
dan carpenter

> 
> 32fe5e393 Kevin Lloyd  2008-07-10  196  complete:
> 32fe5e393 Kevin Lloyd  2008-07-10  197  	result = device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
> 04d66f3d0 Kangjie Lu   2019-03-24  198  	if (result) {
> 04d66f3d0 Kangjie Lu   2019-03-24 @199  		kfree(swocInfo);
>                                                         ^^^^^^^^^^^^^^^
> Double free.
> 

