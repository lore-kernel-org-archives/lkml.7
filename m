Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C47C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35272073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I7qvbT2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGIESI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:18:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46445 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfGIESH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:18:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id i8so8723139pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ch+TWdG/joUE9lf8R+pl5quiUqRnGlS6bkWi0bZbU04=;
        b=I7qvbT2pmgvla4Tv4ZBH0gu/pNnIqZOQYhld+Z69tMEluw0N9VcIY9vlRFKRnqAiKz
         s3XutJxuhB06ZnXrUErY/w0Ppf4fo+u/Xyi0UNJJPBH22TyTo6AsMrRK/MErBhoGobui
         54qX2rVq1sRkGdzWdVjUO9NOqNA6E6VV5C25c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ch+TWdG/joUE9lf8R+pl5quiUqRnGlS6bkWi0bZbU04=;
        b=udtknyHbVRIIDkwctHE+XEEVmBQ7/CvCDALmpfNJZ8dmUPgMysIvuyxwhzBO5quPLa
         9Lio0hT2Fh5nwDxlkQ4pWOFdqooMD9IA0S8JhxaszcW8mAutreifc7tfPAzqWaTEC2ap
         kidHr6iJxc+LVzoghDWbgSSxEmdygK06KSBm2dBFl4YL/fStXFqqSx2VxQF0kwkEdtSj
         gmwdPpiRzX/47tiAr9YPFBIoht13Symgdoan+RzT8QkU9WFcpikjDGEP/XX2w90dzfpg
         VGmKQrY5zL8bkKicfG5UIz3vnNVFvsjr5WsmluM4Dc/j/YB1v5mCvfl8pEXGU/tC9yAf
         xN1g==
X-Gm-Message-State: APjAAAXKn6ElMNrIvTzHFoEAKfP3DqHehHFUF/iIzv8JJI44K+UqmxMC
        OD/h2pba+XIJyWp5foYJWyXzmA==
X-Google-Smtp-Source: APXvYqwiqLP5al1XeM95Fx4LzJq7ytWTW67BL55u7btvZPYzto0IvkeZrVfkqRwlRLE4Q+3xTK4eLg==
X-Received: by 2002:a17:90a:cb97:: with SMTP id a23mr29515402pju.67.1562645887185;
        Mon, 08 Jul 2019 21:18:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t9sm991979pji.18.2019.07.08.21.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 21:18:06 -0700 (PDT)
Date:   Mon, 8 Jul 2019 21:18:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>, Ke Wu <mikewu@google.com>
Subject: [GIT PULL] loadpin update for v5.3-rc1
Message-ID: <201907082117.455440C84@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this loadpin update for v5.3-rc1. Details below...

Thanks!

-Kees

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/loadpin-v5.3-rc1

for you to fetch changes up to 0ff9848067b7b950a4ed70de7f5028600a2157e3:

  security/loadpin: Allow to exclude specific file types (2019-05-31 13:57:40 -0700)

----------------------------------------------------------------
security/loadpin improvement

- Allow exclusion of specific file types (Ke Wu)

----------------------------------------------------------------
Ke Wu (1):
      security/loadpin: Allow to exclude specific file types

 Documentation/admin-guide/LSM/LoadPin.rst | 10 +++++++
 security/loadpin/loadpin.c                | 48 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

-- 
Kees Cook
