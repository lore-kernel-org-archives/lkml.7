Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9569BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B7C21670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568637301;
	bh=m1r5sM7OVOJ5bBrCKEsRDWGy/YYajIIN1WiAT8Un6o0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hhIxavJUT9wKWqze44mgVdY9E1WYJAPlk7gLHRBYdjlrklW79VAv9/LkGvaFwAbSt
	 GPecaP+sz7gJzuMo3QnxGP5s9SmzcDtY7DgfAgkky3VXpucyKvyjzIFQB8gbKDxeaQ
	 dqf/qZSAgKdz9LCDfRhEceiaY8rnotWdmBwZBJHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfIPMfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:35:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43523 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfIPMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:35:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so34002673wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xEZM0yBEjLMD2Uc4K5FOXSSa/FQl2fIXlG8Ls9199s4=;
        b=drTlVZLybfiHlRCdUAJncMb9AWWgsvj4YvLIyuTJAUTG1Xur8GiDP26WIA39XFQio0
         Z+h6fvaBkrK8HWGnBMBCZkeCWcadFNY/K2308f1T378rK4Az5t6CnR1r6SdklW2ZaBNF
         AD4MzCEHW7gn8fN+Tv0+J+6qME3NmRKIyoiY17zYIi/n7FL5nEjBVXdClNWLxhjLXXJ1
         W7dN4yOlJmFt6uaUdp2PWqn04frN1JENxbbDMNyjusFbmRPmXUnA6UmjMl5ejcRsF9Bw
         JCZSgmKr30VXbND4JQuIB3doyhN7jG/kUWtQ6RcWY7wqyRQl4bzba7NhUPDtVjJJ8wTf
         kRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xEZM0yBEjLMD2Uc4K5FOXSSa/FQl2fIXlG8Ls9199s4=;
        b=UCtwhrfw+T+K0Ldl7V+OJB9v8H3Kb2AWoSy7ML2dg/3vC5pNf3+R1Od/sNnB494fVp
         Key1l8VqOd2QVBpX42UwfNV86UwO7Xxu9Bn6aQXM2KSSe+7GGNxpdUYyLOTFt1cTAxYY
         d47M5e6I+4u1E5bsyoOlTo3pLY6NWMWDWyBjogrCooX9XWQsYwmYhuZb5n7Csk8GpFJ3
         llOwKUj2MUDCB4i2A17jngbLusme3Eb34xRsBnBB3girrza2qfWzPgdQip5loGY+cJ8y
         wj95QW+gp7g5T3bcVi3FX4NAeTdTfToEsUAO3hcsmrcA0amHKhctd8cBhz9QXF7dBdNT
         Q79w==
X-Gm-Message-State: APjAAAXkFQcqupIqwmrYNRgM/N2bYB4zVmMVnsI1lVFc37sQDBBkfe89
        QejDYTKy1sL1XP8zAyQQbmE=
X-Google-Smtp-Source: APXvYqwSWZoO6Z8nt3EhVO35ctsZGk9cxFs24AWUJ/swrSnx+4eYi5DquRoTBAsfNm4zlgb3xBZ6ZA==
X-Received: by 2002:a05:6000:188:: with SMTP id p8mr8891931wrx.220.1568637296751;
        Mon, 16 Sep 2019 05:34:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i14sm16571475wra.78.2019.09.16.05.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:34:56 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:34:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v5.4
Message-ID: <20190916123454.GA24902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: e86c2c8b9380440bbe761b8e2f63ab6b04a45ac2 x86/umip: Add emulation (spoofing) for UMIP covered instructions in 64-bit processes as well

The changes in this cycle were:

 - Add UMIP emulation/spoofing for 64-bit processes as well, because of 
   Wine based gaming.

 - Clean up symbols/labels in low level asm code

 - Add an assembly optimized mul_u64_u32_div() implementation on x86-64.

 Thanks,

	Ingo

------------------>
Brendan Shanks (1):
      x86/umip: Add emulation (spoofing) for UMIP covered instructions in 64-bit processes as well

Jiri Slaby (2):
      x86/asm/suspend: Get rid of bogus_64_magic
      x86/asm: Make some functions local labels

Peter Zijlstra (1):
      x86/math64: Provide a sane mul_u64_u32_div() implementation for x86_64


 arch/x86/boot/compressed/head_32.S |  4 +--
 arch/x86/boot/compressed/head_64.S | 18 +++++------
 arch/x86/entry/entry_64.S          |  4 +--
 arch/x86/include/asm/div64.h       | 13 ++++++++
 arch/x86/kernel/acpi/wakeup_64.S   | 10 +++---
 arch/x86/kernel/umip.c             | 65 ++++++++++++++++++++++----------------
 arch/x86/lib/copy_user_64.S        | 14 ++++----
 arch/x86/lib/getuser.S             | 16 +++++-----
 arch/x86/lib/putuser.S             | 22 ++++++-------
 9 files changed, 96 insertions(+), 70 deletions(-)

