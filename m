Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0987C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC52620663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLJHOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:14:45 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:50020 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJHOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:14:45 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ieZjH-0001OU-7D; Tue, 10 Dec 2019 07:14:43 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ieZjE-0002ob-VC; Tue, 10 Dec 2019 07:14:42 +0000
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
To:     Richard Weinberger <richard@nod.at>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davidgow <davidgow@google.com>
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com>
 <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
 <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
 <20191207012108.GA220741@google.com>
 <15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com>
 <CAFd5g448yZ5nSVLnN0gvsv3jLnhWG+dzJgvH1jdV+s2eTq4wxg@mail.gmail.com>
 <1785498655.111829.1575936178298.JavaMail.zimbra@nod.at>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <87f182c6-82a3-d696-72e4-ddaa781a655b@cambridgegreys.com>
Date:   Tue, 10 Dec 2019 07:14:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1785498655.111829.1575936178298.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 00:02, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Brendan Higgins" <brendanhiggins@google.com>
>>> IMHO we should at least mark them as "obsolete" and start preparing to
>>> remove them.
>>
>> Alright, I will send a patch out which marks the other network drivers
>> as "obsolete".
>>
>> Clarification: Should I mark all UML network devices as "obsolete"
>> except for NET_VECTOR? Daemon and MCAST looked to me (I am not a
>> networking expert), like they might not be covered by vector.
> 
> No. Why?
> 
> Thanks,
> //richard
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 
At least pcap and vde are maintenance issues. They do not even build today.

Off the top of my head, daemon needs fixes to the switch - it has an 
O(n) performance hit for n="number of ports" as well as a few other issues.

Tap has a fully functional replacement

Pcap has a fully functional replacement

mcast for 2 instances is functionally equivalent to running l2tp or gre 
back-to-back.

IMHO we can start marking some of them as obsolete.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
