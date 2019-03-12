Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DF7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C652173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ReccDhXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCLXk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:40:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41124 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfCLXky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:40:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2CNYb9n046914;
        Tue, 12 Mar 2019 23:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=A/QHGawCAvtuuQ91VR9eTk+KmTVXz7X8/7COqoYN+Ss=;
 b=ReccDhXmUUHRCLNN9myaKMoRtx3Fcq0X/g6VLbJMU8U7HNCK7vUbQl/eVBQTq72i+Ru+
 Y26gpFVrrArd1nklfmTVScuGv15IsxClZ2QDy0jDCF8N1V436KkpB5eTrvqDFp3SlU0G
 7SThg3uuKnwLSxpB6pUY7PzFyy0Byi19cFkIpkRrSpCKfAQhshwM6K+ePB4c95Ml+iZe
 0HH2KsahZjxFR4MKEVTkfkP+CnM9J4b4pkIfzChdKOSZpD8UIX0paokkcvY2HrXC7l1T
 2F7kgLOGCeD9Z0edINVIZGARB8ny/hL1q4OqXR/V+AjTEICkVoEE2KrDJx9699w2tuyT hg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r44wu7uv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 23:40:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2CNeTXI020448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 23:40:29 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2CNeRGX022916;
        Tue, 12 Mar 2019 23:40:27 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Mar 2019 16:40:27 -0700
Subject: Re: [Xen-devel] [PATCH v4.9 1/1] jiffies: use jiffies64_to_nsecs() to
 fix 100% steal usage for xen vcpu hotplug
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jgross@suse.com, herbert.van.den.bergh@oracle.com,
        sstabellini@kernel.org, sboyd@kernel.org, frederic@kernel.org,
        joe.jin@oracle.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, john.stultz@linaro.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        tglx@linutronix.de
References: <1551772744-524-1-git-send-email-dongli.zhang@oracle.com>
 <15c804c0-eeb1-2adb-9cbf-4a28d39983a0@oracle.com>
 <20190312125600.GF23540@kroah.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <5f7ef4ad-1569-df2c-3811-a55299c8c85b@oracle.com>
Date:   Wed, 13 Mar 2019 07:44:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190312125600.GF23540@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9193 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/19 8:56 PM, Greg KH wrote:
> On Wed, Mar 06, 2019 at 03:35:40PM +0800, Dongli Zhang wrote:
>> Thanks to Joe Jin's reminding, this patch is applicable to mainline linux
>> kernel, although there is no issue due to this kind of bug in mainline kernel.
>>
>> Therefore, can I first submit this patch to mainline kernel and then backport it
>> to stable linux with more detailed explanation how the issue is reproduced on xen?
> 
> Yes, please do that.

I am working on a patch to reform the xen steal clock formula by xen specific
interfaces in linux kernel. In that way, we will not need to change the
signature of existing jiffies relevant functions which expect only delta values
as input.

The new formula will not generate such large input value.

Dongli Zhang

> 
> thanks,
> 
> greg k-h
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
