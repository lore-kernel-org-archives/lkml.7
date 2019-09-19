Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232E9C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C2520678
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jsm5R1vD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404477AbfISTs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:48:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44660 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389652AbfISTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:48:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JJicAk133932;
        Thu, 19 Sep 2019 19:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LAiTKSZHSuxFjM1/p19jMQ1VET2e1DzzMTpoMTyyXYc=;
 b=jsm5R1vDWVV0VtMsXFG2L79ihWBo74/lTDHqseS6/4m7/6/GPWMQdF46IH47lLq+kIrH
 PXYeMtZ+eRu2VS4fyvRg4FbdCdlDNJBp2IjU9YXd8Go9yWIToFN+3tBvdfiFUbL0NRLo
 KyGFlwDPeR2y27CMg0CmLMZd4rVZfY2bgh0CKMYkmZFXqxCLL7ochYpVuE2IVAq7CTKz
 gIP3EQ+0yM0rM88NjqpMINUN+z0DoqVyvtMOOnLgAuJF47Gqt8MPQzoHiYdFfHVUY5XN
 GCWyYBTtCoLi1/DLsEXmkbQTxDk1ZhXUmkWh6yUzcNY3pnGQXXnnhSfxTTsXcdQHP+xA 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v3vb4p7q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 19:48:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JJi0NU183608;
        Thu, 19 Sep 2019 19:48:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2v3vbb5rh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 19:48:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8JJm6gR030344;
        Thu, 19 Sep 2019 19:48:07 GMT
Received: from [10.175.0.114] (/10.175.0.114)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 12:48:06 -0700
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
To:     Thomas Gleixner <tglx@linutronix.de>,
        Johannes Erdfelt <johannes@erdfelt.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
References: <20190829130213.GA23510@araj-mobl1.jf.intel.com>
 <20190903164630.GF11641@zn.tnic>
 <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03> <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <b0b0a1c0-979d-cc54-38e2-d37522aab351@oracle.com>
Date:   Thu, 19 Sep 2019 22:48:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ro
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

La 07.09.2019 00:16, Thomas Gleixner a scris:
> On Fri, 6 Sep 2019, Johannes Erdfelt wrote:
>> On Fri, Sep 06, 2019, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> What your customers are asking for is a receipe for disaster. They can
>>> check the safety of late loading forever, it will not magically become safe
>>> because they do so.
>>>
>>> If you want late loading, then the whole approach needs to be reworked from
>>> ground up. You need to make sure that all CPUs are in a safe state,
>>> i.e. where switching of CPU feature bits of all sorts can be done with the
>>> guarantee that no CPU will return to the wrong code path after coming out
>>> of safe state and that any kernel internal state which depends on the
>>> previous set of CPU feature bits has been mopped up and switched over
>>> before CPUs are released.
>>
>> You say that switching of CPU feature bits is problematic, but adding
>> new features should result only in a warning ("x86/CPU: CPU features
>> have changed after loading microcode, but might not take effect.").
>>
>> Removing a CPU feature bit could be problematic. Other than HLE being
>> removed on Haswell (which the kernel shouldn't use anyway), have there
>> been any other cases?
>>
>> I ask because we have successfully used late microcode loading on tens
>> of thousands of hosts. I'm a bit worried to see that there is a push to
>> remove a feature that we currently rely on.
> 
> The point is that you know what's on stake so you can evaluate precisely
> upfront whether that works or not and you have experienced kernel engineers
> on staff who can tell you which kind of ucode change is going to explode in
> your face and which on does not.
> 
> So it's the special case of a large cloud company with experts on staff.
> 
> Now map that to the average user/sysadmin. If we proliferate this, then the
> inevitable consequence will be that those people read about how great that
> is and how it made your customers happy yadayadayada. Now they go and do
> the same thing and guess what happens? It explodes in their face, they send
> bug reports and someone else will send lousy patches to paper over the
> problem. None of this ends on your desk.
> 
> Yes you can surely argue that if you give people a gun then they can shoot
> themself into their foot. But in that case it's a irresponsible argument
> which just put's your interest above the general rule of not offering
> things which are bound to break in all flavours of wreckage especially in
> the hard to diagnose way.
> 
> So if we want to do late microcode loading in a sane way then there are
> only a few options and none of them exist today:
> 
>   1) Micro-code contains a description of CPUID bits which are going to be
>      exposed after the load. Then the kernel can sanity check whether this
>      changes anything relevant or not. If there is a relevant change it can
>      reject the load and tell the admin that a reboot is required.
> 
>   2) Rework CPUID feature handling so that it can reevaluate and reconfigure
>      the running system safely. There are a lot of things you need for that:
> 
>      A) Introduce a safe state for CPUs to reach which guarantees that none
>         of the CPUs will return from that state via a code path which
>         depends on previous state and might now go the other route with data
>         on the stack which only fits the previous configuration.
> 
>      B) Make all the cpufeature thingies run time switchable. That means
>         that you need to keep quite some code around which is currently init
>         only. That also means that you have to provide backout code for
>         things which set up data corresponding to cpu feature bits and so
>         forth.
> 
> So #2 might be finished in about 20 years from now with the result that
> some of the code pathes might simply still have a
> 
>       if (cpufeature_changed())
>       	   panic();
> 
> because there are things which you cannot back out. So the only sane
> solution is to panic. Which is not a solution as it would be much more sane
> to prevent late loading upfront and force people to reboot proper.
> 
> Now #1 is actually a sensible and feasible solution which can be pulled off
> in a reasonably short time frame, avoids all the bound to be ugly and
> failure laden attempts of fixing late loading completely and provides a
> usable and safe solution for joe user, jack admin and the super experts at
> big-cloud corporate.
> 
> That is not requiring any new format of microcode payload, as this can be
> nicely done as a metadata package which comes with the microcode
> payload. So you get the following backwards compatible states:
> 
>    Kernel  metadata	  result
> 
>    old	  don't care	  refuse late load
> 
>    new	  No   		  refuse late load
> 
>    new	  Yes		  decide based on metadata
> 
> Thoughts?


Internally, we have fix-up multiple corner cases about the late 
microcode loading. We have written some code to handle new features 
showing up but we know they are a bunch of hacks (for sure it lacks of 
different checks that needs to be done before using the new features). I 
am going to take Thomas' suggestion and work on an RFC series.

Thank you,
Mihai Carabas
