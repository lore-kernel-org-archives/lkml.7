Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C44AC31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB64A206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EUPoWQR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfFSCjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:39:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36948 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:39:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2YjkJ066030;
        Wed, 19 Jun 2019 02:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=n1+FfynzaoDaLUFV1I3elLE0Lu/fzcpDdflwkBfDXtI=;
 b=EUPoWQR7eC6fThbT/7MUOaxUWe9T08ocCsvcJvA1scjpanbsOard3YOaBcj7emApwtjn
 a0Mc7ztutb1eGZXiFQzorB2le/ccMqbytS9Y4THcbkc0yL4odqPJRasM5OCwnmlqwNzr
 tXKuHo5aBn1tck0es49y4b0PgpEHsaanlyxB4EfdxlPVTeGRoWphXcCrUFuJZQUoUXjC
 bn6imrpWZ9adhf61DCSBkKc440UYlNyJ1vw5a37AiioAeqcjyYftMw1JALJsEOePBMpb
 RgzxdmnhT1ZZo/tQeo1txquQ4EycNVtXDJlLIuOQzu1x/levtH1XTnOZsLoRWhV3s06m iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t78098pn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:38:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2bTHo141924;
        Wed, 19 Jun 2019 02:38:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2t77ymtrrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:38:08 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J2c7Zi030393;
        Wed, 19 Jun 2019 02:38:07 GMT
Received: from [10.156.74.184] (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 19:38:06 -0700
Subject: Re: [RFC PATCH 12/16] xen/xenbus: support xenbus frontend/backend
 with xenhost_t
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-13-ankur.a.arora@oracle.com>
 <af5e0319-b850-b263-2ce1-7719b66194e4@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <8afe2703-cabd-3d60-ccf0-084666bfcaaa@oracle.com>
Date:   Tue, 18 Jun 2019 19:38:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <af5e0319-b850-b263-2ce1-7719b66194e4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/19 2:50 AM, Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> As part of xenbus init, both frontend, backend interfaces need to talk
>> on the correct xenbus. This might be a local xenstore (backend) or might
>> be a XS_PV/XS_HVM interface (frontend) which needs to talk over xenbus
>> with the remote xenstored. We bootstrap all of these with evtchn/gfn
>> parameters from (*setup_xs)().
>>
>> Given this we can do appropriate device discovery (in case of frontend)
>> and device connectivity for the backend.
>> Once done, we stash the xenhost_t * in xen_bus_type, xenbus_device or
>> xenbus_watch and then the frontend and backend devices implicitly use
>> the correct interface.
>>
>> The rest of patch is just changing the interfaces where needed.
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   drivers/block/xen-blkback/blkback.c        |  10 +-
>>   drivers/net/xen-netfront.c                 |  14 +-
>>   drivers/pci/xen-pcifront.c                 |   4 +-
>>   drivers/xen/cpu_hotplug.c                  |   4 +-
>>   drivers/xen/manage.c                       |  28 +--
>>   drivers/xen/xen-balloon.c                  |   8 +-
>>   drivers/xen/xenbus/xenbus.h                |  45 ++--
>>   drivers/xen/xenbus/xenbus_client.c         |  32 +--
>>   drivers/xen/xenbus/xenbus_comms.c          | 121 +++++-----
>>   drivers/xen/xenbus/xenbus_dev_backend.c    |  30 ++-
>>   drivers/xen/xenbus/xenbus_dev_frontend.c   |  22 +-
>>   drivers/xen/xenbus/xenbus_probe.c          | 246 +++++++++++++--------
>>   drivers/xen/xenbus/xenbus_probe_backend.c  |  19 +-
>>   drivers/xen/xenbus/xenbus_probe_frontend.c |  65 +++---
>>   drivers/xen/xenbus/xenbus_xs.c             | 188 +++++++++-------
>>   include/xen/xen-ops.h                      |   3 +
>>   include/xen/xenbus.h                       |  54 +++--
>>   include/xen/xenhost.h                      |  20 ++
>>   18 files changed, 536 insertions(+), 377 deletions(-)
>>
>> diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c 
>> b/drivers/xen/xenbus/xenbus_dev_frontend.c
>> index c3e201025ef0..d6e0c397c6a0 100644
>> --- a/drivers/xen/xenbus/xenbus_dev_frontend.c
>> +++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
>> @@ -58,10 +58,14 @@
>>   #include <xen/xenbus.h>
>>   #include <xen/xen.h>
>> +#include <xen/interface/xen.h>
>> +#include <xen/xenhost.h>
>>   #include <asm/xen/hypervisor.h>
>>   #include "xenbus.h"
>> +static xenhost_t *xh;
>> +
>>   /*
>>    * An element of a list of outstanding transactions, for which we're
>>    * still waiting a reply.
>> @@ -312,13 +316,13 @@ static void xenbus_file_free(struct kref *kref)
>>        */
>>       list_for_each_entry_safe(trans, tmp, &u->transactions, list) {
>> -        xenbus_transaction_end(trans->handle, 1);
>> +        xenbus_transaction_end(xh, trans->handle, 1);
>>           list_del(&trans->list);
>>           kfree(trans);
>>       }
>>       list_for_each_entry_safe(watch, tmp_watch, &u->watches, list) {
>> -        unregister_xenbus_watch(&watch->watch);
>> +        unregister_xenbus_watch(xh, &watch->watch);
>>           list_del(&watch->list);
>>           free_watch_adapter(watch);
>>       }
>> @@ -450,7 +454,7 @@ static int xenbus_write_transaction(unsigned 
>> msg_type,
>>              (!strcmp(msg->body, "T") || !strcmp(msg->body, "F"))))
>>           return xenbus_command_reply(u, XS_ERROR, "EINVAL");
>> -    rc = xenbus_dev_request_and_reply(&msg->hdr, u);
>> +    rc = xenbus_dev_request_and_reply(xh, &msg->hdr, u);
>>       if (rc && trans) {
>>           list_del(&trans->list);
>>           kfree(trans);
>> @@ -489,7 +493,7 @@ static int xenbus_write_watch(unsigned msg_type, 
>> struct xenbus_file_priv *u)
>>           watch->watch.callback = watch_fired;
>>           watch->dev_data = u;
>> -        err = register_xenbus_watch(&watch->watch);
>> +        err = register_xenbus_watch(xh, &watch->watch);
>>           if (err) {
>>               free_watch_adapter(watch);
>>               rc = err;
>> @@ -500,7 +504,7 @@ static int xenbus_write_watch(unsigned msg_type, 
>> struct xenbus_file_priv *u)
>>           list_for_each_entry(watch, &u->watches, list) {
>>               if (!strcmp(watch->token, token) &&
>>                   !strcmp(watch->watch.node, path)) {
>> -                unregister_xenbus_watch(&watch->watch);
>> +                unregister_xenbus_watch(xh, &watch->watch);
>>                   list_del(&watch->list);
>>                   free_watch_adapter(watch);
>>                   break;
>> @@ -618,8 +622,9 @@ static ssize_t xenbus_file_write(struct file *filp,
>>   static int xenbus_file_open(struct inode *inode, struct file *filp)
>>   {
>>       struct xenbus_file_priv *u;
>> +    struct xenstore_private *xs = xs_priv(xh);
>> -    if (xen_store_evtchn == 0)
>> +    if (xs->store_evtchn == 0)
>>           return -ENOENT;
>>       nonseekable_open(inode, filp);
>> @@ -687,6 +692,11 @@ static int __init xenbus_init(void)
>>       if (!xen_domain())
>>           return -ENODEV;
>> +    if (xen_driver_domain() && xen_nested())
>> +        xh = xh_remote;
>> +    else
>> +        xh = xh_default;
> 
> This precludes any mixed use of L0 and L1 frontends. With this move you
> make it impossible to e.g. use a driver domain for networking in L1 with
> a L1-local PV disk, or pygrub in L1 dom0.
Ah, yes. I hadn't thought about that case.

Let me see how I can rework this interface.

Ankur

> 
> 
> Juergen
