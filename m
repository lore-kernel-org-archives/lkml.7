Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FEEC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0A321D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgACF0X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 00:26:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55710 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACF0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:26:22 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1inFTX-0007TT-Vq
        for linux-kernel@vger.kernel.org; Fri, 03 Jan 2020 05:26:20 +0000
Received: by mail-pg1-f197.google.com with SMTP id v2so28775855pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 21:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OmslvZ6fFzpAiikeOhX15iBaA2LRxmJBqsOZa9p7TaY=;
        b=MvyeJYni16ZAFNy+Se+27DhHAhf+8WAICwGbC30PEwbm7AZSZc8yrXFcojVIGk3pVf
         WdpGMmywdWZjWDJeLaIE/aQJ0MUdxJjvzupj/tKWNt1wz7kMHpqtr2dxz8BItF8Ebi8D
         jv/4KiFMPjVBIbnZhL1M4BGqHJsdG34xNCI82/bImnjExc6RL3rNkHyNttmipaAuipqm
         e/zK6Wl7DpuivRMSxPdkI7m5ievbv8g0zMDPZZu6YMEgu9K01etnN74Yk0xEh93O3PYD
         7P+4rk1Q3iP7f0CR72FMGnS5yjd5KW7+IHxbzkPdV9D7jhRDSfzUgrk8rdxbTDI4XBQX
         /TRA==
X-Gm-Message-State: APjAAAXfLdX9v1Sp4JwWF6wqTfhC5/MOTKLPWIlhshPhHFpb8Z4kyuYX
        9vWLDCuEIkdbguzg/S7AcNFW2wRlUPFa56yNA8QEIZ57+SG1ocppsmQR1TGVkyHXyxOG/C+0Yvf
        9MdnlAmfiJWO2JyTCSE2ayfN1fFMfrkz6Vfdtb0KTkQ==
X-Received: by 2002:a63:2ad8:: with SMTP id q207mr94586684pgq.45.1578029177344;
        Thu, 02 Jan 2020 21:26:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyW1Jwb+vKX4prQ9ief65n8kbJvQf7s7agRn9JvZXdB5fFq/SFtHMRr5B4kzSWwH2WtSd0aqw==
X-Received: by 2002:a63:2ad8:: with SMTP id q207mr94586653pgq.45.1578029176949;
        Thu, 02 Jan 2020 21:26:16 -0800 (PST)
Received: from 2001-b011-380f-35a3-58a8-ce0f-e12f-6096.dynamic-ip6.hinet.net (2001-b011-380f-35a3-58a8-ce0f-e12f-6096.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:58a8:ce0f:e12f:6096])
        by smtp.gmail.com with ESMTPSA id h12sm50428144pfo.12.2020.01.02.21.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2020 21:26:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] usb: hub: move resume delay at the head of all USB access
 functions
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.2001021605410.20954-100000@iolanthe.rowland.org>
Date:   Fri, 3 Jan 2020 13:26:13 +0800
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Harry Pan <harry.pan@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        USB list <linux-usb@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C434F324-5498-4629-8C03-5B1BD01F3A8F@canonical.com>
References: <Pine.LNX.4.44L0.2001021605410.20954-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> On Jan 3, 2020, at 05:37, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Wed, 25 Dec 2019, AceLan Kao wrote:
> 
>> Here[1] are the dmesg and the usbmon log from wireshark, and
>> /sys/kernel/debug/usb/usbmon/0u.
>> 
>> I verified this issue on Dell XPS 13 + Dell Salomon WD19 docking
>> station(plug-in 3 USB disk on it)
>> After s2idle 7 times, 2 usb disks lost. But from wireshark log, the
>> packets look normal, no error.
>> 
>> So, I re-do the test again and log the usbmon/0u output, but it's greek to me.
>> Hope you can help to find some clues in the logs.
>> Thanks.
>> 
>> 1. https://people.canonical.com/~acelan/bugs/usb_issue/
> 
> Maybe Mathias can help figure out what's going on.  It clearly is an 
> xHCI-related problem of some sort.

I think I figured this issue out and I'll send out a patch series soon.

> 
> I can't get much out of these logs.  For one thing, the time period
> covered by the usbmon trace is different from the time period in your
> dmesg log.  When you collect two kinds of logs for a test, it's
> important that they should be collected at the _same_ time!  Otherwise 
> they record different events, which is no use.
> 
> For another, your usbmon trace used the 0u file, but you should have
> used the 2u file instead.  All the errors you get involve devices on 
> bus 2; including other buses in the trace just makes it more confusing 
> and causes more entries to be dropped.
> 
> Also, I don't understand why your Dell Dock devices show up the way
> they do.  The SuperSpeed dock is on bus 2, and the high speed dock is
> on bus 3, which is attached to a different xHCI controller!  A hub
> (which is what a dock is) should show up twice, and both instances
> should be attached to the same controller.

I think this is how Ice Lake xHCI works, the Thunderbolt xHCI is also part of SoC on Ice Lake.

> 
> In any case, it's clear that you've got some problem involving the xHCI
> controller and the SuperSpeed Dell Dock (device 2-1).  Here's an
> excerpt from the dmesg log showing what goes wrong.  This occurs during
> a system resume; apparently the dock's connection drops while the
> system is suspended and there are errors when the system tries to
> re-activate it:
> 
> [  721.507202] usb 2-1: USB disconnect, device number 32
> [  721.507206] usb 2-1.3: USB disconnect, device number 33
> [  721.507209] usb 2-1.3.1: USB disconnect, device number 35
> [  721.540214] usb 2-1.3.3: USB disconnect, device number 36
> [  721.584518] usb 2-1.4: USB disconnect, device number 34
> [  721.647466] xhci_hcd 0000:00:0d.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
> 
> That's the first problem.
> 
> [  721.919433] usb 2-1: new SuperSpeedPlus Gen 2 USB device number 38 using xhci_hcd
> [  721.942597] usb 2-1: New USB device found, idVendor=0bda, idProduct=0487, bcdDevice= 1.47
> [  721.942600] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [  721.942602] usb 2-1: Product: Dell dock
> [  721.942604] usb 2-1: Manufacturer: Dell Inc.
> [  721.944849] hub 2-1:1.0: USB hub found
> [  721.945232] hub 2-1:1.0: 4 ports detected
> [  722.178395] hub 2-1:1.0: hub_ext_port_status failed (err = -71)
> [  722.178570] usb 2-1-port3: attempt power cycle
> [  722.559212] usb 2-1: USB disconnect, device number 38
> [  722.559311] usb 2-1: Failed to suspend device, error -19
> 
> And that's a second error.  Then the system tries again:
> 
> [  722.831431] usb 2-1: new SuperSpeedPlus Gen 2 USB device number 43 using xhci_hcd
> [  722.854608] usb 2-1: New USB device found, idVendor=0bda, idProduct=0487, bcdDevice= 1.47
> [  722.854611] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [  722.854614] usb 2-1: Product: Dell dock
> [  722.854616] usb 2-1: Manufacturer: Dell Inc.
> [  722.857034] hub 2-1:1.0: USB hub found
> [  722.857440] hub 2-1:1.0: 4 ports detected
> [  723.090106] hub 2-1:1.0: hub_ext_port_status failed (err = -71)
> [  723.090316] usb 2-1-port3: attempt power cycle
> [  723.471212] usb 2-1: USB disconnect, device number 43
> [  723.471274] usb 2-1: Failed to suspend device, error -19
> 
> And it fails in the same way.  A third try ends up succeeding:
> 
> [  723.743465] usb 2-1: new SuperSpeedPlus Gen 2 USB device number 48 using xhci_hcd
> ...
> 
> I don't see why the device numbers jump around in such a crazy manner.  
> When device 38 disconnects, the next device is number 43.  And when 
> that fails, the next number is 48!  It looks like device numbers are 
> somehow being allocated for the four child devices even though the log 
> doesn't show them being detected.
> 
> Here's a portion of the usbmon trace that apparently corresponds
> somewhat to part of the log above, although it's hard to be certain.  
> In this trace, device 77 on bus 2 is 2-1.  Unlike the log above, it
> only has a child attached to port 3, not to port 4:
> 
> ffff9879b43ff840 291366827 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
> ffff9879b43ff840 291366846 C Ci:2:001:0 0 4 = 03020000
> ffff9879b2f54780 291469875 S Ci:2:077:0 s a3 00 0000 0001 0004 4 <
> ffff9879b2f54780 291470062 C Ci:2:077:0 0 4 = a0020000
> ffff9879b2f54780 291470069 S Ci:2:077:0 s a3 00 0000 0002 0004 4 <
> ffff9879b2f54780 291470208 C Ci:2:077:0 0 4 = a0020000
> ffff9879b2f54780 291470214 S Ci:2:077:0 s a3 00 0000 0003 0004 4 <
> ffff9879b2f54780 291470387 C Ci:2:077:0 0 4 = 03021000
> ffff9879b2f54780 291470392 S Co:2:077:0 s 23 01 0014 0003 0000 0
> ffff9879b2f54780 291470527 C Co:2:077:0 0 0
> ffff9879b2f54780 291470533 S Ci:2:077:0 s a3 00 0000 0004 0004 4 <
> ffff9879b2f54780 291470709 C Ci:2:077:0 0 4 = a0020000
> ffff9879b43ff480 291573804 S Ii:2:077:1 -115:128 2 <
> ffff9879b2f54780 291573839 S Ci:2:077:0 s a3 00 0000 0003 0004 4 <
> ffff9879b2f54780 291574068 C Ci:2:077:0 0 4 = 03020000
> ffff9879b2f54780 291574166 S Ci:2:077:0 s a3 00 0000 0003 0004 4 <
> ffff9879b2f54780 291574363 C Ci:2:077:0 0 4 = 03020000
> ffff9879b2f54780 291574383 S Co:2:077:0 s 23 03 0004 0003 0000 0
> ffff9879b2f54780 291574580 C Co:2:077:0 0 0
> ffff9879b2f54780 291593804 S Ci:2:077:0 s a3 00 0002 0003 0008 8 <
> ffff9879ae2969c0 291595804 C Ii:2:001:1 0:2048 1 = 02
> ffff9879ae2969c0 291595824 S Ii:2:001:1 -115:2048 4 <
> ffff9879ba3476c0 291595843 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
> ffff9879ba3476c0 291595857 C Ci:2:001:0 0 4 = c0024100
> 
> As far as I can tell, the device was working fine until at this point
> it disconnected itself.
> 
> ffff9879ba3476c0 291595863 S Co:2:001:0 s 23 01 0010 0001 0000 0
> ffff9879ba3476c0 291595867 C Co:2:001:0 0 0
> ffff9879ba3476c0 291595870 S Co:2:001:0 s 23 01 0019 0001 0000 0
> ffff9879ba3476c0 291595875 C Co:2:001:0 0 0
> ffff9879ba3476c0 291595879 S Co:2:001:0 s 23 03 001c 0001 0000 0
> ffff9879ba3476c0 291595884 C Co:2:001:0 0 0
> ffff9879b2f54780 291600949 C Ci:2:077:0 -71 0
> ffff9879b2f54780 291600997 S Co:2:077:0 s 23 03 0004 0003 0000 0
> ffff9879b2f54780 291601000 E Co:2:077:0 -19 0
> 
> Mathias, any suggestions on how Acelan can track down the reasons for 
> these problems?

There are three issues for this hub:
- It may not be in U3 after suspend
- It may not be in U0 after resume
- It disconnects when setting downstream ports to U0 while the hub itself is not in U0.

I'll send a patch series soon.

Kai-Heng

> 
> Alan Stern

