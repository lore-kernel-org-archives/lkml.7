Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A8FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00C520663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLJIyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:54:50 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:50198 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfLJIyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:54:50 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iebI8-0001cm-5Y; Tue, 10 Dec 2019 08:54:48 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iebI5-0005XO-Rv; Tue, 10 Dec 2019 08:54:47 +0000
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
To:     Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, davidgow@google.com
References: <20191209230248.227508-1-brendanhiggins@google.com>
 <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
 <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
 <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
 <7da5a054f533eabf2ffa110c236f011bf9d23954.camel@sipsolutions.net>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com>
Date:   Tue, 10 Dec 2019 08:54:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7da5a054f533eabf2ffa110c236f011bf9d23954.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2019 08:28, Johannes Berg wrote:
> On Tue, 2019-12-10 at 07:34 +0000, Anton Ivanov wrote:
> 
>>> Further to this - any properly written piece of networking code which
>>> uses the newer functions for name/service resolution will have the same
>>> problem. You can be static only if you do everything "manually" the old
>>> way.
>>
>> The offending piece of code is the glibc implementation of getaddrinfo().
>>
>> If you use it and link static the resulting binary is not really static.
> 
> However, this (getaddrinfo) really only applies if you use the vector
> network driver, if you e.g. use only virtio then this particular problem
> isn't present.
> 
> Note sure if we implicitly call getaddrinfo from libpcap, but again,
> that's just a single driver.
> 
> IOW, we could just make CONFIG_STATIC_LINK depend on !VECTOR && !PCAP?

+1

We also need to add VDE (wonder if anyone still uses that).

We will need to add XDP when I finish it. If memory servces me right, 
libelf or libbpf has the same lovely features as NSS.

This is not just NSS - it is creeping in with a lot of new libraries. 
Sometimes the libc guys fix that. For example, librt was like that when 
I started working on epoll and vector IO.

Sometimes (as in the NSS case) they don't. So the static build 
containing those will be broken and we are better off making it conflict 
for those options.

> 
> johannes
> 
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
