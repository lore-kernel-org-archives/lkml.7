Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCCCC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 01:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0A72067C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 01:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIFoW9Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfLNBJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 20:09:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37501 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLNBJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 20:09:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so613546edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 17:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uDET1/4WwioWwROI6pkXcNFShnofxk01ctVQVe+2uk0=;
        b=nIFoW9LoBwdiIpDscOGCynjFYb294TiDMQkcXkFi3Wp3GdXHYIU3XrgLFm6l5VzGB/
         rTLED8OscvI4QypySdsgARxqW9JdoQDjo1XZA6uLy3KFUluJF2zPNgFwbRGjUWZIs+Sj
         zjtyV9KbuAHmH4Duprn2GnFoTIO8b3XMU4hGfAL79Q1G7NEd4rCy1ZbSD/U205GTMqGU
         bFUS2qPz9R15GG9pdCY7gST+OvWHVwAiQSolu1cHY2Jr+PfAfbIIb8UmDPFUhyY/hd3b
         2xBeNS2HTlZzjDfDEuoEW9YWs97oyAQakDu+NJrNzFmBlpl1rb/MRDTTT0p4OLEDjEkZ
         LoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uDET1/4WwioWwROI6pkXcNFShnofxk01ctVQVe+2uk0=;
        b=jffH2D2qd1jTkEGqMvvFdGZ9k5Iev9eRklNOwVzPeLrBqpSR3hgMnHKWIB2UpfZqaM
         aabHWSYFXpcvfEzyTHcIwXEsfYTTH3ceOzgmToFrUk0r3TpgHOceZWwYtRgiGUoHUNfi
         N3Fs1vVJcz3YZw9yRQiLM/tB0/Mj4AtkiesRlxr/IRuEau3tRxI9584XfPfxGN0nOwE8
         G/j+lf9kAvR0TbPwjLa7Gkjit1LQK6Gi4FpFMV6mPLd1365mIpVYshTVue+sMHLQa+Di
         uPUs98zwkZSn29eIyfJ34svaSNk4xG5okqwnuGQZa9XmDQODdaAko88Ue9gafa1fasw/
         3Zwg==
X-Gm-Message-State: APjAAAVouKVJgqCPKKKfyCefmaCdJHNERIYoJ+cpnYsmUVAG3Yy2ex7r
        S/hce4AgWyBjnEJSVjXDACtiw9tqpHq5q0Mc6Camlk8S
X-Google-Smtp-Source: APXvYqwx0aMnaVcmV8TCv/hWtphC5/JyFFI3+i8tOd31mo7/SXz3f6i7Hfr7KY9GWJmbqH/yZF4ohYvwScejy3mZoCo=
X-Received: by 2002:a17:907:2112:: with SMTP id qn18mr19222413ejb.92.1576285768101;
 Fri, 13 Dec 2019 17:09:28 -0800 (PST)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Fri, 13 Dec 2019 17:09:16 -0800
Message-ID: <CAGRSmLvPDM2DchiF2d-zBksdfFa3TdPb5+0K=M+YL3mGKVxkxA@mail.gmail.com>
Subject: Makefile build failure 5.4..3
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Building 5.4.3 x64 it completes but I noticed:

 CC [M]  drivers/net/wireless/intel/iwlwifi/iwl-debug.o
In file included from ./include/linux/export.h:42:0,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/kernel.h:8,
                 from ./include/linux/skbuff.h:13,
                 from ./include/linux/if_ether.h:19,
                 from ./include/linux/etherdevice.h:20,
                 from drivers/net/wireless/mediatek/mt76/mt7615/mac.c:10:
drivers/net/wireless/mediatek/mt76/mt7615/mac.c: In function =E2=80=98to_rs=
si=E2=80=99:
./include/linux/compiler.h:350:38: error: call to
=E2=80=98__compiletime_assert_18=E2=80=99 declared with attribute error: BU=
ILD_BUG_ON
failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) &
(((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) !=3D 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:350:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
./include/linux/bitfield.h:46:3: note: in expansion of macro =E2=80=98BUILD=
_BUG_ON_MSG=E2=80=99
   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
   ^
./include/linux/bitfield.h:95:3: note: in expansion of macro =E2=80=98__BF_=
FIELD_CHECK=E2=80=99
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^
drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in
expansion of macro =E2=80=98FIELD_GET=E2=80=99
  return (FIELD_GET(field, rxv) - 220) / 2;
          ^
./include/linux/compiler.h:350:38: error: call to
=E2=80=98__compiletime_assert_18=E2=80=99 declared with attribute error: BU=
ILD_BUG_ON
failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) &
(((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) !=3D 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:350:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
./include/linux/bitfield.h:48:3: note: in expansion of macro =E2=80=98BUILD=
_BUG_ON_MSG=E2=80=99
   BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is zero"); \
   ^
./include/linux/bitfield.h:95:3: note: in expansion of macro =E2=80=98__BF_=
FIELD_CHECK=E2=80=99
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^
drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in
expansion of macro =E2=80=98FIELD_GET=E2=80=99
  return (FIELD_GET(field, rxv) - 220) / 2;
          ^
./include/linux/compiler.h:350:38: error: call to
=E2=80=98__compiletime_assert_18=E2=80=99 declared with attribute error: BU=
ILD_BUG_ON
failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) &
(((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) !=3D 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:350:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^
./include/linux/build_bug.h:21:2: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON=E2=80=99
  BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
  ^
./include/linux/bitfield.h:54:3: note: in expansion of macro
=E2=80=98__BUILD_BUG_ON_NOT_POWER_OF_2=E2=80=99
   __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +   \
   ^
./include/linux/bitfield.h:95:3: note: in expansion of macro =E2=80=98__BF_=
FIELD_CHECK=E2=80=99
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^
drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in
expansion of macro =E2=80=98FIELD_GET=E2=80=99
  return (FIELD_GET(field, rxv) - 220) / 2;
          ^
scripts/Makefile.build:265: recipe for target
'drivers/net/wireless/mediatek/mt76/mt7615/mac.o' failed
make[9]: *** [drivers/net/wireless/mediatek/mt76/mt7615/mac.o] Error 1
scripts/Makefile.build:509: recipe for target
'drivers/net/wireless/mediatek/mt76/mt7615' failed
make[8]: *** [drivers/net/wireless/mediatek/mt76/mt7615] Error 2
scripts/Makefile.build:509: recipe for target
'drivers/net/wireless/mediatek/mt76' failed
make[7]: *** [drivers/net/wireless/mediatek/mt76] Error 2
scripts/Makefile.build:509: recipe for target
'drivers/net/wireless/mediatek' failed
make[6]: *** [drivers/net/wireless/mediatek] Error 2
make[6]: *** Waiting for unfinished jobs....
