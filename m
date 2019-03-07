Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C882C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEE920652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCGQCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:02:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39358 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfCGQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:02:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so11596888pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPInsmPSHy9h09KAox4on6Wck/Zanl4gpMNIK2Gdkl0=;
        b=LOoybaYBIywJfUnSpvTLISAxpNjh8SNxETg80xnF69bB0lOpv59W0Kp+XQ9j3XCq92
         ISLnV4AWvGqh6M7aRWOR8y+Kkpv0182DF2pI9bbkIRJQfMvwH6YGibvoLaHJMaGVLrZe
         uM9HgR1iARKPFoglKMzM0BTooySmCHKsn3WfoKVLe/o16wEjLj2nvTth/vgC2Z41OE5M
         ZasxO10NBB6ZEj36l2HZMy3mqxWPBIYqIJJ3m3NSIUI87JJBydoTJ4oS0C/W48OgdgkY
         /RqsGFMijs2abP1/kgj+HMiCfO9VrtgeQ4PXflgr7lnod5I0Aw6TUf+Mq+aOn14EW8gF
         dD2A==
X-Gm-Message-State: APjAAAU40uvA4qXDAY2QgILLe89UOnWZjwwXLTSg6hK6us6zCcC/xnPK
        XuyscDY6jEkUN9oSHjGbOJeR4l3meR4=
X-Google-Smtp-Source: APXvYqyV8roXup0tiYuh99s8pYxMTnFb7gElBS5JfofGJ1SnAgYM/gcO3FxJGZreeu22YdG5VrYuLg==
X-Received: by 2002:a63:cc44:: with SMTP id q4mr12063893pgi.183.1551974543052;
        Thu, 07 Mar 2019 08:02:23 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b197sm18265068pga.89.2019.03.07.08.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 08:02:22 -0800 (PST)
Message-ID: <1551974540.9796.69.camel@acm.org>
Subject: Re: [PATCH] lockdep: avoid a clang warning
From:   Bart Van Assche <bvanassche@acm.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Waiman Long <longman@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Mar 2019 08:02:20 -0800
In-Reply-To: <20190307075222.3424524-1-arnd@arndb.de>
References: <20190307075222.3424524-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 08:52 +-0100, Arnd Bergmann wrote:
+AD4 Clang warns about a tentative array definition without a length:
+AD4 
+AD4 kernel/locking/lockdep.c:845:12: error: tentative array definition assumed to have one element +AFs--Werror+AF0
+AD4 
+AD4 There is no real reason to do this here, so just set the same length as
+AD4 in the real definition later in the same file.  It has to be hidden in
+AD4 an +ACM-ifdef or annotated +AF8AXw-maybe+AF8-unused though, to avoid the unused-variable
+AD4 warning if CONFIG+AF8-PROVE+AF8-LOCKING is disabled.
+AD4 
+AD4 Signed-off-by: Arnd Bergmann +ADw-arnd+AEA-arndb.de+AD4
+AD4 ---
+AD4  kernel/locking/lockdep.c +AHw 4 +-+-+--
+AD4  1 file changed, 3 insertions(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
+AD4 index 21cb81fe6359..35a144dfddf5 100644
+AD4 --- a/kernel/locking/lockdep.c
+AD4 +-+-+- b/kernel/locking/lockdep.c
+AD4 +AEAAQA -842,7 +-842,9 +AEAAQA static bool class+AF8-lock+AF8-list+AF8-valid(struct lock+AF8-class +ACo-c, struct list+AF8-head +ACo-h)
+AD4  	return true+ADs
+AD4  +AH0
+AD4  
+AD4 -static u16 chain+AF8-hlocks+AFsAXQA7
+AD4 +-+ACM-ifdef CONFIG+AF8-PROVE+AF8-LOCKING
+AD4 +-static u16 chain+AF8-hlocks+AFs-MAX+AF8-LOCKDEP+AF8-CHAIN+AF8-HLOCKS+AF0AOw
+AD4 +-+ACM-endif
+AD4  
+AD4  static bool check+AF8-lock+AF8-chain+AF8-key(struct lock+AF8-chain +ACo-chain)
+AD4  +AHs

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
