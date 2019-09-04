Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED9C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68F02070C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM6s1cif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfIDS36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:29:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53224 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbfIDS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:29:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id t17so4358986wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/3ryve8qFIa5Tc0ayz/+DZZfN1vz7ogNtKuUpJ6xy7w=;
        b=JM6s1cifCf/OXi1Ul8LmV+zJ6yHsOqzKaF3PYTWFQUPuh+q7Zyntwi5UsCodqKZrsd
         RTQUYA2lYshW+Ue7gxElG3aIW5m1EwfiKmjfKJSiEPuZsAQinwUwDOs1hd8pY0bmm4nl
         ct9O84rL54jMaXwUEVWzkumZD2kDG9Z3rLMf8VpZngenVb1S50Ud6YRRw78bCYTlV5is
         PPgdA0nmODoiOo1fbNdGC106H0sJpe4+AjuoRP6hEx0CU48O4y6XLgxjTwPGl/0pXI9M
         roQlY4XMsYh79ofU47eCjbzRrvI82JYh8k2AgkhCe88r6LH95lecSB9A+0+glXwBVDOO
         ahng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/3ryve8qFIa5Tc0ayz/+DZZfN1vz7ogNtKuUpJ6xy7w=;
        b=H04AEeKRTbMT+7ZbmZRh5HVac8sXrPP3CyQJBjO+D/D/vXwQijGQX7Zx3MWFDzYoYg
         0kj1uTN7a0GNLxPTHLSF+yKLXed3bPVNCDyZgozC0aDTiTPUnn+xlrzQ1u3o9c1JWb24
         FisEjOxcpWpQ55U1zOhW3gYs9kPjIGiCK+Ld59fz9lHrYYSsRSvfYCx+MiP8RJpGKlT+
         v84cONGc/bntB25uspG0O2gwQIEr2x4FA+lcZikUoOzZ3Sg4hExXRdqa/XVwpQElmMjp
         fN+g4uYzlyiBRtDJl4/kWou32RvRkFvdwg6EtNQiCORt6FQUW+RSlOsvX2dKPRk4b/7I
         mbAA==
X-Gm-Message-State: APjAAAU14+h6cW64ovd+Uh0+aejEDxMtRetFpIpKRfWoXdLdM7UtQdgy
        O4sItRzEU6T9ckLZdjFhxy0=
X-Google-Smtp-Source: APXvYqzZvqxl3yX757RGeKlr4SQvPHeW8Z/vf9FbhokVdTdLZphmuT+T8NG86o2z17+Qmf044JCk6Q==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr5605327wma.171.1567621796338;
        Wed, 04 Sep 2019 11:29:56 -0700 (PDT)
Received: from gmail.com ([157.230.19.186])
        by smtp.gmail.com with ESMTPSA id f75sm4416722wmf.2.2019.09.04.11.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 11:29:55 -0700 (PDT)
Date:   Wed, 4 Sep 2019 20:29:49 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.3-rc8
Message-ID: <20190904182949.GA22025@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this trivial update for the .clang-format file.

Cheers,
Miguel

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.3-rc8

for you to fetch changes up to 52d083472e0b64d1da5b6469ed3defb1ddc45929:

  clang-format: Update with the latest for_each macro list (2019-08-31 10:00:51 +0200)

----------------------------------------------------------------
clang-format update for 5.3

----------------------------------------------------------------
Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

 .clang-format | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)
