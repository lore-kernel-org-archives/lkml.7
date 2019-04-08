Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3EAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F327F20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wl0SCb1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDHKhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:37:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55140 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:37:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38ATTQt079483;
        Mon, 8 Apr 2019 10:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1Yh8wsEMtdwfeWmTJL2MOGAwGxin4sl8w/5ToT0KMMo=;
 b=wl0SCb1L0uXsUOv1gq/4QkI4ZOH6jPuigFaEx+hkcNNyeGscNuCm9Uiwe/EQrletr04k
 fpZ/eqL2HJ3r6tUFomtuXTVtlgKro1aFrW+0EiWPPkohGEjpYmFHm/RRlaqrb7ZEL34x
 wQKDaH1qMjjsqtUqgSNTrF/wUuhikjQZz/xJPGbU/QBEmgUL7H6UOS9/1pmecJNLBoms
 wRPT920grRZbAMW9UBs3kY0IfLq1X6FIynqH78a/wKhuyooNCY79jwMzPciTc2EJTn/P
 1BblOtXyq2nMW2BF2bEqKsCQoxwpqpkqVWXW9Mt3gkEp3XjmAbmOEccyM8KNV8KMSG/m Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rpmrpwcav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 10:37:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38AZnh2003711;
        Mon, 8 Apr 2019 10:37:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rpkehmkj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 10:37:02 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x38Ab0LS021527;
        Mon, 8 Apr 2019 10:37:00 GMT
Received: from [10.175.201.94] (/10.175.201.94)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 03:37:00 -0700
Subject: Re: [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     Juergen Gross <jgross@suse.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <35051310-c497-8ad5-4434-1b8426a317d2@redhat.com>
 <8b1f4912-4f92-69ae-ae01-d899d5640572@oracle.com>
 <3ee91f33-2973-c2db-386f-afbf138081b4@redhat.com>
 <59676804-786d-3df8-7752-8e45dec6d65b@oracle.com>
 <ac0fb2d0-59bf-1330-24ab-331c1a69b13f@suse.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <94738323-ebdf-d58e-55b6-313e27c923b0@oracle.com>
Date:   Mon, 8 Apr 2019 11:36:54 +0100
MIME-Version: 1.0
In-Reply-To: <ac0fb2d0-59bf-1330-24ab-331c1a69b13f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080095
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 7:44 AM, Juergen Gross wrote:
> On 12/03/2019 18:14, Joao Martins wrote:
>> On 2/22/19 4:59 PM, Paolo Bonzini wrote:
>>> On 21/02/19 12:45, Joao Martins wrote:
>>>> On 2/20/19 9:09 PM, Paolo Bonzini wrote:
>>>>> On 20/02/19 21:15, Joao Martins wrote:
>>>>>>  2. PV Driver support (patches 17 - 39)
>>>>>>
>>>>>>  We start by redirecting hypercalls from the backend to routines
>>>>>>  which emulate the behaviour that PV backends expect i.e. grant
>>>>>>  table and interdomain events. Next, we add support for late
>>>>>>  initialization of xenbus, followed by implementing
>>>>>>  frontend/backend communication mechanisms (i.e. grant tables and
>>>>>>  interdomain event channels). Finally, introduce xen-shim.ko,
>>>>>>  which will setup a limited Xen environment. This uses the added
>>>>>>  functionality of Xen specific shared memory (grant tables) and
>>>>>>  notifications (event channels).
>>>>>
>>>>> I am a bit worried by the last patches, they seem really brittle and
>>>>> prone to breakage.  I don't know Xen well enough to understand if the
>>>>> lack of support for GNTMAP_host_map is fixable, but if not, you have to
>>>>> define a completely different hypercall.
>>>>>
>>>> I guess Ankur already answered this; so just to stack this on top of his comment.
>>>>
>>>> The xen_shim_domain() is only meant to handle the case where the backend
>>>> has/can-have full access to guest memory [i.e. netback and blkback would work
>>>> with similar assumptions as vhost?]. For the normal case, where a backend *in a
>>>> guest* maps and unmaps other guest memory, this is not applicable and these
>>>> changes don't affect that case.
>>>>
>>>> IOW, the PV backend here sits on the hypervisor, and the hypercalls aren't
>>>> actual hypercalls but rather invoking shim_hypercall(). The call chain would go
>>>> more or less like:
>>>>
>>>> <netback|blkback|scsiback>
>>>>  gnttab_map_refs(map_ops, pages)
>>>>    HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref,...)
>>>>      shim_hypercall()
>>>>        shim_hcall_gntmap()
>>>>
>>>> Our reasoning was that given we are already in KVM, why mapping a page if the
>>>> user (i.e. the kernel PV backend) is himself? The lack of GNTMAP_host_map is how
>>>> the shim determines its user doesn't want to map the page. Also, there's another
>>>> issue where PV backends always need a struct page to reference the device
>>>> inflight data as Ankur pointed out.
>>>
>>> Ultimately it's up to the Xen people.  It does make their API uglier,
>>> especially the in/out change for the parameter.  If you can at least
>>> avoid that, it would alleviate my concerns quite a bit.
>>
>> In my view, we have two options overall:
>>
>> 1) Make it explicit, the changes the PV drivers we have to make in
>> order to support xen_shim_domain(). This could mean e.g. a) add a callback
>> argument to gnttab_map_refs() that is invoked for every page that gets looked up
>> successfully, and inside this callback the PV driver may update it's tracking
>> page. Here we no longer have this in/out parameter in gnttab_map_refs, and all
>> shim_domain specific bits would be a little more abstracted from Xen PV
>> backends. See netback example below the scissors mark. Or b) have sort of a
>> translate_gref() and put_gref() API that Xen PV drivers use which make it even
>> more explicit that there's no grant ops involved. The latter is more invasive.
>>
>> 2) The second option is to support guest grant mapping/unmapping [*] to allow
>> hosting PV backends inside the guest. This would remove the Xen changes in this
>> series completely. But it would require another guest being used
>> as netback/blkback/xenstored, and less performance than 1) (though, in theory,
>> it would be equivalent to what does Xen with grants/events). The only changes in
>> Linux Xen code is adding xenstored domain support, but that is useful on its own
>> outside the scope of this work.
>>
>> I think there's value on both; 1) is probably more familiar for KVM users
>> perhaps (as it is similar to what vhost does?) while  2) equates to implementing
>> Xen disagregation capabilities in KVM.
>>
>> Thoughts? Xen maintainers what's your take on this?
> 
> What I'd like best would be a new handle (e.g. xenhost_t *) used as an
> abstraction layer for this kind of stuff. It should be passed to the
> backends and those would pass it on to low-level Xen drivers (xenbus,
> event channels, grant table, ...).
> 
So if IIRC backends would use the xenhost layer to access grants or frames
referenced by grants, and that would grok into some of this. IOW, you would have
two implementors of xenhost: one for nested remote/local events+grants and
another for this "shim domain" ?

> I was planning to do that (the xenhost_t * stuff) soon in order to add
> support for nested Xen using PV devices (you need two Xenstores for that
> as the nested dom0 is acting as Xen backend server, while using PV
> frontends for accessing the "real" world outside).
> 
> The xenhost_t should be used for:
> 
> - accessing Xenstore
> - issuing and receiving events
> - doing hypercalls
> - grant table operations
> 

In the text above, I sort of suggested a slice of this on 1.b) with a
translate_gref() and put_gref() API -- to get the page from a gref. This was
because of the flags|host_addr hurdle we depicted above wrt to using using grant
maps/unmaps. You think some of the xenhost layer would be ammenable to support
this case?

> So exactly the kind of stuff you want to do, too.
> 
Cool idea!

	Joao
