Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D2DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B639222B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfLLHOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:14:50 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:54290 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfLLHOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:14:50 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ifIgP-0000Xa-Ta; Thu, 12 Dec 2019 07:14:46 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ifIgN-0002uy-Mj; Thu, 12 Dec 2019 07:14:45 +0000
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
To:     James McMechan <james_mcmechan@hotmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davidgow <davidgow@google.com>
References: <20191209230248.227508-1-brendanhiggins@google.com>
 <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
 <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
 <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
 <392256369.112046.1575966868218.JavaMail.zimbra@nod.at>
 <DM6PR10MB3225EB0C204572F8D39C0ED5E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
 <DM6PR10MB32259A098E3BED3CF522C851E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <3f4af81b-72e5-b197-ef25-aaf5aae0e604@cambridgegreys.com>
Date:   Thu, 12 Dec 2019 07:14:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <DM6PR10MB32259A098E3BED3CF522C851E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 05:23, James McMechan wrote:
> Fixed up version without html...
> Um what is broken, uml seems to be working with the old stack and static linking.
> 
> I saw a comment that the vector io stuff breaks uml on static link,
> but I was just running one without vector io, I had the pcap library linked in instead.
> It was up for about 3 days when I rebooted from mconsole 'cad'
> It would seem simplest to just mark vector io as !STATIC in the config...
> I was running 5.4.2 with a pretty close to defconfig
> 
> I had to twiddle the uml pcap a little to deconflict the headers, and make sure pcap was not linking to dbus.
> I have not looked into vector io too closely I seemed to remember it was using host getaddrinfo the only thing in uml doing so I think it was pulling in the glibc, so-so dynamically link networking even when told not to... and that was breaking the startup process by changing memory maps behind the programs back or some such and then segfaulting the process much like the "we will implement async io in userspace behind the processes back" did back in the day.
> 
> I would expect it to be possible to remove the getaddrinfo or use kernel functions.

If you just try to do 1:1 replacement with the legacy functions you stop 
being v6 compliant. You after that need to go through quite a lot of 
hoops and extra code to get that back.

You cannot use kernel functions - this is on the host userspace side of UML.

> It does not seem to have much in the way of comments, and I don't understand what it is trying to do.
> Why would a network protocol need to lookup "protocol/ip address/port num" sets in userspace? it should just be passing everything somewhere...
> Is it trying to do dynamic routing of the packets to different transports?

It is using shared code for (at present) tap (two forms - one optimized 
for throughput, one using a tap/socket pair optimized for packets per 
second), raw sockets, gre, l2tpv3 (both raw and over udp) and one 
flavour unix domain sockets.

Both gre and l2tpv3 support v4 and v6.

While it is possible to replace getaddrinfo with a sequence of 
gethostbyname, etc it will:

1. Grow the size of the code by at least 100 lines if not more. If I 
take care of all corner cases which getaddrinfo() does - more.

2. Defeat one of the purposes of the exercise - to make it easy to add 
new socket transports.

3. There is no guarantee that the glibc guys will not make gethostbyname 
and friends fallback to getaddrinfo internally one day (in fact I am 
surprised they have not done it yet).

> 
> Slight confused but still running,
> 
> Jim McMechan
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
