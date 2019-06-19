Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8992C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E1220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iBBR14Jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfFSEf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 00:35:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45546 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfFSEfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 00:35:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J4Yk4f133604;
        Wed, 19 Jun 2019 04:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ReOw/U0B0z5+s5ITG3P7icDegd9/5IvUV5c71EJZ4Mc=;
 b=iBBR14Jv4W/AlCRkCr6FwMS4kysM4aA0404HL+nT0hmo+4vMbM+n7yifSEV9sYvykFCz
 96SqpYS69jU1AcOV3Ts87RO11rrHBzsSPe9EtmnCoC4ZUNSs8u6BKAzLUTGkW03zzE+s
 9driZkasVO4K5uyi0fzdOd07X9Er1+fGUqd0aFwHXxfFO6TxIw1E8n2+C5INSrSIt6BK
 ek+DcCs/DkRxLTls2GK2xUwjocYkZYxTWa4q0DB0Up2e8t3LLhEqetWTWgL7ImUr1XRm
 JWRYJ2wnoC+ocUnchSSXhS4hgRwvLbBTETvpOsfbPTcIYAIm4qxeaB4TS3xJl9ab/pB+ JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t78098ywp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 04:35:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J4Z7l2157071;
        Wed, 19 Jun 2019 04:35:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t77ymuu7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 04:35:45 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J4Zhns014934;
        Wed, 19 Jun 2019 04:35:43 GMT
Received: from dhcp-10-159-132-89.vpn.oracle.com (/10.159.132.89)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 21:35:43 -0700
Subject: Re: [PATCH v3 -next] firmware: ti_sci: Fix gcc
 unused-but-set-variable warning
To:     Suman Anna <s-anna@ti.com>, YueHaibing <yuehaibing@huawei.com>,
        nm@ti.com, t-kristo@ti.com, ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190614154421.17556-1-yuehaibing@huawei.com>
 <20190615125054.16416-1-yuehaibing@huawei.com>
 <e13fe9fa-4a79-8af5-6968-dfc9364a3c55@ti.com>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <3111974c-2052-498c-303e-f953a599be6c@oracle.com>
Date:   Tue, 18 Jun 2019 21:35:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e13fe9fa-4a79-8af5-6968-dfc9364a3c55@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=841
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=888 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 11:41 AM, Suman Anna wrote:
> On 6/15/19 7:50 AM, YueHaibing wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/firmware/ti_sci.c: In function ti_sci_cmd_ring_config:
>> drivers/firmware/ti_sci.c:2035:17: warning: variable dev set but not used [-Wunused-but-set-variable]
>> drivers/firmware/ti_sci.c: In function ti_sci_cmd_ring_get_config:
>> drivers/firmware/ti_sci.c:2104:17: warning: variable dev set but not used [-Wunused-but-set-variable]
>> drivers/firmware/ti_sci.c: In function ti_sci_cmd_rm_udmap_tx_ch_cfg:
>> drivers/firmware/ti_sci.c:2287:17: warning: variable dev set but not used [-Wunused-but-set-variable]
>> drivers/firmware/ti_sci.c: In function ti_sci_cmd_rm_udmap_rx_ch_cfg:
>> drivers/firmware/ti_sci.c:2357:17: warning: variable dev set but not used [-Wunused-but-set-variable]
>>
>> Use the 'dev' variable instead of info->dev to fix this.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Acked-by: Suman Anna <s-anna@ti.com>
> 
> Hi Santosh,
> Can you pick up this patch, goes on top of your for_5.3/driver-soc branch?
> 
Applied.
