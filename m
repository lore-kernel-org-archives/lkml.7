Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5C2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF6A21773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aNLuRKMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfEWPVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:21:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48218 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfEWPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:21:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4NFIqaj062657;
        Thu, 23 May 2019 15:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=LOcDRDBvuqevUfYHGbx7vmhcJBhEgAgUiuLdp1DKZgo=;
 b=aNLuRKMpfxfHrIVQhB6D6ajL5KJiVCHgV1l4soy2pzoNm4KTMbQ33bYFr+PDooIGnWJo
 FiCe337XLGUk1lyLtHjJB3At//ZOl4TaN/pYld1outbnZpiYUAqC3z2z4PWgNSkJ3eqB
 lafPGnTBoZ7GbksvTE850WEkEie0VDL7Z+sZ1oqi6wH7w0+dqXXKbAOH6X1cwtEjm8xy
 wbYiolySUFKzIRq1YWG+PYOIWF8xX5OSh2gwFEXT2DnrmOsek64xNW9TzDLlRGYolEmH
 pbt/1qjemxTY+fC/KWaQVDnqP2S09TEFFajCXaIJbcwl5Tb0f/WHAPkYyrZdq33hN6bU /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2smsk5b40e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 15:21:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4NFJoxI160823;
        Thu, 23 May 2019 15:21:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2smsgvj8yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 15:21:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4NFL9L8015891;
        Thu, 23 May 2019 15:21:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 May 2019 15:21:08 +0000
Date:   Thu, 23 May 2019 18:20:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?utf-8?B?5p2O5aSp5q2j?= <ltz0302@gmail.com>
Cc:     Rob Springer <rspringer@google.com>, devel@driverdev.osuosl.org,
        Jie Zhang <zhangjie.cnde@gmail.com>, linux-kernel@i4.cs.fau.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] staging/gasket: Fix string split
Message-ID: <20190523152055.GP19380@kadam>
References: <20190521150728.25501-1-ltz0302@gmail.com>
 <20190521151444.GN31203@kadam>
 <CAOJV0ikYP5jxrwNzFQ2rmOaAA2cv71TvuOjzasvAW=ezWc3znw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOJV0ikYP5jxrwNzFQ2rmOaAA2cv71TvuOjzasvAW=ezWc3znw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=761
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905230104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=816 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905230104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 05:11:56PM +0200, 李天正 wrote:
> Hello，
> we are doing a project in the university and we cooperated to make this
> patch. Some warnings are found by Mr.Zhang.

Use the Reported-by to show who found the bug or Co-developed-by: if you
both wrote code.

regards,
dan carpenter

