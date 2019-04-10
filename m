Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7BAC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E83217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2RD4e8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfDJMtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:49:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36926 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfDJMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:49:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so2636914qtn.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHPgCmaymQyZfNVG1HLTvKccH87arPhdYsIiLTP4S9Q=;
        b=c2RD4e8/wP4b7qALSUXCSg/9z1qXom9QmcsJviEBG4mqHj7JnR8MRnZQUQ3T4wXoEx
         ddlM+0Gh6YPN3AUOsIeR7H9gE05QPRrkCaeq/gUGDQfcLIATMRROY6gTWScIWd6v+YMj
         Ws/B3josYa2eHRyaq6QPMmaPIZvkLQ4erUqT7jY+jf8+55Bi/WYhr7T1rHnSzMYrMIQX
         1SgkhfqfAqG5BcGMpii82/xBvscDqRazRVHIUHuJY98ePY4aAPTosmiQ6kQcU5g7Qc4K
         aM1Jg7emYYHBR1jL3AckLPOk1KVJYy/99AINM2xd+cJz/q56GiNS2rsTjC9a/NuYd9/g
         MKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHPgCmaymQyZfNVG1HLTvKccH87arPhdYsIiLTP4S9Q=;
        b=PN+0CaPj33LigSVt5o7Qg05HIIHReMdIl8gn89oWRLO7Sy/h9ELNU1mDDtWOVTpunw
         urn+6rPTKNtpjaDaPAQ5d1N+JLJxmQj0ECSWUndHcSMDk5CvlmH/Ea+3W6hor9MtUpSi
         vKiFf7o3pQjPeh2YwpuzlMpDmNJX4drxHcwnDOYgXpKAk6XgHX68eBFFZHokhabv6use
         Xcxtvtjam9tFhdiOgBQDUxwaTGsV2+KVk0xewrPSoCCwsFezsf/jSH3XWr6MUp95cby6
         8QCghi4m67srRojSp5V6hnHORGgXpYJVOdWHbN4RcBhhF503fGfUb0Lu/sRfg8+/nZT0
         34LA==
X-Gm-Message-State: APjAAAWyOpgf/BFbSV2DBdEp84r2b7WTPcLGkDYnpm57369tT81QSqAt
        S+HxYXC+Lh9jI69ZDfkD5gEXfnaAfaqOHXb6dWq2iA==
X-Google-Smtp-Source: APXvYqyKE/VTpCCP0LoJ49Ca2P67Xg/z2eGzzex4E/oimMlShLLKZPHrsLoC9RVU9tB3sOEldzdZhdIB6Gd0quUbjrE=
X-Received: by 2002:ac8:13c3:: with SMTP id i3mr36417317qtj.211.1554900554330;
 Wed, 10 Apr 2019 05:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190322121745.159768-1-kyletso@google.com> <20190404141345.GF21319@kuha.fi.intel.com>
 <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net> <CAGZ6i=2zKLhS4By8Xanc863G+jSxPYg8SLU-UHkY94r5MiEYag@mail.gmail.com>
 <20190409130230.GC20058@kuha.fi.intel.com> <20190409130649.GD20058@kuha.fi.intel.com>
 <9c9d17e3-bd99-c877-359c-a0a1b10a8d73@redhat.com> <AM5PR1001MB099440C3AA6DA6BA2AB0F2AE802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB099440C3AA6DA6BA2AB0F2AE802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 10 Apr 2019 20:49:02 +0800
Message-ID: <CAGZ6i=0rRgNH5bU-zcP58MNi+VSa+xeAQWL67egaZ-ui-ebmYA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: collision avoidance
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 6:32 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 09 April 2019 15:41, Hans de Goede wrote:
>
> > Hi,
> >
> > On 09-04-19 15:06, Heikki Krogerus wrote:
> > > On Tue, Apr 09, 2019 at 04:02:30PM +0300, Heikki Krogerus wrote:
> > >> +Hans
> > >>
> > >> On Mon, Apr 08, 2019 at 10:17:35PM +0800, Kyle Tso wrote:
> > >>> On Fri, Apr 5, 2019 at 9:42 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >>>>
> > >>>> On 4/4/19 7:13 AM, Heikki Krogerus wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> On Fri, Mar 22, 2019 at 08:17:45PM +0800, Kyle Tso wrote:
> > >>>>>> This patch provides the implementation of Collision Avoidance
> > >>>>>> introduced in PD3.0. The start of each Atomic Message Sequence
> > >>>>>> (AMS) initiated by the port will be denied if the current AMS is
> > >>>>>> not interruptible. The Source port will set the CC to SinkTxNG if
> > >>>>>> it is going to initiate an AMS, and SinkTxOk otherwise.
> > >>>>>> Meanwhile, any AMS initiated by a Sink port will be denied in
> > >>>>>> TCPM if the port partner (Source) sets SinkTxNG except for HARD_RESET
> > and SOFT_RESET.
> > >>>>>
> > >>>>> I tested this with my GDBWin which has fusb302. When I plug-in
> > >>>>> DisplayPort adapter, the partner device never gets registered, and
> > >>>>> I see steady flow of warnings from fusb302:
> > >>>>>
> > >>>>
> > >>>> FWIW, I made multiple attempts to review the patch. Each time I get
> > >>>> stuck after a while and notice that I don't understand what is going on.
> > >>>>
> > >>>> Maybe the state machine needs a complete overhaul. It seems to have
> > >>>> reached a point where it is getting too complex to understand what is going
> > on.
> > >>>>
> > >>>>> [  693.391176] Vconn is on during toggle start [  693.391250]
> > >>>>> WARNING: CPU: 2 PID: 30 at drivers/usb/typec/tcpm/fusb302.c:562
> > >>>>> fusb302_set_toggling+0x129/0x130 [fusb302] [  693.400293] Modules
> > linked in: intel_xhci_usb_role_switch fusb302 tcpm roles pi3usb30532 i915 typec
> > intel_gtt intel_cht_int33fe
> > >>>>> [  693.406309] CPU: 2 PID: 30 Comm: kworker/u8:1 Tainted: G        W
> > 5.1.0-rc3-heikki+ #17
> > >>>>> [  693.408434] cht_wcove_pwrsrc cht_wcove_pwrsrc: Could not detect
> > >>>>> charger type [  693.412278] Hardware name: Default string Default
> > >>>>> string/Default string, BIOS 5.11 05/25/2017 [  693.412283]
> > >>>>> Workqueue: i2c-fusb302 tcpm_state_machine_work [tcpm] [
> > >>>>> 693.424256] RIP: 0010:fusb302_set_toggling+0x129/0x130 [fusb302] [
> > >>>>> 693.427234] Code: 89 df e8 da ef ff ff 85 c0 78 c6 c6 83 b0 01 00
> > >>>>> 00 00 eb b7 b9 02 00 00 00 e9 48 ff ff ff 48 c7 c7 20 e8 21 a0 e8
> > >>>>> 8e 0c e4 e0 <0f> 0b e9 58 ff ff ff 41 55 4c 8d 6f e8 41 54 41 89
> > >>>>> f4 55 53 48 8d [  693.436204] RSP: 0000:ffffc9000076bd90 EFLAGS:
> > >>>>> 00010286 [  693.439174] RAX: 0000000000000000 RBX:
> > >>>>> ffff888178080028 RCX: 0000000000000000 [  693.442157] RDX:
> > >>>>> 000000000000001f RSI: ffffffff8259051f RDI: ffffffff8259091f [
> > >>>>> 693.445130] RBP: 0000000000000003 R08: ffffffff82590500 R09:
> > >>>>> 00000000000202c0 [  693.448100] R10: 0000010cb24a3d18 R11:
> > >>>>> 000000000000001e R12: ffff8881780801b0 [  693.451086] R13:
> > ffffffffa021e4e5 R14: 0000000000000003 R15: ffff888178080040 [  693.454060] FS:
> > 0000000000000000(0000) GS:ffff88817bb00000(0000) knlGS:0000000000000000 [
> > 693.460009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  693.462984] CR2:
> > 00000000f7fb74a0 CR3: 000000000200d000 CR4: 00000000001006e0 [  693.465969]
> > Call Trace:
> > >>>>> [  693.468937]  tcpm_set_cc+0xb9/0x170 [fusb302] [  693.471894]
> > >>>>> tcpm_ams_start+0x1b8/0x2a0 [tcpm]
> > >>>>
> > >>>> tcpm_ams_start() sets TYPEC_CC_RP_1_5 unconditionally, no matter
> > >>>> what. This causes the fusb302 code to start toggling. As such, it
> > >>>> may well attempt to start toggling in the wrong state.
> > >>>>
> > >>>> Guenter
> > >>>>
> > >>>
> > >>> I read the fusb302 spec but failed to find the statement that says
> > >>> it should "set toggling" when CC switches among default/medium/high.
> > >>>
> > >>> quot from fusb302 spec:
> > >>> "The FUSB302 allows the host software to change the charging current
> > >>> capabilities of the port through the HOST_CUR control bits. If the
> > >>> HOST_CUR bits are changed prior to attach, the FUSB302 automatically
> > >>> indicates the programmed current capability when a device is attached.
> > >>> If the current capabilities are changed after a device is attached,
> > >>> the FUSB302 immediately changes the CC line to the programmed
> > >>> capability."
> > >>>
> > >>> Is it possible to skip fusb302_set_toggling() @ line#658 if
> > >>> tcpm_set_cc() is called in order to switch the cc among
> > >>> default/medium/high of Rp ?
> > >
> > > Hans, you introduced that in commit daf81d0137a9c ("usb: typec:
> > > fusb302: Refactor / simplify tcpm_set_cc()"), so could you take a look
> > > at this.
> >
> > I do not believe that that commit introduces the fusb302_set_toggling() as the
> > subject of the commit says it just refactors things, the set_toggling call was
> > introduced by:
> >
> > commit ea3b4d5523bc8("usb: typec: fusb302: Resolve fixed power role contract
> > setup")
> >
> > Before that:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/u
> > sb/typec/tcpm/fusb302.c?id=40326e857c57a0095d3f9d72c14cb13aef4ca564
> >
> > tcpm_set_cc actually turned toggling off in all cases.
> >
> > I've no doubt that Adam was seeing a real problem, but I've doubted if this was
> > the right fix before. I even had it reverted in my tree for a while, but since in my
> > use-cases so far it has not caused any problems I've not looked into it further.
>
> From my recollection, that was the only way to generate the necessary event from
> fusb302 to indicate a connection, when the device was in a fixed role state
> (i.e. only source or only sink). Without it the driver doesn't work in these
> scenarios as there's no TOGDONE event generated by fusb302, so no eventual call
> to 'tcpm_cc_change()' to tell TCPM that something has happened and move on the
> state machine. Not all devices will be DRP so we have to account for this.
>

The switch among different Rp values on CC pins comes from TCPM and
after the switch finishes, TCPM doesn't need to update the CC status because
this kind of switch won't affect the state machine.

> >
> > In the mean time the code has changed quite a bit though, so making
> > tcpm_set_cc() behave as it did before, see:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/u
> > sb/typec/tcpm/fusb302.c?id=40326e857c57a0095d3f9d72c14cb13aef4ca564
> >
> > Will require writing something from scratch based on the new code which
> > mimicks the behaviour of the old code; and then we also need to fix Adam's
> > problem on top.
> >
> > Regards,
> >
> > Hans

I tried to fix this with below changes and it works.

============================================
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -110,6 +110,9 @@ struct fusb302_chip {
        enum typec_cc_status cc2;
        u32 snk_pdo[PDO_MAX_OBJECTS];

+       /* Local pin status */
+       enum typec_cc_status cc;
+
 #ifdef CONFIG_DEBUG_FS
        struct dentry *dentry;
        /* lock for log buffer access */
@@ -611,6 +614,19 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum
typec_cc_status cc)
        enum toggling_mode mode;

        mutex_lock(&chip->lock);
+       if ((chip->cc == TYPEC_CC_RP_DEF || chip->cc == TYPEC_CC_RP_1_5 ||
+            chip->cc == TYPEC_CC_RP_3_0) && (cc == TYPEC_CC_RP_DEF ||
+            cc == TYPEC_CC_RP_1_5 || cc == TYPEC_CC_RP_3_0)) {
+               ret = fusb302_set_src_current(chip, cc_src_current[cc]);
+               if (ret < 0) {
+                       fusb302_log(chip, "cannot set src current %s, ret=%d\n",
+                                   typec_cc_status_name[cc], ret);
+                       goto done;
+               }
+               fusb302_log(chip, "cc := %s", typec_cc_status_name[cc]);
+               goto rp_switch;
+       }
+
        switch (cc) {
        case TYPEC_CC_OPEN:
                mode = TOGGLING_MODE_OFF;
@@ -659,6 +675,8 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum
typec_cc_status cc)
        if (ret < 0)
                fusb302_log(chip, "cannot set toggling mode, ret=%d", ret);

+rp_switch:
+       chip->cc = cc;
 done:
        mutex_unlock(&chip->lock);
============================================

TCPM logs:

[   52.267343] CC1: 0 -> 1, CC2: 0 -> 2 [state DRP_TOGGLING, polarity
0, connected]
[   52.267354] state change DRP_TOGGLING -> SRC_ATTACH_WAIT
[   52.267435] pending state change SRC_ATTACH_WAIT -> SNK_TRY @ 200 ms
[   52.466852] state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
[   52.466876] cc:=2
[   52.471851] pending state change SNK_TRY -> SNK_TRY_WAIT @ 140 ms
[   52.610244] state change SNK_TRY -> SNK_TRY_WAIT [delayed 140 ms]
[   52.610256] state change SNK_TRY_WAIT -> SRC_TRYWAIT
[   52.610298] cc:=3
[   52.613262] pending state change SRC_TRYWAIT ->
SRC_TRYWAIT_UNATTACHED @ 140 ms
[   52.625248] CC1: 1 -> 1, CC2: 2 -> 2 [state SRC_TRYWAIT, polarity
0, connected]
[   52.625261] state change SRC_TRYWAIT -> SRC_TRYWAIT_DEBOUNCE
[   52.625299] pending state change SRC_TRYWAIT_DEBOUNCE ->
SRC_ATTACHED @ 200 ms
[   52.823417] state change SRC_TRYWAIT_DEBOUNCE -> SRC_ATTACHED
[delayed 200 ms]
[   52.823425] polarity 1
[   52.823458] Requesting mux state 1, usb-role 1, orientation 2
[   52.846919] vconn:=1
[   52.854536] vbus:=1 charge=0
[   52.893437] pending state change SRC_ATTACHED -> SRC_UNATTACHED @ 480 ms
[   52.894715] VBUS on
[   52.894718] state change SRC_ATTACHED -> SRC_STARTUP
[   52.894733] AMS POWER_NEGOTIATION start
[   52.894736] cc:=4
[   52.895043] state change SRC_STARTUP -> AMS_START in AMS POWER_NEGOTIATION
[   52.895046] state change AMS_START -> SRC_SEND_CAPABILITIES in AMS
POWER_NEGOTIATION
[   52.895048] PD TX, header: 0x11a1
[   52.910309] PD TX complete, status: 0
[   52.910346] pending state change SRC_SEND_CAPABILITIES ->
HARD_RESET_SEND @ 150 ms in AMS POWER_NEGOTIATION
[   52.912383] PD RX, header: 0x1042 [1]
[   52.912387] state change SRC_SEND_CAPABILITIES -> SRC_NEGOTIATE_CAPABILITIES
[   52.912398] Requested 5000 mV, 900 mA for 900 / 900 mA
[   52.912400] PD TX, header: 0x363
[   52.915725] PD TX complete, status: 0
[   52.915765] pending state change SRC_NEGOTIATE_CAPABILITIES ->
SRC_TRANSITION_SUPPLY @ 35 ms
[   52.950125] state change SRC_NEGOTIATE_CAPABILITIES ->
SRC_TRANSITION_SUPPLY [delayed 35 ms]
[   52.950139] PD TX, header: 0x566
[   52.953910] PD TX complete, status: 0
[   52.955573] state change SRC_TRANSITION_SUPPLY -> SRC_READY
[   52.957359] PD TX, header: 0x176f
[   52.962785] PD TX complete, status: 0
[   52.966026] PD RX, header: 0x524f [1]
[   52.966037] Rx VDM cmd 0xff008041 type 1 cmd 1 len 5
[   52.966081] Identity: 04b4:1120.0000
[   52.966106] PD TX, header: 0x196f
[   52.969875] PD TX complete, status: 0
[   52.972298] PD RX, header: 0x244f [1]
[   52.972304] Rx VDM cmd 0xff008042 type 1 cmd 2 len 2
[   52.972308] SVID 1: 0xff01
[   52.972340] PD TX, header: 0x1b6f
[   52.976066] PD TX complete, status: 0
[   52.986511] PD RX, header: 0x264f [1]
[   52.986516] Rx VDM cmd 0xff018043 type 1 cmd 3 len 2
[   52.986520]  Alternate mode 0: SVID 0xff01, VDO 1: 0x00000405
