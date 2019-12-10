Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D723FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F4320663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLJHUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:20:53 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:50036 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfLJHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:20:53 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ieZpC-0001PM-0K; Tue, 10 Dec 2019 07:20:51 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1ieZp9-0002xH-E2; Tue, 10 Dec 2019 07:20:49 +0000
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
To:     Richard Weinberger <richard@nod.at>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, davidgow@google.com
References: <20191209230248.227508-1-brendanhiggins@google.com>
 <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
Date:   Tue, 10 Dec 2019 07:20:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2019 23:15, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Brendan Higgins" <brendanhiggins@google.com>
>> An: "Jeff Dike" <jdike@addtoit.com>, "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>
>> CC: "Johannes Berg" <johannes.berg@intel.com>, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel"
>> <linux-kernel@vger.kernel.org>, davidgow@google.com, "Brendan Higgins" <brendanhiggins@google.com>
>> Gesendet: Dienstag, 10. Dezember 2019 00:02:48
>> Betreff: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
> 
>> CONFIG_STATIC_LINK appears to have been broken since before v4.20. It
>> doesn't play nice with CONFIG_UML_NET_VECTOR=y:
>>
>> /usr/bin/ld: arch/um/drivers/vector_user.o: in function
>> `user_init_socket_fds': vector_user.c:(.text+0x430): warning: Using
>> 'getaddrinfo' in statically linked applications requires at runtime the
>> shared libraries from the glibc version used for linking
> 
> This is nothing serious.
> 
>> And it seems to break the ptrace check:
>>
>> Checking that ptrace can change system call numbers...check_ptrace :
>> child exited with exitcode 6, while expecting 0; status 0x67f
>> [1]    126822 abort      ./linux mem=256M
> 
> Didn't we fix that already?

Yes we did - I commented on this.

> 
>> (Apparently, a patch was recently discussed that fixes this - around
>> v5.5-rc1[1] - but the fact that this was broken for over a year
>> remains.)
>>
>> According to Anton, PCAP throws even more warnings, and the resulting
>> binary isn't really even static anyway, so there is really no point in
>> keeping this config around[2].
> 
> What?
> Anton, please explain. Why is it not static when build with CONFIG_STATIC_LINK?


LIBC itself tries to dynamic load stuff internally.

It is beyond our control and it claims that it will work only on EXACTLY 
the same version of libc library as the one used for static link.

So you get a not-exactly static binary which is not properly moveable 
between systems.

This is specifically in the name resolution, etc parts of libc which all 
of: pcap, vector, vde, etc rely on.

Another alternative is to turn off static specifically for those.

Further to this - any properly written piece of networking code which 
uses the newer functions for name/service resolution will have the same 
problem. You can be static only if you do everything "manually" the old way.

> 
> Thanks,
> //richard
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
