Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD532C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F181218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqIRqg1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfDWWtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39457 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfDWWtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so15002257ljg.6;
        Tue, 23 Apr 2019 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFAcF+BNJAUspNATnW1zZ1un5px4lM5fhU2ckCqOLfU=;
        b=uqIRqg1RjFNLtTkHdroYCCfX3hLuyGL5DDMo1x9QQHSQSGSRS5qzObRovEnyXQ1/zE
         FTy/qxX/kLTiS2sxTmJHK8WgKYjp7yneJyNe3tdwOJtS2jBKkMkjUzahG3QnG1dSvmLj
         CM1QFUj2MP1o6TZAxfeeaBFFTKHrNMh4++g9nVp28iVHW7eGXsJXTPK32ioKiaXMTlpP
         6IfbbYkYfMGKvaXj3TgKGLSordovkXdTWSH+IqndUWhh+Z3xMM+KC763ZIU6IcszCk/6
         ySM2s2zVLgso4EHhsEnN7y7F6+8PRuGQlF/buTpXBnLJXmtbYOxR/pYijuk0asOrA2L4
         XR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFAcF+BNJAUspNATnW1zZ1un5px4lM5fhU2ckCqOLfU=;
        b=nWKu4Q1ZwIa0YLHwATGddQEtugDE1z4FvLO4qsWPTfETVMbSZip45rt4Ey6HGt6h3P
         sBTjQybLN0K7BRm1VOVfSkJitXOwj9J4svbTkHCXmw+x/NNlOsSot4ptgMqz2tNv+oX3
         hxRFHdevKBWklszrLzqiv1TAYREa5/wySKMc+x12YcSe2x4WF+TCuWx6P/10bkWljlQb
         w1e+8aAmeaK1GCVd0IwRMYu6PbzO4PX/sDyAqhBRmvPOSzRlJdLWcKl6Aoigt83xd5Lz
         phlKcecyEp6IUCB+xtfihysyFNOmttnQyx0o6+AMgARUaH6MN8ExaCa8vVbuudfi5snS
         /mQA==
X-Gm-Message-State: APjAAAX4rhsXCCoUnKXExV+YaGbcXnNghyM6hUBv6LABZP0vhDMkw/Fa
        1TAQGtNMcRbEId1saBr5FFc=
X-Google-Smtp-Source: APXvYqxrJla13/QY5XcjVmsD+3mKA6DpwhKSbOeaIHJPhSl4jAZ0vBJf8k8SZ85FOT+TRef1iQU5Sw==
X-Received: by 2002:a2e:8446:: with SMTP id u6mr15394840ljh.71.1556059740001;
        Tue, 23 Apr 2019 15:49:00 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:48:59 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 00/12] mips: Post-bootmem-memblock transition fixes
Date:   Wed, 24 Apr 2019 01:47:36 +0300
Message-Id: <20190423224748.3765-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First attempt of making the MIPS subsystem utilizing the memblock early memory
allocator was done by me a few years ago. I created a patchset with
21 patches [1]. It turned out to be too complicated and I decided to resend a
reworked patchset with smaller number of changes [2]. I did this and after a
small review process a v2 patchset was also posted. Then my spare
time was over and I couldn't proceed with the patchset support and
resubmission.

In a year Mike Rapoport took charge in this task and posted a small
patch which essentially did the bootmem allocator removal from MIPS
subsystem [3]. A single small patch did in general the whole thing my huge
patchsetes were intended for in the first place (though it lacked a few fixes).
Mike even went further and completely removed the bootmem allocator from
kernel code, so all the subsystems would need to use the only one early
memory allocator. This significantly simplified the platforms code as well
as removed a deprecated subsystem with duplicated functionality. Million
credits to Mike for this.

Getting back to the MIPS subsystem and it memblock allocator usage. Even
though the patch suggested by Mike [3] fixed most of the problems caused
by enabling the memblock allocator usage, some of them have been left
uncovered by it. First of all the PFNs calculation algorithm hasn't been
fully refactored. A reserved memory declaration loop has been left
untouched though it was clearly over-complicated for the new initialization
procedure. Secondly the MIPS platform code reserved the whole space below
kernel start address, which doesn't seem right since kernel can be
located much higher than memory space really starts. Thirdly CMA if it
is enabled reserves memory regions by means of memblock in the first place.
So the bootmem-init code doesn't need to do it again. Fifthly at early
platform initialization stage non of bootmem-left methods can be called
since there is no memory pages mapping at that moment, so __nosave* region
must be reserved by means of memblock allocator. Finally aside from memblock
allocator introduction my early patchsets included a series of useful
alterations like "nomap" property implementation for "reserved-memory"
dts-nodes, memblock_dump_all() method call after early memory allocator
initialization for debugging, low-memory test procedure, kernel memory
mapping printout at boot-time, and so on. So all of these fixes and
alterations are introduced in this new patchset. Please review. Hope
this time I'll be more responsive and finish this series up until it
is merged.

[1] https://lkml.org/lkml/2016/12/18/195
[2] https://lkml.org/lkml/2018/1/17/1201
[3] https://lkml.org/lkml/2018/9/10/302

NOTE I added a few "Reviewed-by:  Matt Redfearn <matt.redfearn@mips.com>"
since some patches of this series have been picked up from my earlier
patchsets, which Matt's already reviewed. I didn't add the tag for patches,
which were either new or partially ported.

Serge Semin (12):
  mips: Make sure kernel .bss exists in boot mem pool
  mips: Discard rudiments from bootmem_init
  mips: Combine memblock init and memory reservation loops
  mips: Reserve memory for the kernel image resources
  mips: Discard post-CMA-init foreach loop
  mips: Use memblock to reserve the __nosave memory range
  mips: Add reserve-nomap memory type support
  mips: Dump memblock regions for debugging
  mips: Perform early low memory test
  mips: Print the kernel virtual mem layout on debugging
  mips: Make sure dt memory regions are valid
  mips: Enable OF_RESERVED_MEM config

 arch/mips/Kconfig                |   1 +
 arch/mips/include/asm/bootinfo.h |   1 +
 arch/mips/kernel/prom.c          |  18 ++++-
 arch/mips/kernel/setup.c         | 129 +++++++++----------------------
 arch/mips/mm/init.c              |  49 ++++++++++++
 5 files changed, 102 insertions(+), 96 deletions(-)

-- 
2.21.0

