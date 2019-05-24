Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E2C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DB520863
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EuZua2Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbfEXALo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:11:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35353 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387613AbfEXALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:11:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so1964280pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=55+scLPzywd2t6Q9yx3Qo50LoEln+k1CYwGY53WWjzw=;
        b=EuZua2Uzj4PFIiNubpucYeny5iInwuYR+P39ZD/rE/lEL2FPFCY4KF7C9r/zE3fIsH
         NAna6L2IHwMgPHCUgEk1jHwDhX2jy6B+xtoSR35UuQNkV+BJ9+PDF1/9k4oUEPJDSiRo
         0KVAjc7QFF/nw0767rfpVHo+EbMTIiMCjvsmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=55+scLPzywd2t6Q9yx3Qo50LoEln+k1CYwGY53WWjzw=;
        b=dKfUpIB7gJNxiyRY2NWR64jWfIT/ft5dr6OkR0S5jZ3i5bIxfaGFpNwI2sMfj5hMtQ
         sk1xf/yHOcSfQcGxAE+FiOR6kK7nhwjErQB9oY4crwhLuiASvuNlylg0vyFmOOPV9oft
         HUrWyJMv1N0JrY+7xBbF0eK6u2rEg0psZSjx+8AIu1maQvwPtAouaNNddxn5FS04DOLe
         UvcDOIJIRcG++5hHeghHIWOjf0+hWM6mp5jZX6ihiefijc8Ne//bgOgS5k814U16JZdm
         8JwIuT5XNrr6VF0hPNqT9lsljpGUg3VoLO2XE2k1MDtLWmBBswTCZVHXZL0O9sbWTU3Y
         gunQ==
X-Gm-Message-State: APjAAAVDy2bQ4P7UmFkR2Hv413v0f4xMC9TuPzJMcon5NFQSqnvMA6O9
        ib7nB3RpMp6bCzOKuOxSEHBx/7fGWRaiXA==
X-Google-Smtp-Source: APXvYqwIfZhlX2GDAEViod1U1tdxrWTVRDC+bH4vbpfSIRi2ENnxCO9LMZ917gDBnasxtFKUES9r4w==
X-Received: by 2002:aa7:881a:: with SMTP id c26mr102396225pfo.254.1558656702464;
        Thu, 23 May 2019 17:11:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x18sm597981pfj.17.2019.05.23.17.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 17:11:41 -0700 (PDT)
Message-ID: <5ce736bd.1c69fb81.f2410.2b19@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM0PR04MB6434A12D2DCB42ECAA7EB1FAEE010@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190523195313.24701-1-farosas@linux.ibm.com> <5ce722ac.1c69fb81.b62d2.16d0@mx.google.com> <AM0PR04MB6434A12D2DCB42ECAA7EB1FAEE010@AM0PR04MB6434.eurprd04.prod.outlook.com>
Subject: Re: [PATCH] scripts/gdb: Fix invocation when CONFIG_COMMON_CLK is not set
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jackie Liu <liuyun01@kylinos.cn>
To:     Fabiano Rosas <farosas@linux.ibm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
User-Agent: alot/0.8.1
Date:   Thu, 23 May 2019 17:11:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leonard Crestez (2019-05-23 16:09:18)
> On 5/24/2019 1:46 AM, Stephen Boyd wrote:
> > Quoting Fabiano Rosas (2019-05-23 12:53:11)
> >> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/con=
stants.py.in
> >> index 1d73083da6cb..2efbec6b6b8d 100644
> >> --- a/scripts/gdb/linux/constants.py.in
> >> +++ b/scripts/gdb/linux/constants.py.in
> >> @@ -40,7 +40,8 @@
> >>   import gdb
> >>  =20
> >>   /* linux/clk-provider.h */
> >> -LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
> >> +if IS_BUILTIN(CONFIG_COMMON_CLK):
> >> +    LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
> >>  =20
> >=20
> > Why is this LX_GDBPARSED() instead of LX_VALUE()? From what I can tell
> > it doesn't need to be runtime evaluated, just assigned to something that
> > is macro expanded by CPP.
>=20
> Because CLK_GET_RATE_NOCACHE expands to BIT() which expands to a=20
> constant with an UL suffix which python doesn't understand.
>=20
> Alternatively we could redefine the BIT macros inside constants.py.in=20
> but using gdb features seemed better. We could even try to strip integer =

> literal suffixes with sed.
>=20
> Mentioned before: https://lkml.org/lkml/2019/5/3/341
>=20

Ah ok. A comment in the code would have helped me, but o well.

I'd still like to apply this change to clk tree so that we can avoid
needing to do the IS_BUILTIN check entirely.

----8<----
From: Stephen Boyd <sboyd@kernel.org>
Date: Thu, 23 May 2019 17:05:59 -0700
Subject: [PATCH] clk: Remove ifdef for COMMON_CLK in clk-provider.h

This ifdef has been there since the beginning of this file, but it
doesn't really seem to serve any purpose besides obfuscating the struct
definitions and #defines here from compilation units that include it.
Let's always expose these function prototypes and struct definitions so
that code can inspect clk providers without needing to have
CONFIG_COMMON_CLK enabled.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clk-provider.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bb6118f79784..3bced2ec9f26 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -9,8 +9,6 @@
 #include <linux/of.h>
 #include <linux/of_clk.h>
=20
-#ifdef CONFIG_COMMON_CLK
-
 /*
  * flags used across common struct clk.  these flags should only affect the
  * top-level framework.  custom flags for dealing with hardware specifics
@@ -1019,5 +1017,4 @@ static inline int of_clk_detect_critical(struct devic=
e_node *np, int index,
=20
 void clk_gate_restore_context(struct clk_hw *hw);
=20
-#endif /* CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
--=20
Sent by a computer through tubes
