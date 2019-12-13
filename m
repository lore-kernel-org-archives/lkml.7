Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED7AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0CD2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="av45X8UB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfLMAfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:35:36 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40420 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbfLMAff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:35:35 -0500
Received: by mail-pg1-f202.google.com with SMTP id z12so337035pgf.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=HtK9xLwQDzGm+XiM/V3mqEhkctZrVfQExhZP64CAkFM=;
        b=av45X8UBoDasxQtdUR/kaLHvAHnHqZ0KguighfVlEi1MLGDZJyX+X/OctMg/qQNkxx
         aZSq54MBNlXTd0KPfh183tzC4j2Mhx3byjTrz74wtCNVa71EAHmL5lahqvgNrklAZ1Mz
         EI0lEEvl/H1fIx9K0h+JHvPTbciX8XqO/bytl60c7VgAcGaywHcCn73ML038ODDRwYXE
         mnC28CWxlHia2Ydi8Wk9GlK9noE8UsraXZ5SX4h6okl+mda1P+LhpoID6wUY7puYOKjF
         QSHGgrHRvwNnLxPEGYZBjxGnk75KZHMdk1q9njYZRpPblfvdUOpz58YjED1yLtHHZmr0
         /iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=HtK9xLwQDzGm+XiM/V3mqEhkctZrVfQExhZP64CAkFM=;
        b=NNYP42WT+2LK2Lc+V63fZZGl5MlFxW75fyyxgdExmbS/Q1cPl8wA1oRXJZa9qx1xPB
         /BXd1bi0rcNof236OK43y0WUjQly5ahV604GNSeKwfQQva1dl73itFol6e/BC5cvj7pU
         x50y4kfFMYKeMNc57GJ6jBA8cEYN7gwkxFviCYz8+IgaonlShyIq9DcjmAWjd6GzE7rK
         2Xp3Zxo61qoCpS2rny7LBqckPf41nZrB7+ee7Nx7x1qmw6y6D8SonqjE1w4eL4AXkgoJ
         BQLxb/58hEKXP/J3odppjtMOhUP53Jnn4F5ay6JowmRh9sLpt3pUa+JPdrRZniu7oPUD
         ONwA==
X-Gm-Message-State: APjAAAUkR5t5P21KsEup8pVcpWfE3vUFDdxLJoCoxztFZkYU47/QJ80A
        xsGXKstxlnbg9QNPtUjGBgDOK4dPKGnAOHqmmMd47A==
X-Google-Smtp-Source: APXvYqwkxYDvjlMgd7Crym7lfFwdMASMN3c0AFKGwJWaLZGshyjLoCuEXqUt6MHkWZ+L6yjQZHGJgoE6qNW3xfcXUZj1MQ==
X-Received: by 2002:a65:42c2:: with SMTP id l2mr13503356pgp.172.1576197334956;
 Thu, 12 Dec 2019 16:35:34 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:35:22 -0800
Message-Id: <20191213003522.66450-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v1] lkdtm/bugs: fix build error in lkdtm_UNSET_SMEP
From:   Brendan Higgins <brendanhiggins@google.com>
To:     keescook@chromium.org
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=3Dum with CONFIG_UML_X86=3Dy and CONFIG_64BIT=3Dy we get
the build errors:

drivers/misc/lkdtm/bugs.c: In function =E2=80=98lkdtm_UNSET_SMEP=E2=80=99:
drivers/misc/lkdtm/bugs.c:288:8: error: implicit declaration of function =
=E2=80=98native_read_cr4=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  cr4 =3D native_read_cr4();
        ^~~~~~~~~~~~~~~
drivers/misc/lkdtm/bugs.c:290:13: error: =E2=80=98X86_CR4_SMEP=E2=80=99 und=
eclared (first use in this function); did you mean =E2=80=98X86_FEATURE_SME=
P=E2=80=99?
  if ((cr4 & X86_CR4_SMEP) !=3D X86_CR4_SMEP) {
             ^~~~~~~~~~~~
             X86_FEATURE_SMEP
drivers/misc/lkdtm/bugs.c:290:13: note: each undeclared identifier is repor=
ted only once for each function it appears in
drivers/misc/lkdtm/bugs.c:297:2: error: implicit declaration of function =
=E2=80=98native_write_cr4=E2=80=99; did you mean =E2=80=98direct_write_cr4=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  native_write_cr4(cr4);
  ^~~~~~~~~~~~~~~~
  direct_write_cr4

So specify that this block of code should only build when
CONFIG_X86_64=3Dy *AND* CONFIG_UML is unset.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---

This patch is part of my larger effort to get allyesconfig closer to
working for ARCH=3Dum. For more information about that, checkout the cover
letter for a related patchset here:

https://lore.kernel.org/lkml/20191211192742.95699-1-brendanhiggins@google.c=
om/

---
 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index a4fdad04809a9..6c1aab177fced 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -278,7 +278,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
=20
 void lkdtm_UNSET_SMEP(void)
 {
-#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
 #define MOV_CR4_DEPTH	64
 	void (*direct_write_cr4)(unsigned long val);
 	unsigned char *insn;
--=20
2.24.1.735.g03f4e72817-goog

