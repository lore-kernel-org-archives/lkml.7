Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7F8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED29208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDIOlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:41:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44099 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfDIOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:41:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so5652916wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGwHiTy3w6TTvN4tiJzIGEvDD3LckMpwND5QTpBxOgY=;
        b=hQGhbykknJX3G+5Jc0SfHxIhpq525E8cn+EN2GCIxLNTWFEEiCMYaP///ZEbVQjYAz
         GLLCsaWxISEj3nQwma5YeEyBAkdYS+X046M0hzxRWwD5bi7iVVdcZT+UwSrlaJbe4jHp
         2WGN4ND+i28/L+LXzZzdiRqEoKpkIMWgA9W7NlqNq9A36xpPamfPb1lhF4wLzzJ6ISDI
         roTD94mMjOtX9hx1s4KeuO7El4KgqzovvIK3nf5zITKQxZBCIqewfGKjKaBNqG/9O8nl
         3NazMvwPzwCPF/YJ6cQRbkGMzZ3hwgqzA+sgPYusPdZtoXoRZggHTLKnw2KTIztDVTXj
         iZWw==
X-Gm-Message-State: APjAAAWdaSdvYiJ4NpSrAdN67kt0aFu8DGWWkYZkDkq/S0cEV+mm9g32
        zjNCySd72+XntSWmf1B7YexBD+ruUd8=
X-Google-Smtp-Source: APXvYqwULSnz4QRriK6GpjwcQqKR1e6ooTk04kX1se5ft/VEVTQ0bs02E/g13TngNaSd/UzW59Kb+g==
X-Received: by 2002:a5d:46c9:: with SMTP id g9mr21788211wrs.211.1554820874270;
        Tue, 09 Apr 2019 07:41:14 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g12sm32263895wrw.40.2019.04.09.07.41.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:41:13 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: tcpm: collision avoidance
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kyle Tso <kyletso@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190322121745.159768-1-kyletso@google.com>
 <20190404141345.GF21319@kuha.fi.intel.com>
 <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net>
 <CAGZ6i=2zKLhS4By8Xanc863G+jSxPYg8SLU-UHkY94r5MiEYag@mail.gmail.com>
 <20190409130230.GC20058@kuha.fi.intel.com>
 <20190409130649.GD20058@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9c9d17e3-bd99-c877-359c-a0a1b10a8d73@redhat.com>
Date:   Tue, 9 Apr 2019 16:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409130649.GD20058@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-04-19 15:06, Heikki Krogerus wrote:
> On Tue, Apr 09, 2019 at 04:02:30PM +0300, Heikki Krogerus wrote:
>> +Hans
>>
>> On Mon, Apr 08, 2019 at 10:17:35PM +0800, Kyle Tso wrote:
>>> On Fri, Apr 5, 2019 at 9:42 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 4/4/19 7:13 AM, Heikki Krogerus wrote:
>>>>> Hi,
>>>>>
>>>>> On Fri, Mar 22, 2019 at 08:17:45PM +0800, Kyle Tso wrote:
>>>>>> This patch provides the implementation of Collision Avoidance introduced
>>>>>> in PD3.0. The start of each Atomic Message Sequence (AMS) initiated by
>>>>>> the port will be denied if the current AMS is not interruptible. The
>>>>>> Source port will set the CC to SinkTxNG if it is going to initiate an
>>>>>> AMS, and SinkTxOk otherwise. Meanwhile, any AMS initiated by a Sink port
>>>>>> will be denied in TCPM if the port partner (Source) sets SinkTxNG except
>>>>>> for HARD_RESET and SOFT_RESET.
>>>>>
>>>>> I tested this with my GDBWin which has fusb302. When I plug-in
>>>>> DisplayPort adapter, the partner device never gets registered, and I
>>>>> see steady flow of warnings from fusb302:
>>>>>
>>>>
>>>> FWIW, I made multiple attempts to review the patch. Each time I get stuck
>>>> after a while and notice that I don't understand what is going on.
>>>>
>>>> Maybe the state machine needs a complete overhaul. It seems to have reached
>>>> a point where it is getting too complex to understand what is going on.
>>>>
>>>>> [  693.391176] Vconn is on during toggle start
>>>>> [  693.391250] WARNING: CPU: 2 PID: 30 at drivers/usb/typec/tcpm/fusb302.c:562 fusb302_set_toggling+0x129/0x130 [fusb302]
>>>>> [  693.400293] Modules linked in: intel_xhci_usb_role_switch fusb302 tcpm roles pi3usb30532 i915 typec intel_gtt intel_cht_int33fe
>>>>> [  693.406309] CPU: 2 PID: 30 Comm: kworker/u8:1 Tainted: G        W         5.1.0-rc3-heikki+ #17
>>>>> [  693.408434] cht_wcove_pwrsrc cht_wcove_pwrsrc: Could not detect charger type
>>>>> [  693.412278] Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
>>>>> [  693.412283] Workqueue: i2c-fusb302 tcpm_state_machine_work [tcpm]
>>>>> [  693.424256] RIP: 0010:fusb302_set_toggling+0x129/0x130 [fusb302]
>>>>> [  693.427234] Code: 89 df e8 da ef ff ff 85 c0 78 c6 c6 83 b0 01 00 00 00 eb b7 b9 02 00 00 00 e9 48 ff ff ff 48 c7 c7 20 e8 21 a0 e8 8e 0c e4 e0 <0f> 0b e9 58 ff ff ff 41 55 4c 8d 6f e8 41 54 41 89 f4 55 53 48 8d
>>>>> [  693.436204] RSP: 0000:ffffc9000076bd90 EFLAGS: 00010286
>>>>> [  693.439174] RAX: 0000000000000000 RBX: ffff888178080028 RCX: 0000000000000000
>>>>> [  693.442157] RDX: 000000000000001f RSI: ffffffff8259051f RDI: ffffffff8259091f
>>>>> [  693.445130] RBP: 0000000000000003 R08: ffffffff82590500 R09: 00000000000202c0
>>>>> [  693.448100] R10: 0000010cb24a3d18 R11: 000000000000001e R12: ffff8881780801b0
>>>>> [  693.451086] R13: ffffffffa021e4e5 R14: 0000000000000003 R15: ffff888178080040
>>>>> [  693.454060] FS:  0000000000000000(0000) GS:ffff88817bb00000(0000) knlGS:0000000000000000
>>>>> [  693.460009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  693.462984] CR2: 00000000f7fb74a0 CR3: 000000000200d000 CR4: 00000000001006e0
>>>>> [  693.465969] Call Trace:
>>>>> [  693.468937]  tcpm_set_cc+0xb9/0x170 [fusb302]
>>>>> [  693.471894]  tcpm_ams_start+0x1b8/0x2a0 [tcpm]
>>>>
>>>> tcpm_ams_start() sets TYPEC_CC_RP_1_5 unconditionally, no matter what. This causes
>>>> the fusb302 code to start toggling. As such, it may well attempt to start toggling
>>>> in the wrong state.
>>>>
>>>> Guenter
>>>>
>>>
>>> I read the fusb302 spec but failed to find the statement that says it
>>> should "set toggling" when CC switches among default/medium/high.
>>>
>>> quot from fusb302 spec:
>>> "The FUSB302 allows the host software to change the charging current
>>> capabilities of the port through the HOST_CUR control bits. If the
>>> HOST_CUR bits are changed prior to attach, the FUSB302 automatically
>>> indicates the programmed current capability when a device is attached.
>>> If the current capabilities are changed after a device is attached,
>>> the FUSB302 immediately changes the CC line to the programmed
>>> capability."
>>>
>>> Is it possible to skip fusb302_set_toggling() @ line#658 if
>>> tcpm_set_cc() is called in order to switch the cc among
>>> default/medium/high of Rp ?
> 
> Hans, you introduced that in commit daf81d0137a9c ("usb: typec:
> fusb302: Refactor / simplify tcpm_set_cc()"), so could you take a look
> at this.

I do not believe that that commit introduces the fusb302_set_toggling()
as the subject of the commit says it just refactors things, the
set_toggling call was introduced by:

commit ea3b4d5523bc8("usb: typec: fusb302: Resolve fixed power role contract setup")

Before that:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/tcpm/fusb302.c?id=40326e857c57a0095d3f9d72c14cb13aef4ca564

tcpm_set_cc actually turned toggling off in all cases.

I've no doubt that Adam was seeing a real problem, but I've doubted if this
was the right fix before. I even had it reverted in my tree for a while, but
since in my use-cases so far it has not caused any problems I've not looked
into it further.

In the mean time the code has changed quite a bit though, so making
tcpm_set_cc() behave as it did before, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/tcpm/fusb302.c?id=40326e857c57a0095d3f9d72c14cb13aef4ca564

Will require writing something from scratch based on the new code which
mimicks the behaviour of the old code; and then we also need to fix Adam's
problem on top.

Regards,

Hans






> 
>>> the tcpm log on another PD controller:
>>> [ 1215.709538] CC1: 0 -> 2, CC2: 0 -> 1 [state DRP_TOGGLING, polarity
>>> 0, connected]
>>> [ 1215.709551] state change DRP_TOGGLING -> SRC_ATTACH_WAIT
>>> [ 1215.709576] pending state change SRC_ATTACH_WAIT -> SRC_ATTACHED @
>>> 200 ms
>>> [ 1215.907465] state change SRC_ATTACH_WAIT -> SRC_ATTACHED [delayed
>>> 200 ms]
>>> [ 1215.907670] polarity 0
>>> [ 1215.908070] Requesting mux state 1, usb-role 1, orientation 1
>>> [ 1215.909342] vconn:=1
>>> [ 1215.909549] vbus:=1 charge=0
>>> [ 1215.909633] Setting pd capable false
>>> [ 1215.909637] pending state change SRC_ATTACHED -> SRC_UNATTACHED @
>>> 480 ms
>>> [ 1215.909685] VBUS on
>>> [ 1215.909687] state change SRC_ATTACHED -> SRC_STARTUP
>>> [ 1215.914263] AMS POWER_NEGOTIATION start
>>> [ 1215.914267] cc:=4
>>> [ 1215.914288] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
>>> [ 1215.914294] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS
>>> POWER_NEGOTIATION
>>> [ 1215.914298] PD TX, header: 0x11a1
>>> [ 1215.919552] PD TX complete, status: 2
>>> [ 1215.919577] pending state change SRC_SEND_CAPABILITIES ->
>>> SRC_SEND_CAPABILITIES @ 150 ms in AMS POWER_NEGOTIATION
>>> [ 1216.071041] state change SRC_SEND_CAPABILITIES ->
>>> SRC_SEND_CAPABILITIES [delayed 150 ms]
>>> [ 1216.071049] PD TX, header: 0x11a1
>>> [ 1216.072508] PD TX complete, status: 0
>>> [ 1216.072535] Setting pd capable true
>>> [ 1216.072645] pending state change SRC_SEND_CAPABILITIES ->
>>> HARD_RESET_SEND @ 150 ms in AMS POWER_NEGOTIATION
>>> [ 1216.073915] PD RX, header: 0x1042 [1]
>>> [ 1216.073920] state change SRC_SEND_CAPABILITIES -> SRC_NEGOTIATE_CAPABILITIES
>>> [ 1216.073941] Requested 5000 mV, 900 mA for 900 / 900 mA
>>> [ 1216.073944] PD TX, header: 0x363
>>> [ 1216.075281] PD TX complete, status: 0
>>> [ 1216.075337] pending state change SRC_NEGOTIATE_CAPABILITIES ->
>>> SRC_TRANSITION_SUPPLY @ 35 ms
>>> [ 1216.113742] state change SRC_NEGOTIATE_CAPABILITIES ->
>>> SRC_TRANSITION_SUPPLY [delayed 35 ms]
>>> [ 1216.113752] PD TX, header: 0x566
>>> [ 1216.116743] PD TX complete, status: 0
>>> [ 1216.117175] state change SRC_TRANSITION_SUPPLY -> SRC_READY
>>> [ 1216.118737] PD TX, header: 0x176f
>>> [ 1216.120285] PD TX complete, status: 0
>>> [ 1216.122455] PD RX, header: 0x524f [1]
>>> [ 1216.122463] Rx VDM cmd 0xff008041 type 1 cmd 1 len 5
>>> [ 1216.122511] Identity: 04b4:1120.0000
>>> [ 1216.122531] PD TX, header: 0x196f
>>> [ 1216.123965] PD TX complete, status: 0
>>> [ 1216.125573] PD RX, header: 0x244f [1]
>>> [ 1216.125578] Rx VDM cmd 0xff008042 type 1 cmd 2 len 2
>>> [ 1216.125581] SVID 1: 0xff01
>>> [ 1216.125603] PD TX, header: 0x1b6f
>>> [ 1216.127074] PD TX complete, status: 0
>>> [ 1216.128750] PD RX, header: 0x264f [1]
>>> [ 1216.128754] Rx VDM cmd 0xff018043 type 1 cmd 3 len 2
>>> [ 1216.128758]  Alternate mode 0: SVID 0xff01, VDO 1: 0x00000405
>>>
>>>>> [  693.474855]  ? _cond_resched+0x10/0x20
>>>>> [  693.477807]  tcpm_state_machine_work+0x57e/0x28f6 [tcpm]
>>>>> [  693.480776]  ? tcpm_pd_event_handler+0x111/0x320 [tcpm]
>>>>> [  693.483743]  process_one_work+0x1da/0x410
>>>>> [  693.486703]  worker_thread+0x28/0x3c0
>>>>> [  693.489651]  ? process_one_work+0x410/0x410
>>>>> [  693.492603]  kthread+0x10b/0x130
>>>>> [  693.495548]  ? kthread_create_on_node+0x60/0x60
>>>>> [  693.498506]  ret_from_fork+0x1f/0x30
>>>>>
>>>>>
>>>>> Here's the tcpm debugfs log:
>>>>>
>>>>> [  692.553000] CC1: 0 -> 2, CC2: 0 -> 1 [state DRP_TOGGLING, polarity 0, connected]
>>>>> [  692.553016] state change DRP_TOGGLING -> SRC_ATTACH_WAIT
>>>>> [  692.553056] pending state change SRC_ATTACH_WAIT -> SNK_TRY @ 200 ms
>>>>> [  692.757402] state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
>>>>> [  692.757410] cc:=2
>>>>> [  692.761946] pending state change SNK_TRY -> SNK_TRY_WAIT @ 100 ms
>>>>> [  692.869308] state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
>>>>> [  692.869313] state change SNK_TRY_WAIT -> SRC_TRYWAIT
>>>>> [  692.869317] cc:=3
>>>>> [  692.873657] pending state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED @ 100 ms
>>>>> [  692.882524] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_TRYWAIT, polarity 0, connected]
>>>>> [  692.882537] state change SRC_TRYWAIT -> SRC_TRYWAIT_DEBOUNCE
>>>>> [  692.882567] pending state change SRC_TRYWAIT_DEBOUNCE -> SRC_ATTACHED @ 200 ms
>>>>> [  693.085337] state change SRC_TRYWAIT_DEBOUNCE -> SRC_ATTACHED [delayed 200 ms]
>>>>> [  693.085347] polarity 0
>>>>> [  693.085352] Requesting mux state 1, usb-role 1, orientation 1
>>>>> [  693.346845] vconn:=1
>>>>> [  693.347174] vbus:=1 charge=0
>>>>> [  693.358340] pending state change SRC_ATTACHED -> SRC_UNATTACHED @ 480 ms
>>>>> [  693.378702] VBUS on
>>>>> [  693.378711] state change SRC_ATTACHED -> SRC_STARTUP
>>>>> [  693.378741] AMS POWER_NEGOTIATION start
>>>>> [  693.378745] cc:=4
>>>>> [  693.505321] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
>>>>> [  693.505325] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS POWER_NEGOTIATION
>>>>> [  693.505327] PD TX, header: 0x11a1
>>>>> [  693.613296] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms in AMS POWER_NEGOTIATION
>>>>> [  693.613309] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_SEND_CAPABILITIES, polarity 0, connected]
>>>>> [  693.765730] state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES [delayed 150 ms]
>>>>> [  693.765753] PD TX, header: 0x11a1
>>>>> [  693.770016] PD TX complete, status: 0
>>>>> [  693.770261] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES_TIMEOUT @ 150 ms in AMS POWER_NEGOTIATION
>>>>> [  693.775178] PD RX, header: 0x1042 [1]
>>>>> [  693.775195] state change SRC_SEND_CAPABILITIES -> SRC_NEGOTIATE_CAPABILITIES
>>>>> [  693.775236] Requested 5000 mV, 400 mA for 400 / 900 mA
>>>>> [  693.775244] PD TX, header: 0x363
>>>>> [  693.778253] PD TX complete, status: 0
>>>>> [  693.778363] pending state change SRC_NEGOTIATE_CAPABILITIES -> SRC_TRANSITION_SUPPLY @ 35 ms
>>>>> [  693.803463] Received hard reset
>>>>> [  693.803473] state change SRC_NEGOTIATE_CAPABILITIES -> HARD_RESET_START
>>>>> [  693.806323] pending state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF @ 30 ms
>>>>> [  693.837400] state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF [delayed 30 ms]
>>>>> [  693.837414] vconn:=1
>>>>> [  693.837426] vbus:=0 charge=0
>>>>> [  693.843380] Requesting mux state 1, usb-role 1, orientation 1
>>>>> [  693.844554] pending state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON @ 760 ms
>>>>> [  693.844575] VBUS off
>>>>> [  693.844580] state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON
>>>>> [  693.844617] vbus:=1 charge=0
>>>>> [  693.850688] pending state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED @ 480 ms
>>>>> [  693.868706] VBUS on
>>>>> [  693.868713] state change SRC_HARD_RESET_VBUS_ON -> SRC_STARTUP
>>>>> [  693.868742] AMS POWER_NEGOTIATION start
>>>>> [  693.868749] cc:=4
>>>>> [  694.101422] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
>>>>> [  694.101425] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS POWER_NEGOTIATION
>>>>> [  694.101428] PD TX, header: 0x11a1
>>>>> [  694.205301] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms in AMS POWER_NEGOTIATION
>>>>> [  694.205317] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_SEND_CAPABILITIES, polarity 0, connected]
>>>>> [  694.325808] Received hard reset
>>>>> [  694.325816] state change SRC_SEND_CAPABILITIES -> HARD_RESET_START in AMS NONE_AMS
>>>>> [  694.329208] pending state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF @ 30 ms in AMS NONE_AMS
>>>>> [  694.359394] state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF [delayed 30 ms]
>>>>> [  694.359401] vconn:=1
>>>>> [  694.359408] vbus:=0 charge=0
>>>>> [  694.366321] Requesting mux state 1, usb-role 1, orientation 1
>>>>> [  694.367685] pending state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON @ 760 ms in AMS NONE_AMS
>>>>> [  694.367700] VBUS off
>>>>> [  694.367704] state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON in AMS NONE_AMS
>>>>> [  694.367721] vbus:=1 charge=0
>>>>> [  694.374175] pending state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED @ 480 ms in AMS NONE_AMS
>>>>> [  694.374194] CC1: 2 -> 0, CC2: 1 -> 0 [state SRC_HARD_RESET_VBUS_ON, polarity 0, disconnected]
>>>>> [  694.374201] state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED in AMS NONE_AMS
>>>>> [  694.631957] Start DRP toggling
> 
> thanks,
> 
