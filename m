Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2ECC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6009216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAWmzM3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfEHQvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:51:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41466 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfEHQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:51:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id l132so1303904pfc.8;
        Wed, 08 May 2019 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7Jk8aznOiVhdbAYmpI97ZVHkdkGLp8aJ27lp2F/63Go=;
        b=DAWmzM3M21vmzVVwN393ese8B4BtxTPlF5G9biRIvJFj9GG1ndHp15DxKe5XdIeski
         DJtbPYSNR4vR2E5sac41ocfLgeycTpOIGhzRzvNxJhs/rVeIgwIMIxCLjR1LNV5EbVDK
         1lgSw/EiW6WiHuuDzpbB8ajtLeadE4PeN3HISOQ/TWx67zh6ifC08GmuTiDmP05pne9w
         YOihYL8k0kPTSL2HKS+HVpX1Pvtom+6vPkUeVijcGa+6ktkzJbLO1xsgKBeLX8ldaNv1
         fyoNy2fVrYYFKLXTPnSw3ltuU8s2uf8lFq3Jf4bn7VQi+frWtaCt4nVe1L/5VYsL2MBJ
         b3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7Jk8aznOiVhdbAYmpI97ZVHkdkGLp8aJ27lp2F/63Go=;
        b=I7QOOLjanc8kWpJj0F88HSpiwJefFbCSqh6943HN3pRNJohTgo1iyeszU70tNRjejD
         4fgsx7Tcvi5dMMlbHVhDMORryGwfJim+B2FpK1+U4F7z65rBuJ1Dq78INVjqoszaIDs3
         two+Co9KJSTzHmGya9f9Rh+6zRL8hyd5+hfan39ZfhQeLfJFJnfMwbtTyUzjfVJxqxQl
         kLEWu9OcyCCJm5fisEr/CYiBjVVL13o+8M0mv16U6dqJt447PLgEbQ1NA3vwY7hykinb
         btA8ybRXug+B7XRS6XfwFZVJUH7xISgEngScvseQoXaYUuplVr/ZDgyGu4iKA03Gn1z4
         mLOw==
X-Gm-Message-State: APjAAAU1UL2U+uatZkg2Pp03ZGB+lyNUCf2DXsFt/z5PryUn1JOA1WXZ
        LSwzeDRZbb/RLlyXsYPJMjQ=
X-Google-Smtp-Source: APXvYqwoFp+viCfu9mN4g6RNXBwAwxhF8uJGFipFQFnwDr4oHtDgpnY4MFQk8XkKNEvQljyt/y6j6A==
X-Received: by 2002:a65:5588:: with SMTP id j8mr30497876pgs.306.1557334293491;
        Wed, 08 May 2019 09:51:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10sm20749488pfa.37.2019.05.08.09.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:51:32 -0700 (PDT)
Date:   Wed, 8 May 2019 09:51:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>, linux-imx@nxp.com
Subject: Re: [PATCH v2 1/1] usb: typec: tcpci: Clear the fault status register
Message-ID: <20190508165131.GA7234@roeck-us.net>
References: <20190508002749.14816-1-angus@akkea.ca>
 <20190508002749.14816-2-angus@akkea.ca>
 <aed487a4-3f7c-55e8-9c84-feaa1c7f583d@roeck-us.net>
 <3fd046562f3bea2cb85354f8d3c420fc@www.akkea.ca>
 <3918f78b-15ec-9204-b2fc-f371157bc29c@roeck-us.net>
 <b1e568714632bc3be89f1452299873d2@www.akkea.ca>
 <20190508162211.GA5495@roeck-us.net>
 <1ba8244c4cfe5723c601c5e0416d6ffc@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ba8244c4cfe5723c601c5e0416d6ffc@www.akkea.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 10:33:22AM -0600, Angus Ainslie wrote:
> On 2019-05-08 10:22, Guenter Roeck wrote:
> >On Wed, May 08, 2019 at 07:48:43AM -0600, Angus Ainslie wrote:
> >>Hi Guenter
> >>
> >>On 2019-05-07 23:18, Guenter Roeck wrote:
> >>>On 5/7/19 7:49 PM, Angus Ainslie wrote:
> >>>>On 2019-05-07 20:03, Guenter Roeck wrote:
> >>>>>On 5/7/19 5:27 PM, Angus Ainslie (Purism) wrote:
> >>>>>>If the fault status register doesn't get cleared then
> >>>>>>the ptn5110 interrupt gets stuck on. As the fault register gets
> >>>>>>set everytime the ptn5110 powers on the interrupt is always stuck.
> >>>>>>
> >>>>>>Fixes: fault status register stuck
> >>>>>>Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> >>>>>>---
> >>>>>>  drivers/usb/typec/tcpm/tcpci.c | 11 +++++++++++
> >>>>>>  1 file changed, 11 insertions(+)
> >>>>>>
> >>>>>>diff --git a/drivers/usb/typec/tcpm/tcpci.c
> >>>>>>b/drivers/usb/typec/tcpm/tcpci.c
> >>>>>>index c1f7073a56de..a5746657b190 100644
> >>>>>>--- a/drivers/usb/typec/tcpm/tcpci.c
> >>>>>>+++ b/drivers/usb/typec/tcpm/tcpci.c
> >>>>>>@@ -463,6 +463,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
> >>>>>>      else if (status & TCPC_ALERT_TX_FAILED)
> >>>>>>          tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
> >>>>>>  +    if (status & TCPC_ALERT_FAULT) {
> >>>>>
> >>>>>Wait - the driver doesn't set TCPC_ALERT_FAULT in the alert mask
> >>>>>register. How can the chip report it if fault alerts are not enabled ?
> >>>>
> >>>>Well that I didn't check. But I know this code gets executed so
> >>>>something must be turning it on.
> >>>>
> >>>>Also if I don't clear it I get an unlimited number of interrupts.
> >>>>
> >>>>>What am I missing here ?
> >>>>
> >>>>Can the power on fault be masked ?
> >>>>
> >>>
> >>>There is a TCPC_ALERT_FAULT mask bit, so I would think so.
> >>>Can you dump register contents in the irq function and at the end of
> >>>tcpci_init() ?
> >>>
> >>
> >>Ok so this seems to be related to imx8mq errata e7805:
> >>
> >>I2C: When the I2C clock speed is configured for 400 kHz, the SCL low
> >>period
> >>violates the I2C spec of
> >>1.3 uS min
> >>
> >>The work around suggested by NXP is to set the clock to 384 kHz so that
> >>is
> >>what I did and this is the output:
> >>
> >>[    4.091512] device: 'tcpm-source-psy-0-0052': device_add
> >>[    4.091581] PM: Adding info for No Bus:tcpm-source-psy-0-0052
> >>[    4.091596] device: 'tcpm-source-psy-0-0052': dev_uevent: class
> >>uevent()
> >>returned -11
> >>[    4.094774] tcpci 0-0052: ALERT MASK 0x7f
> >>[    4.107869] driver: 'tcpci': driver_bound: bound to device '0-0052'
> >>[    4.107935] bus: 'i2c': really_probe: bound device 0-0052 to driver
> >>tcpci
> >>[    4.110994] tcpci 0-0052: ALERT MASK 0x7f
> >>[    4.115511] tcpci 0-0052: FAULT ALERT status 0x80
> >>[    4.126332] tcpci 0-0052: ALERT MASK 0x7f
> >>[    4.130784] tcpci 0-0052: FAULT ALERT status 0x0
> >>
> >>The first "ALERT MASK" is in the init function immediately after setting
> >>
> >>        reg = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_FAILED |
> >>                TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_RX_STATUS |
> >>                TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS;
> >>        if (tcpci->controls_vbus)
> >>                reg |= TCPC_ALERT_POWER_STATUS;
> >>        ret = tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
> >>
> >>
> >>So it looks like the register is correct but the fault interrupt still
> >>fires. At 200 kHz I get the following output.
> >>
> >>[    4.136845] device: 'tcpm-source-psy-0-0052': device_add
> >>[    4.136943] PM: Adding info for No Bus:tcpm-source-psy-0-0052
> >>[    4.136966] device: 'tcpm-source-psy-0-0052': dev_uevent: class
> >>uevent()
> >>returned -11
> >>[    4.178510] tcpci 0-0052: ALERT MASK 0x7f
> >>[    4.217197] driver: 'tcpci': driver_bound: bound to device '0-0052'
> >>[    4.217371] bus: 'i2c': really_probe: bound device 0-0052 to driver
> >>tcpci
> >>
> >>So this is what is expected no fault interrupt.
> >>
> >>Maybe errata e7805 needs an update.
> >>
> >>Sorry for the noise.
> >>
> >
> >Let's not jump to conclusions; I don't think this is noise. It is more
> >likely that the i2c problem uncovers a race condition in tcpci_init().
> >
> >In tcpci_init(), we first clear TCPC_ALERT by writing 0xffff into it.
> >Subsequently, we set TCPC_ALERT_MASK. I suspect what may happen is
> >that the chip has FAULT_ALERT enabled, and that a fault was logged.
> >We don't clear the FAULT_STATUS register in tcpci_init(), thus
> >FAULT_ALERT is immediately set again, before we clear the FAULT_ALERT
> >mask bit.
> >
> 
> Ok but wouldn't slowing down the bus speed make this more likely to happen
> than less ?
> 
No, I don't think so. After all, FAULT_ALERT should be set again immediately
if FAULT_STATUS was not cleared. I think the speed problem by itself may
trigger a fault, and we see the secondary impact of that. Is FAULT_STATUS
bit 0 (I2C Interface Error Interrupt) set, by any chance ?

Plus, you don't see a fault in the first place with the lower speed, or
did I miss something ?

> >The standard says that the alert pin shall not be set if the respective
> >interrupt is masked, but maybe the chip doesn't follow that. Either case,
> >the standard does say that masked alerts are still reported in the status
> >registers, so it is not surprising that the fault status is reported.
> >
> >What we should probably do in tcpci_init() is to change the register
> >initialization order, and to clear the fault status register.
> >
> >- Set TCPC_ALERT_MASK
> >- Set FAULT_STATUS_MASK (to 0)
> >- Clear TCPC_FAULT_STATUS
> >- Clear TCPC_ALERT
> >
> >I suspect that will fix your problem.
> >
> 
> I'll try and get time to give that a shot.
> 
> >Another question is if TCPC_ALERT_FAULT (together with appropriate
> >FAULT_STATUS_MASK bits) should be enabled, and if faults should be
> >logged. But that would be a separate patch or patch series.
> >
> 
> I was thinking this too but it also falls into the if I can find time
> category.
> 
Seems like we all have the same problem ...

Thanks,
Guenter
