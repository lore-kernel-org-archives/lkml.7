Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D106FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E58D2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjCXqN6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfE1IoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:44:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41754 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1IoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:44:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id q16so8486763ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KJsIAmZlgomiviR9u23s6r8ukXmCLjxqlexRKIvP9zk=;
        b=MjCXqN6oEwKDIq1BrGwjFirFzeLs8hVkB+6w8ltYbqHKQT+Rc1/f+U1tm8iBOG+Pag
         8ClofD1nqewVrgyi408KSQGOjnEIKDj6tdBnWyecSH6O0nvKIYq8iB7B13ID+sa5Zqh3
         IqD+fwOL3qLWrT5HB5pqVNBekmT8yFNIuby9KNeJrcY3IlM8weCvYsC7xaFd7PZM/Dlq
         nDabg+HaMWpLrysgXIwDZTAo9DxP3RZ3CBI/r2NH+cdXbYxDiAHasj1k5iNU6U7NrSsD
         UMIXsoTKONKbDw1hDJkFsukWMIUJgLE+wgF7/BNq9q5Nl5W2xdJ7uJvxU7wTIiqE5M3J
         z2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KJsIAmZlgomiviR9u23s6r8ukXmCLjxqlexRKIvP9zk=;
        b=JjpJX4tmkt0Ik8/I4IExU43a00wqMKMN0pWkTHyHZb5WeE6Zr5Dug983z9TQXrx/ns
         s62+jxr6IuwwNSsj85/+qVf3zdGiTFyZEck+KbeMNPhd+VxVK25ciU1As/mKMUSqg/W0
         WWiqFx5UqdbBZtzRcAs2fJVXRnIQu4KQyYzLxaqRmiLM2QVboQ8YyDnc+q4gDcKiqUuu
         h9rbGrATdxVcm1Bn7vITbfX3u2fD6aGnWj7LObQDOw051YfHaA1R7RztegzpOZ2DZyle
         q8z644NMmuYkTOc/FLLy3895LRgeBK50rEvKvpcO6JJqbAOJ1kpVo/4TbCszodJXSxDI
         X8Dg==
X-Gm-Message-State: APjAAAVad7IKM/N8MasNDacjbrEWbvczAowQYYGkxuZijq/CxoWXdwCp
        WqTykqL8pEzNfRm0SiPdsi2c/koUScCVoX7n7m4Iz8Ja3yg=
X-Google-Smtp-Source: APXvYqwUbOW+3HzlVH2QENJChAHBleV0jq85hTu4fDbpYu+weBQDdWZLTTiQbK+48yPJHAcpsfe9rg7ZLGP+Svxdj+g=
X-Received: by 2002:a2e:4c7:: with SMTP id a68mr45332096ljf.165.1559033044316;
 Tue, 28 May 2019 01:44:04 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 May 2019 10:43:53 +0200
Message-ID: <CACRpkdYFqcu=gz57H-+h5C3g_rvD-+XoRTw_A86PKDVA3=rfJg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are a bunch of pin control fixes for v5.2.

The outstanding commits are the Intel fixes that arrived
during the merge window and I got relayed by pull request
from Andy. Apart from that a minor Kconfig noise.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.2-2

for you to fetch changes up to b1fa7d8592c730d1b44536b5cacadeb318d369fd:

  Merge tag 'intel-pinctrl-v5.2-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into fixes
(2019-05-27 11:07:31 +0200)

----------------------------------------------------------------
Pin control fixes for v5.2:
- Interrupt clearing fix for the Intel pin controllers affecting
  touchpads on some laptops.
- Compile Kconfig fix for the STMFX expander pin controller.

----------------------------------------------------------------
Amelie Delaunay (1):
      pinctrl: stmfx: Fix compile issue when CONFIG_OF_GPIO is not defined

Andy Shevchenko (1):
      pinctrl: intel: Use GENMASK() consistently

Kai-Heng Feng (1):
      pinctrl: intel: Clear interrupt status in mask/unmask callback

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.2-2' of
git://git.kernel.org/.../pinctrl/intel into fixes

 drivers/pinctrl/Kconfig               |  2 +-
 drivers/pinctrl/intel/pinctrl-intel.c | 45 ++++++++---------------------------
 2 files changed, 11 insertions(+), 36 deletions(-)
