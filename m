Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B12ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE23721835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570569747;
	bh=b2R98nFWJA8KQ9V8pVgOiwJ2juY6CvTkExzj2ehzTIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iTwp/ODmKDECXURd7e3E/jJOEiXkfttCu5mVtz859W7F71D8N8zbnAlBKATn1QSEa
	 NkeZZVS1Im3b4ykQFmDJoPDM2Sk+N7X2kaNrBEmcpyDybQUFClHpeT44H1pFwHBH2s
	 ZgLfGySjb5zYDM6/KyoH7zP9DlaagbSzcJzx58jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfJHVWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbfJHVWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:22:25 -0400
Received: from localhost (unknown [131.107.159.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A71421721;
        Tue,  8 Oct 2019 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570569744;
        bh=b2R98nFWJA8KQ9V8pVgOiwJ2juY6CvTkExzj2ehzTIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vpmmdg5MTkxwa3zXfobJHRUbwnWMiu+EA3sK18sc4ke2+W62vZaJFbZ57kmPBs4XC
         /CibLn3+WkAwGOu528NZN47XvQAOMcgaSH2WvDSLCql7NmQOjuGky5RZxkxFuz8sqE
         wndV0BcOdcpbxhftcdDQNhN6cSrv4059R9xjP+AA=
Date:   Tue, 8 Oct 2019 17:22:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, sboyd@kernel.org, bauerman@linux.ibm.com,
        zohar@linux.ibm.com
Subject: Re: [PATCH v2 1/2] Add support for arm64 to carry ima measurement
 log in kexec_file_load
Message-ID: <20191008212224.GC1396@sasha-vm>
References: <20191007185943.1828-1-prsriva@linux.microsoft.com>
 <20191007185943.1828-2-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191007185943.1828-2-prsriva@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 11:59:42AM -0700, Prakhar Srivastava wrote:
>During kexec_file_load, carrying forward the ima measurement log allows
>a verifying party to get the entire runtime event log since the last
>full reboot since that is when PCRs were last reset.
>
>Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>---
> arch/Kconfig                           |   6 +-
> arch/arm64/include/asm/ima.h           |  24 +++
> arch/arm64/include/asm/kexec.h         |   5 +
> arch/arm64/kernel/Makefile             |   3 +-
> arch/arm64/kernel/ima_kexec.c          |  78 ++++++++++
> arch/arm64/kernel/machine_kexec_file.c |   6 +
> drivers/of/Kconfig                     |   6 +
> drivers/of/Makefile                    |   1 +
> drivers/of/of_ima.c                    | 204 +++++++++++++++++++++++++
> include/linux/of.h                     |  31 ++++
> 10 files changed, 362 insertions(+), 2 deletions(-)
> create mode 100644 arch/arm64/include/asm/ima.h
> create mode 100644 arch/arm64/kernel/ima_kexec.c
> create mode 100644 drivers/of/of_ima.c
>
>diff --git a/arch/Kconfig b/arch/Kconfig
>index a7b57dd42c26..d53e1596c5b1 100644
>--- a/arch/Kconfig
>+++ b/arch/Kconfig
>@@ -19,7 +19,11 @@ config KEXEC_CORE
> 	bool
>
> config HAVE_IMA_KEXEC
>-	bool
>+	bool "Carry over IMA measurement log during kexec_file_load() syscall"
>+	depends on KEXEC_FILE
>+	help
>+	  Select this option to carry over IMA measurement log during
>+	  kexec_file_load.

This change looks very wrong: HAVE_* config symbols are used to indicate
the availability of certain arch specific capability, rather than act as
a config option. How does this work with CONFIG_IMA_KEXEC ?

Also, please, at the very least verify that basic functionality works on
the architectures we have access to. Trying it on x86:

$ make allmodconfig
scripts/kconfig/conf  --allmodconfig Kconfig
#
# No change to .config
#
$ make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      security/integrity/ima/ima_fs.o
In file included from security/integrity/ima/ima_fs.c:26:
security/integrity/ima/ima.h:28:10: fatal error: asm/ima.h: No such file or directory
 #include <asm/ima.h>
          ^~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:266: security/integrity/ima/ima_fs.o] Error 1
make[2]: *** [scripts/Makefile.build:509: security/integrity/ima] Error 2
make[1]: *** [scripts/Makefile.build:509: security/integrity] Error 2
make: *** [Makefile:1649: security] Error 2

--
Thanks,
Sasha
