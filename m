Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B62C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BF9214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT+cVRZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLQwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:52:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36213 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:52:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id y10so20481109qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=1GTUTqPyKA7fdLFpvNIrbSjC2AnzToYwfHxXwFmZPG8=;
        b=cT+cVRZgssMPkfVuB1mxiAURimCdvQr6nSutxCZoCyLq96IJIKkl1nHQousqSqzlFE
         ZpB3pRD6QmMKkQoHJsdWoMyS+d8xVfPqfYaMwNHBZgpgxb3l4d8o/VwRahgifnLyH/BR
         uXt0uQEKV4Hs0gPF38ZYszGQqx+aixr23cuSOIV2m+5I/rtK7n4Quzgq2AYO5F4s+kJD
         hhvHHSFS/3HUBKfMDorynD20DUbGf2QX4DjPCGrw/9lDVIOB5BxO57177yL5Ciew5uSd
         l8oJYfn+LFfGqdlkJUsZSgbdxCh5SgysGc7heTXBnqfl0sYkrPknMaXlZkRoTZmcC3v8
         MhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=1GTUTqPyKA7fdLFpvNIrbSjC2AnzToYwfHxXwFmZPG8=;
        b=uaFxiUpnhSxZkUScteusIt+7yrKvX+WILDa7JpmneaYW41/fP6Ir2xKdsP5P9koi4w
         D5ofgX46JSnzB7cWDKhKklHDCCuGQ6x+jwlnUfJN2DoHD5TfVqXIzlEih/n/HNAxtvyp
         mq+vAPnmvPsQyXMyHAw17r43nA2pBvdXHzBkjcbL4pM0kQtochWtL9RrTVuq2ELtUN7h
         rMMe/6M8CHZKAF++U93VnsK5IgqJ97Ukr1wx37Vt0Fqx4L5HG/L/X6ZLFwClXviBt7+N
         kBKDNKjccDfRMoUee/7e2KPArcvFINv652vl8qG786pyRcKig3iuIS1/Va+5bjL7wJXp
         qiiw==
X-Gm-Message-State: APjAAAUcH+tgM7CwY3JP3ungF937tafM2HIgc1VSBIeFME5gAgVv6xqU
        BIEWp3OWUv+zntOILsHktpXeFX1ywURPsA==
X-Google-Smtp-Source: APXvYqylaz5cmtZ+EhsRME1xXE8l0sORLh7oOhXyTQ4sS6/w6fz2HdaVJbRpM9LhGtjnQb6JVoFXgw==
X-Received: by 2002:ac8:60cf:: with SMTP id i15mr32626740qtm.339.1573577561213;
        Tue, 12 Nov 2019 08:52:41 -0800 (PST)
Received: from gmail.com ([162.219.176.52])
        by smtp.gmail.com with ESMTPSA id q1sm10477714qti.46.2019.11.12.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:52:40 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:52:36 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 0/9] staging: rtl8723bs: cleanup patches
Message-ID: <cover.1573577309.git.jarias.linux@gmail.com>
Mail-Followup-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset performs some specific cleanup tasks on the rtl8723bs
driver code.

Javier F. Arias (9):
  staging: rtl8723bs: Remove multiple blank lines
  staging: rtl8723bs: Remove blank lines before a close brace
  staging: rtl8723bs: Remove blank lines after an open brace
  staging: rtl8723bs: Remove unnecessary braces
  staging: rtl8723bs: Add necessary braces
  staging: rtl8723bs: Fix unbalanced braces
  staging: rtl8723bs: Fix incorrect type in argument warnings
  staging: rtl8723bs: Remove unnecessary conditional block
  staging: rtl8723bs: Rename variable

 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 186 +++++-------------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  19 +-
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |   4 +-
 3 files changed, 53 insertions(+), 156 deletions(-)

-- 
2.20.1

