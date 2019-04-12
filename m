Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911AE2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555064196;
	bh=01LUp7TppCEJfyRZN7JdgmR/yQbauCDTUWlOFV2b2q0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HfMUK1L72tNjZr8RkcTGTwxU5SEdldayQ9XFkMPQzR05txrUImbak13UC6PBZk/tB
	 NlgAmqvzxjwsnQW6wmyCqL6rtioV2SNnyq0Vq0ttEnPExMMA8VR0gvrcaZzTbGx7tf
	 iTCZRtjnF/1JGmm6vKjL+OGkKsArbacjNVPALRUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDLKQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:16:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39675 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfDLKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:16:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so11212629wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7vRlQAko5KVEPu4wliiXc2KZK6U9PlVj69UuRDsMMLs=;
        b=AKF6qSdBYA58w0itzilne/hWgttaOkmmw4NVgKFhBzBIRRhvdp7LfldhqnGXUgWG3C
         iXCQNg5LtcPWuekj7rpzJb7hnuNV10qT6zjXQTDmiKp5/yryVnTkT78y9yMbkYWfTq/Z
         CZ/RhXEMRhrUlEO3Hyqdyh+5yyvaeSOr7m8ag7N6vsbGduOS34ba52CDizWA297lxRhc
         EI/MUTh401B6vGa8FmqP6O6fJoh0GM0zUPZ4u4F51fJvqaRZd4EVRdo1jAd2N6HihiEv
         dc7s/ZCWwGqCw5oqOLGx5vuQ8NJGdE9r+pRbRFMq322Yege0q6OGDvBocXASZlihrgpp
         1kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7vRlQAko5KVEPu4wliiXc2KZK6U9PlVj69UuRDsMMLs=;
        b=p4sdiRMDPSjh7ljhErO/ocSb16r5SPIzOTov00wvu7YEVNGRnTopAn4+qjyqp9F5Pc
         SIKbNwTTlOiScIbFE/6YOf7O8M+LfLubcj6uyNfdrh99o6oqUqN/d1+DN6LbhjtLjVHE
         Df/55eT1QAA2VxD1MVVjNbEWUQBfjwRq7sKeXr4YKu+jaNvu6JLgAZpjJcd3ZWwvylNE
         +snAYJ0VVbL6o4SHRPrB/9NjU0NVKosa8G4+ODk7TIme+NU+rtOHRP5Rw69x7snPge22
         TwyD5V0MNaQNNCJJVwzkGEQo7lKxA7WVpNbkLBMxEQVpvuW/FEt0dNBStB1+W9ZpEm3x
         iLbw==
X-Gm-Message-State: APjAAAXnsv7XULhShxM33VsZRaBpnEf/bKhTZyci6S6Xf5eEaYWN5OKO
        VVuoY/vXSkdfk2872RAevyA=
X-Google-Smtp-Source: APXvYqyjuA48vzSlJCYaF166xpVnhVOc+7Kgd0N7PcQF6dxuX3hSphSuGkMXZYDLeVf136gR1AAHYg==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr34867340wrp.194.1555064193086;
        Fri, 12 Apr 2019 03:16:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f10sm48525734wrs.17.2019.04.12.03.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 03:16:32 -0700 (PDT)
Date:   Fri, 12 Apr 2019 12:16:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/urgent fixes
Message-ID: <20190412101630.GA89501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 4fa5ecda2bf96be7464eb406df8aba9d89260227 objtool: Add rewind_stack_do_exit() to the noreturn list

Fix an objtool warning plus fix a u64_to_user_ptr() macro expansion bug.

 Thanks,

	Ingo

------------------>
Jann Horn (1):
      linux/kernel.h: Use parentheses around argument in u64_to_user_ptr()

Josh Poimboeuf (1):
      objtool: Add rewind_stack_do_exit() to the noreturn list


 include/linux/kernel.h | 4 ++--
 tools/objtool/check.c  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 34a5036debd3..2d14e21c16c0 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -47,8 +47,8 @@
 
 #define u64_to_user_ptr(x) (		\
 {					\
-	typecheck(u64, x);		\
-	(void __user *)(uintptr_t)x;	\
+	typecheck(u64, (x));		\
+	(void __user *)(uintptr_t)(x);	\
 }					\
 )
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5dde107083c6..479196aeb409 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -165,6 +165,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"fortify_panic",
 		"usercopy_abort",
 		"machine_real_restart",
+		"rewind_stack_do_exit",
 	};
 
 	if (func->bind == STB_WEAK)
