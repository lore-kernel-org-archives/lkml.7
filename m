Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F5AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461E621473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFSbdAbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDHORt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:17:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44304 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:17:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id w5so15528329qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDAf/scod4/Mi0YuNqzWgz/m9OXrNuBCv4S2jQaFAjU=;
        b=tFSbdAbeLdtNmcK3KPaHQpicEi8s+aBKvfzLGHyTTN1w1R0xfLpht/SdvSuqN8Cc/N
         ReSlNW0ZA+E+bSrSE5JT5WaRFEKO59ptLB7SQQvAkzO+Kr4Tvi3DNeGv6pd+O5N9Qgfi
         aS9NESBwdt2oq7zxwKNivnaiNv44xhHd2jdyRzH+gzf0AJzC6ToQRXdNuCnN64ZLXLpw
         bQg+t+JuJbJQBncrXXGWS3FKdEijdgF/jJtsorW8EJ/9glN/9JUzjpVAad4RFDN0GRGw
         y1iwIVi3+0xqNVUpH9I0g9yRUOoT89Qf6sMhMAr/IIQ4tT3oNTDYt8o2re0JdFTWIGaj
         Z0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDAf/scod4/Mi0YuNqzWgz/m9OXrNuBCv4S2jQaFAjU=;
        b=i7F3W4OlAg2iTrxgTPgix/S0Gtgc4dJi9PKe6Vh9dfLJsc5d6EuChBGWg5y/OTz+cj
         yPx8ZyE4XlpKYYbD9axuqmkG6eSQmKf32YeccPQ65/TB5SpnsMrCOwGDRTKNhG8IO2iZ
         LZiMZCsDMkpINWocpJOpG32xC3W5xqxe12hWFChje3flVJ/uSIAVPFHom+TFiGp3lqRZ
         vRUxxAW3CKo6rwjmi6jk3mfCsqVgJlL2HMH4fzJHIhIJLgg/pWiu5JCOwr26MkiJtKic
         DMXU27j06rxlgnXLAOvnBgx4B71iwL7Ix+wAu3OOcMjWbxcneSB9pKIt/BeFPUdFmPpG
         2jFQ==
X-Gm-Message-State: APjAAAXYE5+4/XS9EZwt0WdEHo/Xqa7H2zE0lDeifQRaq0gaQGyiTeTR
        Jw6U38GVQHctc2QPGv32JqQHgexxD9YEimMAM0XGrV96kWpXrg==
X-Google-Smtp-Source: APXvYqyzQ4+yBfJ9OUG/hrR66LMezPw88j8Gu36YQS27pS3gjwGIoTPwpuC85SZWvzOS9BmhHm+aw6+GEfHapErTywU=
X-Received: by 2002:a0c:add2:: with SMTP id x18mr24143334qvc.23.1554733066956;
 Mon, 08 Apr 2019 07:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190322121745.159768-1-kyletso@google.com> <20190404141345.GF21319@kuha.fi.intel.com>
 <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net>
In-Reply-To: <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Mon, 8 Apr 2019 22:17:35 +0800
Message-ID: <CAGZ6i=2zKLhS4By8Xanc863G+jSxPYg8SLU-UHkY94r5MiEYag@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: collision avoidance
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 9:42 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/4/19 7:13 AM, Heikki Krogerus wrote:
> > Hi,
> >
> > On Fri, Mar 22, 2019 at 08:17:45PM +0800, Kyle Tso wrote:
> >> This patch provides the implementation of Collision Avoidance introduced
> >> in PD3.0. The start of each Atomic Message Sequence (AMS) initiated by
> >> the port will be denied if the current AMS is not interruptible. The
> >> Source port will set the CC to SinkTxNG if it is going to initiate an
> >> AMS, and SinkTxOk otherwise. Meanwhile, any AMS initiated by a Sink port
> >> will be denied in TCPM if the port partner (Source) sets SinkTxNG except
> >> for HARD_RESET and SOFT_RESET.
> >
> > I tested this with my GDBWin which has fusb302. When I plug-in
> > DisplayPort adapter, the partner device never gets registered, and I
> > see steady flow of warnings from fusb302:
> >
>
> FWIW, I made multiple attempts to review the patch. Each time I get stuck
> after a while and notice that I don't understand what is going on.
>
> Maybe the state machine needs a complete overhaul. It seems to have reached
> a point where it is getting too complex to understand what is going on.
>
> > [  693.391176] Vconn is on during toggle start
> > [  693.391250] WARNING: CPU: 2 PID: 30 at drivers/usb/typec/tcpm/fusb302.c:562 fusb302_set_toggling+0x129/0x130 [fusb302]
> > [  693.400293] Modules linked in: intel_xhci_usb_role_switch fusb302 tcpm roles pi3usb30532 i915 typec intel_gtt intel_cht_int33fe
> > [  693.406309] CPU: 2 PID: 30 Comm: kworker/u8:1 Tainted: G        W         5.1.0-rc3-heikki+ #17
> > [  693.408434] cht_wcove_pwrsrc cht_wcove_pwrsrc: Could not detect charger type
> > [  693.412278] Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
> > [  693.412283] Workqueue: i2c-fusb302 tcpm_state_machine_work [tcpm]
> > [  693.424256] RIP: 0010:fusb302_set_toggling+0x129/0x130 [fusb302]
> > [  693.427234] Code: 89 df e8 da ef ff ff 85 c0 78 c6 c6 83 b0 01 00 00 00 eb b7 b9 02 00 00 00 e9 48 ff ff ff 48 c7 c7 20 e8 21 a0 e8 8e 0c e4 e0 <0f> 0b e9 58 ff ff ff 41 55 4c 8d 6f e8 41 54 41 89 f4 55 53 48 8d
> > [  693.436204] RSP: 0000:ffffc9000076bd90 EFLAGS: 00010286
> > [  693.439174] RAX: 0000000000000000 RBX: ffff888178080028 RCX: 0000000000000000
> > [  693.442157] RDX: 000000000000001f RSI: ffffffff8259051f RDI: ffffffff8259091f
> > [  693.445130] RBP: 0000000000000003 R08: ffffffff82590500 R09: 00000000000202c0
> > [  693.448100] R10: 0000010cb24a3d18 R11: 000000000000001e R12: ffff8881780801b0
> > [  693.451086] R13: ffffffffa021e4e5 R14: 0000000000000003 R15: ffff888178080040
> > [  693.454060] FS:  0000000000000000(0000) GS:ffff88817bb00000(0000) knlGS:0000000000000000
> > [  693.460009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  693.462984] CR2: 00000000f7fb74a0 CR3: 000000000200d000 CR4: 00000000001006e0
> > [  693.465969] Call Trace:
> > [  693.468937]  tcpm_set_cc+0xb9/0x170 [fusb302]
> > [  693.471894]  tcpm_ams_start+0x1b8/0x2a0 [tcpm]
>
> tcpm_ams_start() sets TYPEC_CC_RP_1_5 unconditionally, no matter what. This causes
> the fusb302 code to start toggling. As such, it may well attempt to start toggling
> in the wrong state.
>
> Guenter
>

I read the fusb302 spec but failed to find the statement that says it
should "set toggling" when CC switches among default/medium/high.

quot from fusb302 spec:
"The FUSB302 allows the host software to change the charging current
capabilities of the port through the HOST_CUR control bits. If the
HOST_CUR bits are changed prior to attach, the FUSB302 automatically
indicates the programmed current capability when a device is attached.
If the current capabilities are changed after a device is attached,
the FUSB302 immediately changes the CC line to the programmed
capability."

Is it possible to skip fusb302_set_toggling() @ line#658 if
tcpm_set_cc() is called in order to switch the cc among
default/medium/high of Rp ?

the tcpm log on another PD controller:
[ 1215.709538] CC1: 0 -> 2, CC2: 0 -> 1 [state DRP_TOGGLING, polarity
0, connected]
[ 1215.709551] state change DRP_TOGGLING -> SRC_ATTACH_WAIT
[ 1215.709576] pending state change SRC_ATTACH_WAIT -> SRC_ATTACHED @
200 ms
[ 1215.907465] state change SRC_ATTACH_WAIT -> SRC_ATTACHED [delayed
200 ms]
[ 1215.907670] polarity 0
[ 1215.908070] Requesting mux state 1, usb-role 1, orientation 1
[ 1215.909342] vconn:=1
[ 1215.909549] vbus:=1 charge=0
[ 1215.909633] Setting pd capable false
[ 1215.909637] pending state change SRC_ATTACHED -> SRC_UNATTACHED @
480 ms
[ 1215.909685] VBUS on
[ 1215.909687] state change SRC_ATTACHED -> SRC_STARTUP
[ 1215.914263] AMS POWER_NEGOTIATION start
[ 1215.914267] cc:=4
[ 1215.914288] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
[ 1215.914294] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS
POWER_NEGOTIATION
[ 1215.914298] PD TX, header: 0x11a1
[ 1215.919552] PD TX complete, status: 2
[ 1215.919577] pending state change SRC_SEND_CAPABILITIES ->
SRC_SEND_CAPABILITIES @ 150 ms in AMS POWER_NEGOTIATION
[ 1216.071041] state change SRC_SEND_CAPABILITIES ->
SRC_SEND_CAPABILITIES [delayed 150 ms]
[ 1216.071049] PD TX, header: 0x11a1
[ 1216.072508] PD TX complete, status: 0
[ 1216.072535] Setting pd capable true
[ 1216.072645] pending state change SRC_SEND_CAPABILITIES ->
HARD_RESET_SEND @ 150 ms in AMS POWER_NEGOTIATION
[ 1216.073915] PD RX, header: 0x1042 [1]
[ 1216.073920] state change SRC_SEND_CAPABILITIES -> SRC_NEGOTIATE_CAPABILITIES
[ 1216.073941] Requested 5000 mV, 900 mA for 900 / 900 mA
[ 1216.073944] PD TX, header: 0x363
[ 1216.075281] PD TX complete, status: 0
[ 1216.075337] pending state change SRC_NEGOTIATE_CAPABILITIES ->
SRC_TRANSITION_SUPPLY @ 35 ms
[ 1216.113742] state change SRC_NEGOTIATE_CAPABILITIES ->
SRC_TRANSITION_SUPPLY [delayed 35 ms]
[ 1216.113752] PD TX, header: 0x566
[ 1216.116743] PD TX complete, status: 0
[ 1216.117175] state change SRC_TRANSITION_SUPPLY -> SRC_READY
[ 1216.118737] PD TX, header: 0x176f
[ 1216.120285] PD TX complete, status: 0
[ 1216.122455] PD RX, header: 0x524f [1]
[ 1216.122463] Rx VDM cmd 0xff008041 type 1 cmd 1 len 5
[ 1216.122511] Identity: 04b4:1120.0000
[ 1216.122531] PD TX, header: 0x196f
[ 1216.123965] PD TX complete, status: 0
[ 1216.125573] PD RX, header: 0x244f [1]
[ 1216.125578] Rx VDM cmd 0xff008042 type 1 cmd 2 len 2
[ 1216.125581] SVID 1: 0xff01
[ 1216.125603] PD TX, header: 0x1b6f
[ 1216.127074] PD TX complete, status: 0
[ 1216.128750] PD RX, header: 0x264f [1]
[ 1216.128754] Rx VDM cmd 0xff018043 type 1 cmd 3 len 2
[ 1216.128758]  Alternate mode 0: SVID 0xff01, VDO 1: 0x00000405

> > [  693.474855]  ? _cond_resched+0x10/0x20
> > [  693.477807]  tcpm_state_machine_work+0x57e/0x28f6 [tcpm]
> > [  693.480776]  ? tcpm_pd_event_handler+0x111/0x320 [tcpm]
> > [  693.483743]  process_one_work+0x1da/0x410
> > [  693.486703]  worker_thread+0x28/0x3c0
> > [  693.489651]  ? process_one_work+0x410/0x410
> > [  693.492603]  kthread+0x10b/0x130
> > [  693.495548]  ? kthread_create_on_node+0x60/0x60
> > [  693.498506]  ret_from_fork+0x1f/0x30
> >
> >
> > Here's the tcpm debugfs log:
> >
> > [  692.553000] CC1: 0 -> 2, CC2: 0 -> 1 [state DRP_TOGGLING, polarity 0, connected]
> > [  692.553016] state change DRP_TOGGLING -> SRC_ATTACH_WAIT
> > [  692.553056] pending state change SRC_ATTACH_WAIT -> SNK_TRY @ 200 ms
> > [  692.757402] state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
> > [  692.757410] cc:=2
> > [  692.761946] pending state change SNK_TRY -> SNK_TRY_WAIT @ 100 ms
> > [  692.869308] state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
> > [  692.869313] state change SNK_TRY_WAIT -> SRC_TRYWAIT
> > [  692.869317] cc:=3
> > [  692.873657] pending state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED @ 100 ms
> > [  692.882524] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_TRYWAIT, polarity 0, connected]
> > [  692.882537] state change SRC_TRYWAIT -> SRC_TRYWAIT_DEBOUNCE
> > [  692.882567] pending state change SRC_TRYWAIT_DEBOUNCE -> SRC_ATTACHED @ 200 ms
> > [  693.085337] state change SRC_TRYWAIT_DEBOUNCE -> SRC_ATTACHED [delayed 200 ms]
> > [  693.085347] polarity 0
> > [  693.085352] Requesting mux state 1, usb-role 1, orientation 1
> > [  693.346845] vconn:=1
> > [  693.347174] vbus:=1 charge=0
> > [  693.358340] pending state change SRC_ATTACHED -> SRC_UNATTACHED @ 480 ms
> > [  693.378702] VBUS on
> > [  693.378711] state change SRC_ATTACHED -> SRC_STARTUP
> > [  693.378741] AMS POWER_NEGOTIATION start
> > [  693.378745] cc:=4
> > [  693.505321] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
> > [  693.505325] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS POWER_NEGOTIATION
> > [  693.505327] PD TX, header: 0x11a1
> > [  693.613296] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms in AMS POWER_NEGOTIATION
> > [  693.613309] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_SEND_CAPABILITIES, polarity 0, connected]
> > [  693.765730] state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES [delayed 150 ms]
> > [  693.765753] PD TX, header: 0x11a1
> > [  693.770016] PD TX complete, status: 0
> > [  693.770261] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES_TIMEOUT @ 150 ms in AMS POWER_NEGOTIATION
> > [  693.775178] PD RX, header: 0x1042 [1]
> > [  693.775195] state change SRC_SEND_CAPABILITIES -> SRC_NEGOTIATE_CAPABILITIES
> > [  693.775236] Requested 5000 mV, 400 mA for 400 / 900 mA
> > [  693.775244] PD TX, header: 0x363
> > [  693.778253] PD TX complete, status: 0
> > [  693.778363] pending state change SRC_NEGOTIATE_CAPABILITIES -> SRC_TRANSITION_SUPPLY @ 35 ms
> > [  693.803463] Received hard reset
> > [  693.803473] state change SRC_NEGOTIATE_CAPABILITIES -> HARD_RESET_START
> > [  693.806323] pending state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF @ 30 ms
> > [  693.837400] state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF [delayed 30 ms]
> > [  693.837414] vconn:=1
> > [  693.837426] vbus:=0 charge=0
> > [  693.843380] Requesting mux state 1, usb-role 1, orientation 1
> > [  693.844554] pending state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON @ 760 ms
> > [  693.844575] VBUS off
> > [  693.844580] state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON
> > [  693.844617] vbus:=1 charge=0
> > [  693.850688] pending state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED @ 480 ms
> > [  693.868706] VBUS on
> > [  693.868713] state change SRC_HARD_RESET_VBUS_ON -> SRC_STARTUP
> > [  693.868742] AMS POWER_NEGOTIATION start
> > [  693.868749] cc:=4
> > [  694.101422] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
> > [  694.101425] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS POWER_NEGOTIATION
> > [  694.101428] PD TX, header: 0x11a1
> > [  694.205301] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms in AMS POWER_NEGOTIATION
> > [  694.205317] CC1: 2 -> 2, CC2: 1 -> 1 [state SRC_SEND_CAPABILITIES, polarity 0, connected]
> > [  694.325808] Received hard reset
> > [  694.325816] state change SRC_SEND_CAPABILITIES -> HARD_RESET_START in AMS NONE_AMS
> > [  694.329208] pending state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF @ 30 ms in AMS NONE_AMS
> > [  694.359394] state change HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF [delayed 30 ms]
> > [  694.359401] vconn:=1
> > [  694.359408] vbus:=0 charge=0
> > [  694.366321] Requesting mux state 1, usb-role 1, orientation 1
> > [  694.367685] pending state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON @ 760 ms in AMS NONE_AMS
> > [  694.367700] VBUS off
> > [  694.367704] state change SRC_HARD_RESET_VBUS_OFF -> SRC_HARD_RESET_VBUS_ON in AMS NONE_AMS
> > [  694.367721] vbus:=1 charge=0
> > [  694.374175] pending state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED @ 480 ms in AMS NONE_AMS
> > [  694.374194] CC1: 2 -> 0, CC2: 1 -> 0 [state SRC_HARD_RESET_VBUS_ON, polarity 0, disconnected]
> > [  694.374201] state change SRC_HARD_RESET_VBUS_ON -> SRC_UNATTACHED in AMS NONE_AMS
> > [  694.631957] Start DRP toggling
> >
> >
> > thanks,
> >
>
