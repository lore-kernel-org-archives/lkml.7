Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48E9C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 21:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C14E206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 21:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Qc99rLKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLUVHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:07:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38808 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLUVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 16:07:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id d7so12314304otf.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IQDzCGNeAK5EBtUX/LCaBsUYMxFLJD3gX/4djK3YpRc=;
        b=Qc99rLKJgNWmEo4aen5nEwhzg0Id7tJ25T7TMJzjSGBHrUlcLKVEARoCtwqqkbUWnx
         uupcmM2Kbu4hbAw+axe5k9rWtzyRnSRh9NrhQFLqGNJUn/rIBg9PASLauLvb+vXYLhi0
         SacpUI9vfda6grwUlYTSOaw6h8UCjDlPm3ZUzgCBW9io+sF2BOjtT52nu07Cp9Frd9fu
         DjjItt4s6wdKeRzbzjKJa2v1ephnx7CZBesu0nHlod7IUS5zjBOa0gD/oVDl/rQquKGI
         8nXANHDmPfeB6GH6iebGxM+Jrd+AWW14x7IYdBPfs5Q5sL6c3/uF860uGgO9MCuHJ8e7
         v5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IQDzCGNeAK5EBtUX/LCaBsUYMxFLJD3gX/4djK3YpRc=;
        b=PknJQ5rtnVlUglkHOTMes3XA3AywjISu3Z4YTYPxTcG6Ax4gzzDxypyogLYxRMYgy2
         TOPyEIgJ+pXEYaqu5NdA41/Vzt7aMhVALuvMGbYa4vhS0PWkQMipz6Pr79BvlwJlwLuu
         LZaJoo0uwR0U5CnpnQrAwOqYTPODNmBjSOYMdIkUTaJWNINbFD6kPdtXOmpxhfDvsyRR
         KgFf907s21a3AQQQLXv4+oBMiv7qVDFOcY6WCXxdcUZHAJyjKz/8vz1Wx7jcO99OUtas
         zwZwkE+hvrUjLsLlH/qisBpb9hVzcbBUWVFZaWyBy7M+7DqjHhcKzEsE1Sdfx9uQq7BP
         cSRw==
X-Gm-Message-State: APjAAAWieELcQMm+U7i9cX7j6typKIHP7YWxyLS9frFxKDwjXGcSTwvz
        3745Ax0bWNgJ/jJYKsqXwSJuHjJ6uqNN0Q1ryoGD0kOH9do=
X-Google-Smtp-Source: APXvYqzA75IgQS6VboqDPPddv0Nmm2P0sHQlEcSJ/8iJ0sdo9xLSQTvgYrEfrvkcQTYOnRoSpRzPnKHKGsvCcFyyDks=
X-Received: by 2002:a05:6830:174c:: with SMTP id 12mr4748830otz.71.1576962451276;
 Sat, 21 Dec 2019 13:07:31 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 21 Dec 2019 13:07:20 -0800
Message-ID: <CAPcyv4gfbuttbdW0ea6EUzMihUK33cc0mBQmLjqZe1T_QCKF-Q@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fix for v5.5-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-5.5-rc3

...to receive a minor regression fix. The libnvdimm unit tests were
expecting to mock calls to ioremap_nocache() which disappeared in
v5.5-rc1. This fix has appeared in -next and collided with some
cleanups that Christoph has planned for v5.6, but he will fix up his
branch once this goes in.

---

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-5.5-rc3

for you to fetch changes up to c1468554776229d0db69e74a9aaf6f7e7095fd51:

  tools/testing/nvdimm: Fix mock support for ioremap (2019-12-11 17:11:10 -0800)

----------------------------------------------------------------
libnvdimm fix 5.5-rc3

- Restore the operation of the libnvdimm unit tests after the removal of
  ioremap_nocache().

----------------------------------------------------------------
Dan Williams (1):
      tools/testing/nvdimm: Fix mock support for ioremap

 tools/testing/nvdimm/Kbuild       | 1 +
 tools/testing/nvdimm/test/iomap.c | 6 ++++++
 2 files changed, 7 insertions(+)
