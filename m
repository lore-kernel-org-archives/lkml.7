Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64CBC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B534B208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsBucXSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfFGVgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:36:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfFGVgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:36:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57LYGAY170210;
        Fri, 7 Jun 2019 21:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NXJGCU3/W4wLfQGXPOA3m/uLCu+EtFoy0mWC4Jm7UAs=;
 b=XsBucXSo93RbwXY84AGjQGH8v16k0Q2On6Ld0xxSfgo+N/oRrcQ3eoOjeEA7CTPrpTRs
 LvdcG+hMeZ1sU4Hn+/IYWXWgU58+vQfEEoUDGnROnv4d0VE3MMZ5CwJLa4ZrzwAhCoGo
 1irPK3VQEybxyl0ya37Ai6OjnYDVhFqvN+ZARBQCaxQ+W1b3/SwyVzZ0ajf1cTGSkU0T
 5aWwhqYufdx7HEfjevomknREyFeb0Cryjt9Q0ewADigbHAbDKpik61qoCO1hUId1yq59
 lYJfV5Tqf6p3jvfY+FClpSR6yZxqYsI9YyV80cBJU3FkF4wDdEftp1TvpRT4kMpfVknx 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sugsu0mdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 21:35:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57LYi48049381;
        Fri, 7 Jun 2019 21:35:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2swnhdg3n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 21:35:51 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57LZpCl004451;
        Fri, 7 Jun 2019 21:35:51 GMT
Received: from [10.11.0.40] (/10.11.0.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 14:35:51 -0700
Subject: Re: [PATCH] firmware: ti_sci: Add support for processor control
To:     Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190605223334.30428-1-s-anna@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <4302c224-9e50-6320-2585-60bfe0aa2a32@oracle.com>
Date:   Fri, 7 Jun 2019 14:35:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190605223334.30428-1-s-anna@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=700
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=746 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/19 3:33 PM, Suman Anna wrote:
> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
> is used in Texas Instrument's System on Chip (SoC) such as those
> in K3 family AM654 SoC to communicate between various compute
> processors with a central system controller entity.
> 
> The system controller provides various services including the control
> of other compute processors within the SoC. Extend the TI-SCI protocol
> support to add various TI-SCI commands to invoke services associated
> with power and reset control, and boot vector management of the
> various compute processors from the Linux kernel.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> Hi Santosh, Nishanth, Tero,
> 
> Appreciate it if this patch can be picked up for the 5.3 merge window.
> This is a dependency patch for my various remoteproc drivers on TI K3
> SoCs. Patch is on top of v5.2-rc1.
> 
I will pick this up for 5.3.

Regards,
Santosh
