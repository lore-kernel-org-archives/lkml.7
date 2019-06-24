Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349D9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A09208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZB3U5aza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfFXOiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:38:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55396 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFXOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:38:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OEXk4g134892;
        Mon, 24 Jun 2019 14:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qqZ0vjCynBtAVoz/jZdw6YOTIgqpd9vMUeh8RLrW8HA=;
 b=ZB3U5azaP/RYhKcVP24a6qHhmISY9+MjkNLIdqylvxmsoNEC020tXE7lSRVpTdoSK7uQ
 ZHEs+lxvcbJcyw/tCmMdXvugIcPmoRCtxOk1B+S1nfvLnK6iz7dXz1EicxiWF+yzIusK
 Q5xQNtnWa+9S9x9cshw9DkbOMzwyPiPTtyVCI42npST1pBMTNPBf/c9cNoOUoJ6X7KIL
 il1F7LWikeZbBeU4sRvM7DNv6uzhgOhE8OUxPFVNYS8pU4o1heqh8GI9IZAArT6Qzvyx
 XdW/nvdFAg1wcEGdeE54h6MqdvJhMWC9Un7kRR2dxYhCqcpLsqnOKgfbJgy6TTOfmtZp sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9pesr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 14:37:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OEZnRu180321;
        Mon, 24 Jun 2019 14:37:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f3ac4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 14:37:18 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OEbCvQ011558;
        Mon, 24 Jun 2019 14:37:12 GMT
Received: from [10.191.23.140] (/10.191.23.140)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 07:37:12 -0700
Subject: Re: [PATCH 1/6] x86/xen: Mark xen_hvm_need_lapic() and
 xen_hvm_need_lapic() as __init
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
 <alpine.DEB.2.21.1906241554210.32342@nanos.tec.linutronix.de>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <1d6ce240-3285-bcfe-8dad-e5a02e9829d6@oracle.com>
Date:   Mon, 24 Jun 2019 22:37:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906241554210.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/6/24 21:58, Thomas Gleixner wrote:
> On Sun, 23 Jun 2019, Zhenzhong Duan wrote:
>
>> .. as they are only called at early bootup stage. In fact, other
>> functions in x86_hyper_xen_hvm.init.* are all marked as __init.
>>
>> Unexport xen_hvm_need_lapic as it's never used outside.
> Can you please provide a cover letter for your patch series and explain
> what this whole exercise is about.

Sure, I'll send a new ones with changes you suggested and the cover letter.

Thanks

Zhenzhong

