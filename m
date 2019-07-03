Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857D2C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F89221873
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LYZGo2Ny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfGCCPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:15:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfGCCPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x632DjV5159738;
        Wed, 3 Jul 2019 02:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TPUr3GVO/Gj7hfmOlod1TVREougro104UwyKk/uRAko=;
 b=LYZGo2NyUqx2WE+YB2OoGuHbvvxESMst1mo3oQ2YsVSNSZ4zjDLUQZKAwdRLd88J+0Un
 BTQgIvKSh+98g85O4jIy2EoMLkR6iXgvPY4wPm0iRWMNkT3UQ5O7U5oBh/S1TINyojQ9
 QMGxl/HWeKd8KGi8j7iiT1knkNsBP5OyZF5T15lJOia5SkUATQlqaJtzk58yxQ6BrNHy
 B6Dh39LreSTEgWs9E/RQ+i6Hkd0SPhPo5zioJS8YjPqCa3AJnilkFs3onZyHhcxEvRej
 aC4I90zch5nvMKPMkUR7nrHbbAtYNFcuBrriCqpzkx2tL6WqhTLKdX0py3Qbk6MzUh3J Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2te61pxr92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 02:14:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x632Ce9k099569;
        Wed, 3 Jul 2019 02:14:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tebkuknsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 02:14:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x632EP7e016631;
        Wed, 3 Jul 2019 02:14:25 GMT
Received: from [10.191.27.205] (/10.191.27.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 19:14:25 -0700
Subject: Re: [PATCH v4 5/5] xen: Add 'xen_nopv' parameter back for backward
 compatibility
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
References: <1561958399-28906-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561958399-28906-6-git-send-email-zhenzhong.duan@oracle.com>
 <603e1c8a-408b-360d-9a84-6d91b5f1db1b@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <cd07bf77-11e6-5aca-9449-ffad8aea95cb@oracle.com>
Date:   Wed, 3 Jul 2019 10:14:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <603e1c8a-408b-360d-9a84-6d91b5f1db1b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907030026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/3 2:13, Boris Ostrovsky wrote:
> On 7/1/19 1:19 AM, Zhenzhong Duan wrote:
>> Map 'xen_nopv' to 'nopv' and mark 'xen_nopv' obsolete in
>> kernel-parameters.txt
> I am not sure we want patch #3, why not do everything in a single patch?
>
Thanks for review. I'll fix all those based on your comments.

Zhenzhong

