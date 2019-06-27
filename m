Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45496C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1818C2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LSSz5tEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfF0M1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:27:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57688 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0M1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:27:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RCOvkT118930;
        Thu, 27 Jun 2019 12:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=zN2Zg/SRNDfb3CjVSZPYtadej8e83QgIVYu0JKeZv2M=;
 b=LSSz5tEtvsn30+kW/ZMiVwWDJhDNdEbl4poSKdZ6DVKP1endvdQmtuPDqeV23SQIBFkd
 5x8uTEvWLyalfQF4XuVXqkWPiriKoX2qJR1Jye3znYRIpgGRLWP/2MkIcTcqLHREv4DB
 1HVzRKRdb7zZo799JKRZiEfm5ruRNm5sg3Z2t8dy77Axr5myTjHWnACRGxDWoa7yXycz
 MnV/ak611NQwjovqYd/fIQyt9A9kSrH4XpwO65SFV+a6kuEVTXw22p+DDY7wGq07NzXw
 lxNf+rwwwCaVfCdBBAr4jPRq/2HyRzZVJ8Hquft/pvK58SzPZdtcPw9MCLAZq/qccR14 lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqqwsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 12:27:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RCPYKS034383;
        Thu, 27 Jun 2019 12:27:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t9acd7c4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 12:27:01 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5RCQrMe001253;
        Thu, 27 Jun 2019 12:26:53 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 05:26:52 -0700
Date:   Thu, 27 Jun 2019 15:26:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lukas Schneider <lukas.s.schneider@fau.de>
Cc:     leobras.c@gmail.com, digholebhagyashri@gmail.com,
        bhanusreemahesh@gmail.com, daniel.vetter@ffwll.ch,
        der_wolf_@web.de, payal.s.kshirsagar.98@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jannik Moritz <jannik.moritz@fau.de>, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH] fbtft: Cleanup line over 80 character warnings
Message-ID: <20190627122643.GB19015@kadam>
References: <20190627121240.31584-1-lukas.s.schneider@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627121240.31584-1-lukas.s.schneider@fau.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I don't feel like this makes it more readable.

regards,
dan carpenter

