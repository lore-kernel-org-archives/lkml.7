Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A87C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfLJHIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:08:50 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:49998 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfLJHIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:08:49 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ieZdT-0001M9-4T; Tue, 10 Dec 2019 07:08:43 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ieZdQ-0002j8-NY; Tue, 10 Dec 2019 07:08:42 +0000
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     johannes.berg@intel.com, Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com>
 <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
 <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
 <20191207012108.GA220741@google.com>
 <15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com>
 <CAFd5g448yZ5nSVLnN0gvsv3jLnhWG+dzJgvH1jdV+s2eTq4wxg@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <778d990f-5e07-b7af-498e-61f69c26f040@cambridgegreys.com>
Date:   Tue, 10 Dec 2019 07:08:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFd5g448yZ5nSVLnN0gvsv3jLnhWG+dzJgvH1jdV+s2eTq4wxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2019 23:40, Brendan Higgins wrote:
> On Sat, Dec 7, 2019 at 1:15 AM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
>> On 07/12/2019 01:21, Brendan Higgins wrote:
>>> On Fri, Dec 06, 2019 at 04:32:34PM -0800, Brendan Higgins wrote:
>>>> On Thu, Dec 5, 2019 at 11:23 PM Anton Ivanov
>>>> <anton.ivanov@cambridgegreys.com> wrote:
>>>> [...]
>>>>> 1. There is a proposed patch for the build system to fix it.
>>> So I just tried the patch you linked on the cover letter[1], and I am
>>> still getting the build error described above:
>>>
>>> arch/um/drivers/pcap_user.c:35:12: error: conflicting types for ‘pcap_open’
>>>    static int pcap_open(void *data)
>>>               ^~~~~~~~~
>>> In file included from /usr/include/pcap.h:43,
>>>                    from arch/um/drivers/pcap_user.c:7:
>>> /usr/include/pcap/pcap.h:859:18: note: previous declaration of ‘pcap_open’ was here
>>>    PCAP_API pcap_t *pcap_open(const char *source, int snaplen, int flags,
>>>
>>> Looking at the patch, I wouldn't expect it to solve this problem.
>>>
>>> Are there maybe different conflicting libpcap-dev libraries and I have
>>> the wrong one? Or is this just still broken?
>>>
>>>>> 2. We should be removing all old drivers and replacing them with the
>>>>> vector ones.
>>>> Hmm...does this mean you would entertain a patch removing all the
>>>> non-vector UML network drivers? I would be happy to see VDE go as
>>>> well.
>>>>
>>>> In any event, it sounds like I should probably drop this patch as it
>>>> is currently.
>>>>
>>>> Thanks!
>>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=938962#79
>>>
>>> _______________________________________________
>>> linux-um mailing list
>>> linux-um@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-um
>>>
>> OK, looks like the pcap.h differs now as well.
>>
>> I will fix that too. It looks like you need both a pcap fix and a
>> library linking fix for this to work.
>>
>> The patch fixes the issue with the build system which no longer provides
>> the means for UML to specify extra libraries (I probably had an older
>> pcap version on the machine where I tested this).
>>
>> IMHO frankly it is no longer necessary.
>>
>> 5.5-rc1 vector raw now has the facility to add/remove (including at
>> runtime) filters compiled with pcap outside UML. It was merged this week.
>>
>> We now have the following line-up for vector drivers - EoGRE, EoL2TPv3,
>> RAW (+/- BPF), TAP and BESS. Speeds are 2.5 to 9Gbit on my machine
>> (mid-range Ryzen desktop).
>>
>> If I figure out a way to get hold of the underlying tap raw sockets the
>> same way vhost does, TAP can probably go to 12Gbit or thereabouts. Same
>> applies to getting zerocopy working with raw.
>>
>> As a basis for comparison I get 18Gbit on the same machine using vEth
>> and containers. 50% of that is actually a very decent number.
>>
>> While vector drivers are not 1:1 replacements for the existing drivers,
>> you can achieve the same topologies and the same connectivity at much
>> higher performance - the old drivers test out in the 500Mbit range on
>> the same hardware.
>>
>> IMHO we should at least mark them as "obsolete" and start preparing to
>> remove them.
> Alright, I will send a patch out which marks the other network drivers
> as "obsolete".
>
> Clarification: Should I mark all UML network devices as "obsolete"
> except for NET_VECTOR? Daemon and MCAST looked to me (I am not a
> networking expert), like they might not be covered by vector.
>
They are not 1:1 replacements unfortunately.

However, in order to fix daemon I have to rewrite the switch from 
uml-utilities too. It is beyond obsolete.

MCAST for 2 UML instances can be replaced by either GRE or L2TPv3, for 
more than 2 you are better off introducing a proper switch.

I am OK if all old drivers are marked as obsolete at this point, so 
please proceed with the patch.

Brgds,

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

