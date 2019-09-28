Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D3C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532F02081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569674569;
	bh=M2RhVrs7nUfRzaw+oEJ1uo5OLM7Aq6RQ/ST7b4rjrpc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XfGBjVoPLDoPZkSbJ+8rQwfpsgEjwNaqKLrFztzhn6DBtEomU1FFzRdF/8jL3sCdG
	 Auyax5goEwcbt9r34kmUTOhHSF8PIcohbjjogILdmBPO6bVCeEsAyiXtRV/cz9O+SU
	 1fUAF1K9LX8U+L3yvaj1QItMBRGyj0O4Wq+YimYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfI1Mms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 08:42:48 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41611 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfI1Mms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 08:42:48 -0400
Received: by mail-wr1-f46.google.com with SMTP id h7so5994142wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ha5whZWGZpr7pKFOAPS2wHg86nQyxI6gFzMaGr0Tqg8=;
        b=nf3l7V1PH9+NtJWW0u0LSy+C2YqdzbHcElQp2W9YSrYH+fNgKLQbb48G1Ndpqs8VWZ
         FHmg56z0mH4n6PQZ3f8EwcYRb3uJMj6GCt+cq2nEw4WQfG/FLuW0fSQuKSvBTBz5gc6F
         G1J3LGAqAUkll/keVVCH4TcKJwONNr/zK+zb+SY32Pr19vuPldCa/GUJ/BI6IkZXWo43
         uvlYb9qPy8FfFWH+XGlfAAN7WRSJ4upEcsIldW9sYfJ9pMo8HyK11KZjdHcXza73KDFa
         sXiAZD6EBW1Rtl1PeornJt2Xuwkzr38A9yu0/1LNB1wnY1nV2RJRrgwIHaD3sla3oejG
         X8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Ha5whZWGZpr7pKFOAPS2wHg86nQyxI6gFzMaGr0Tqg8=;
        b=t6X2r5/5LfuiKy1jS+0s3QhGK2BRD4ILf4kLd9iwJKM+eE085Ri/O5cK7P4QvD2AzD
         Vvi/df+7GvGNzvpfcALbaUfF3X/22+S8kt2r0ORgwhQL0VKfdjzD18NMfoRkdFtS4Mmo
         jjstPWmx0X6OWbf3nXh1mpnDmlHv5SdKyISM0iNACznswkYTRh5BSBxzEAWgdZ6wu2cZ
         VX+wpTnAv8Q8GCvhwg4CNovb9jr/ottlGod9UWpEpV+7eVKjUMVOCrwVp8fe24jBgI8O
         ryb2BG3a1FUnhKVFAG2WS4AUp9muc2evYF1XHsDnzZgN0GIo+4O6SGErvqvsq3iLSy42
         3XTw==
X-Gm-Message-State: APjAAAXM5RS0Jo6e5et03C57iNwC4S0TDMuuiKAfkqfKO1uKc25UVrIP
        89AXmnzrwfLtFx2SvK0l4Pc=
X-Google-Smtp-Source: APXvYqzY+zbZiKIIGSPiJcKbONI5qz5NsThCFlkXiTAB4jBq5HEZY6HvTq3YQFgz2vjIc6Mpq40dNQ==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr6386838wrm.396.1569674566140;
        Sat, 28 Sep 2019 05:42:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v6sm18997265wma.24.2019.09.28.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 05:42:45 -0700 (PDT)
Date:   Sat, 28 Sep 2019 14:42:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fix
Message-ID: <20190928124243.GA2563@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: ca14c996afe7228ff9b480cf225211cc17212688 x86/purgatory: Disable the stackleak GCC plugin for the purgatory

A kexec fix for the case when GCC_PLUGIN_STACKLEAK=y is enabled.

 Thanks,

	Ingo

------------------>
Arvind Sankar (1):
      x86/purgatory: Disable the stackleak GCC plugin for the purgatory


 arch/x86/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 10fb42da0007..b81b5172cf99 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -23,6 +23,7 @@ KCOV_INSTRUMENT := n
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
+PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN)
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
