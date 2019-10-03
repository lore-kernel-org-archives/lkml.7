Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAF6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C892217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fluxL/8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfJCKi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:38:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727756AbfJCKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570099134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eLlUVpMUJ7UTXAxMirS61O/jA9c42jyV4whFedVPSg=;
        b=fluxL/8MlgrGPcEC3sxaA6dopM2PJbm5YuPlZ7cmnIIcHpcjWzFX5vS26AQXnqJkO9Hj0B
        uS1BAuVe4FP22q0tv/B8lpVYPN+qdvP+C0R9/PKqQD3Y0IqwxtFmDR3pWwGunEULxt+vIU
        nu5X+EnOrlcXU3qVquFV2laXdBqDn8s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-qhXTNWDUMa679Hab9ngwow-1; Thu, 03 Oct 2019 06:38:51 -0400
Received: by mail-ed1-f69.google.com with SMTP id k5so1343054edx.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=Zty8/Q0OySNT/ktkEAyyxRNQZ8QSAdHua1C4cgrimkA=;
        b=j9jrAJRjgJb+zr4pFjCiU4n5hu81XMkPatS/5CmhXPDN7SV9vW2/c6xQP3xlcPLSE6
         0QpmeNLUu4f0sicmmv1k0n2rJQXEJrMBZk2dLlaguuaHnToBXh2w2KuD5V/2kGafQ13s
         i871TXRUPztcpprX0suqtnujTJM1gjviDbYKWDt+92SEFo42m+cL9undsAiABFz/BRrA
         f9eA/qWiTAwDd1n+5L7Z07+ief9mO7mac239MtCkHTQmPpLHAqd+kli3ihaCDcqGVQ08
         q3tvQAqlMs5KPYZ5rm0lyWI4Z1abCU+Sq6f9uE4NkM2tZdMwvwYdGjAJaZ1PQp8w1xNK
         BESQ==
X-Gm-Message-State: APjAAAV+mP4lruRBZWzZNQGpODREkGL5TgDm1JSpxLCC4iaQoCgdANTn
        NqtKX/LQnxrl1bKB7Gq2R2yNTDX63SkIErZS9wL/t1+dEkf1KugOK5SQoQ4gHtnnfvkDo1J/3dk
        I7aGS2IuHOenvJVWMHB188sOe
X-Received: by 2002:aa7:c657:: with SMTP id z23mr8712922edr.234.1570099129491;
        Thu, 03 Oct 2019 03:38:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyfu4YPJ9llgjaSMRwL2/r9ndtt8lHtTAkweihmATBdReHUNup+Cc9FpWFsLNJuh/xhRO3ylQ==
X-Received: by 2002:aa7:c657:: with SMTP id z23mr8712910edr.234.1570099129200;
        Thu, 03 Oct 2019 03:38:49 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id k22sm204657eja.56.2019.10.03.03.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 03:38:48 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] tcpm: AMS and Collision Avoidance
To:     Kyle Tso <kyletso@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190920032437.242187-1-kyletso@google.com>
 <bd03390e-35fb-2885-d026-b8df58f02283@redhat.com>
 <CAGZ6i=1mid0Cq2EtWTJHwRzPxXZJnLtTWwYL2QS0vZHNR9mJqQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f7f50c17-976c-475e-4ea0-b8660331d4cd@redhat.com>
Date:   Thu, 3 Oct 2019 12:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAGZ6i=1mid0Cq2EtWTJHwRzPxXZJnLtTWwYL2QS0vZHNR9mJqQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: qhXTNWDUMa679Hab9ngwow-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/mixed;
 boundary="------------E32AFC9A40715FE6E08ECA16"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E32AFC9A40715FE6E08ECA16
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

On 03-10-2019 12:04, Kyle Tso wrote:
> Hi Hans
>=20
> Could you append the TCPM log?

I've attached both good and bad logs, both start with plugging in
one of these PD charging pass-through + USB-3 + HDMI out dongles.

at a quick glance the problem
seems to be that with the 2 AMS patches added we stop transmitting
after:

[  137.751964] Rx VDM cmd 0xff018144 type 1 cmd 4 len 1

Where as the good logs still transmits (and receives) a couple of
packets extra after this:

[ 4475.965108] Rx VDM cmd 0xff018144 type 1 cmd 4 len 1
[ 4475.965224] PD TX, header: 0x2f6f
[ 4475.968979] PD TX complete, status: 0
[ 4475.980811] PD RX, header: 0x2a4f [1]
[ 4475.980816] Rx VDM cmd 0xff018150 type 1 cmd 16 len 2
[ 4475.980929] PD TX, header: 0x216f
[ 4475.984093] PD TX complete, status: 0
[ 4475.996798] PD RX, header: 0x1c4f [1]
[ 4475.996803] Rx VDM cmd 0xff018151 type 1 cmd 17 len 1

Regards,

Hans


>=20
> On Thu, Oct 3, 2019 at 5:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Kyle,
>>
>> On 20-09-2019 05:24, Kyle Tso wrote:
>>> *** BLURB HERE ***
>>>
>>> Kyle Tso (2):
>>>     usb: typec: tcpm: AMS and Collision Avoidance
>>>     usb: typec: tcpm: AMS for PD2.0
>>
>> I've finally gotten a chance to test this on one of my own devices
>> which uses the tcpm framework for its Type-c port.
>>
>> I am afraid that this series breaks DP altmode support,
>> specifically, the dp_altmode_configure() function no longer
>> seems to get called, leading to no pin-assignment being
>> selected by default and DP thus not working.
>>
>> So sorry, but I have to NACK this series since it causes
>> regressions.
>>
>> It might be easiest if you can get yourself some hardware
>> which supports DP altmode and uses the fusb302 Type-C
>> controller (which unlike your controller is actually
>> supported by the mainline kernel).
>>
>> 2 devices which have this are the original (version 1)
>> of the GPD win and the GPD pocket. Since the version
>> is not always clearly marked, make sure you get one which
>> has a X7-Z8750 CPU, those are the version 1 models, you
>> can still get these e.g. here:
>>
>> https://www.geekbuying.com/item/GPD-Pocket-7-Inch-Tablet-PC-Intel-Atom-X=
7-Z8750-8GB-128GB-375711.html
>> https://www.geekbuying.com/item/GPD-Win-Intel-Z8750-Windows-10-4GB-64GB-=
Gamepad-Tablet-PC---Black-378018.html
>>
>> These 2 devices still need 2 minor patches to hookup the DP
>> support, I have just finished these 2 patches up and I'm
>> submitting them upstream today, I will Cc you on these.
>>
>> If you combine these with one of the many DP-charging pass-through
>> + USB-3 out + HDMI out dongles, e.g.:
>> https://www.aliexpress.com/item/32953320909.html
>>
>> And then after plugging in do:
>>
>> cat /sys/class/typec/port0-partner/port0-partner.0/displayport/pin_assig=
nment
>>
>> This should print:
>>
>> C [D]
>>
>> But when I add your patches into the mix it prints just:
>>
>> C D
>>
>> And these debug pr_err calls never happen:
>>
>> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/type=
c/altmodes/displayport.c
>> index 7845df030b72..d14f94078dd9 100644
>> --- a/drivers/usb/typec/altmodes/displayport.c
>> +++ b/drivers/usb/typec/altmodes/displayport.c
>> @@ -106,6 +106,7 @@ static int dp_altmode_configure(struct dp_altmode *d=
p, u8 con)
>>                  break;
>>          }
>>
>> +       pr_err("dp_altmode_configure pin_assign %08x conf %08x\n", pin_a=
ssign, DP_CONF_GET_PIN_ASSIGN(dp->data.conf));
>>          /* Determining the initial pin assignment. */
>>          if (!DP_CONF_GET_PIN_ASSIGN(dp->data.conf)) {
>>                  /* Is USB together with DP preferred */
>> @@ -115,6 +116,8 @@ static int dp_altmode_configure(struct dp_altmode *d=
p, u8 con)
>>                  else if (pin_assign & DP_PIN_ASSIGN_DP_ONLY_MASK)
>>                          pin_assign &=3D DP_PIN_ASSIGN_DP_ONLY_MASK;
>>
>> +               pr_err("dp_altmode_configure masked pin_assign %08x\n", =
pin_assign);
>> +
>>                  if (!pin_assign)
>>                          return -EINVAL;
>>
>>
>> Regards,
>>
>> Hans
>>

--------------E32AFC9A40715FE6E08ECA16
Content-Type: text/x-log; charset=UTF-8; name=tcpm-bad.log
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="tcpm-bad.log"

[   45.033737] Setting voltage/current limit 0 mV 0 mA
[   45.034062] polarity 0
[   45.034066] Requesting mux state 0, usb-role 0, orientation 0
[   45.039791] state change INVALID_STATE -> SNK_UNATTACHED [rev1 NONE_AMS]
[   45.040579] CC1: 0 -> 0, CC2: 0 -> 0 [state SNK_UNATTACHED, polarity 0, =
disconnected]
[   45.040603] i2c-fusb302: registered
[   45.043532] Setting voltage/current limit 0 mV 0 mA
[   45.043543] polarity 0
[   45.043546] Requesting mux state 0, usb-role 0, orientation 0
[   45.045309] cc:=3D0
[   45.047407] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100=
 ms [rev1 NONE_AMS]
[   45.153486] state change PORT_RESET -> PORT_RESET_WAIT_OFF [delayed 100 =
ms]
[   45.153501] state change PORT_RESET_WAIT_OFF -> SNK_UNATTACHED [rev1 NON=
E_AMS]
[   45.153510] Start toggling
[  136.458043] CC1: 0 -> 2, CC2: 0 -> 1 [state TOGGLING, polarity 0, connec=
ted]
[  136.458056] state change TOGGLING -> SRC_ATTACH_WAIT [rev1 NONE_AMS]
[  136.458124] pending state change SRC_ATTACH_WAIT -> SNK_TRY @ 200 ms [re=
v1 NONE_AMS]
[  136.659629] state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
[  136.659647] cc:=3D2
[  136.662964] pending state change SNK_TRY -> SNK_TRY_WAIT @ 100 ms [rev1 =
NONE_AMS]
[  136.771185] state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
[  136.771200] state change SNK_TRY_WAIT -> SRC_TRYWAIT [rev1 NONE_AMS]
[  136.771207] cc:=3D4
[  136.774216] pending state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED @=
 100 ms [rev1 NONE_AMS]
[  136.874416] state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED [delayed =
100 ms]
[  136.874427] state change SRC_TRYWAIT_UNATTACHED -> SNK_UNATTACHED [rev1 =
NONE_AMS]
[  136.874434] Start toggling
[  136.876604] state change SNK_UNATTACHED -> TOGGLING [rev1 NONE_AMS]
[  136.935349] CC1: 2 -> 2, CC2: 1 -> 1 [state TOGGLING, polarity 0, connec=
ted]
[  136.935356] state change TOGGLING -> SRC_ATTACH_WAIT [rev1 NONE_AMS]
[  136.935376] pending state change SRC_ATTACH_WAIT -> SRC_ATTACHED @ 200 m=
s [rev1 NONE_AMS]
[  137.138416] state change SRC_ATTACH_WAIT -> SRC_ATTACHED [delayed 200 ms=
]
[  137.138431] polarity 0
[  137.138438] Requesting mux state 1, usb-role 1, orientation 1
[  137.400456] vconn:=3D1
[  137.401212] vbus:=3D1 charge=3D0
[  137.414633] pending state change SRC_ATTACHED -> SRC_UNATTACHED @ 480 ms=
 [rev1 NONE_AMS]
[  137.434650] VBUS on
[  137.434656] state change SRC_ATTACHED -> SRC_STARTUP [rev1 NONE_AMS]
[  137.435506] AMS POWER_NEGOTIATION start
[  137.435513] cc:=3D4
[  137.440580] state change SRC_STARTUP -> AMS_START [rev3 POWER_NEGOTIATIO=
N]
[  137.440591] state change AMS_START -> SRC_SEND_CAPABILITIES [rev3 POWER_=
NEGOTIATION]
[  137.440596] PD TX, header: 0x11a1
[  137.449240] PD TX complete, status: 2
[  137.451075] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPAB=
ILITIES @ 150 ms [rev3 POWER_NEGOTIATION]
[  137.603369] state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES =
[delayed 150 ms]
[  137.603380] PD TX, header: 0x11a1
[  137.606492] PD TX complete, status: 0
[  137.606544] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPAB=
ILITIES_TIMEOUT @ 150 ms [rev3 POWER_NEGOTIATION]
[  137.612978] PD RX, header: 0x1042 [1]
[  137.613001] state change SRC_SEND_CAPABILITIES -> SRC_NEGOTIATE_CAPABILI=
TIES [rev2 POWER_NEGOTIATION]
[  137.613171] Requested 5000 mV, 1500 mA for 1500 / 1500 mA
[  137.613180] PD TX, header: 0x363
[  137.617198] PD TX complete, status: 0
[  137.617237] pending state change SRC_NEGOTIATE_CAPABILITIES -> SRC_TRANS=
ITION_SUPPLY @ 35 ms [rev2 POWER_NEGOTIATION]
[  137.652433] state change SRC_NEGOTIATE_CAPABILITIES -> SRC_TRANSITION_SU=
PPLY [delayed 35 ms]
[  137.652444] PD TX, header: 0x566
[  137.655955] PD TX complete, status: 0
[  137.656164] state change SRC_TRANSITION_SUPPLY -> SRC_READY [rev2 POWER_=
NEGOTIATION]
[  137.656540] AMS POWER_NEGOTIATION finished
[  137.656973] AMS DISCOVER_IDENTITY start
[  137.657101] PD TX, header: 0x176f
[  137.660691] PD TX complete, status: 0
[  137.676290] PD RX, header: 0x524f [1]
[  137.676298] Rx VDM cmd 0xff008041 type 1 cmd 1 len 5
[  137.677650] Identity: 177a:1120.0001
[  137.677660] AMS DISCOVER_IDENTITY finished
[  137.677694] AMS DISCOVER_SVIDS start
[  137.677706] PD TX, header: 0x196f
[  137.680918] PD TX complete, status: 0
[  137.690755] PD RX, header: 0x244f [1]
[  137.690767] Rx VDM cmd 0xff008042 type 1 cmd 2 len 2
[  137.690773] SVID 1: 0xff01
[  137.690777] AMS DISCOVER_SVIDS finished
[  137.690799] AMS DISCOVER_MODES start
[  137.690813] PD TX, header: 0x1b6f
[  137.694841] PD TX complete, status: 0
[  137.706629] PD RX, header: 0x264f [1]
[  137.706638] Rx VDM cmd 0xff018043 type 1 cmd 3 len 2
[  137.706644]  Alternate mode 0: SVID 0xff01, VDO 1: 0x00000c05
[  137.707886] AMS DISCOVER_MODES finished
[  137.739303] AMS DFP_TO_UFP_ENTER_MODE start
[  137.740205] PD TX, header: 0x1d6f
[  137.743047] PD TX complete, status: 0
[  137.751952] PD RX, header: 0x184f [1]
[  137.751964] Rx VDM cmd 0xff018144 type 1 cmd 4 len 1

--------------E32AFC9A40715FE6E08ECA16
Content-Type: text/x-log; charset=UTF-8; name=tcpm-good.log
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="tcpm-good.log"

[ 4474.691171] CC1: 0 -> 2, CC2: 0 -> 1 [state TOGGLING, polarity 0, connec=
ted]
[ 4474.691176] state change TOGGLING -> SRC_ATTACH_WAIT
[ 4474.691192] pending state change SRC_ATTACH_WAIT -> SNK_TRY @ 200 ms
[ 4474.896231] state change SRC_ATTACH_WAIT -> SNK_TRY [delayed 200 ms]
[ 4474.896249] cc:=3D2
[ 4474.899518] pending state change SNK_TRY -> SNK_TRY_WAIT @ 100 ms
[ 4475.008034] state change SNK_TRY -> SNK_TRY_WAIT [delayed 100 ms]
[ 4475.008058] state change SNK_TRY_WAIT -> SRC_TRYWAIT
[ 4475.008070] cc:=3D4
[ 4475.011131] pending state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED @=
 100 ms
[ 4475.119009] state change SRC_TRYWAIT -> SRC_TRYWAIT_UNATTACHED [delayed =
100 ms]
[ 4475.119039] state change SRC_TRYWAIT_UNATTACHED -> SNK_UNATTACHED
[ 4475.119051] Start toggling
[ 4475.122693] state change SNK_UNATTACHED -> TOGGLING
[ 4475.181832] CC1: 2 -> 2, CC2: 1 -> 1 [state TOGGLING, polarity 0, connec=
ted]
[ 4475.181843] state change TOGGLING -> SRC_ATTACH_WAIT
[ 4475.181879] pending state change SRC_ATTACH_WAIT -> SRC_ATTACHED @ 200 m=
s
[ 4475.383256] state change SRC_ATTACH_WAIT -> SRC_ATTACHED [delayed 200 ms=
]
[ 4475.383268] polarity 0
[ 4475.383272] Requesting mux state 1, usb-role 1, orientation 1
[ 4475.647963] vconn:=3D1
[ 4475.648307] vbus:=3D1 charge=3D0
[ 4475.666560] pending state change SRC_ATTACHED -> SRC_UNATTACHED @ 480 ms
[ 4475.685693] VBUS on
[ 4475.685697] state change SRC_ATTACHED -> SRC_STARTUP
[ 4475.685822] state change SRC_STARTUP -> SRC_SEND_CAPABILITIES
[ 4475.685826] PD TX, header: 0x11a1
[ 4475.693636] PD TX complete, status: 2
[ 4475.693663] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPAB=
ILITIES @ 150 ms
[ 4475.846995] state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES =
[delayed 150 ms]
[ 4475.847008] PD TX, header: 0x11a1
[ 4475.851029] PD TX complete, status: 0
[ 4475.851195] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPAB=
ILITIES_TIMEOUT @ 150 ms
[ 4475.857173] PD RX, header: 0x1042 [1]
[ 4475.857186] state change SRC_SEND_CAPABILITIES -> SRC_NEGOTIATE_CAPABILI=
TIES
[ 4475.857212] Requested 5000 mV, 1500 mA for 1500 / 1500 mA
[ 4475.857220] PD TX, header: 0x363
[ 4475.860901] PD TX complete, status: 0
[ 4475.860970] pending state change SRC_NEGOTIATE_CAPABILITIES -> SRC_TRANS=
ITION_SUPPLY @ 35 ms
[ 4475.897261] state change SRC_NEGOTIATE_CAPABILITIES -> SRC_TRANSITION_SU=
PPLY [delayed 35 ms]
[ 4475.897290] PD TX, header: 0x566
[ 4475.901901] PD TX complete, status: 0
[ 4475.902200] state change SRC_TRANSITION_SUPPLY -> SRC_READY
[ 4475.902549] PD TX, header: 0x176f
[ 4475.906360] PD TX complete, status: 0
[ 4475.921523] PD RX, header: 0x524f [1]
[ 4475.921530] Rx VDM cmd 0xff008041 type 1 cmd 1 len 5
[ 4475.921555] Identity: 177a:1120.0001
[ 4475.921570] PD TX, header: 0x196f
[ 4475.925036] PD TX complete, status: 0
[ 4475.935315] PD RX, header: 0x244f [1]
[ 4475.935322] Rx VDM cmd 0xff008042 type 1 cmd 2 len 2
[ 4475.935326] SVID 1: 0xff01
[ 4475.935343] PD TX, header: 0x1b6f
[ 4475.939463] PD TX complete, status: 0
[ 4475.950648] PD RX, header: 0x264f [1]
[ 4475.950661] Rx VDM cmd 0xff018043 type 1 cmd 3 len 2
[ 4475.950674]  Alternate mode 0: SVID 0xff01, VDO 1: 0x00000c05
[ 4475.951938] PD TX, header: 0x1d6f
[ 4475.955930] PD TX complete, status: 0
[ 4475.965103] PD RX, header: 0x184f [1]
[ 4475.965108] Rx VDM cmd 0xff018144 type 1 cmd 4 len 1
[ 4475.965224] PD TX, header: 0x2f6f
[ 4475.968979] PD TX complete, status: 0
[ 4475.980811] PD RX, header: 0x2a4f [1]
[ 4475.980816] Rx VDM cmd 0xff018150 type 1 cmd 16 len 2
[ 4475.980929] PD TX, header: 0x216f
[ 4475.984093] PD TX complete, status: 0
[ 4475.996798] PD RX, header: 0x1c4f [1]
[ 4475.996803] Rx VDM cmd 0xff018151 type 1 cmd 17 len 1

--------------E32AFC9A40715FE6E08ECA16--

