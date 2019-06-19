Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D56C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB27F20673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HuDXGRU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfFSDBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 23:01:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 23:01:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2xYt0070365;
        Wed, 19 Jun 2019 03:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PU/QrzBhX1uRODKyqt1OB2b+ZI2Y0GRQ2fyxY3ZZbo0=;
 b=HuDXGRU7GQwxXiFXtOKnyASfppsjV52cCnaFNBeV+I7vIMTLNUP5rmbhk0FL7p5TxcpJ
 FFSM34/PVM70T/rzInzVvcaEo2ET9J7PwBD2TTDBQwrKxTi+6VtUvb3SiilFLLgVFZeC
 aQOHB6Tdk/Tf+5LAmHZ2c8C2/Neu96Oe3NdSvxrUhimkdWXoZ+PNa7kSckbxtDcu5RGC
 OPq/gQGdQUP0C3urjtz/M6w+RKpPVW1JITRrnFRv0wyWbgVVf0X6VkZX4WTjvnPOOYSL
 Kq2LPogVFA5dHfqSZwu433L6yvwPPCl8LYFncAtg7slPyshJAGyqR9ktrNXBuc/NCCo2 rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t78098qva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:00:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2vpmm044585;
        Wed, 19 Jun 2019 02:58:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t77yn2wew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:58:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J2wuUd007233;
        Wed, 19 Jun 2019 02:58:56 GMT
Received: from [10.156.74.184] (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 19:58:55 -0700
Subject: Re: [RFC PATCH 14/16] xen/blk: gnttab, evtchn, xenbus API changes
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-15-ankur.a.arora@oracle.com>
 <1a4e2fe7-ed2d-05f1-9f2f-f0a940b30151@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <54f3f690-4e71-325a-6544-6867174a0f0c@oracle.com>
Date:   Tue, 18 Jun 2019 19:59:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1a4e2fe7-ed2d-05f1-9f2f-f0a940b30151@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 3:14 AM, Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> For the most part, we now pass xenhost_t * as a parameter.
>>
>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> I don't see how this can be a patch on its own.
Yes, the reason this was separate was that given this was an
RFC, I didn't want to pollute the logic page with lots of
mechanical changes.

> 
> The only way to be able to use a patch for each driver would be to
> keep the original grant-, event- and xenbus-interfaces and add the
> new ones taking xenhost * with a new name. The original interfaces
> could then use xenhost_default and you can switch them to the new
> interfaces one by one. The last patch could then remove the old
> interfaces when there is no user left.
Yes, this makes sense.

Ankur

> 
> 
> Juergen
