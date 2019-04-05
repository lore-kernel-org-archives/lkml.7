Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFABEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AE8206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkfCg7iQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfDENmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:42:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDENmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:42:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so3093133pgk.12;
        Fri, 05 Apr 2019 06:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/tdzLJiuuuH/k42nytiU69DlIEy/5fN1NXYhETaelTw=;
        b=pkfCg7iQrILeRL7uPg7GYy6gDijLnk1zXE7RfzI/1Ru/qVNzDDqVpEyhISJuxLLh+f
         gTKGVU1wMGR4a2KKRgVaKKn93dIOwHXsHAmNmbXGDMzRpR1nUwgv8quNchQWoQM3MG2j
         OnQzat42oIUOpASapQrWMt2f9n2vpnLweSdvtebKmhOpJzbexdI1SjHK9LbS3FUXT3vZ
         Ox1b+DOGv1cCV6FvzOmbqQs8K0r7N9AdTKVjWTfdxPVRnCODsFOO3fhB2asNJFZG9FaK
         VIZExJus1jcU+REh9pbqXlpnEQQuSzm57ePnROM5uUgvB6o3UkOhCwNPoM72q8/Akbo2
         wD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/tdzLJiuuuH/k42nytiU69DlIEy/5fN1NXYhETaelTw=;
        b=JHLihe8BTtcIibHbw2wzJrK3NmWUIx3NSajP2GDMh6BUR6m0Uox9Tpj5lYwVyu+VZQ
         smOMMzaMvuoEUFsaYClOuMD3Umwnt6lwU89H+L3o/pEqGUOfI/jlBCpRy917ZN2zi8nG
         GhOcfy2YUip3fH1vchjGg89LWSXaSYjijwt/KPd5FGloN9rH4Jf2470Mw8TfX14yAAjC
         eswZiebiaD/U1CLOi3M/jln90ivFDgwIUE1nZZRAsr7SD0g7LGdxpxekNOelcXE1dYGu
         GxdNCEQcQEVTm5DsRKHhdDTHQVsBhj6b+Im8xR8aUl1bM6wjDbZRW8lHGJ87HtIG6eTJ
         hwEg==
X-Gm-Message-State: APjAAAU9eR0ihuP8zOFsjKBmIE2+GimjE2fpWarFApAn80l7I6hojzu1
        f+ZN+aERoVuhrMxO+ESerfduO2Sk
X-Google-Smtp-Source: APXvYqzRJLif+zCKiQpOQDMvmBzxmLJMQWBDL49ard8OwmaNNJ0zgd8nNLMWvAKeVbU4tvk2tOhxhg==
X-Received: by 2002:a63:fa54:: with SMTP id g20mr11603632pgk.242.1554471734774;
        Fri, 05 Apr 2019 06:42:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i126sm31912534pfc.101.2019.04.05.06.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 06:42:14 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: tcpm: collision avoidance
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kyle Tso <kyletso@google.com>
Cc:     gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190322121745.159768-1-kyletso@google.com>
 <20190404141345.GF21319@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net>
Date:   Fri, 5 Apr 2019 06:42:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404141345.GF21319@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 7:13 AM, Heikki Krogerus wrote:
> Hi,
> 
> On Fri, Mar 22, 2019 at 08:17:45PM +0800, Kyle Tso wrote:
>> This patch provides the implementation of Collision Avoidance introduced
>> in PD3.0. The start of each Atomic Message Sequence (AMS) initiated by
>> the port will be denied if the current AMS is not interruptible. The
>> Source port will set the CC to SinkTxNG if it is going to initiate an
>> AMS, and SinkTxOk otherwise. Meanwhile, any AMS initiated by a Sink port
>> will be denied in TCPM if the port partner (Source) sets SinkTxNG except
>> for HARD_RESET and SOFT_RESET.
> 
> I tested this with my GDBWin which has fusb302. When I plug-in
> DisplayPort adapter, the partner device never gets registered, and I
> see steady flow of warnings from fusb302:
> 

FWIW, I made multiple attempts to review the patch. Each time I get stuck
after a while and notice that I don't understand what is going on.

Maybe the state machine needs a complete overhaul. It seems to have reached
a point where it is getting too complex to understand what is going on.

> [  693.391176] Vconn is on during toggle start
> [  693.391250] WARNING: CPU: 2 PID: 30 at drivers/usb/typec/tcpm/fusb302.c:562 fusb302_set_toggling+0x129/0x130 [fusb302]
> [  693.400293] Modules linked in: intel_xhci_usb_role_switch fusb302 tcpm roles pi3usb30532 i915 typec intel_gtt intel_cht_int33fe
> [  693.406309] CPU: 2 PID: 30 Comm: kworker/u8:1 Tainted: G        W         5.1.0-rc3-heikki+ #17
> [  693.408434] cht_wcove_pwrsrc cht_wcove_pwrsrc: Could not detect charger type
> [  693.412278] Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
> [  693.412283] Workqueue: i2c-fusb302 tcpm_state_machine_work [tcpm]
> [  693.424256] RIP: 0010:fusb302_set_toggling+0x129/0x130 [fusb302]
> [  693.427234] Code: 89 df e8 da ef ff ff 85 c0 78 c6 c6 83 b0 01 00 00 00 eb b7 b9 02 00 00 00 e9 48 ff ff ff 48 c7 c7 20 e8 21 a0 e8 8e 0c e4 e0 <0f> 0b e9 58 ff ff ff 41 55 4c 8d 6f e8 41 54 41 89 f4 55 53 48 8d
> [  693.436204] RSP: 0000:ffffc9000076bd90 EFLAGS: 00010286
> [  693.439174] RAX: 0000000000000000 RBX: ffff888178080028 RCX: 0000000000000000
> [  693.442157] RDX: 000000000000001f RSI: ffffffff8259051f RDI: ffffffff8259091f
> [  693.445130] RBP: 0000000000000003 R08: ffffffff82590500 R09: 00000000000202c0
> [  693.448100] R10: 0000010cb24a3d18 R11: 000000000000001e R12: ffff8881780801b0
> [  693.451086] R13: ffffffffa021e4e5 R14: 0000000000000003 R15: ffff888178080040
> [  693.454060] FS:  0000000000000000(0000) GS:ffff88817bb00000(0000) knlGS:0000000000000000
> [  693.460009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  693.462984] CR2: 00000000f7fb74a0 CR3: 000000000200d000 CR4: 00000000001006e0
> [  693.465969] Call Trace:
> [  693.468937]  tcpm_set_cc+0xb9/0x170 [fusb302]
> [  693.471894]  tcpm_ams_start+0x1b8/0x2a0 [tcpm]

tcpm_ams_start() sets TYPEC_CC_RP_1_5 unconditionally, no matter what. This causes
the fusb302 code to start toggling. As such, it may well attempt to start toggling
in the wrong state.

Guenter

> [  693.474855]  ? _cond_resched+0x10/0x20
> [  693.477807]  tcpm_state_machine_work+0x57e/0x28f6 [tcpm]
> [  693.480776]  ? tcpm_pd_event_handler+0x111/0x320 [tcpm]
> [  693.483743]  process_one_work+0x1da/0x410
> [  693.486703]  worker_thread+0x28/0x3c0
> [  693.489651]  ? process_one_work+0x410/0x410
> [  693.492603]  kthread+0x10b/0x130
> [  693.495548]  ? kthread_create_on_node+0x60/0x60
> [  693.498506]  ret_from_fork+0x1f/0x30
> 
> 
> Here's the tcpm debugfs log:
> 
> [  692.553000] CC1: 0 -> 2, CC2: 0 -> 1 [state DRP_TOGGLING, polarity 0, connected]
> [  692.553016] state change DRP_TOGGLING -> SRC_ATTACH_WAIT
> [  692.553056] pending state change SRC_ATTACH_WAIT -> SNK_TRY @ 200 ms
> [  692.757402] state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
> [  692.757410] cc:=2
> [  692.761946] pending state change SNK_TRY -> SNK_TRY_WAIT @ 100 ms
> [  692.869308] state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
> [  692.869313] state change SNK_TRY_WAIT -> SRC_TRYWAIT
> [  692.869317] cc:=3
> [  692.873657] pending state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED @ 100 ms
> [  692.882524] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_TRYWAIT, polarity 0, connected]
> [  692.882537] state change SRC_TRYWAIT -> SRC_TRYWAIT_DEBOUNCE
> [  692.882567] pending state change SRC_TRYWAIT_DEBOUNCE -> SRC_ATTACHED @ 200 ms
> [  693.085337] state change SRC_TRYWAIT_DEBOUNCE -> SRC_ATTACHED [delayed 200 ms]
> [  693.085347] polarity 0
> [  693.085352] Requesting mux state 1, usb-role 1, orientation 1
> [  693.346845] vconn:=1
> [  693.347174] vbus:=1 charge=0
> [  693.358340] pending state change SRC_ATTACHED -> SRC_UNATTACHED @ 480 ms
> [  693.378702] VBUS on
> [  693.378711] state change SRC_ATTACHED -> SRC_STARTUP
> [  693.378741] AMS POWER_NEGOTIATION start
> [  693.378745] cc:=4
> [  693.505321] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
> [  693.505325] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS POWER_NEGOTIATION
> [  693.505327] PD TX, header: 0x11a1
> [  693.613296] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms in AMS POWER_NEGOTIATION
> [  693.613309] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_SEND_CAPABILITIES, polarity 0, connected]
> [  693.765730] state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES [delayed 150 ms]
> [  693.765753] PD TX, header: 0x11a1
> [  693.770016] PD TX complete, status: 0
> [  693.770261] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES_TIMEOUT @ 150 ms in AMS POWER_NEGOTIATION
> [  693.775178] PD RX, header: 0x1042 [1]
> [  693.775195] state change SRC_SEND_CAPABILITIES -> SRC_NEGOTIATE_CAPABILITIES
> [  693.775236] Requested 5000 mV, 400 mA for 400 / 900 mA
> [  693.775244] PD TX, header: 0x363
> [  693.778253] PD TX complete, status: 0
> [  693.778363] pending state change SRC_NEGOTIATE_CAPABILITIES -> SRC_TRANSITION_SUPPLY @ 35 ms
> [  693.803463] Received hard reset
> [  693.803473] state change SRC_NEGOTIATE_CAPABILITIES -> HARD_RESET_START
> [  693.806323] pending state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF @ 30 ms
> [  693.837400] state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF [delayed 30 ms]
> [  693.837414] vconn:=1
> [  693.837426] vbus:=0 charge=0
> [  693.843380] Requesting mux state 1, usb-role 1, orientation 1
> [  693.844554] pending state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON @ 760 ms
> [  693.844575] VBUS off
> [  693.844580] state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON
> [  693.844617] vbus:=1 charge=0
> [  693.850688] pending state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED @ 480 ms
> [  693.868706] VBUS on
> [  693.868713] state change SRC_HARD_RESET_VBUS_ON -> SRC_STARTUP
> [  693.868742] AMS POWER_NEGOTIATION start
> [  693.868749] cc:=4
> [  694.101422] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
> [  694.101425] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS POWER_NEGOTIATION
> [  694.101428] PD TX, header: 0x11a1
> [  694.205301] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms in AMS POWER_NEGOTIATION
> [  694.205317] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_SEND_CAPABILITIES, polarity 0, connected]
> [  694.325808] Received hard reset
> [  694.325816] state change SRC_SEND_CAPABILITIES -> HARD_RESET_START in AMS NONE_AMS
> [  694.329208] pending state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF @ 30 ms in AMS NONE_AMS
> [  694.359394] state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF [delayed 30 ms]
> [  694.359401] vconn:=1
> [  694.359408] vbus:=0 charge=0
> [  694.366321] Requesting mux state 1, usb-role 1, orientation 1
> [  694.367685] pending state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON @ 760 ms in AMS NONE_AMS
> [  694.367700] VBUS off
> [  694.367704] state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON in AMS NONE_AMS
> [  694.367721] vbus:=1 charge=0
> [  694.374175] pending state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED @ 480 ms in AMS NONE_AMS
> [  694.374194] CC1: 2 -> 0, CC2: 1 -> 0 [state SRC_HARD_RESET_VBUS_ON, polarity 0, disconnected]
> [  694.374201] state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED in AMS NONE_AMS
> [  694.631957] Start DRP toggling
> 
> 
> thanks,
> 

