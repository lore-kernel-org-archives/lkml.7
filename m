Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D487C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70A6206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtOlueDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfJIVpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:45:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34636 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfJIVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:45:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so2791865lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neyxcVlEmCYVV210NlpiIy48qmIVtJilY8X2MVXciDE=;
        b=MtOlueDnBpCLLEX2Ak6A1UGYP494h9lCZm1pV8BJ37DnmZThV8Cu6TuRxcyEaBgdxv
         vmE6qZRNxinv3MjeqeL9e1j4c0lUF/zXMij6GZBHfIDNr1GkpJq4pf3S29L8Ja4XVROO
         h0qIWxvLOxOOgSZExbFZnLfYSVHar+rvO6V/+iHNoxWbCSyHkf7BQNK50E6WSFeoMZob
         z/guRRiKnm6BFj8Cf+HrsDdJ8BOWfM4qXLXq15CfIPCPxgwZz1ANUd8i57j7zNYC4HR1
         rCpqYRx5VeEcn5wFD3Bcb90c7jZVlA1O9fM8ADwpXMInl+60xDLIL2FDGxiOqa3IAhKn
         hsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neyxcVlEmCYVV210NlpiIy48qmIVtJilY8X2MVXciDE=;
        b=bT9Yf4PJ6sd5XE/c4aBvUEVt6XzQKVt8ruSpeftaG9tObgWnYjFyr7SrqOLzkizfdh
         V1/0Tgj4A4QCIpRQsPWQJUDKBxety8PW50AXceq0rWbe7+DU37vCLMgbAZyTFuvtvgup
         CI3AXI7Y+SqFBaBwbm/DzIeBawTrylfYKYSb5uJVc2oBPO6+JNKZ+Ur/pa/fo0lXFJ3p
         39/M7KgNIhX9ALRF0tYq4An6GZeeMqaX2EAtwjvVz1k22sAotJh/JP8A2zFwYc8zpgjR
         3lnJpJOJHscwLDFO+2gK79+CSeMbxwsWEU40DQY+EYTdcUv0R89U3PwD/TGsBkvAy2L0
         C0dg==
X-Gm-Message-State: APjAAAUJTcss9Wui8UisxJbwYsKrwZQR1UFM/gRhuFIyYE22QabV+6hT
        5BjZslMWyQujtIhZKbN1RY6iKG3MBm8=
X-Google-Smtp-Source: APXvYqymMK99J9uCn2e3V8grlBLNaigjD7+gYTn+BMEuczjejrLDagkHC3I9pgqMrdXfA1MSb9bWvw==
X-Received: by 2002:ac2:4471:: with SMTP id y17mr3575074lfl.28.1570657519502;
        Wed, 09 Oct 2019 14:45:19 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id v22sm701503ljh.56.2019.10.09.14.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 14:45:18 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, bp@alien8.de, joe@perches.com,
        johannes@sipsolutions.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        yamada.masahiro@socionext.com, x86@kernel.org
Subject: [Patch v4 0/2] Add compile time sanity check of GENMASK inputs
Date:   Wed,  9 Oct 2019 23:45:00 +0200
Message-Id: <20191009214502.637875-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
References: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Add build time validity checks of GENMASK (and GENMASK_ULL) inputs.
The main differences from v3:

- Patch v3 1/3 was merged into Linus tree through the x86 tree and is
  not part of this series any longer.
- Disable the input check for GCC < 4.9 due to a gcc bug.

Joe Perches sent a patch series to fix existing misuses, currently there
are two remaining such misuses (which patches pending) left in Linus
tree. However, the remaining two cases are in unused macros and will not
break any builds until someone tries to use them. There was also an
arm-specific misuse which have also been fixed since v2 of this patchset
was merged to linux-next. When v3 of this patchset was included in
linux-next, there were not additional build failures or warnings
(there are some failed builds due to other patches though), however
<noreply@ellerman.id.au> and Geert Uytterhoeven reported that it broke
compilation with old versions of gcc so a v4 is needed.

Changelog
Since v3
  - Patch v2 1/3 (the x86 build warning) has been merged into Linus tree
    through the x86 tree (and is therefore not part of v4).
  - Disable the GENMASK input check if GCC version < 4.9 due to a
    compiler bug [0].

[0]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
  
Since v2
  - Use __builtin_constant_p instead of __is_constexpr to avoid pulling
    in kernel.h (that include was missing in v2, so the header was no
    longer builable standalone
  - add cast to BUILD_BUG_ON_ZERO to make the type int
  - Remove unnecessary casts due to the above
  - Drop patch that renamed macro arguments

Since v1
  - Add comment about why inputs are not checked when used in asm file
  - Use UL(0) instead of 0
  - Extract mask creation in a separate macro to improve readability
  - Use high and low instead of h and l (part of this was extracted to a
    separate patch)
  - Updated commit message

Rikard Falkeborn (2):
  linux/build_bug.h: Change type to int
  linux/bits.h: Add compile time sanity check of GENMASK inputs

 include/linux/bits.h      | 22 ++++++++++++++++++++--
 include/linux/build_bug.h |  4 ++--
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.23.0

