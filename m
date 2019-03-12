Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4240FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B32D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCLOLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:11:45 -0400
Received: from foss.arm.com ([217.140.101.70]:42958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfCLOLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:11:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E27A4165C;
        Tue, 12 Mar 2019 07:11:44 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93FBB3F71D;
        Tue, 12 Mar 2019 07:11:43 -0700 (PDT)
Subject: Re: ssh session with qemu-arm using busybox
To:     pintu.ping@gmail.com, mick@ics.forth.gr
Cc:     linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, qemu-devel@nongnu.org
References: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
 <2c5d240eabdb56913f4abcc9aacf2b6b@mailhost.ics.forth.gr>
 <CAOuPNLg4dfoovZ_eqL5XvNW3Ak9dGeCVr=vbG6G5t4Rxo-nC9Q@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <00078ed3-fe1d-722e-0943-80bb189ee3ab@arm.com>
Date:   Tue, 12 Mar 2019 14:11:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAOuPNLg4dfoovZ_eqL5XvNW3Ak9dGeCVr=vbG6G5t4Rxo-nC9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2019 14:02, Pintu Agarwal wrote:
>>
>> -netdev user,id=unet,hostfwd=tcp::2222-:22 \
>> -net user \
>>
>> and you 'll get guest's port 22 to be forwarded to hosts port 2222, so
>> you can do
>>
>> ssh root@localhost:2222
>>
>> from the host.
>>
> 
> I tried many different options, but unfortunately none worked for me.
> 1)
> qemu-system-arm -M vexpress-a9 -m 1024M -kernel
> ../KERNEL/linux/arch/arm/boot/zImage -dtb
> ../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
> rootfs.img.gz -append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init
> ip=dhcp" -nographic -smp 4 -netdev user,id=unet,hostfwd=tcp::2222-:22
> -net user
> 
> With this the eth0 interface is removed, and I see this message
> (although login works):
> qemu-system-arm: warning: hub 0 with no nics
> qemu-system-arm: warning: netdev unet has no peer
> Booting Linux on physical CPU 0x0
> <skip>
> NET: Registered protocol family 17
> <skip>
> Run /sbin/init as init process
> ifconfig: SIOCSIFADDR: No such device
> route: SIOCADDRT: Network is unreachable
> 
> But, ssh is still not working.
> ssh root@localhost:2222
> ssh: Could not resolve hostname localhost:2222: Name or service not known

man ssh

+

Make sure you have sshd in your custom rootfs and has been stared.

Cheers
Suzuki
