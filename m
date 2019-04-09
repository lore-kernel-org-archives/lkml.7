Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF11C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AB320857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDIUyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:54:55 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:58298 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbfDIUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:54:54 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id DxlZhRJXuiLOmDxlch53S7; Tue, 09 Apr 2019 22:54:52 +0200
Message-ID: <023f28b1990577648c33281e1f4588d0abc8aa69.camel@tiscali.nl>
Subject: Re: CONFIG_* symbols in UAPI headers?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Christoph Hellwig <hch@lst.de>, Jie Zhang <jie.zhang@analog.com>
Cc:     Mike Frysinger <vapier@gentoo.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Apr 2019 22:54:49 +0200
In-Reply-To: <10ca99831556bed2849e16caa5a4810628dc320c.camel@tiscali.nl>
References: <20190408124640.GA607@lst.de>
         <10ca99831556bed2849e16caa5a4810628dc320c.camel@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAfFDH/8l/gdX5Z/nU3yD7Q9gZAmeeCNsjPAX+xaubSqHFnEx7wdLCdrmFUf6RAfLRlLGqpDuiBgLI+ce56lETx4JzdhZXliWy+Cvryp+M3HT6rQwOP/
 5GkeDK0ibh7xbTIfewzMhoSxd17G4G84kTd1im5rYilsSS7WM7aOrSs9ppiv++K6QFxVLudhaTlomskflGP391ya6xDIUSaTolsvyI8FyWzkRoZmm0kNNHYi
 TM4WkOLnMI59vzQGXyNyedqmbUPMTxu3G7JmsmNDPaBDucfrFpOEqW/TC7BB01/5y6HghRj3OLe3D2yRK297JMwPsdfSTuY9ECGQmPvf9z0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Bolle schreef op di 09-04-2019 om 21:11 [+0200]:
> Does it still apply?

It does, cleanly. Output is (for v5.1-rc4):

./usr/include/asm-generic/fcntl.h:119: leaks CONFIG_64BIT to userspace where it is not valid
./usr/include/asm-generic/mman-common.h:22: leaks CONFIG_MMAP_ALLOW_UNINITIALIZED to userspace where it is not valid
./usr/include/linux/elfcore.h:62: leaks CONFIG_BINFMT_ELF_FDPIC to userspace where it is not valid
./usr/include/linux/flat.h:17: leaks CONFIG_BINFMT_SHARED_FLAT to userspace where it is not valid
./usr/include/linux/atmdev.h:104: leaks CONFIG_COMPAT to userspace where it is not valid
./usr/include/linux/pktcdvd.h:37: leaks CONFIG_CDROM_PKTCDVD_WCACHE to userspace where it is not valid
./usr/include/linux/raw.h:17: leaks CONFIG_MAX_RAW_DEVS to userspace where it is not valid
./usr/include/linux/hw_breakpoint.h:27: leaks CONFIG_HAVE_MIXED_BREAKPOINTS_REGS to userspace where it is not valid
./usr/include/linux/eventpoll.h:82: leaks CONFIG_PM_SLEEP to userspace where it is not valid
./usr/include/asm/auxvec.h:14: leaks CONFIG_IA32_EMULATION to userspace where it is not valid
./usr/include/asm/mman.h:7: leaks CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS to userspace where it is not valid

Which suggests it might be doable to silence these warnings.


Paul Bolle

