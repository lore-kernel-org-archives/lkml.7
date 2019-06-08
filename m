Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B1FC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C56C208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aA36vdZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfFHFCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 01:02:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34136 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfFHFCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 01:02:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x584xk27074161;
        Sat, 8 Jun 2019 05:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=iekzr2MQdPk3SDaxbZ1003Sw3EsU+tQlu1SJLk3qzkE=;
 b=aA36vdZUbKpVadR8J3OuJ5awvlQML0GkP2l5izNB6IAtGdz36BY2rV+apJAvO/Mr1nfW
 5vXVJKfxSrHdj7lgPKwPdxvV8tt8HLEw5JvVomshJmPhMyILYqAhQikogWdJ6zkz7g9z
 ATAgdF8wH81scaymHxxQH1kt4Nal2TOI9jIl9/0sis4EUY1+cHdpid1gFnFIOR9a58x6
 O+HtO31TJp+AyVKYgbuHo18k+njbnyLcltlmnz+HKU/dk1AvL5vdqHEeTy1oiS4pWtvG
 L8mG25b9D5SgAh9cIRjSqXXa09AsZ7KQ1t1ULb65/kta9fMPPnKHohvZUXU7e/eb5ZoJ iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2t02he8c39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 05:01:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x58518rL118548;
        Sat, 8 Jun 2019 05:01:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t024t2sj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 05:01:44 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5851hDF029132;
        Sat, 8 Jun 2019 05:01:43 GMT
Received: from [192.168.0.110] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 22:01:42 -0700
Subject: Re: [RFC PATCH 06/16] x86/xen: add shared_info support to xenhost_t
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-7-ankur.a.arora@oracle.com>
 <97d41abd-3717-1f78-4d5e-dfa74261e9c7@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <71126f1a-ad50-cf4e-2cc8-5a778a7ecbb4@oracle.com>
Date:   Fri, 7 Jun 2019 22:01:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <97d41abd-3717-1f78-4d5e-dfa74261e9c7@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906080037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906080037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-07 8:08 a.m., Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> HYPERVISOR_shared_info is used for irq/evtchn communication between the
>> guest and the host. Abstract out the setup/reset in xenhost_t such that
>> nested configurations can use both xenhosts simultaneously.
> 
> I have mixed feelings about this patch. Most of the shared_info stuff we
> don't need for the nested case. In the end only the event channels might
> be interesting, but we obviously want them not for all vcpus of the L1
> hypervisor, but for those of the current guest.
Agreed about the mixed feelings part. shared_info does feel far too
heavy to drag along just for the event-channel state.
Infact, on thinking a bit more, a better abstraction for nested
event-channels would have been as an extension to the primary
xenhost's event-channel bits.
(The nested upcalls also go via the primary xenhost in patch-8.)

Ankur

> 
> So I think just drop that patch for now. We can dig it out later in case > nesting wants it again.
> 
> 
> Juergen

