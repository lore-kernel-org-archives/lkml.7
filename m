Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE5FC43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D8B20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ivjq879M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394189AbfIFUAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:00:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38184 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394121AbfIFUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:00:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id h17so3038335otn.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=a797GSlScu7TceDm8JT9sMdOWrDRiCOoWgKbIGvEAOE=;
        b=ivjq879MyPjXeuWLQbzp6PpkI+gFVrJF92I5JYQYSOI7wweZURIWNxqsrewFxIlMjl
         YWKsMn04ooxcUoTEoyfzZg6SR3Aq0v8gQo+aZA8xLWmZaxq73KIaJg9LwlKONx3AW1we
         mG2Y6UFWVxanzI+wywN8oQndM4KFLqAuxL4DIJCVrnqvPuq+NVj7Op69hqa+CvdR20ko
         Weyv5tkeJ3jU88p17+WpZqAGcDQo0/aSzZuymFCRk7RhW7VXHcbZ6zfozPz8JukXPI8t
         +r3h58TsR9m5aFf1qMlPJ8+9FsNEWK3id0TM/FzBlZbnb7bzujkLIAVOiAh0nhH242/t
         Wx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a797GSlScu7TceDm8JT9sMdOWrDRiCOoWgKbIGvEAOE=;
        b=YMgk3T4PrsLi98HIh2ogF+MChXoEr5OAT97RuKYeWz749uVj33W3sxuPg5nuKqURLY
         36miMBFgDRwnoUGdG7J5yOntuRbGzOnfcIUlEsHGtba6yIhgZV1ELbYdCIxVOWhgv9Xu
         M4bd5tHdFpal2sUA/pOPfllJKIewcxHFfaT21Q0UMwGIstrD6/h5woNI4LTm8tWS0cNh
         YethAaruO5O1mf4hQ5KQbjjUB8+4gxKOim5YLeC39Omv24tLxlXzNUBIHcPWd0i+4xof
         ziYBmPkiLWZrPW3cs5FxWK8dvg94vSMKip1ByN/gfxC1fCzwwVhy9t+ukpYEzDbH4KsD
         NxxA==
X-Gm-Message-State: APjAAAVyfSfrs+c+kyeRWGPQgjuXiWvJ7NmjJF4wNzmMibsEaXGJVWU1
        gAX9kfagC4+5Q4DgfzsSFiizoybQc+z25T/VDp0k5A==
X-Google-Smtp-Source: APXvYqwwyf89TmMvDL8rpbSvr9eAas+QJDsbwLJoO4zMfL6iQ4m63v0JMuzagoFlmJsftEQgCE1iprUTYWm3zoEVJcU=
X-Received: by 2002:a9d:6d15:: with SMTP id o21mr9234698otp.363.1567800011694;
 Fri, 06 Sep 2019 13:00:11 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 Sep 2019 13:00:00 -0700
Message-ID: <CAPcyv4jDWgZDJTAgghrFX1MQXPJX_6jiqsmx9sQUOL7ZaWtk+w@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fix for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        jmoyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-5.3-rc8

...to receive a fix for a regression introduced in v5.3-rc1. The
latest version has shipped in -next with no reported issues.

---

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-5.3-rc8

for you to fetch changes up to 274b924088e93593c76fb122d24bc0ef18d0ddf4:

  libnvdimm/pfn: Fix namespace creation on misaligned addresses
(2019-08-28 10:33:13 -0700)

----------------------------------------------------------------
libnvdimm fix v5.3-rc8

- Restore support for 1GB alignment namespaces, truncate the end of
  misaligned namespaces.

----------------------------------------------------------------
Jeff Moyer (1):
      libnvdimm/pfn: Fix namespace creation on misaligned addresses

 drivers/nvdimm/pfn_devs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
