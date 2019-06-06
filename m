Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EBFC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FA820673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0T5B+WL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFFHcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:32:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33479 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFFHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:32:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so1277092wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e28AQOSNVuH9BCwVassenAYllziB9rQBHwACuXiGBI0=;
        b=R0T5B+WL33Rb+7uIk9oZ2CfauW9TfoR9f4Ly4IEcBtR8WIsyabWCxdAqgbIqipJVGg
         U7H9DxzBMMfxBr2kAGi4+ehn+1Y5+ZdpkB3wuD5XQ7LQjyIf99N8AXJBvuc1BjDcYe77
         2SZioFYBlg6gdCHcBAU8FPkTjViAU9eJswBY5JNKxz3qJmvflMb5Q8rrnXbX+T0yx6an
         n1r7ZfylkrbgHy6OIiRWlg5yjXdMSUbTS+42T20qpGAGJkfGioI2/rzs94AvAHEzsSwU
         AhMlp8Tl1wbR8bk3WaNmteA2D8wlFqwZuBu7k051aXLgM61DxJSKxg91kKvxufGw6FfS
         OWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e28AQOSNVuH9BCwVassenAYllziB9rQBHwACuXiGBI0=;
        b=JGLu22RlJUF6Mw9j+hFNXn9J+F2W3MM7Ht3a5uyj3WxzShIQfQBh+Km3HCPG+Mk6vP
         YZCdVfWgmw5thXfoZ3lXhysnDbvMS/vOqPc8WDstohUL6tHO9CCswJt02mplFfeJ+8ds
         quHNkTLw6Lt275OQdjF/NIhJ+0t/BzE110tZMYG0Hh8NgXeXr+KdEfINHR/CePHG8JYd
         8pQoaWAFUU9cBwMeyUX2/qKPuewYt0jJQ52uatJOjTW0NsDCiF8CZEyjKvfc9NpMM/nG
         zt4oMLBwx0WOwR7qonpzxoCs776zelspIklqB8rUF5R0lIeEuSUqPwbplJVSLHkiTFar
         M7hQ==
X-Gm-Message-State: APjAAAWrnviZ9W50dW37IUfLoYuT/qf33vURvoqCeBDZFHriomzATytR
        n6f0wNXN42G0JfWxli3e5WI=
X-Google-Smtp-Source: APXvYqzbAH9hxFr+sRNq84PkdhhVpJM6uCPG0O2/RRBRmeLqyquMVnHBZT7i8gSziEou+SBHmd7J8g==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr27270317wra.261.1559806339282;
        Thu, 06 Jun 2019 00:32:19 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id x83sm964216wmb.42.2019.06.06.00.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 00:32:18 -0700 (PDT)
Date:   Thu, 6 Jun 2019 10:32:16 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.2-rc4/5
Message-ID: <20190606073216.GA31142@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is a pull request containing fixes to be merged to 5.2-rc4/5.

It contains 3 bug fixes. See the tag comment for more details.

Thanks,
Oded

The following changes since commit 8aa75b72e3e6f0f566cd963606ec5da11b195c0b:

  Merge tag 'misc-habanalabs-fixes-2019-05-24' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2019-05-31 09:19:42 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-06-06

for you to fetch changes up to 1f65105ffc472624b45aff8bedb819c10a85944d:

  habanalabs: Read upper bits of trace buffer from RWPHI (2019-06-04 15:13:09 +0300)

----------------------------------------------------------------
This tag contains the following fixes:

- Fix the code that checks whether we can use 2MB page size when mapping
  memory in the ASIC's MMU. The current code had a "hole" which happened
  in architectures other then x86-64.

- Fix the debugfs interface to read/write from/to the device using device
  virtual addresses. There was a bug in the translation regarding
  addresses that were mapped using 2MB page size.

- Fix a bug in the debug/profiling code, where the code didn't read the
  full address but only the lower 32-bits of the address.

----------------------------------------------------------------
Oded Gabbay (1):
      habanalabs: fix bug in checking huge page optimization

Tomer Tayar (2):
      habanalabs: Fix virtual address access via debugfs for 2MB pages
      habanalabs: Read upper bits of trace buffer from RWPHI

 drivers/misc/habanalabs/debugfs.c             |  5 ++++-
 drivers/misc/habanalabs/goya/goya_coresight.c | 14 ++++++++++++--
 drivers/misc/habanalabs/memory.c              |  6 ------
 3 files changed, 16 insertions(+), 9 deletions(-)
