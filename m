Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B666C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5212620700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFPfQkw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCSCVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:21:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35901 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfCSCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:21:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id y36so10672472qtb.3;
        Mon, 18 Mar 2019 19:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dnX7acLjjtd/vDr4bl+ZDtbbpdNDmNSTxIge0DpT5Ao=;
        b=CFPfQkw8jcEMSWsX/O1VengNB3IbEGw8w/3McFCx1ts+ykUYFrN16oXwBqUsv0FQru
         R2jX+8GyMcZE+jPC/GGlEt2J6IALpGW6ft+btWw7lRaih5LrINhcghSXF1K17uqHeCLz
         2nsbor0Sk1u1RcUxlI1IkRevwVeetGTNZRCnIdeg4TgL538w+4aG3apgU9CqnbLOXubn
         GmUeh3gNBadiUcNPy3PJEQavxCIWPbypOBvmd/0dvi80bQKRANmP4vhOp+AhQuj0QyWl
         cOtJDuBk4yS+T3ZMK2QBc3by3MXe2o15c+dTuK2HmxEjTBbflgU5PBQcLM3h0lS2qZyt
         130A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dnX7acLjjtd/vDr4bl+ZDtbbpdNDmNSTxIge0DpT5Ao=;
        b=heXkjBusxe90qkHMfhMDXYwlxFnf/Y7y1cij9lOaHZuvSCQ8ZFyVkPRB/CXVNcEnqP
         gu7nhRvV9OLCZ4ofT95uN02V26clGqSn9l7fVPAizTYq5uIDhh0X0JuLUaiHpiuFN1Iw
         1vkcvZnju7t/v5PhUHL3WRuDfTS8OM22QDQ8NEIh/d8WYUsemK8Rwdob4F3TS4pIiBTP
         i+HKJ66nwqBnVZ437+t12+vEj1j0p0YUjaJWqFm3sl4M39XSUi0eRLxKy3A0Az++vZhU
         4/mNTxn274xKN4gbzwlfonJqZ9Km340/4IxJ5FRq5T1lCvs4LafTvmguWA/Z5gLG+pN4
         stUw==
X-Gm-Message-State: APjAAAWKJj5D+7uuOX5tlA4iBgRFqhQ1PuJCoxumMHbWgyDncwPlWr2s
        aBOy5aDh4B+D2MdA0m6iI8M=
X-Google-Smtp-Source: APXvYqzCNrUxnzS+yQI9zb3sulri/72lCxA5G93OLXibAUPC8eHWkJfWtntpI7szJM9aqBJIzxobwA==
X-Received: by 2002:ac8:1081:: with SMTP id a1mr52228qtj.79.1552962109919;
        Mon, 18 Mar 2019 19:21:49 -0700 (PDT)
Received: from rys-Inspiron-5420 ([201.82.188.175])
        by smtp.gmail.com with ESMTPSA id y21sm8450796qth.90.2019.03.18.19.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 19:21:49 -0700 (PDT)
Date:   Mon, 18 Mar 2019 23:21:44 -0300
From:   Renato Soma <renatoys08@gmail.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        mistave@countermail.com
Subject: Re: [PATCH 0/1] platform/x86: dell-wmi: Uncomment events that were
Message-ID: <20190319022144.GA14111@rys-Inspiron-5420>
References: <20190316010942.6448-1-renatoys08@gmail.com>
 <20190316091756.2zfccpnhfnjogktp@pali>
 <20190317183049.GA5989@rys-Inspiron-5420>
 <20190318120032.nynbshqudmlslxxz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318120032.nynbshqudmlslxxz@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 01:00:32PM +0100, Pali Rohár wrote:
> > =====================================================================
> > 
> > ----------------------------------------
> > Left WMI key: Windows Mobility Center
> > Press:    'x'
> > Hold:     -
> > Release:  -
> > 
> > In my machine (Inspiron 5420), whenever I press this key, the key
> > outputs the character "x". I've seen nothing on dmesg even if I
> > keep this key pressed for longer amounts of time. I'm still trying
> > to understand why this is hapenning.
> 
> This is strange. Is not also some Alt/Meta/Ctrl or other modifier sent
> too? Because Meta+X could be some windows shortcut...
> 
> > 
> > ----------------------------------------
> > Middle WMI key: Dell Audio With Preset Switch
> > Press:    Key with type 0x0000 and code 0xe02a pressed
> > Hold:     -
> > Release:  Key with type 0x0000 and code 0xe02b pressed
> > 
> > Differently from what you saw on a Inspiron 7520, I could not
> > reproduce the behavior that you reported on the first link above.
> > In my case, when I press the key, the code 0xe02a is shown at dmesg
> > only once. Also, even though I keep it pressed for longer than ~30
> > seconds or so, I could not see the entry 0xe02c apper. More on that
> > behavior later on. When releasing the key, I can see the code 0xe02b
> > show up at dmesg.
> > 
> > ----------------------------------------
> > Right WMI key: Dell Instant Launch
> > Press:    -
> > Hold:     -
> > Release:  -
> > 
> > This key is with a really weird behavior on my machine.
> > When testing, I would normally press and relase so that the following
> > messages would pop-up:
> > 
> > [ 2830.499420] atkbd serio0: Unknown key pressed (translated set 2,
> > code 0x60 on isa0060/serio0).
> > [ 2830.499422] atkbd serio0: Use 'setkeycodes 60 <keycode>'
> > to make it known.
> 
> This means that you have not configured atkbd keycodes yet. Run
> setkeycodecs and assign some keycode for that scancode 60. After that
> kernel atkbd (PS/2 keyboard) starts sending events to userspace.

All right, I'll investigate and try these approaches, thanks!

> 
> There are two ways how Dell firmware can inform operating system that
> key was pressed. Notebook keyboard is connected to motherboard via
> classic PS/2 port (of PS/2 port is emulated for OS). So operating system
> sees PS/2 keyboard and key pressed are received by PS/2 atkbd driver.
> For some (unknown/strange?) reasons firmware send some keys not via PS/2
> keyboard port, but via ACPI interface, hence needs for dell_wmi driver
> which handle them.
> 
> So some keypress events come via PS/2, some via ACPI-WMI. Linux kernel
> then send all keypress events to userspace.
> 
> When debugging problems with hot keys, you always need to look at all
> possible sources...
> 
> 
> dell-wmi.c is a driver for receiving APCI-WMI events; atkbd.c is a PS/2
> keyboard driver.
> 
> In dell-wmi.c is a function dell_wmi_events_set_enabled which is needed
> to call on some Dell machines to start receiving those ACPI-WMI events.
> You can try to call it for your laptop, maybe it is needed too.
> Currently it is called only for two laptop models, see table
> dell_wmi_smbios_list.
> 
> > In the meantime, I'll try to find out why the first button is outputting
> > an "x" character on my machine.
> 
> Check that you caught all keypresses. X11 tools just print keys known to
> X server, not all which are supported by Linux kernel.
> 
> You can use e.g. input-events utility. And also check all input devices,
> as wrote some keys are send via PS/2 keyboard input device, some via
> ACPI-WMI input device.
> 

Ok, I was unaware of this, I'll keep this in mind when reasearching.

I think that now I'm going to take my time in order to process all that
you explained to me and study this issue a little more, then possibly
start a new thread regarding my findings.

Thanks for your attention and time,

Renato
