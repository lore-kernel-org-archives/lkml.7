Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB229C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D48522527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebC2n5Jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfLKTqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:46:39 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48951 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLKTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:46:38 -0500
Received: by mail-pl1-f202.google.com with SMTP id v12so1830283plp.15
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xTTAjJf21FVVJPXeayVLtKF3IlyrepWpUnexj9VEhJs=;
        b=ebC2n5JyjeehjclWkWSRXyOR7TPsVZVOBkzoZavzbWVbuvVk6Hp8HYxp2OOqkmC+ez
         aOFsny+7gZ9si0XiJvk+i/xDtoxTzZqUTaohUpkO1ajuQ2CethlGM8XFiRwKl+fSOuEd
         T+5DW/4a72q/nViyS8t61thMzb2lu11vcF235Fxd9qdi8B3LtHEE71qX4YspvvBp/jFg
         K/zDE7Eezi84kn9t0JAen4KWjBdYwxyRqtcSK5I5W33Bpg6ky+F1LaWDQ0m2K1fxd+u1
         qKXsq1WeyawYtQwDd0Ixxn1U+YFpw/zFXoXyN+Z+zLLhzRAOPDnSgHP/DaRinnJ04Eye
         26Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xTTAjJf21FVVJPXeayVLtKF3IlyrepWpUnexj9VEhJs=;
        b=ZV6uSc8Z7vbKQM8uu/yOtSpcrvO8yrJnf+Ul2ILLJa+LLbtr3r0ArKxX7dB7BWSF5L
         7k5nVl6yEPur8Ns2MYng/r1YFsF6aj+uGB/zOcnQZyJIDXP6puZeq/cOFDQFhzOxyz2W
         sZQTxpY4NRl5GH+oXXjRX53BQ+l0EOX0YTwXxLZDB1aWpPlRYR84fUXqAKEVBYPZdmHJ
         TqqgGma+X9pNK5IrSN5q6K1t9vFdS0UwWXjJxwOa6o0IzmvyTOdogERcbz0lhKJv7g7w
         Xpad50XE1stu3lPordHfc5ppNl5hDNFvcHlrsJrYlP6quWVVVo7bJ1gD5CMe8HRYtVnL
         Kl8w==
X-Gm-Message-State: APjAAAX+UVfia09FaPAfELWvKV8Bk/Nw0jsmCkrfghrzw/fJkToOVsD4
        V3FPcnVHuursWD2Brws/UoIRC2j8
X-Google-Smtp-Source: APXvYqzum264DGIMoJbIoYDlLehggfMENzp1eoSv/AtM2VQGSLXKj3lGJHxjgd3af7xpXcw+E2S6hiPC
X-Received: by 2002:a63:1106:: with SMTP id g6mr6000325pgl.13.1576093597574;
 Wed, 11 Dec 2019 11:46:37 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:46:03 -0500
Message-Id: <20191211194606.87940-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH 0/3] iommu/vt-d bad RMRR workarounds
From:   Barret Rhoden <brho@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

Commit f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in BIOS is
reported as reserved") caused a machine to fail to boot for me, but only
after a kexec.

Firmware provided an RMRR entry with base and end both == 0:

	DMAR: RMRR base: 0x00000000000000 end: 0x00000000000000

Yes, firmware should not do that.  I'd like to be able to handle it.

That bad entry was actually OK on a fresh boot, since the region of
0x0000..0x0001 ([start, end + 1)) was type RESERVED due to this e820
update call:

	e820: update [mem 0x00000000-0x00000fff] usable ==> reserved

However, after a kexec, for whatever reason that first entry changed from

	BIOS-e820: [mem 0x0000000000000000-0x000000000009cbff] usable

to

	BIOS-e820: [mem 0x0000000000000100-0x000000000009cbff] usable

It starts at 0x100, not 0x000.  Ultimately, the range for that bad RMRR
[0x0, 0x1) isn't in the e820 map at all after a kexec.

The existing code aborts all of the DMAR parsing, eventually my disk
drivers fail, I can't mount the root filesystem, etc.  If you're
curious, I get a bunch of these errors:

	ata2.00: qc timeout (cmd 0xec)

I can imagine a bunch of ways around this.

One option is to hook in a check for buggy RMRRs in intel-iommu.c.  If
the base and end are 0, just ignore the entry.  That works for my
specific buggy DMAR entry.  There might be other buggy entries out
there.  The docs specify some requirements on the base and end (called
limit) addresses.

Another option is to change the sanity check so that unmapped ranges are
considered OK.  That would work for my case, but only because we're
hiding the firmware bug: my DMAR has a bad RMRR that happens to fall into a
reserved or non-existent range.  The downside here is that we'd
presumably be setting up an IOMMU mapping for this bad RMRR.  But at
least it's not pointing to any RAM we're using.  (That's actually what
goes on in the current, non-kexec case for me.  Phys page 0 is marked
RESERVED, and I have an RMRR that points to it.)  This option also would
cover any buggy firmwares that use an actual RMRR that pointed to memory
that was omitted from the e820 map.

A third option: whenever the RMRR sanity check fails, just ignore it and
return 0.  Don't set up the rmrru.  Right now, we completely abort DMAR
processing.  If there was an actual device that needed to poke this
memory that failed the sanity check (meaning, not RESERVED, currently),
then we're already in trouble; that device could clobber RAM, right?  If
we're going to use the IOMMU, I'd rather the device be behind an IOMMU
with *no* mapping for the region, so it couldn't clobber whatever we
happened to put in that location.

I actually think all three options are reasonable ideas independently of
one another.  This patchset that does all three.  Please take at least
one of them.  =)  (May require a slight revision if you don't take all
of them).

Barret Rhoden (3):
  iommu/vt-d: skip RMRR entries that fail the sanity check
  iommu/vt-d: treat unmapped RMRR entries as sane
  iommu/vt-d: skip invalid RMRR entries

 arch/x86/include/asm/iommu.h |  2 ++
 drivers/iommu/intel-iommu.c  | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.24.0.525.g8f36a354ae-goog

