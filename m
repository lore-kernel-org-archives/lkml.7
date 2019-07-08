Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A793C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC29D20861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562591378;
	bh=5RABCSg6zQ/zkckj2LGiZOXyqo+NP/aDcMx2k9MQ99I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VBmncxf0/lRx9XoU/H+XQvdYSishs93sLJByLHpGM/lxlesMl/0/xOg+Ci65DUrE2
	 VswGvFOgOuNsFhWqBFs0wZBKY3cgD1Kdy91dN8q2mn/91Oz3dk16Jw+Vkax8pFy6m9
	 Cm0o0FGp9IZq1p0u7ub6ZaxbXZUq5KzbJBXhSRPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfGHNJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:09:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37191 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfGHNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:09:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so7886833wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UO7iPLw+d+5QAs8mC/kWdHfLAJ0gNwYKBpQVZICrKZc=;
        b=Ja7erGRhyrF8CaiN4Nc3p6Txnnb0+w5ZSAGxxOHUQeCkowQm8hSj/QcOt7rK2DUHPn
         pTvTWDNhiKjVZxlUdsSEQ74aFmuWTjc+f8+mCzW9o/FqpWRHDOx4E4pIbSi704YrGf/U
         nQ27LDuIXMOZlCO9QHuySkcU3soDgYWbB5iE4YUhQXl0wV33SNwPhHREP1ymZBuZQEtL
         r/QBe3c3cflL7gIT0oIVl55IWCoC0FA2uPMcSrj3vXGZnGuPISH70jzKFXY0NVZ0aabE
         mKrPF8YWEvpOZPYPkX7oueAUql579H8amBJ2+YGSsuVIbeK+JxXXwvFy4T8fD/g/GBqD
         jV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=UO7iPLw+d+5QAs8mC/kWdHfLAJ0gNwYKBpQVZICrKZc=;
        b=g7bi+0Y4/9Iqu4Ibm4pyktW9QyRBgb8f8LKvmu9HDVQMQ5kUGN8GspbAVuXGJMLwvw
         3f6NdFbeM4SK5lvmeGAdDslj7MEhkT9LKtjFd3MhhCpUYJepU4+4f56tlQr2aUHMCGyk
         EMfVtjifRJoRZHrHIHgMa3Pw9rCPbtoJUiKzJuM1FVD/8ASMM427iWOFcM99BS6eJDj3
         j33cXxKhIe58nC+nOdYX4514r3GzP45bpDMkNwm/8lf1aA7s+Ing8wk7rGMnF8xeDHFj
         NwOsptLamooG1cnCCYSpSMc9V1T9iteKoA0f9Fn+hWnyFlM1E+9Nk9xK0e95v+lHJHx8
         9Lvw==
X-Gm-Message-State: APjAAAWKl4osvjKpwWugVTSntSo2rj8VOlHuChd/hMckPpe5RHreTv33
        +vSpYlmqVctod5k4tK3JZTs=
X-Google-Smtp-Source: APXvYqxdCGyPVaCqWSVnAqEMtDJc8RdZxxWY2BXz6oiuaezqsX4+21LAypkOwcATQPcgonU7xICcHA==
X-Received: by 2002:adf:fdd2:: with SMTP id i18mr14224870wrs.125.1562591374276;
        Mon, 08 Jul 2019 06:09:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e19sm8979425wra.71.2019.07.08.06.09.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 06:09:33 -0700 (PDT)
Date:   Mon, 8 Jul 2019 15:09:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/build changes for v5.3
Message-ID: <20190708130931.GA100057@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: 87b61864d7ab2aec5c212ff18950d4972f0dfb4e x86/build: Remove redundant 'clean-files += capflags.c'

Two kbuild enhancements by Masahiro Yamada.

 Thanks,

	Ingo

------------------>
Masahiro Yamada (2):
      x86/build: Add 'set -e' to mkcapflags.sh to delete broken capflags.c
      x86/build: Remove redundant 'clean-files += capflags.c'


 arch/x86/kernel/cpu/Makefile      | 3 +--
 arch/x86/kernel/cpu/mkcapflags.sh | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 5102bf7c8192..50abae9a72e5 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -54,8 +54,7 @@ quiet_cmd_mkcapflags = MKCAP   $@
 
 cpufeature = $(src)/../../include/asm/cpufeatures.h
 
-targets += capflags.c
 $(obj)/capflags.c: $(cpufeature) $(src)/mkcapflags.sh FORCE
 	$(call if_changed,mkcapflags)
 endif
-clean-files += capflags.c
+targets += capflags.c
diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index d0dfb892c72f..aed45b8895d5 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -4,6 +4,8 @@
 # Generate the x86_cap/bug_flags[] arrays from include/asm/cpufeatures.h
 #
 
+set -e
+
 IN=$1
 OUT=$2
 
