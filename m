Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991DFC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C92E218A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r55Olug4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfFQGKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:10:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43462 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfFQGKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:10:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H64Lsi130933;
        Mon, 17 Jun 2019 06:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=grdh29BU5yPRUROUC1gK19xRI+enCyZKgEFK2tTBSUk=;
 b=r55Olug45CBi7UUK63b+i0uGwVL2OZxoTNQDJNqyv5qxve3Nv3Sjvv8XFA1+ev5CFjym
 8/iFWQtWiDQEWGZ9HVExOIZhW4Di9BT4MXx4Wr3e0zMZ8qskkatJgRIdZwQPgwfe3WAf
 dkRVSdtEF17G38I35GrioUvENz9ewK19+O3gQiNAaTfZFayOw6hvsCrQ2tsc64E3jz0e
 /OYhraHsoetNaAhLf7xpIJiW3nMHgmvWYVfXrTQfZZjibIMbVapybEP623SR2G1oPB+k
 zGP6twlX1njC0FciqjV+u3dy9gPQswM1W/aatT2j8ujVE2zEM7psbNFDXZoABXnOYsqj Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t4r3tcgv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 06:09:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H695oe117917;
        Mon, 17 Jun 2019 06:09:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t5h5sybe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 06:09:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5H69QdH022783;
        Mon, 17 Jun 2019 06:09:26 GMT
Received: from [192.168.0.110] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Jun 2019 23:09:26 -0700
Subject: Re: [RFC PATCH 09/16] xen/evtchn: support evtchn in xenhost_t
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-10-ankur.a.arora@oracle.com>
 <c91abc40-03e3-2ebd-a878-b251a97869db@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <be7c4638-6677-9ed1-7d68-539898b90b2a@oracle.com>
Date:   Sun, 16 Jun 2019 23:09:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c91abc40-03e3-2ebd-a878-b251a97869db@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-14 5:04 a.m., Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> Largely mechanical patch that adds a new param, xenhost_t * to the
>> evtchn interfaces. The evtchn port instead of being domain unique, is
>> now scoped to xenhost_t.
>>
>> As part of upcall handling we now look at all the xenhosts and, for
>> evtchn_2l, the xenhost's shared_info and vcpu_info. Other than this
>> event handling is largley unchanged.
>>
>> Note that the IPI, timer, VIRQ, FUNCTION, PMU etc vectors remain
>> attached to xh_default. Only interdomain evtchns are allowable as
>> xh_remote.
> 
> I'd do only the interface changes for now (including evtchn FIFO).
Looking at this patch again, it seems to me that it would be best to
limit the interface change (to take the xenhost_t * parameter) only to
bind_interdomain_*. That also happily limits the change to the drivers/
subtree.

> 
> The main difference will be how to call the hypervisor for sending an
> event (either direct or via a passthrough-hypercall).
Yeah, though, this would depend on how the evtchns are mapped (if it's
the L1-Xen which is responsible for mapping the evtchn on behalf of the 
L0-Xen, then notify_remote_via_evtchn() could just stay the same.)
Still, I'll add a send interface (perhaps just an inline function) to
the xenhost interface for this.

Ankur

> 
> 
> Juergen

