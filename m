Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD1B207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574692230;
	bh=AJPq8iM8XKX35GeEM/v+3PL7IYZTj8lHeZoM6KqMLx4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=LUOjv4D6CDeuSkAV1hqdp5Z9FODZUv7u5muKmo7rX58VZZLsGSX5VBpJdt2VZBy3A
	 vrakaCiCOgplJnD8wuGXIgTWBRGzLR89h5T08XTV76vLo50M1xVUkg7okTQf/oVWyz
	 47cKxcCQXHCiOAhRKqBr4WaxqDkRAR6tdcV2gn4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfKYOa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:30:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51777 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:30:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so15391934wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HsN9w+fDw5MnFSUDoKFOCnHxeu5TYCyLe2clUa/gQLU=;
        b=FJJ5CxsCOKCIiImHFSffNMF+WPqeHrU1OL/fGmB246Y14SbE3Kh5R+i7Wck4fhjbbx
         7uWYJzF+aAF2NDCi7T6I6ix7j8oKDWzTk0VIBMOGGCmilQEd//JlE+Z9uxrR/YoWg1QO
         KOKcRxUZjRp+eo+8zsCGFXqLTP2BqBtq0zUAbdsAQ3/9qzMWAsdenfDMm/FBl3MdcaRI
         4PPYOYYdbq5wM0e/SS0wtXBC0QrQM2y/rLDre5eBN+FC8iAziX7w6TWyaw/LviwV5Ecc
         yNUSNmqXfsVtg5spDt8/XzOFDdhGUcUG5j9wUAm5fFKMtYjU1SteuodEdgOiXh+YBKM+
         c1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=HsN9w+fDw5MnFSUDoKFOCnHxeu5TYCyLe2clUa/gQLU=;
        b=HqslMT8OPdFX6RLEplKxoBgoIdjhh0Hbt7ltIZih9wCTNgRqsd4JblW4sw3Ty41vWX
         +O60oU255qyI30QEKPNaRblcSPFkpnsi0ugfTXNtHnzD6TpQuiMnVLhkwGtFQ8NLxLtw
         YLzcorb4M+yqgZoaGLQ3Oc6X8+ZCznuxZK3FJObFzj4PYPoqct3JLc+ASnFltlJFEI6/
         WCSwT3WHFQHRV4cwwKTZJiUk/fciPRgNi/FNCyLtdNDoJe1OYac4HWVacxt/zZ0ZuFav
         IUzdIanPrpadPpW973sethWdgnn1gzuEVPkgrhdwIc6KFSBramC+AB2dEPn1sLOHoodM
         t59A==
X-Gm-Message-State: APjAAAW3/a8wMKFuR53kL96ehvjyCouthKD4noZZ4iV/2cJelKnxtvjk
        SFaq+5vEmVTCtcTEqCja2YJZp3JB
X-Google-Smtp-Source: APXvYqw5acLLRPqslG4olW2nK3lZJVciq0/5Hb2YBPaZZIJRnlpFkueLMVAzHv2pTWor8TL8FFfiCw==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr27405206wmh.74.1574692225131;
        Mon, 25 Nov 2019 06:30:25 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b14sm8622429wmj.18.2019.11.25.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:30:24 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:30:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform changes for v5.5
Message-ID: <20191125143022.GA113303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-platform-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

   # HEAD: 7a56b81c474619fa84c60d07eaa287c8fc33ac3c x86/jailhouse: Only enable platform UARTs if available

UV platform updates (with a "hubless" variant) and Jailhouse updates for 
better UART support.

 Thanks,

	Ingo

------------------>
Mike Travis (8):
      x86/platform/uv: Save OEM_ID from ACPI MADT probe
      x86/platform/uv: Return UV Hubless System Type
      x86/platform/uv: Add return code to UV BIOS Init function
      x86/platform/uv: Setup UV functions for Hubless UV Systems
      x86/platform/uv: Add UV Hubbed/Hubless Proc FS Files
      x86/platform/uv: Decode UVsystab Info
      x86/platform/uv: Check EFI Boot to set reboot type
      x86/platform/uv: Account for UV Hubless in is_uvX_hub Ops

Ralf Ramsauer (2):
      x86/jailhouse: Improve setup data version comparison
      x86/jailhouse: Only enable platform UARTs if available


 arch/x86/include/asm/uv/bios.h        |   2 +-
 arch/x86/include/asm/uv/uv.h          |  16 ++-
 arch/x86/include/asm/uv/uv_hub.h      |  61 ++++-------
 arch/x86/include/uapi/asm/bootparam.h |  25 +++--
 arch/x86/kernel/apic/x2apic_uv_x.c    | 184 ++++++++++++++++++++++++++++++----
 arch/x86/kernel/jailhouse.c           | 136 +++++++++++++++++++------
 arch/x86/platform/uv/bios_uv.c        |   9 +-
 7 files changed, 323 insertions(+), 110 deletions(-)
