Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA9FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 03:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EDA20828
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 03:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFBKmpMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFEDUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 23:20:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33442 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFEDUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 23:20:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so9164433plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 20:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KQxqODuHQSQtSovTOjbNPCaPMCE8H5PhPgJ8g/Tl5K8=;
        b=TFBKmpMV7EF0aCUjJUfIw6n8vOUKtCRAD2rjDvT7B3eNZN3+Vynr+gc+weeg3cdbMc
         GmyvgqAuNBBG5F30zfe4tR37tZbfIpqT9NlHqMQ4ymdtnCAR0m2hmHaBlucR9u8rkpbp
         CjUbJ1Vd1YSASQHoRe9jClWUn5SVkgcsZTBrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KQxqODuHQSQtSovTOjbNPCaPMCE8H5PhPgJ8g/Tl5K8=;
        b=eoGFiSDAXVvr63Z0FnSPGU6Y6RVgNLKhyL4WaNHdII+2M8gK/toEcqhiQLKsnqhel7
         biY0j2+WrCGCgnRrjfB+L8yMyNWIYukCs+tjLqqibi4Zj2xi3VZtpij9vR3AMciSPJLA
         YXuAkKh8YXffJU2+zXiWupJBZiRwvQlNp5n0FlOsXDucltWHfjmpz9IpDf0DthwGRwmD
         H/XA/ydf+AVUMh4zsB1MnP9pCwAAJKwxYn+ocbQiXTTxv9rv+mSWO3PAAGfIG/KFI3sn
         RRXm9nb+kdBgESqut6bzlJa2YgI0KUBqcEc4ZKHBmkERcEkzpaRHNFF5JfXNCC84XAMl
         ZKtg==
X-Gm-Message-State: APjAAAWO50Ve3dY1FfaCfzoLuQVeTtWS+5Ri3LdSJTI3KQl1CxnKZqak
        Lb5bBGjU8VbdWYodc5BlBFzHqA==
X-Google-Smtp-Source: APXvYqykLZu9VnTaUPCU45TKVYxiMnHtmMWT98CP2FahCw+wcqXd2E+4GI9WD2LayUPEOMq8WrJiYA==
X-Received: by 2002:a17:902:18a:: with SMTP id b10mr40528391plb.277.1559704823277;
        Tue, 04 Jun 2019 20:20:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o192sm13448583pgo.74.2019.06.04.20.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 20:20:22 -0700 (PDT)
Date:   Tue, 4 Jun 2019 20:20:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>, stable@vger.kernel.org
Subject: [GIT PULL] pstore fixes for v5.2-rc4
Message-ID: <201906042018.72255CAF94@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore fixes for v5.2-rc4. They've been in linux-next
for a bit now and catch some pstore corner cases found recently.

Thanks!

-Kees

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.2-rc4

for you to fetch changes up to 8880fa32c557600f5f624084152668ed3c2ea51e:

  pstore/ram: Run without kernel crash dump region (2019-05-31 01:19:06 -0700)

----------------------------------------------------------------
pstore fixes for v5.2-rc4

- Avoid NULL deref when unloading/reloading ramoops module (Pi-Hsun Shih)
- Run ramoops without crash dump region

----------------------------------------------------------------
Kees Cook (1):
      pstore/ram: Run without kernel crash dump region

Pi-Hsun Shih (1):
      pstore: Set tfm to NULL on free_buf_for_compression

 fs/pstore/platform.c |  7 +++++--
 fs/pstore/ram.c      | 36 +++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 15 deletions(-)

-- 
Kees Cook
