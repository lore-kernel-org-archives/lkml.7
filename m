Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E3C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CB12067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfGOQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:40:35 -0400
Received: from sobre.alvarezp.com ([173.230.155.94]:54078 "EHLO
        sobre.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbfGOQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:40:35 -0400
Received: from [192.168.15.3] (187-177-154-156.dynamic.axtel.net [187.177.154.156])
        by sobre.alvarezp.com (Postfix) with ESMTPSA id 573971E31B;
        Mon, 15 Jul 2019 11:40:33 -0500 (CDT)
From:   Octavio Alvarez <octallk1@alvarezp.org>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org>
 <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org>
 <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>
 <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
 <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de>
 <098de4c3-5f71-f84d-8b49-d2f43e18ed91@alvarezp.org>
 <alpine.DEB.2.21.1906271632300.32342@nanos.tec.linutronix.de>
Message-ID: <82fa0f47-ccb9-18fc-e35d-af02df37e3fb@alvarezp.org>
Date:   Mon, 15 Jul 2019 11:40:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906271632300.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-MX
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 9:38 AM, Thomas Gleixner wrote:
>> I did two tests:
>>
>> If I boot with sky2.disable_msi=1 on the kernel cmdline then the problem goes
>> away (when back from hibernation, the NIC works OK).
>>
>> If I boot regularly (disable_msi not set) and then do modprobe -r sky2;
>> modprobe sky2 disable_msi=1, the problem stays (when back from hibernation,
>> the NIC does not work).
> 
> Interesting. Did you verify that the driver still uses INTx after
> hibernation in /proc/interrupts?
> 
>   cat /proc/interrupts | grep eth0
> 
> The 6st column should show IO-APIC for INTx. If it shows PCI-MSI then
> something went wrong

Hi, Thomas,

If I reboot with sky2.disable_msi=1, then I get IO-APIC and the bug does 
not occur:

  19:          0          0          0          0   IO-APIC  19-fasteoi eth0

However, if I reboot without sky2.disable_msi=1 it properly starts as 
PCI-MSI and then, after re-modprobing it it goes to IO-APIC, but the bug 
occurs anyway:

$ cat /proc/interrupts | grep eth
  27:          0          1          0          0   PCI-MSI 3145728-edge 
      eth0

$ sudo modprobe -r sky2
[sudo] password for alvarezp:

$ sudo modprobe sky2 disable_msi=1

$ # hibernating and coming back hibernation

$ cat /proc/interrupts | grep eth
  19:          0          0          0          0   IO-APIC  19-fasteoi 
  eth0


> Also please check Linus suspicion about the module being reloaded after
> hibernation through some distro magic.

This is not happening. Each time the driver is loaded the message "sky2: 
driver version 1.30" is shown.

I confirm only 1 line for the sky2.disable_msi=1 from kernel boot and 
only 2 lines for re-modprobing.

Best regards,
Octavio.
