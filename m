Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0FF22BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IPH/9AVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404317AbfGYFkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:40:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55528 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404241AbfGYFkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:40:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P5d0Xf078656;
        Thu, 25 Jul 2019 05:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DIaad5qbirnDkeKlUJE4RYRnrPGQKiec4THTqLDSXrw=;
 b=IPH/9AVYiWVzq6wlgvo3F/88gUEHhrUGkzLM6HKQ3AmDJPgJ8FW1o+LAKoVFyJLNsUwb
 zsrH29WQGuIYFvvrTct1noJAWGP/8qtGXRkEr+gewJ/1f2dvoFCOpy3i9lZck/YnIK61
 jNr2CX38esOUkjQUYt0LsFbgzuHJIPziZ8qxVU66qow2iB++jbx1iY41Mr0DwIl6QHCA
 2ANpXPrK4JxlnkWQcrPaFf2m5BynwVihkJd0W4F9mSDy3r9CxoRka8aPoGoJUb0uyHbS
 YDvkMJudKzqg3boByZ4sZ9HKCuCpRp//23F3sY3O6NEQ4bNxLWaol7M+3AEhbFvKISaY NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tx61c1f6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 05:40:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P5bmEi117255;
        Thu, 25 Jul 2019 05:40:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tx60yn82x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 05:40:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6P5dxBH003035;
        Thu, 25 Jul 2019 05:39:59 GMT
Received: from [10.159.158.5] (/10.159.158.5)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 22:39:56 -0700
Subject: Re: [PATCH v2 0/1] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <1564007603-9655-1-git-send-email-jane.chu@oracle.com>
 <CAPcyv4iqdbL+=boCciMTgUEn-GU1RQQmBJtNU9RHoV84XNMS+g@mail.gmail.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <fa353250-2ea2-3be3-5e4d-1ccf7dc06014@oracle.com>
Date:   Wed, 24 Jul 2019 22:39:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iqdbL+=boCciMTgUEn-GU1RQQmBJtNU9RHoV84XNMS+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=986
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2019 3:52 PM, Dan Williams wrote:
> On Wed, Jul 24, 2019 at 3:35 PM Jane Chu <jane.chu@oracle.com> wrote:
>>
>> Changes in v2:
>>   - move 'tk' allocations internal to add_to_kill(), suggested by Dan;
> 
> Oh, sorry if it wasn't clear, this should move to its own patch that
> only does the cleanup, and then the follow on fix patch becomes
> smaller and more straightforward.
> 

Make sense, thanks! I'll split up the patch next.

thanks,
-jane
