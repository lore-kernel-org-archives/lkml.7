Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23889206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBdU7GTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfB1NMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:12:36 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38071 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfB1NMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:12:36 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so15536282itg.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xKipXMEM/SXog4j6oVyeMsM28FN3V+TT0xo7uw044oI=;
        b=tBdU7GTQwlO9vhl3VjDtsoRyjOCVh2ajdEnI5XczrFDpoYTDhgJkOpyEKYtIfxMJFW
         C7ceRhIkgdFqC0SbO8mD7iD6Gp937qBoWdivKurFMMwZ1xwIaNZtUWH0UT7R1g9G0f+G
         9HRvHtIhSpYiTMZzEBOnNE5NKxBVvEdAgnkNVnCRZCdhQpboHko+vPB6et3XNkTg4zWk
         m8ncopuI/yQbP7n7xmDE/YFr5TCIWWLOoSU6r6wKbGpnRln4wz/wjhNbWgAoUEAnfu0P
         35xzckg7NZwuzUeFj9Cb8mX3lFUyd7UftP9WWqhLtt6jwXa4m9R/bDPXqV0G0/ZgWs97
         O40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xKipXMEM/SXog4j6oVyeMsM28FN3V+TT0xo7uw044oI=;
        b=BJANMPix/3ACSdcQCex2785dkLBXNWpOk3akqyVB4EptktUdjekX1oYd42rUrGZvVk
         8h64o2rQYz2zfB3sbqyymVTJJ6G/lQTrI1yYm4h7aMb+xXWjuHaOqz2bm0lu4tbUWW3o
         cC3Ho5dvD+u4i/EuQDd8edw9SypQ8fLbSy7LjW82XmGcoLQ/Hpw6zHo+Zu7jdo9VNwQf
         sCz8zenWb/TfNpObzt3upEwRlaFn+myKEwmXdLwu4si0y+PkYdTDPQPIf/2ZXHLct8Y1
         vqesoGYVs3gRRYfc3NRZAMYzcShfW467tnBXAvmDkWQR0EgVS5P6TXXzA9b5iTtAlZ8k
         BJ3g==
X-Gm-Message-State: AHQUAuaT5LkDtWgFaypZyXlQQZQU66FQ9vXbFl2J/wLh5UpgYSpqLWxQ
        s6araG+t9ltssT2ZZs3LK0+dVIpZvcWxiIk0gI26vA==
X-Google-Smtp-Source: AHgI3IYhN1Tf9wSbp+kmMAUmWHkKJ3H1RY41+OBtG6UuvutXEBBYmSvt4CQ42BeAN2dCVTl7/jh9+S+Mie6BS6p4/D0=
X-Received: by 2002:a05:6638:2a1:: with SMTP id d1mr4544444jaq.2.1551359555232;
 Thu, 28 Feb 2019 05:12:35 -0800 (PST)
MIME-Version: 1.0
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 28 Feb 2019 14:12:24 +0100
Message-ID: <CAHUa44FUFCW82U3+a+t1M0u6va+D3PuGGBU8cPb_D055hzu3DQ@mail.gmail.com>
Subject: [GIT PULL] tee subsys for v5.1
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these small TEE subsystem updates. The license for two .h
files in OP-TEE driver is clarified with a dual license. The kernel
space tee client interface is complemented with cancellation support.

I've based this pull request on the last pull request I did (now in
the drivers/tee branch) in order to avoid a conflict with "tee: add
cancellation support to client interface".

Thanks,
Jens

The following changes since commit 5fe8b1cc6a03c46b3061e808256d39dcebd0d0f0:

  hwrng: add OP-TEE based rng driver (2019-02-01 15:12:46 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git
tags/tee-misc-for-v5.1

for you to fetch changes up to 32356d309c22a9497e612ed437d66407e15935f3:

  tee: optee: update optee_msg.h and optee_smc.h to dual license
(2019-02-28 13:49:29 +0100)

----------------------------------------------------------------
OP-TEE driver
- dual license for optee_msg.h and optee_smc.h
Generic
- add cancellation support to client interface

----------------------------------------------------------------
Igor Opaniuk (1):
      tee: add cancellation support to client interface

Jerome Forissier (1):
      tee: optee: update optee_msg.h and optee_smc.h to dual license

 drivers/tee/optee/optee_msg.h | 26 ++------------------------
 drivers/tee/optee/optee_smc.h | 26 ++------------------------
 drivers/tee/tee_core.c        |  9 +++++++++
 include/linux/tee_drv.h       | 12 ++++++++++++
 4 files changed, 25 insertions(+), 48 deletions(-)
