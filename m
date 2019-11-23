Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6EC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4FB206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKWVko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:40:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45725 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKWVkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:40:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so9421331qke.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 13:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsNbUCO53oXLI0M1MnPVejhOno/TJ5a5bDmO3kiWZjY=;
        b=q+Lb4JXQ1VlDSK4+81cldpzUg/TGrzVjaFT/0vaso6hwj0vLcMh6CMkelWy5+zqeMD
         74B8Z4fVV0ovycfxXe1paqYOSslTgWtF4QVpKG5Vqj9kTfOfQyncWuk8TWYFNa1W5f9g
         NPqT6UchUlHTcYahC2PJ922vvcTTWmp6xNucP1Fz6CNd9oG2n08DA/GU69eBoSvs1a4g
         VfzDkO6GulJQIZC5J55594B3xAgZuRgmUCOt7oLnEci5e7vjz5JvQff17hcWgtBkfEAA
         KjHhBP0iAZLP/eRye+2DXqeOaQTZVa3nO9D7sXPKXeuFYfHthNB9g2wGaIJ7QEdSfyLF
         /Y9w==
X-Gm-Message-State: APjAAAVtCd7OIZLwfOhWu8THlhDNZUSUeasUyOq17E7ximn4RL+TDgQc
        4AKjoTSLkvIzf8y95nMbjNUqscDJfus=
X-Google-Smtp-Source: APXvYqzN6Xqf8lxukGvxDXyO9UtS1FYTy7rp6dY6azwab2tGu9uuzJ/kfmF3uCeZp4gNdj3zqyUSuA==
X-Received: by 2002:a37:514:: with SMTP id 20mr8058137qkf.321.1574545240687;
        Sat, 23 Nov 2019 13:40:40 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v189sm933208qkc.37.2019.11.23.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:40:40 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/3] init/main.c: minor cleanup/bugfix of envvar handling
Date:   Sat, 23 Nov 2019 16:40:36 -0500
Message-Id: <20191123214039.139275-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191123210808.107904-1-nivedita@alum.mit.edu>
References: <20191123210808.107904-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unknown_bootoption passes unrecognized command line arguments to init as
either environment variables or arguments. Some of the logic in the
function is broken for quoted command line arguments.

When an argument of the form param="value" is processed by parse_args
and passed to unknown_bootoption, the command line has
  param\0"value\0
with val pointing to the beginning of value. The helper function
repair_env_string is then used to restore the '=' character that was
removed by parse_args, and strip the quotes off fully. This results in
  param=value\0\0
and val ends up pointing to the 'a' instead of the 'v' in value. This
bug was introduced when repair_env_string was refactored into a separate
function, and the decrement of val in repair_env_string became dead code.

This causes two problems in unknown_bootoption in the two places where
the val pointer is used as a substitute for the length of param:

1. An argument of the form param=".value" is misinterpreted as a
potential module parameter, with the result that it will not be placed
in init's environment.

2. An argument of the form param="value" is checked to see if param is
an existing environment variable that should be overwritten, but the
comparison is off-by-one and compares 'param=v' instead of 'param='
against the existing environment. So passing, for example, TERM="vt100"
on the command line results in init being passed both TERM=linux and
TERM=vt100 in its environment.

Patch 1 adds logging for the arguments and environment passed to init
and is independent of the rest: it can be dropped if this is
unnecessarily verbose.

Patch 2 removes repair_env_string from initcall parameter parsing in
do_initcall_level, as that uses a separate copy of the command line now
and the repairing is no longer necessary.

Patch 3 fixes the bug in unknown_bootoption by recording the length of
param explicitly instead of implying it from val-param.

Arvind Sankar (3):
  init/main.c: log arguments and environment passed to init
  init/main.c: remove unnecessary repair_env_string in do_initcall_level
  init/main.c: fix quoted value handling in unknown_bootoption

 init/main.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.23.0

