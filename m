Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1553CC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABDB218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Db/FPfaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfFQG33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:29:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34102 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfFQG32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:29:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H6Sksk151126;
        Mon, 17 Jun 2019 06:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=w6Yoz+9IqeNomaLoN+e6oc9dQxJ2P3sRhOKehviO6xI=;
 b=Db/FPfaBlkjGZQqmj2lh5JmB69aSmUZK3gMINtRgEwmzzFC+bPyKofTCIqqENk/kzzc7
 2tv9kCh6CY1LQn0r2iX0s5HN2GXXVcd52vCjbbw28+MoAQgsoHPetYYmpLkX92A2R3Lr
 oOCQXDXsrrzrCOQYW2K0CnFee+xwTp3ZTgsiLvmqAU/0AO7boHIfNsYGhFLdMmzYK3v6
 7ThC/ONBzkZZDvvH43aI41o2ze/FrIsy4PLeT5ZKIY+mtV6tmy8rG2vgv2hx28Z1mcbR
 cMuCRfYuDJ0r+emJITNGmyIt5W+Q+rI4Svc2W1RJwMHDylTo1pW1nGSREDuUngWBNxip gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t4r3tckww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 06:28:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H6SQ3I083288;
        Mon, 17 Jun 2019 06:28:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t5mgb6brv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 06:28:45 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5H6Shnv008545;
        Mon, 17 Jun 2019 06:28:43 GMT
Received: from [192.168.0.110] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Jun 2019 23:28:43 -0700
Subject: Re: [RFC PATCH 07/16] x86/xen: make vcpu_info part of xenhost_t
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-8-ankur.a.arora@oracle.com>
 <9f1323f4-06ae-93a5-c9b0-3b84ee549fa6@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <b1bb28b0-1974-6641-f044-bcddfbf0b628@oracle.com>
Date:   Sun, 16 Jun 2019 23:28:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9f1323f4-06ae-93a5-c9b0-3b84ee549fa6@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-14 4:53 a.m., Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> Abstract out xen_vcpu_id probing via (*probe_vcpu_id)(). Once that is
>> availab,e the vcpu_info registration happens via the VCPUOP hypercall.
>>
>> Note that for the nested case, there are two vcpu_ids, and two vcpu_info
>> areas, one each for the default xenhost and the remote xenhost.
>> The vcpu_info is used via pv_irq_ops, and evtchn signaling.
>>
>> The other VCPUOP hypercalls are used for management (and scheduling)
>> which is expected to be done purely in the default hypervisor.
>> However, scheduling of L1-guest does imply L0-Xen-vcpu_info switching,
>> which might mean that the remote hypervisor needs some visibility
>> into related events/hypercalls in the default hypervisor.
> 
> Another candidate for dropping due to layering violation, I guess.
Yeah, a more narrowly tailored interface, where perhaps the L1-Xen
maps events for L0-Xen makes sense.
Also, just realized that given that L0-Xen has no control over
scheduling of L1-Xen's guests (some of which it might want to
send events to), it makes sense for L1-Xen to have some state
for guest evtchns which pertain to L0-Xen.


Ankur

> 
> 
> Juergen

