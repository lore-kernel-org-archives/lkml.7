Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F475C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D54208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rIQF9uV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfFGRmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:42:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbfFGRmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:42:16 -0400
Received: from zn.tnic (p200300EC2F066300951FA2F4E0AD5C5F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6300:951f:a2f4:e0ad:5c5f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AB7F1EC0985;
        Fri,  7 Jun 2019 19:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559929335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JQAA3WN3TzT4ccULLhRVUNCaToxHzRDaxQlu0v0KeKg=;
        b=rIQF9uV41BvAC4hfRi8JcZbwUXDaNc64zAoy9ThP0f4r75Gr9YWrfKDJiI8r5Hm3CcAMo3
        eEpBzGhEpnSvlmxv6snr8d4LM5DOmbodNzpImQN035obHy8RqWLj4ls4/DOK5CG/dKIWgl
        PTkp9mSUVWoqx0lH20XB56ic/xGjWmU=
Date:   Fri, 7 Jun 2019 19:42:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190607174211.GN20269@zn.tnic>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:30:21PM +0800, lijiang wrote:
> Hi, Boris and Thomas
> 
> Could you give me any suggestions about this patch series? Other reviewers?

So I'm testing this on a box with SME enabled but after loading the
crash kernel, it freezes instead of rebooting. My cmdline is:

 kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+ --command-line="maxcpus=1 root=/dev/sda5 ro debug ignore_loglevel log_buf_len=16M no_console_suspend net.ifnames=0 systemd.log_target=null mem_encrypt=on kvm_amd.sev=1 nr_cpus=1 irqpoll reset_devices vga=normal LANG=en_US.UTF-8 earlyprintk=serial cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"

and the reserved range is:

[    0.000000] Reserving 256MB of memory at 3392MB for crashkernel (System RAM: 16271MB)

I'm wondering if it is related to

https://lkml.kernel.org/r/20190604134952.GC26891@MiWiFi-R3L-srv

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
