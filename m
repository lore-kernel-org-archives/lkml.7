Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E77C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F8620675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551988490;
	bh=FRxuCqVKPaG/zFaa/oNLybwsGS6u2nHZWwOLRwFXRJI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=x/VZdGHN3tlmM2gM//ogHDAyRgBRxejzIJgTa4L88pnzJKOzw6Rg3zuDXrJ1VPHXS
	 39kKvgdGqhbLlRwbYBaOm+HBYPbMRYrzkThkLF93GzWobPZhf1NR9/YY/VWRMTo3kp
	 m9F4aDSMRQS3rY+C65BSoLDnl8adE7eOxjDmAtSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfCGTyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:54:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:54:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so18892457wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RYjiYyeyuiqbed1VSGA4wCf9tAmEHyYTNRs+HWwVlyM=;
        b=jRAY0NvqBKW77yEAFfRWy+1RbsFJd+ibnbyYKmRKXn/4bXJSLz/Ydf5RL0YVRbTUxE
         JHyBjUs2Clsy8CzK+MSVYzEdpSQ3zPtNIPSapv4njKiqKGxBaPn4LODbN0hqiQUSTw0+
         SH2THOZV9Jr/hGEyo9klLR1QSJCFSiQrVSiK8JoNLhbIjRcI2gwmo9J0tO73G/3yAs+w
         fOIP6Q+JnSjNTcG4AaFKC3ZATGghcc/aypwQlSijQgu13oBlOrtY/96tTXHNmLZynLyX
         mflBGA1evLqylRTTBOoUaCxgFy8ijzxW9pBxtpOHIdOiuDAU0Oj4kFWhQsoZJiHdfO/b
         gfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=RYjiYyeyuiqbed1VSGA4wCf9tAmEHyYTNRs+HWwVlyM=;
        b=hzZZ20GmEuUNjSi/kIcVv3qUzCAqi20zOCQ/qfBhRXVvIAEaxK7ZUKQyQX/K8yveSC
         yScda5+3BsRzR13JJya4pPMXnrdRTJ4sKdUIGJp8/4XwB50Y2F2ZgcEPfUuK8j+E0A5Y
         D8+IznwEkXczQs8zeL1xDn7cbqvgcuFTcNaKjy66SMLzCMcnl/TJjBBvVSt6/SyKif3i
         4nYH0VKMGQ/hsVk2OfnEotNTjENKkDJePquqF54mmEbmXqr4XD8J2Ky4kULVsi5HPZCG
         b35pWv68cPZR0c2uCAd/4eW+RCdb8HFDz1h5xxgdzkttwHjjw4EjT0GMVrT9k2lox0J8
         Meog==
X-Gm-Message-State: APjAAAWSdARDqD7dkQGnVQrzRufL7AZAu+OcKysPE7ABvjF+1HAXOsZ2
        jefWTXZXawQUtuAH1hbsR04=
X-Google-Smtp-Source: APXvYqyPq3GiKI2eNvDCQYpznP71+eYQgBElgRh3rUCUKND/acxnGH3QnT95PhI6h6ghsP8YmMnU9g==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr7891609wrx.134.1551988487433;
        Thu, 07 Mar 2019 11:54:47 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i13sm6852875wrm.86.2019.03.07.11.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 11:54:46 -0800 (PST)
Date:   Thu, 7 Mar 2019 20:54:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform change for v5.1
Message-ID: <20190307195444.GA99563@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-platform-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

   # HEAD: 1c034a2fe56061af439c4e74f8f6c08e3714a730 x86/defconfig: Enable EFI stub, mixed mode and BGRT

A defconfig update.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      x86/defconfig: Enable EFI stub, mixed mode and BGRT


 arch/x86/configs/i386_defconfig   | 2 ++
 arch/x86/configs/x86_64_defconfig | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 4bb95d7ad947..5d946f4a881f 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -310,3 +310,5 @@ CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_CRYPTO_AES_586=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_EFI_STUB=y
+CONFIG_ACPI_BGRT=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 0fed049422a8..300ad569d6a7 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -308,3 +308,6 @@ CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_EFI_STUB=y
+CONFIG_EFI_MIXED=y
+CONFIG_ACPI_BGRT=y
