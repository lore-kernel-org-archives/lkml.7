Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F138FC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03D7214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbfFTBhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 21:37:41 -0400
Received: from sobre.alvarezp.com ([173.230.155.94]:56534 "EHLO
        sobre.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfFTBhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:37:41 -0400
Received: from [192.168.15.64] (unknown [189.205.206.165])
        by sobre.alvarezp.com (Postfix) with ESMTPSA id 8E779228AF;
        Wed, 19 Jun 2019 20:37:38 -0500 (CDT)
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org>
 <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org>
 <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>
From:   Octavio Alvarez <octallk1@alvarezp.org>
Message-ID: <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
Date:   Wed, 19 Jun 2019 20:37:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 3:45 PM, Thomas Gleixner wrote:
>> I noticed that Thomas' mailbox is filtering my mail because of some RBL and
>> have not figured out why that is yet so maybe he has not gotten any e-mails
>> from me. However, I already tried conacting using a different mail provider.
> 
> I got your mail from June 1st via LKML and this one directly and via
> LKML. It's in the pile of the other ~1000 mails in my backlog as I was out
> on vacation and travel. Just because people do not reply immediately does
> not mean they ignore you.

I didn't assume "ignore", just wondered if messages got through. Thank 
you for explaining; I will be more patient. :-)

> Can you please provide the content of /proc/interrupts with the driver
> loaded and working after boot (don't hibernate) for the following kernels:
> 
>    Linus upstream

$ cat linux-master-after-boot.txt
            CPU0       CPU1       CPU2       CPU3
   0:         34          0          0          0   IO-APIC   2-edge 
  timer
   1:          0          0        257          0   IO-APIC   1-edge 
  i8042
   8:          0          0          0          1   IO-APIC   8-edge 
  rtc0
   9:          0        949          0          0   IO-APIC   9-fasteoi 
  acpi
  12:          0       2587          0          0   IO-APIC  12-edge 
  i8042
  16:          0          0         88       4116   IO-APIC  16-fasteoi 
  ehci_hcd:usb1, ath9k
  18:          0          0          0          0   IO-APIC  18-fasteoi 
  i801_smbus, ips
  23:        992          0        420        720   IO-APIC  23-fasteoi 
  ehci_hcd:usb2
  27:          1          0          0          0   PCI-MSI 3145728-edge 
      eth0
  28:      22999          0          0       8916   PCI-MSI 512000-edge 
     ahci[0000:00:1f.2]
  29:          0        243          0          0   PCI-MSI 32768-edge 
    i915
  30:          0          0        527          0   PCI-MSI 442368-edge 
     snd_hda_intel:card0
NMI:          9         10         10         14   Non-maskable interrupts
LOC:      26980      34136      32278      30957   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:          9         10         10         14   Performance 
monitoring interrupts
IWI:      12118      12820      11923      13042   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:       2566       1590       1565       1363   Rescheduling interrupts
CAL:       2090       1927       1925       2002   Function call interrupts
TLB:        238        256        206        262   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC 
interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:          2          3          3          3   Machine check polls
HYP:          0          0          0          0   Hypervisor callback 
interrupts
HRE:          0          0          0          0   Hyper-V 
reenlightenment interrupts
HVS:          0          0          0          0   Hyper-V stimer0 
interrupts
ERR:          0
MIS:          0
PIN:          0          0          0          0   Posted-interrupt 
notification event
NPI:          0          0          0          0   Nested 
posted-interrupt event
PIW:          0          0          0          0   Posted-interrupt 
wakeup event


>    Linus upstream + revert

$ cat linux-master-reverted-after-boot.txt
            CPU0       CPU1       CPU2       CPU3
   0:         34          0          0          0   IO-APIC   2-edge 
  timer
   1:          0          0          0        402   IO-APIC   1-edge 
  i8042
   8:          1          0          0          0   IO-APIC   8-edge 
  rtc0
   9:          0       1085          0          0   IO-APIC   9-fasteoi 
  acpi
  12:          0          0       5155          0   IO-APIC  12-edge 
  i8042
  16:          0          0         88       6917   IO-APIC  16-fasteoi 
  ehci_hcd:usb1, ath9k
  18:          0          0          0          0   IO-APIC  18-fasteoi 
  i801_smbus, ips
  23:        324          0          0       1959   IO-APIC  23-fasteoi 
  ehci_hcd:usb2
  27:          1          0          0          0   PCI-MSI 3145728-edge 
      eth0
  28:      39442          0          0          0   PCI-MSI 512000-edge 
     ahci[0000:00:1f.2]
  29:          0       2021          0          0   PCI-MSI 32768-edge 
    i915
  30:          0          0        544          0   PCI-MSI 442368-edge 
     snd_hda_intel:card0
NMI:         16         17         18         17   Non-maskable interrupts
LOC:      46049      47263      47259      44457   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:         16         17         18         17   Performance 
monitoring interrupts
IWI:      17558      15616      15991      15884   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:       4333       3136       2882       2690   Rescheduling interrupts
CAL:       2803       2518       2405       2588   Function call interrupts
TLB:       1085       1171       1201       1077   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC 
interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:          2          3          3          3   Machine check polls
HYP:          0          0          0          0   Hypervisor callback 
interrupts
HRE:          0          0          0          0   Hyper-V 
reenlightenment interrupts
HVS:          0          0          0          0   Hyper-V stimer0 
interrupts
ERR:          0
MIS:          0
PIN:          0          0          0          0   Posted-interrupt 
notification event
NPI:          0          0          0          0   Nested 
posted-interrupt event
PIW:          0          0          0          0   Posted-interrupt 
wakeup event

>    4.14 stable (that's before the big overhaul of the vector/msi code)

Haven't been able to boot 4.14 yet (as I already have a newer GCC). 
Still trying to properly compile.

Meanwhile, here it is for 4.9, which is the latest Debian-provided 
kernel and worked:

$ cat linux-4.9-after-boot.txt
            CPU0       CPU1       CPU2       CPU3
   0:         49          0          0          0   IO-APIC   2-edge 
  timer
   1:         74         65         90         81   IO-APIC   1-edge 
  i8042
   8:          0          0          1          0   IO-APIC   8-edge 
  rtc0
   9:         71         73         74         73   IO-APIC   9-fasteoi 
  acpi
  12:        263        250        257        293   IO-APIC  12-edge 
  i8042
  16:        340         56        507         63   IO-APIC  16-fasteoi 
  ehci_hcd:usb1, ath9k
  18:          0          0          0          0   IO-APIC  18-fasteoi 
  i801_smbus, ips
  23:        429        250        444        246   IO-APIC  23-fasteoi 
  ehci_hcd:usb2
  24:          1          0          0          0   PCI-MSI 3145728-edge 
      eth0
  25:       1469      17413       1462       1474   PCI-MSI 512000-edge 
     ahci[0000:00:1f.2]
  26:         20         15       1177         18   PCI-MSI 32768-edge 
    i915
  27:        119        115        125        124   PCI-MSI 442368-edge 
     snd_hda_intel:card0
NMI:          7          8          8          6   Non-maskable interrupts
LOC:      13917      19102      13725      13534   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:          7          8          8          6   Performance 
monitoring interrupts
IWI:       5372       7444       5009       4967   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:       1001        835        616        590   Rescheduling interrupts
CAL:       3360       3170       3607       3670   Function call interrupts
TLB:        146        169         74        219   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC 
interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:          2          2          2          2   Machine check polls
ERR:          0
MIS:          0
PIN:          0          0          0          0   Posted-interrupt 
notification event
PIW:          0          0          0          0   Posted-interrupt 
wakeup event

I will keep trying 4.14, unless you say otherwise.

I tried diffing -u but I could not interpret the result.

Thank you for your help,
Octavio.
