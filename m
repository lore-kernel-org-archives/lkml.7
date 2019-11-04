Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4CCCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D22E21655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfKDOZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:25:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:3708 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfKDOZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:25:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 06:25:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="212324113"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Nov 2019 06:25:00 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Nov 2019 16:24:59 +0200
Date:   Mon, 4 Nov 2019 16:24:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
Message-ID: <20191104142459.GC2552@lahna.fi.intel.com>
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 04, 2019 at 02:13:13PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> suspending the system, and resuming with Dell’s Thunderbolt TB16
> dock connected, the USB input devices, keyboard and mouse,
> connected to the TB16 stop working. They work for a few seconds
> (mouse cursor can be moved), but then stop working. The laptop
> keyboard and touchpad still works fine. All firmware is up-to-date
> according to `fwupdmgr`.

What are the exact steps to reproduce? Just "echo mem >
/sys/power/state" and then resume by pressing power button?

> [  139.752819] PM: suspend entry (s2idle)
> [  139.753919] Filesystems sync: 0.001 seconds
> [  139.754235] (NULL device *): firmware: direct-loading firmware qca/nvm_usb_00000302.bin
> [  139.754251] (NULL device *): firmware: direct-loading firmware qca/rampatch_usb_00000302.bin
> [  139.754879] (NULL device *): firmware: direct-loading firmware i915/kbl_dmc_ver1_04.bin
> [  139.754921] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [  139.756608] OOM killer disabled.
> [  139.756609] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
> [  139.757586] printk: Suspending console(s) (use no_console_suspend to debug)
> [  139.965726] psmouse serio1: Failed to disable mouse on isa0060/serio1
> [  150.530364] usb usb5: root hub lost power or was reset
> [  150.530365] usb usb6: root hub lost power or was reset
> [  150.723502] ath10k_pci 0000:02:00.0: UART prints enabled
> [  150.788182] ath10k_pci 0000:02:00.0: unsupported HTC service id: 1536
> [  150.955648] usb 6-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [  151.172726] usb 5-1: reset high-speed USB device number 2 using xhci_hcd
> [  151.509514] usb 6-1.2: reset SuperSpeed Gen 1 USB device number 3 using xhci_hcd
> [  151.980691] usb 5-1.3: reset low-speed USB device number 3 using xhci_hcd
> [  152.588838] usb 5-1.6: reset low-speed USB device number 5 using xhci_hcd
> [  153.026451] usb 5-1.5: reset high-speed USB device number 4 using xhci_hcd
> [  154.578785] OOM killer enabled.
> [  154.578788] Restarting tasks ... done.
> [  154.671809] PM: suspend exit

The first suspend/resume cycle seems to be fine with the exception of
the HDA issue below.

> [  155.362025] IPv6: ADDRCONF(NETDEV_CHANGE): enx98e743a83cdb: link becomes ready
> [  155.363594] r8152 6-1.2:1.0 enx98e743a83cdb: carrier on
> [  156.614284] snd_hda_intel 0000:00:1f.3: No response from codec, disabling MSI: last cmd=0x20270503
> [  157.622232] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  158.626371] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  159.634102] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  161.678121] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  162.682272] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  163.694234] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  165.730142] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  166.734062] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  167.737908] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  169.782041] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  170.785827] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  171.790000] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  173.829896] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  174.833893] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  175.837849] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  177.873704] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  178.881771] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  179.885738] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  181.921643] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  182.925675] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503

The second suspend/resume cycle seems to have more issues:

> [  183.132176] PM: suspend entry (s2idle)
> [  183.133798] Filesystems sync: 0.001 seconds
> [  183.133968] (NULL device *): firmware: direct-loading firmware i915/kbl_dmc_ver1_04.bin
> [  183.134108] (NULL device *): firmware: direct-loading firmware qca/nvm_usb_00000302.bin
> [  183.134111] (NULL device *): firmware: direct-loading firmware qca/rampatch_usb_00000302.bin
> [  183.134236] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [  183.136034] OOM killer disabled.
> [  183.136034] Freezing remaining freezable tasks ... 
> [  183.937677] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  185.973399] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  186.977389] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  187.981569] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  190.017506] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  190.731632] pcieport 0000:04:04.0: pciehp: Slot(4): Link Down
> [  190.731640] pcieport 0000:04:04.0: pciehp: Slot(4): Card not present

The PCIe link towards the dock goes down.

> [  190.731664] pcieport 0000:3e:04.0: Refused to change power state, currently in D3
> [  190.732691] xhci_hcd 0000:3f:00.0: remove, state 1
> [  190.732712] usb usb6: USB disconnect, device number 1
> [  190.732718] usb 6-1: USB disconnect, device number 2
> [  190.732724] usb 6-1.2: USB disconnect, device number 3
> [  190.732953] xhci_hcd 0000:3f:00.0: xHCI host controller not responding, assume dead
> [  190.763874] xhci_hcd 0000:3f:00.0: USB bus 6 deregistered
> [  190.763902] xhci_hcd 0000:3f:00.0: remove, state 1
> [  190.763918] usb usb5: USB disconnect, device number 1
> [  190.763926] usb 5-1: USB disconnect, device number 2
> [  190.763933] usb 5-1.3: USB disconnect, device number 3
> [  190.765347] usb 5-1.5: USB disconnect, device number 4
> [  190.767022] usb 5-1.6: USB disconnect, device number 5
> [  190.771437] xhci_hcd 0000:3f:00.0: Host halt failed, -19
> [  190.771445] xhci_hcd 0000:3f:00.0: Host not accessible, reset failed.
> [  190.772400] xhci_hcd 0000:3f:00.0: USB bus 5 deregistered
> [  190.773654] pcieport 0000:3b:01.0: Refused to change power state, currently in D3
> [  190.774231] pci_bus 0000:3c: busn_res: [bus 3c] is released
> [  190.774473] pci 0000:3b:01.0: Removing from iommu group 19
> [  190.774712] pci 0000:3f:00.0: Removing from iommu group 19
> [  190.774784] pci_bus 0000:3f: busn_res: [bus 3f] is released
> [  190.774990] pci 0000:3e:01.0: Removing from iommu group 19
> [  190.775345] pci_bus 0000:40: busn_res: [bus 40-6d] is released
> [  190.775566] pci 0000:3e:04.0: Removing from iommu group 19
> [  190.775624] pci_bus 0000:3e: busn_res: [bus 3e-6d] is released
> [  190.775817] pci 0000:3d:00.0: Removing from iommu group 19
> [  190.776158] pci_bus 0000:3d: busn_res: [bus 3d-6d] is released
> [  190.776360] pci 0000:3b:04.0: Removing from iommu group 19
> [  190.776692] pci_bus 0000:3b: busn_res: [bus 3b-6d] is released
> [  190.776890] pci 0000:3a:00.0: Removing from iommu group 19
> [  191.029202] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  192.041443] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  194.077394] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  195.081341] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  196.085350] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  196.121810] (elapsed 12.986 seconds) done.
> [  196.121823] printk: Suspending console(s) (use no_console_suspend to debug)
> [  196.781066] thunderbolt 0-303: device disconnected
> [  196.781161] thunderbolt 0-3: device disconnected

And seems the whole TBT link goes down as well.

What does /sys/bus/thunderbolt/devices/0-0/nvm_version contain?

Also can you add CONFIG_PCI_DEBUG=y in your .config and reproduce so we
can maybe see what is happening in the PCIe side.
