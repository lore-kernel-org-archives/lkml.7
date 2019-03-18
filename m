Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B54C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E8020872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2sXJYDd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfCRDKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:10:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44316 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfCRDKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:10:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2I34uRM113709;
        Mon, 18 Mar 2019 03:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0eFjCXnfgt40+OHDtKFxAdJZphrqp7d2bQ6vDtLlPCU=;
 b=2sXJYDd9AvgfUOYyExYpTYQK56LYB4fAu9zel+LjZCnbEDICvJcjMuXVuY5lGQ+TOULt
 sNQk+YeC33WAZ/8i7yABFRWoCo/sCG/L7D0plwCJfQKG6MT9KqhleenTfvRLKG4NhB4B
 qasoVoTTytHYIO4o58S2I3tx5axA8CH15N0jKBKW4ah8SegT5yF7qLNKVyrX/Ccn+7gm
 50n91f6gcxUf9Oe9idtu/kBt/m8/LvWQvuRH8mMfdzNUBYvbzw05hMf3UrgQXbEDFg3I
 Bezhdj7dJo+ohbBemOcMtXG3+jNb5qt5HdCjHYpLd31CqiFEgOvwsqEgH7s+KMa+/3jc 7A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r8pnec440-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 03:10:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2I3AB3G022715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 03:10:11 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2I3AAsD030944;
        Mon, 18 Mar 2019 03:10:11 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Mar 2019 20:10:10 -0700
Subject: Re: [BUG] scsi: ses: out of bound accessing in
 ses_enclosure_data_process
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>, diego.gonzalez@oracle.com
References: <78dd3eca-7e8a-72f9-07f9-e2c7cc4569b0@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <40646609-8298-2d76-2f0c-e732404a23d4@oracle.com>
Date:   Mon, 18 Mar 2019 11:13:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <78dd3eca-7e8a-72f9-07f9-e2c7cc4569b0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone please give some suggestions ?

It looks like there somethings wrong in the read-in data, 

	/* skip all the enclosure descriptors */
	for (i = 0; i < num_enclosures && type_ptr < buf + len; i++) {
		types += type_ptr[2];
		type_ptr += type_ptr[3] + 4; ----> here
	}
Then the typr_ptr got out of bound of the buffer.


Thanks
Jianchao

On 3/14/19 11:19 AM, jianchao.wang wrote:
> Dear all
> 
> When our customer probe the lpfc devices, they encountered odd memory corruption issues,
> and we get 'out of bound' access warning at following position after open KASAN
> 
> ses_enclosure_data_process
> 
> for (i = 0; i < types; i++, type_ptr += 4) {
>   for (j = 0; j < type_ptr[1]; j++) {
>                    ^^^^^^^^^^^
>                    out of bound
> 
> With some debug log, I got following,
> 
> page1 ffff88042d1aad20 len 32 types 5 type_ptr ffff88042d1aad64
> 
> Would anyone please give some suggestions on this ?
> 
> Thanks
> Jianchao
> 
