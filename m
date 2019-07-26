Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA16C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFBD218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfGZQON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:14:13 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:50471 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbfGZQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:14:13 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id r2qwhnCKBqTdhr2qzhaRsR; Fri, 26 Jul 2019 18:14:11 +0200
Message-ID: <618de21a4510f20f1b38a894517b5e9011f0da69.camel@tiscali.nl>
Subject: [VDSO] [x86_32] v5-3-rc1 needs vdso32=0 to get systemd-journald
 running
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Jul 2019 18:13:54 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAGaDAyiZZkOmvJFn9gtgZfobwcqOOgxK+HtrZ5++aoJdMNtArqs+boMM81ycHkMCcOf0k4ygQZaCu1OKmp/vZt5/HpaKmkaXXOYxXohp87xjL1XFQDk
 0dkTqMBDnEn3niXbryC2mQYHh3qySaYQpbPRv5Ie7lmq76kt/H0HFDwOWggstGteKeE0nSFj01OQhWJJ2OrKogU3GMPPmX0g5IYG28MH55z7BRVOz+ZJle/0
 UhUe/BerILihsJYsSUfolk+r/SiPFXFoXdgMDjLfcPFPMPI++05pR0I00s6VXjMinLnES7cfWRwclSziCnGyFkZqo10uE9Gh9OhGKwuNVLZwLlx5cwzg8NZG
 4Vgg4lHF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My first attempts to boot v5.3-rc1 on my (ancient) ThinkPad X41 made systemd-
journald crash. I kept ending up with nasty my messages on the console:

         Starting Journal Service...
[...]
[    7.143552] systemd-journald[213]: Assertion 'clock_gettime(map_clock_id(clock_id), &ts) == 0' failed at ../src/basic/time-util.c:55, function now(). Aborting.
[FAILED] Failed to start Journal Service.
See 'systemctl status systemd-journald.service' for details.
[    7.220367] systemd-coredump[217]: Cannot resolve systemd-coredump user. Proceeding to dump core as root: No such process
[  OK  ] Stopped Journal Service.

And without systemd-journald I couldn't get userspace up and running.

A bit of tinkering showed that "vdso32=0" on the kernel command line allows me
to get a usable userspace.

Any idea where I should look next to pinpoint this?

Thanks,


Paul Bolle

