Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5F92087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfG3MRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:17:07 -0400
Received: from smtp.infotech.no ([82.134.31.41]:39395 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbfG3MRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:17:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 0F0CD204165;
        Tue, 30 Jul 2019 14:17:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J3twQyiY8KbP; Tue, 30 Jul 2019 14:17:03 +0200 (CEST)
Received: from [82.134.31.183] (unknown [82.134.31.183])
        by smtp.infotech.no (Postfix) with ESMTPA id DA3CF20414E;
        Tue, 30 Jul 2019 14:17:03 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [RFC PATCH] usb: typec: tcpm: Ignore unsupported/unknown
 alternate mode requests
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
 <20190729140457.GC28600@kuha.fi.intel.com>
 <20190729173104.GA32556@roeck-us.net>
 <20190730120747.GL28600@kuha.fi.intel.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <f0bf0afd-af51-09d4-c552-5d19d0d5a829@interlog.com>
Date:   Tue, 30 Jul 2019 14:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730120747.GL28600@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-30 2:07 p.m., Heikki Krogerus wrote:
> On Mon, Jul 29, 2019 at 10:31:04AM -0700, Guenter Roeck wrote:
>> On Mon, Jul 29, 2019 at 05:04:57PM +0300, Heikki Krogerus wrote:
>>> Hi,
>>>
>>> On Wed, Jul 24, 2019 at 09:30:37PM -0700, Guenter Roeck wrote:
>>>> TCPM may receive PD messages associated with unknown or unsupported
>>>> alternate modes. If that happens, calls to typec_match_altmode()
>>>> will return NULL. The tcpm code does not currently take this into
>>>> account. This results in crashes.
>>>>
>>>> Unable to handle kernel NULL pointer dereference at virtual address 000001f0
>>>> pgd = 41dad9a1
>>>> [000001f0] *pgd=00000000
>>>> Internal error: Oops: 5 [#1] THUMB2
>>>> Modules linked in: tcpci tcpm
>>>> CPU: 0 PID: 2338 Comm: kworker/u2:0 Not tainted 5.1.18-sama5-armv7-r2 #6
>>>> Hardware name: Atmel SAMA5
>>>> Workqueue: 2-0050 tcpm_pd_rx_handler [tcpm]
>>>> PC is at typec_altmode_attention+0x0/0x14
>>>> LR is at tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm]
>>>> ...
>>>> [<c03fbee8>] (typec_altmode_attention) from [<bf8030fb>]
>>>> 				(tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm])
>>>> [<bf8030fb>] (tcpm_pd_rx_handler [tcpm]) from [<c012082b>]
>>>> 				(process_one_work+0x123/0x2a8)
>>>> [<c012082b>] (process_one_work) from [<c0120a6d>]
>>>> 				(worker_thread+0xbd/0x3b0)
>>>> [<c0120a6d>] (worker_thread) from [<c012431f>] (kthread+0xcf/0xf4)
>>>> [<c012431f>] (kthread) from [<c01010f9>] (ret_from_fork+0x11/0x38)
>>>>
>>>> Ignore PD messages if the asociated alternate mode is not supported.
>>>>
>>>> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
>>>> Cc: Douglas Gilbert <dgilbert@interlog.com>
>>>> Fixes: e9576fe8e605c ("usb: typec: tcpm: Support for Alternate Modes")
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> Taking a stab at the problem. I don't really know if this is the correct
>>>> fix, or even if my understanding of the problem is correct, thus marking
>>>> the patch as RFC.
>>>
>>> My guess is that typec_match_altmode() is the real culprit. We can't
>>> rely on the partner mode index number when identifying the port alt
>>> mode.
>>>
>>> Douglas, can you test the attached hack instead of this patch?
>>>
>>>
>>> thanks,
>>>
>>> -- 
>>> heikki
>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>> index ec525811a9eb..033dc097ba83 100644
>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>> @@ -1067,12 +1067,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
>>>   
>>>   	modep = &port->mode_data;
>>>   
>>> -	adev = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
>>> -				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
>>> -
>>>   	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
>>>   				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
>>>   
>>> +	adev = (void *)typec_altmode_get_partner(pdev);
>>> +
>>
>> I understand that typec_altmode_get_partner() returns a const *;
>> maybe adev should be declared as const struct typec_altmode *
>> instead of using a typecast.
> 
> Yes...
> 
>> Also, typec_altmode_get_partner() can return NULL as well if pdev is NULL.
>> Is it guaranteed that typec_match_altmode() never returns NULL for pdev ?
> 
> ...and probable no. But I don't think we can receive Attention to a
> mode that hasn't been entered.
> 
> I'm not proposing that as a patch. It's just a hunch. That's why I'm
> calling it a "hack". Before we prepare anything finalized, I would
> like to here from Douglas if he's able to test that or not?

Hi,
I'm an ocean away from my test rig at the moment, won't be back home till
after August 10. Maybe I can set up something here as I have one OM13588.
Will try later today. Also, switching from an sama5d2_xplained to an Acme
Systems Arietta which is at91sam9g25 based to run Linux. So it won't be
exactly the same hardware.

Doug Gilbert

