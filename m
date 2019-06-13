Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05EEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA5E20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393165AbfFMQ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbfFMBSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 21:18:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6C07307C940;
        Thu, 13 Jun 2019 01:18:13 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88DD65C298;
        Thu, 13 Jun 2019 01:18:08 +0000 (UTC)
Date:   Thu, 13 Jun 2019 09:18:04 +0800
From:   "dyoung@redhat.com" <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, lijiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190613011804.GA27786@dhcp-128-65.nay.redhat.com>
References: <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic>
 <20190612015549.GI26148@MiWiFi-R3L-srv>
 <20190612151033.GJ32652@zn.tnic>
 <3dfa5985-008a-20d8-5171-cfe96807c303@amd.com>
 <20190612180724.GP32652@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612180724.GP32652@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Jun 2019 01:18:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/19 at 08:07pm, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 04:52:22PM +0000, Lendacky, Thomas wrote:
> > I think the discussion ended up being that debuginfo wasn't being stripped
> > from the kernel and initrd (mainly the initrd).  What are the sizes of
> > the kernel and initrd that you are loading for kdump via kexec?
> > 
> > From previous post:
> >   kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+
> 
> You mean those sizes?
> 
> $ ls -lh /boot/vmlinuz-5.2.0-rc3+ /boot/initrd.img-5.2.0-rc3+
> -rw-r--r-- 1 root root 7.8M Jun 10 12:53 /boot/initrd.img-5.2.0-rc3+
> -rw-r--r-- 1 root root 6.7M Jun 10 12:53 /boot/vmlinuz-5.2.0-rc3+
> 
> That should fit easily in 256M :)

The final used size is uncompressed size, for example in my case:

$ ls -lth arch/x86/boot/bzImage 
-rw-rw-r-- 1 dyoung dyoung 6.3M May 24 11:19 arch/x86/boot/bzImage
$ ls -lth arch/x86/boot/compressed/vmlinux.bin
-rwxrwxr-x 1 dyoung dyoung 25M May 24 11:19 arch/x86/boot/compressed/vmlinux.bin

The vmlinuz is 6.3M, uncompressed kernel is about 25M, since yours
bzImage is 7.8M, I would expect the final size is around 29M

for initramfs, you can check it by:

$ ls -lth /boot/initramfs-5.0.9-301.fc30.x86_64kdump.img
-rw------- 1 root root 16M May 28 08:59 /boot/initramfs-5.0.9-301.fc30.x86_64kdump.img
$ mkdir tmp
$ cd tmp
$ sudo lsinitrd --unpack /boot/initramfs-5.0.9-301.fc30.x86_64kdump.img
$ du -hs .
46M	.

You can see my kdump initrd is 46M after unpacking.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

Thanks
Dave
