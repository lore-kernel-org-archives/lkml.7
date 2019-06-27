Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A54C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EE0206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qpnaljbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0Ir6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:47:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0Ir5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:47:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R8iNhV136940;
        Thu, 27 Jun 2019 08:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=93mz8clE7mxFWu7TjZH7XFY2Ms8eR0PjjG2K5ojozgI=;
 b=qpnaljbO9CoGsmmw0g8t05pozvaEEQb7XuExawKy1R4TLe22JEnrVwQFq9X1K6im+QsC
 DcIL+htMGSUznepYL5RaHrSpO9nyKAo5bHHZANfwsxTFJTa+7/lFaNww7kBPH5r+Gjly
 yzmpFrVn3qeh+fCkTtVfFTWpIN35NTX2Oo11Aio29XqkRbIdiBsvXaBjTZHvBfYmDMmz
 nFtL5KGfvtDkCrkkOAvKqWSpetn99TxbD/Ir3r0B3aXBtxxI5Xhm51AN2ppB72DinXmU
 ZQ4AfkUQS93KXSAZwVaNCH8aQYvlxJNuhx+ziEz0aXxTD/VNqKgCP05+kFF9Hc9YfGoh 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyqpx0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 08:47:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R8jvqI003241;
        Thu, 27 Jun 2019 08:47:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f4w1j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 08:47:25 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5R8lFhp014205;
        Thu, 27 Jun 2019 08:47:15 GMT
Received: from [10.191.15.58] (/10.191.15.58)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 01:47:14 -0700
Subject: Re: [PATCH v2 0/7] misc fixes to PV extentions code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
 <alpine.DEB.2.21.1906261511180.32342@nanos.tec.linutronix.de>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <ab80e007-1d7e-ff13-d11a-10999d198ad3@oracle.com>
Date:   Thu, 27 Jun 2019 16:47:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906261511180.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/6/26 21:39, Thomas Gleixner wrote:
> Documentation/process/submitting-patches.rst clearly explains why it is a
> bad idea to send random collections of patches especially if some patches
> are independent and contain bug fixes.
>
> These rules exist for a reason and are not subject to personal
> interpretation. You want your patches to be reviewed and merged, so pretty
> please make the life of those who need to do that as easy as possible.
>
> It's not the job of reviewers and maintainers to distangle your randomly
> ordered patch series.

Ok，understood.  I'll send independent and unrelated patch seperately.

Thanks

Zhenzhong

