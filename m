Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F47CC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011BF20678
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568632537;
	bh=+uBO5q/COWKPECOgSPFLvcXeJofqQ46Y2vvrzK7erRQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=k/4pSnp4q4cXCYIhDPIJNNGRFHVj1RHDzA4RGMg9GCppxycObQWj4julZDI/7tQ2/
	 AJfATB55fMMY9AAuYte6SKZt2tOCqYBKducGrCF4EFk7BR0YKqIO85uRkzZrCEjN4M
	 /kUHzj248BXCJNjmC9GLJAd37w75FZ5+7uNaoGmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfIPLPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:15:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36558 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfIPLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:15:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id t3so9831479wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vmcSfcyvNHUIfgjndVUYPtpVZq6pnPBVlpt2pFBZtLs=;
        b=TcLcC8XXmoR1UZXAPPbOOY8Q9ODDzqSL5T7+KywZcvSMONfTYuo0IeFE+JHOwPja9B
         l7MAuYEZmSwPF6hRqPUN4Cbn+01PywN5S5L6P1yWRVWRVIHVHrGdQS39Qxgo9Pi0/Xtg
         Y5kcfUZISxMEijZKDaJ+fxES99uv5MWxU6EU26VuzHzIUA0cXrN/JawXTbawbbpKuKVF
         crV4JeibDpeqVMi/toCZCcqScOKcB4f8PzJew2mSJ6JVyE3UFRIhoLJtGjp9FmzMx0Be
         VZDNqabAvknjRtylzeoenWkpizlaeSNa/awK8hCauMuH4aTb7YoBy5LozEJdqiLY9Zma
         N3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vmcSfcyvNHUIfgjndVUYPtpVZq6pnPBVlpt2pFBZtLs=;
        b=Quc3ObaAkgAH7dTunROrC/HZm7TJ8u1Mjrw2sxVQdWlaxWFpAENsrrQxPQka2eArR1
         P+Aeny+CgI8TTDadxtnpqf5FbIs0PR2H5DhDfUoO8cUW86FQj82KPNkbs252fVU7xQAw
         z+TxCUDOJ4vvdHTYyXABubiJhbuP0jAzQzSY8OoEX+4X78rjhG9nNDmNk4dJJ8kI2A5i
         I5biqR7ibBxWm2OGfgpcHidiL6fr3vgATaI+y1i8HMNNWlIq5kMGM6fkm5nfNo3vMN3+
         RajHnYeLoeYFClxrcS1eDl/616K+N82oZAx05vhQYx2U/SzGB1DjMc0egbo/TswnyOe7
         e4DQ==
X-Gm-Message-State: APjAAAU2exfFqPy2pAgzwykJ4h7dl5ARVKo2m8nYRY7sT1gEmKzbA+jR
        f19T0e6CkVwZhg65P7ZtHFvM6QVs
X-Google-Smtp-Source: APXvYqy6zfvYSqlQ5W9YyeW5g7XeU41VVFynAZtvdceuURC4mKQaMH/KSCYeGNALymciHbbqcqTcLw==
X-Received: by 2002:a1c:f913:: with SMTP id x19mr13287021wmh.2.1568632533640;
        Mon, 16 Sep 2019 04:15:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a7sm43690175wra.43.2019.09.16.04.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 04:15:32 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:15:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool change for v5.3
Message-ID: <20190916111530.GA86274@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-objtool-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

   # HEAD: f73b3cc39c84220e6dccd463b5c8279b03514646 objtool: Clobber user CFLAGS variable

Fix objtool builds with more exotic, user-defined CFLAGS.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      objtool: Clobber user CFLAGS variable


 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 88158239622b..20f67fcf378d 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -35,7 +35,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
