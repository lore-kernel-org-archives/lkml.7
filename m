Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17212C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCAB207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbfIIPLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:11:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfIIPLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:11:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBA01AE8B;
        Mon,  9 Sep 2019 15:10:57 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To:     James Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830055514.GC8492@lst.de>
 <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
 <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
 <c50cbc24-328f-35b7-5c74-c66a9bd76128@grimberg.me>
 <84338eac-c287-1826-4ac1-72cd17ee62cc@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 mQINBE6KyREBEACwRN6XKClPtxPiABx5GW+Yr1snfhjzExxkTYaINHsWHlsLg13kiemsS6o7
 qrc+XP8FmhcnCOts9e2jxZxtmpB652lxRB9jZE40mcSLvYLM7S6aH0WXKn8bOqpqOGJiY2bc
 6qz6rJuqkOx3YNuUgiAxjuoYauEl8dg4bzex3KGkGRuxzRlC8APjHlwmsr+ETxOLBfUoRNuE
 b4nUtaseMPkNDwM4L9+n9cxpGbdwX0XwKFhlQMbG3rWA3YqQYWj1erKIPpgpfM64hwsdk9zZ
 QO1krgfULH4poPQFpl2+yVeEMXtsSou915jn/51rBelXeLq+cjuK5+B/JZUXPnNDoxOG3j3V
 VSZxkxLJ8RO1YamqZZbVP6jhDQ/bLcAI3EfjVbxhw9KWrh8MxTcmyJPn3QMMEp3wpVX9nSOQ
 tzG72Up/Py67VQe0x8fqmu7R4MmddSbyqgHrab/Nu+ak6g2RRn3QHXAQ7PQUq55BDtj85hd9
 W2iBiROhkZ/R+Q14cJkWhzaThN1sZ1zsfBNW0Im8OVn/J8bQUaS0a/NhpXJWv6J1ttkX3S0c
 QUratRfX4D1viAwNgoS0Joq7xIQD+CfJTax7pPn9rT////hSqJYUoMXkEz5IcO+hptCH1HF3
 qz77aA5njEBQrDRlslUBkCZ5P+QvZgJDy0C3xRGdg6ZVXEXJOQARAQABtCpIYW5uZXMgUmVp
 bmVja2UgKFN1U0UgTGFicykgPGhhcmVAc3VzZS5kZT6JAkEEEwECACsCGwMFCRLMAwAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJOisquAhkBAAoJEGz4yi9OyKjPOHoQAJLeLvr6JNHx
 GPcHXaJLHQiinz2QP0/wtsT8+hE26dLzxb7hgxLafj9XlAXOG3FhGd+ySlQ5wSbbjdxNjgsq
 FIjqQ88/Lk1NfnqG5aUTPmhEF+PzkPogEV7Pm5Q17ap22VK623MPaltEba+ly6/pGOODbKBH
 ak3gqa7Gro5YCQzNU0QVtMpWyeGF7xQK76DY/atvAtuVPBJHER+RPIF7iv5J3/GFIfdrM+wS
 BubFVDOibgM7UBnpa7aohZ9RgPkzJpzECsbmbttxYaiv8+EOwark4VjvOne8dRaj50qeyJH6
 HLpBXZDJH5ZcYJPMgunghSqghgfuUsd5fHmjFr3hDb5EoqAfgiRMSDom7wLZ9TGtT6viDldv
 hfWaIOD5UhpNYxfNgH6Y102gtMmN4o2P6g3UbZK1diH13s9DA5vI2mO2krGz2c5BOBmcctE5
 iS+JWiCizOqia5Op+B/tUNye/YIXSC4oMR++Fgt30OEafB8twxydMAE3HmY+foawCpGq06yM
 vAguLzvm7f6wAPesDAO9vxRNC5y7JeN4Kytl561ciTICmBR80Pdgs/Obj2DwM6dvHquQbQrU
 Op4XtD3eGUW4qgD99DrMXqCcSXX/uay9kOG+fQBfK39jkPKZEuEV2QdpE4Pry36SUGfohSNq
 xXW+bMc6P+irTT39VWFUJMcSuQINBE6KyREBEACvEJggkGC42huFAqJcOcLqnjK83t4TVwEn
 JRisbY/VdeZIHTGtcGLqsALDzk+bEAcZapguzfp7cySzvuR6Hyq7hKEjEHAZmI/3IDc9nbdh
 EgdCiFatah0XZ/p4vp7KAelYqbv8YF/ORLylAdLh9rzLR6yHFqVaR4WL4pl4kEWwFhNSHLxe
 55G56/dxBuoj4RrFoX3ynerXfbp4dH2KArPc0NfoamqebuGNfEQmDbtnCGE5zKcR0zvmXsRp
 qU7+caufueZyLwjTU+y5p34U4PlOO2Q7/bdaPEdXfpgvSpWk1o3H36LvkPV/PGGDCLzaNn04
 BdiiiPEHwoIjCXOAcR+4+eqM4TSwVpTn6SNgbHLjAhCwCDyggK+3qEGJph+WNtNU7uFfscSP
 k4jqlxc8P+hn9IqaMWaeX9nBEaiKffR7OKjMdtFFnBRSXiW/kOKuuRdeDjL5gWJjY+IpdafP
 KhjvUFtfSwGdrDUh3SvB5knSixE3qbxbhbNxmqDVzyzMwunFANujyyVizS31DnWC6tKzANkC
 k15CyeFC6sFFu+WpRxvC6fzQTLI5CRGAB6FAxz8Hu5rpNNZHsbYs9Vfr/BJuSUfRI/12eOCL
 IvxRPpmMOlcI4WDW3EDkzqNAXn5Onx/b0rFGFpM4GmSPriEJdBb4M4pSD6fN6Y/Jrng/Bdwk
 SQARAQABiQIlBBgBAgAPBQJOiskRAhsMBQkSzAMAAAoJEGz4yi9OyKjPgEwQAIP/gy/Xqc1q
 OpzfFScswk3CEoZWSqHxn/fZasa4IzkwhTUmukuIvRew+BzwvrTxhHcz9qQ8hX7iDPTZBcUt
 ovWPxz+3XfbGqE+q0JunlIsP4N+K/I10nyoGdoFpMFMfDnAiMUiUatHRf9Wsif/nT6oRiPNJ
 T0EbbeSyIYe+ZOMFfZBVGPqBCbe8YMI+JiZeez8L9JtegxQ6O3EMQ//1eoPJ5mv5lWXLFQfx
 f4rAcKseM8DE6xs1+1AIsSIG6H+EE3tVm+GdCkBaVAZo2VMVapx9k8RMSlW7vlGEQsHtI0FT
 c1XNOCGjaP4ITYUiOpfkh+N0nUZVRTxWnJqVPGZ2Nt7xCk7eoJWTSMWmodFlsKSgfblXVfdM
 9qoNScM3u0b9iYYuw/ijZ7VtYXFuQdh0XMM/V6zFrLnnhNmg0pnK6hO1LUgZlrxHwLZk5X8F
 uD/0MCbPmsYUMHPuJd5dSLUFTlejVXIbKTSAMd0tDSP5Ms8Ds84z5eHreiy1ijatqRFWFJRp
 ZtWlhGRERnDH17PUXDglsOA08HCls0PHx8itYsjYCAyETlxlLApXWdVl9YVwbQpQ+i693t/Y
 PGu8jotn0++P19d3JwXW8t6TVvBIQ1dRZHx1IxGLMn+CkDJMOmHAUMWTAXX2rf5tUjas8/v2
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <0a3fddcc-62fb-44f4-2be7-a1f9dbdbd1c8@suse.de>
Date:   Mon, 9 Sep 2019 17:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <84338eac-c287-1826-4ac1-72cd17ee62cc@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/19 12:24 AM, James Smart wrote:
> On 8/30/2019 2:07 PM, Sagi Grimberg wrote:
>>
>>>>>>> Yes we do, userspace should use it to order events.  Does udev not
>>>>>>> handle that properly today?
>>>>>>
>>>>>> The problem is not ordering of events, its really about the fact that
>>>>>> the chardev can be removed and reallocated for a different controller
>>>>>> (could be a completely different discovery controller) by the time
>>>>>> that userspace handles the event.
>>>>>
>>>>> The same is generally true for lot of kernel devices.  We could reduce
>>>>> the chance by using the idr cyclic allocator.
>>>>
>>>> Well, it was raised by Hannes and James, so I'll ask them respond here
>>>> because I don't mind having it this way. I personally think that this
>>>> is a better approach than having a cyclic idr allocator. In general, I
>>>> don't necessarily think that this is a good idea to have cyclic
>>>> controller enumerations if we don't absolutely have to...
>>>
>>> We hit it right and left without the cyclic allocator, but that won't
>>> necessarily remove it.
>>>
>>> Perhaps we should have had a unique token assigned to the controller,
>>> and have the event pass the name and the token.  The cli would then,
>>> if the token is present, validate it via an ioctl before proceeding
>>> with other ioctls.
>>>
>>> Where all the connection arguments were added we due to the reuse
>>> issue and then solving the question of how to verify and/or lookup
>>> the desired controller, by using the shotgun approach rather than
>>> being very pointed, which is what the name/token would do.
>>
>> This unique token is: trtype:traddr:trsvcid:host-traddr ...
> 
> well yes :)  though rather verbose.   There is still a minute window as
> we're comparing values in sysfs, prior to opening the device, so
> technically something could change in that window between when we
> checked sysfs and when we open'd.   We can certain check after we open
> the device to solve that issue.
> 
> There is some elegance to a 32-bit token for the controller (can be an
> incrementing value) passed in the event and used when servicing the
> event that avoids a bunch of work.
> 
> Doing either of these would eliminate what Hannes liked - looking for
> the discovery controller with those attributes. Although, I don't know
> that looking for it is all that meaningful.
> 
yeah, we do have this fundamental problem with uevents; they do refer to
a '/dev/nvmeX' device with those parameters, but this device might be
long gone (or have been reallocated) by the time the event is processed.

From my POV we have two choices here:
- rely on the transport options to find a matching controller (ignoring
the device name) and use that for sending out discovery requests. In the
end, it shouldn't really matter device we're using if the transport
options are identical. Although I'm not sure for RDMA; here we don't
necessarily have a host transport address, so we _might_ send the
discovery via the wrong controller in a CMIC enviroment.
- Match the options in nvme-cli, and just discard the event if it
doesn't match. Which is some additional coding in nvme-cli and might ran
afoul if we ever miss events.

I'd go for the second option; after considering the first introduces far
too many conditions rendering debugging impractical.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
