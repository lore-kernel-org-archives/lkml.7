Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E995C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A4F21781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mb3MIbxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfK1NTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:19:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39172 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1NTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:19:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id f18so20016626lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=a6UykuI2ITtmBK53f/J/gVoOVqoOXR1NtFRyFCtxoEc=;
        b=mb3MIbxtl/blBcrQRjuFDoZUW5guLzIK8vDrdeEmPfM0TgQscB8bx+QXwUdKHptcrW
         LUsKmQKHDKE/Gj2KYgIUHJYVsMguz+FL1i/16M16CXRYvG141LShZ3uAoWeBgCXpl3XD
         YpBcYs5oSbYWRIsJYNBAQyboCcuMHBt7vVZThWALc0HOCu0VMMi+Zp6oszCHhCpLTplF
         q7THgvqpOIjaAkrR9M/RC/7ugTyiDZ/SbTNmTgBASeXsqsK4Ws0vo1ddvCQY2qhpg86J
         EGL9iR/UFL7h36bARljzkRPjvl+4T3Vn6ZtdDIzxTEx2YlZ/HlWX55i+LjJ3S5OYe4Dd
         00CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a6UykuI2ITtmBK53f/J/gVoOVqoOXR1NtFRyFCtxoEc=;
        b=O7farmxDsBCLKJmPd+oqfFSQEp9QndTpEw16WaT7bjACj6p/xWJAF7Dot0SkhwZdIv
         RRW/ReGQyQlkxSMM0Dg0BstsVRwMDEBD0rh+zdZYn7tjuYo78tf9ZO9vLthuw1Y/Y9an
         cH62ceJBkwcE6QATDFQ2p1AdDcDvYb6BKJjD0KVLxTMg7TkjhQitMxwfa0KILaxykPxS
         n0nMD+r4DhsOUA6Bmlt6uZ+gVBMEpkgs9QH49ZuwzH/By5EaWKUk1JYtl/s5nlT6EP+l
         RjoYn6pa5zS4P6CGcx6VdVtAkh3AKScyBAq6LLVWBVmgLSNz4oGlUU8DrdauNRGVPogM
         3c/g==
X-Gm-Message-State: APjAAAU92aaR1si6fPSRkl/n3M0NgkKhnCa7GqOlc3vB9jruz0O3i1wN
        Eh5wbjnjWspD1JwEdYMlcnd/xDdEhMUHpVQuGSBLnA==
X-Google-Smtp-Source: APXvYqwYXHWQE8HF3VzPJ7gwhW7vLjPmEWwu9T2UbexqzTjOPa39f/ftjXJJSpBmdc1RK+4dxxgWXAT/gWFx58pcByE=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr5039588lfi.135.1574947142730;
 Thu, 28 Nov 2019 05:19:02 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 14:18:51 +0100
Message-ID: <CACRpkdb_5xjLBSPaGrDadHUj=4Npz13YELJw+Ov+JyigGPBZjg@mail.gmail.com>
Subject: [GIT PULL] Oneliner fix for the pinctrl pull request
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

as requested yesterday, a oneliner fix adding the license to
the new Intel pin controller.

This time just based on the top of your tree from yesterday.

Please pull it in.

Sorry for the mess.

Yours,
Linus Walleij

The following changes since commit a6ed68d6468bd5a3da78a103344ded1435fed57a:

  Merge tag 'drm-next-2019-11-27' of
git://anongit.freedesktop.org/drm/drm (2019-11-27 17:45:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.5-2

for you to fetch changes up to 6d29032c2cef31633db5dfd946fbcf9190dddef0:

  pinctrl: Fix warning by adding missing MODULE_LICENSE (2019-11-28
09:12:43 +0100)

----------------------------------------------------------------
Fixes a MODULE_LICENSE() problem in the Equilibrium pin
controller.

----------------------------------------------------------------
Rahul Tanwar (1):
      pinctrl: Fix warning by adding missing MODULE_LICENSE

 drivers/pinctrl/pinctrl-equilibrium.c | 1 +
 1 file changed, 1 insertion(+)
