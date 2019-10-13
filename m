Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A0C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A654C206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 13:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="I1aRlrCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfJMN3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 09:29:40 -0400
Received: from mout.web.de ([212.227.15.3]:57823 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbfJMN3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 09:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570973375;
        bh=Nr42B9aBot+89ngMAgddWyD408N4oSxV4VDb4qYDa/E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I1aRlrCpg8KCPOyIEOQQM6kHtTvUesjrBkw0pvhZPC6BH8f6ZH5TKVQ2R4Iyw1Ngg
         t/TFhTSpuEpo7x9iT3Iif7l4pNqAQeLkOWtgLu3j/xKdoqZKDWe3axif41ok7EL2Ht
         y2k6DgoCaAAYwAlLInD+tl+8TJhSzaSUfp2gUmzI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfEfA-1hiNEM3coS-00onRW; Sun, 13
 Oct 2019 15:29:34 +0200
Subject: Re: [PATCH] tools/virtio: Fix build
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
 <20191013075107-mutt-send-email-mst@kernel.org>
 <08c1e081-765b-7c3a-ed31-2059dc521fd0@web.de>
 <20191013081541-mutt-send-email-mst@kernel.org>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <eacb6818-fe3e-f983-9946-e172f0077d4b@web.de>
Date:   Sun, 13 Oct 2019 15:29:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191013081541-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u38kb41fQZHanwjHDCiuNl8EpyKeLVtNVqpe6qF/BXbhMZpL64P
 SYcBUBPHZLcLYqPhV7OS3kXmXYDs4DNH3Zl6rG6aronuhRQTlND3bZN7iFJs9GGCdPrJ66b
 wt8xD2sMINgC6ziCE0exTDEm4A2LhGKLxmBtYbfRv9KefLyCHPHyYhYMNsOW/uNB+ZuvefW
 OF8bo8dFW03AAzliY/xeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T2cwXKca+Ss=:idTQ0bM/ueDQ27qTDnnmJe
 EbguWUybeeWnceajsFa8Uh75JDVmpN8lmPiHWgNosobbUoJFqpvAJm1y1vO83K4bonsJCS2uB
 329EXUFzCRSCBVeoqHNHDy5WQtoXybOYFYPOl7YhWiVVCjIdjAHjE9s5iqcWDIimh/te40Umq
 FRcdtGPXlNuqFUv8HUh0gGLdgaQ7outkZJyIjrK0wEdEwr4U3QlgVU1dbTu5sLEAxEZ8EUx5f
 EkQM8ZnXXkglwPA+96pMgUNbTELkVYks0NLf/k7s+5j0RDizPPKCNHtK4gWo6a7dvRP7ZHLKX
 IoBL/k9WQECVFgMoKNYIGJjuF7E5Sty6kvb/4xmjIZema7+vdfmmOOREK2r8AWTxwDwUMxU/A
 27l436kdA1gwTdzVoeIaY3lSmE3ddp7KbWG467FSMR+1NtSDZ2zKSKhPVxa1veL/1MrIssh0+
 QoUe1+pNqcymf7k7M0rYCf/QY+sPqBVzYGH/xT0J41wh9GQLVmL8chHkiGyla34B4SOLz0Y5w
 /JQRLAGUwRMEleobwmyqOhLF+zMtwMvfVt94Uc2aXnpzljDlqxe6h0nILVE4EfSF9377WTLRg
 JhYu6Ektdo794JAv1EkjbPTUOsAiNq/htxI7H+hPLV18Y9xRxVl7ABPME4/wnHivgTroJ/ZQm
 2+OHDUfIwmidHzO59VAEqvgx8hcxtcHzvbNdGpfCyefZ7oXGnf4+FAWBVUsSKToZH8xPqTneg
 guQX9WQMNLlPo62agC+3zUW/CsM3J/JGWDB7WFhL4WvlSJh33eiJgDREYooLKwjdKLBhzufRR
 kvFA3DXbnJ0YiGx5Q+p/z5CqQme3WWHlBt4A6T37fZUPrLnWZDrRJqxPFzphXaS8+7LN3Uoni
 MQgRwT03ibRRZiNpKZ3ysdD2mA8H8/rax0vFKTiDdjElyrPg/osKIZ/6Au2Q25oR3eytlpmkJ
 2JkDsSKeb9apCmkmTj5wrCAgD+mWZudTs48AAzTY3/fonpV27KaotYrZsT8JCZpKMPBlR70CP
 YSyF3mWs7PiNJvDtYVH1GoZHcxKGJbScfog69tVahLQmcKcd+xopVjyK8h1Pl86UYch2+9XQM
 VoX0aCieIF99GTlmheDrr+kEXy2CKnXmgR8uQEB+zySDLziFIzG3hf00TPO0IrUqv8t56W6Rl
 rMUM5l6gXitNThNbqigYVyl8+iRuytowD3u5dMBwTsly7B+bxOC2fFZe7Z0O6f3F0BW2vNUYo
 Di8acTbgFsYgIvyd1ocV9hUeouvUBk9HK5t1eKp9llaM0T/XkwNMsHNf/tn9AVh65uTlC01DZ
 XQ2KjS6l0Yt0Kh4eQhclCtw7414W6MfY+J/s0KoMyfidbeREHqR+l0xexntP0ctFzkA/jFSQp
 g/veluVA/YQDb5564WxoSUHXQ01Iji68jsh9KNmrhc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.19 14:20, Michael S. Tsirkin wrote:
> On Sun, Oct 13, 2019 at 02:01:03PM +0200, Jan Kiszka wrote:
>> On 13.10.19 13:52, Michael S. Tsirkin wrote:
>>> On Sun, Oct 13, 2019 at 11:03:30AM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Various changes in the recent kernel versions broke the build due to
>>>> missing function and header stubs.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Thanks!
>>> I think it's already fixes in the vhost tree.
>>> That tree also includes a bugfix for the test.
>>> Can you pls give it a spin and report?
>>
>> Mostly fixed: the xen_domain stup is missing.
>>
>> Jan
>
> That's in xen/xen.h. Do you still see any build errors?

ca16cf7b30ca79eeca4d612af121e664ee7d8737 lacks this - forgot to add to
some commit?

Jan
