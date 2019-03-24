Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280ADC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91AB222C5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HbO+O/Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfCXNHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 09:07:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:42645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfCXNHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 09:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553432843;
        bh=ghE7C3MmCEdxxtqwqprr06LXPWDQGdGSEmqxheIys3k=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=HbO+O/UoAM3RsVD6nra60HG9gYcRyzKpS7aF4/4+lwK3spoRFZUhyXme4pENPP20k
         obmQqZ6q6dzWo2wcx1z0afb7YIZdGBfFo1zWEIqND0qLm8kgTrAGiNa+B0gc88aCtM
         lN6V7h1yxu3W7r5GWaqoJweMH6PETrB6Q/X5qJ9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hades ([185.6.148.228]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MNqfr-1h52yP3OSB-007Rmt for
 <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 14:07:23 +0100
Message-ID: <624bbdbb24ad7db69be29956cbf14689fd003cdb.camel@gmx.com>
Subject: Debug scsi message in linux 4.19.31
From:   Hussam Al-Tayeb <ht990332@gmx.com>
To:     linux-kernel@vger.kernel.org
Date:   Sun, 24 Mar 2019 15:07:21 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GxHDMKG/f4D1oFQrseUp8yGyo+gdfRpKNHRNCoQTOCRUmpgaukX
 ui9GlTpFvqh1YCNI5MgFWTqEbLOooOX9ttz81dyw5jvgREn4etWz7ZzmUKwhHzFxYYxhpuc
 rs1pW94ibBVdgXnR5Pym5FTDmiD8K7ek744Kc0Cy4dXw/hkx3eIo4/vSSfONnpTe/bwkZC3
 BLcNgzlflks5kUVdeQRjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iRQTzXiqhUw=:paTNs18gp9zmIbb9cmYPcn
 NRfnfurf0iAD8Fs+lZNaqlGCdG+ZVucBtd3wpUYJRwRObC6ycOPHWbBt9Vfq9irZvPUEmOonE
 FQcFOWABbGv6r4nhZF6xxVEHR29MgbkXEXD5KSfCEbm7XxIPoajFXrSLAPFV+1KifiPwQmMhL
 rL+Fkzi7CL2i03eKrD3yM7oc9TuQUJU7XQ54kOrE/F6E1AOwmpFRFGOgRZ+pk/1dLKSmQ8V5w
 N7z6hqDiZvGS9X+19esPTCUBXrhhx08TSzrFsDftWRZXtkB4DCo+NoAE5pnOFbqFp1/gqyhi7
 mjALtaw25bMdBGT3UNAQckyDL9xVZp5O7cfZo4Df4XVI1KkAHyadxIYw/OtL8mUbUBCtk0MzH
 8pK2qSz+LJHzd8VpLOT0NIEvmc1TNXTE3nR3oo8nFsXNT0eK37h9s6L0yyRWXfj6pzBEOSfjj
 oq8K3zIAiywd7Fs9VItninOxYSRMOFMu0uIhDsz5Zo/Y/FnWoXh8vbMIbchEKsMdIYGI1FNsM
 bCqILuOatFx4GrK20iwTx4CyY2hE6Y1qCdZ+h94LvrWN6wE5oXQmvKg3xHtJnlPs6sEIm3BMb
 th/RBl7Kd1cr57oJN3P3X2BAfHC8DviyCmGvgST7DeN2Reu6LhRpuZdb0YKIzFW9yzgjrw+lc
 ZQWfxq9NqMHVSC/3y1DuNA02a+Ja7unnUMhuUeMsEytNS7TPUU+IzvJFgR/qbv3aZeNk99Lyg
 nCCxe+ZK2NaNNvIOs/MFaB0WLbdix6cVhekjW7J0rQfJGjrDSD/v79qzVHPZU9sX+txjS8JdZ
 Zuaf/xsToanLFHxAxrDZ1MgdKGVUFOn4VtUjiu83/f2Gk7/lvfO7Zp6vTHXW5529lIlzP5O78
 kS0CutiGgcpEnPAWqDLjLpHK2DbjankEza5Ns4+VFzzsSAi3pLG01A/R5YNZ17zQ9BGwJT28t
 3XkIdcPvSfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I'm seeing a debug message in linux stable kernel 4.19.31 with this
patch
scsi-sd-optimal-i-o-size-should-be-a-multiple-of-physical-block-
size.patch

I am getting:
Mar 23 17:40:10 hades kernel: sd 0:0:0:0: [sda] Optimal transfer size 0
bytes < PAGE_SIZE (4096 bytes)
Mar 23 17:40:10 hades kernel: sd 2:0:0:0: [sdb] Optimal transfer size 0
bytes < PAGE_SIZE (4096 bytes)
Mar 23 17:46:43 hades kernel: sd 4:0:0:0: [sdc] Optimal transfer size 0
bytes < PAGE_SIZE (4096 bytes)

sda and sdb are physically attached SATA mechanical disks (Western
Digital and Seagate, respectively).
sdc is a kingston usb flash drive. All three disks use ext4 luks
encrypted partitions.
Is the fact that it is reporting 0 as optimal transfer size something I
should worry about? Note that the the three storage devices are from
three different manufacturers.
This particular machine is a Lenovo Intel(R) Core(TM) i5-6400 CPU @
2.70GHz with 16GB Kingston DDR4 ram.

I tried moving the root disk to another machine (a DELL Core I7 7700
with slightly faster ram from Samsung) and I saw the same message.

This seems like a patch that fits better in a hardware vendor or
operating system distributor tree than the upstream kernel. Shouldn't
stable tree kernels only contain direct fixes and regression fixes?
Does it really belong in an LTS kernel?

Please CC me in your reply as I am not subscribed to the list.
Thank you.

