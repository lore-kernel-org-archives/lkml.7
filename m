Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECB2C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731CB20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CyBi/MGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfFJRQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:16:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51148 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387779AbfFJRQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:16:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AH9X9n063504;
        Mon, 10 Jun 2019 17:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ArflQXTEtW7+wS+EJF7tgCpdlxkbA5ggbwnizlvqqmY=;
 b=CyBi/MGtW5w7pnIDqqQqIjJrN02f+Yng2CL6Rd3nXKoW+K0e9Q3vbsj6FfhaI8VQcM9S
 dTcYLiugHXFec3b39vRB7Ud+zDxfCYwImBQt+qEpomFVU2YFG+Zy+t4PPMLBg9JpmYb0
 wio7htbXlMwsZ2t05+Gd50Uf89J1H9rx7e3HMZOIYp2jGuV4K7mWWL/jdJq3HXB934lx
 /aXEBEhZUjaOsWV8mKtEGc253vcNfkAFMLF7sIYMvmB9/39udbSahlqApu34eFyqG3G5
 zyWHLmwZECjPKxcOpa4IlI3Ej8f3ouWoQUA4IkLDT91YD/WUQ1iwxczaklj6sw9XUrgs Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2t02hegcj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 17:16:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AHEpna070241;
        Mon, 10 Jun 2019 17:16:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t04hxw2m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 17:16:10 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5AHG4xY003496;
        Mon, 10 Jun 2019 17:16:04 GMT
Received: from [10.209.242.19] (/10.209.242.19)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 10:16:03 -0700
Subject: Re: [PATCH] firmware: ti_sci: Add support for processor control
To:     Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190605223334.30428-1-s-anna@ti.com>
 <4302c224-9e50-6320-2585-60bfe0aa2a32@oracle.com>
 <2174bc51-9e28-e519-b936-9e101e2a2a4e@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <ea3bf059-86b0-2d8c-c42d-44c08a6ec808@oracle.com>
Date:   Mon, 10 Jun 2019 10:16:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2174bc51-9e28-e519-b936-9e101e2a2a4e@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/19 5:19 AM, Tero Kristo wrote:
> On 08/06/2019 00:35, santosh.shilimkar@oracle.com wrote:
>> On 6/5/19 3:33 PM, Suman Anna wrote:
>>> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
>>> is used in Texas Instrument's System on Chip (SoC) such as those
>>> in K3 family AM654 SoC to communicate between various compute
>>> processors with a central system controller entity.
>>>
>>> The system controller provides various services including the control
>>> of other compute processors within the SoC. Extend the TI-SCI protocol
>>> support to add various TI-SCI commands to invoke services associated
>>> with power and reset control, and boot vector management of the
>>> various compute processors from the Linux kernel.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> ---
>>> Hi Santosh, Nishanth, Tero,
>>>
>>> Appreciate it if this patch can be picked up for the 5.3 merge window.
>>> This is a dependency patch for my various remoteproc drivers on TI K3
>>> SoCs. Patch is on top of v5.2-rc1.
>>>
>> I will pick this up for 5.3.
> 
> Santosh,
> 
> There is a pile of drivers/firmware changes for ti-sci, which have cross 
> dependencies, and will cause merge conflicts also as they touch same file.
> 
> Do you mind if I setup a pull-request for these all and send it to you? 
> They are going to be on top of the keystone clock pull-request I just 
> sent today though, otherwise it won't compile (the 32bit clock support 
> has dependency towards the clock driver.)
> 
That will be great Tero.

Regards,
Santosh
