Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B928C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA63D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtJqBkDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfDLLAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:00:15 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34086 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDLLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:00:15 -0400
Received: by mail-wm1-f44.google.com with SMTP id r186so189378wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aNpJEdsmIxt8JO1EQ10k4o8b0/hSqREdTeoRUsBMoRI=;
        b=gtJqBkDAn1UQ5MPu8diM/47WTxqiyVar27GqfDi23XSOffjqOEixGj5AdVdYWrqHqg
         KKh6ESqBxlX3wMChavdISdVlhPxYLIvSQV2vO2MDrxnjIAJkNFZep+75N3a8buERgpIO
         ZF3bo2AJgf9o442pdeOS/+xE00pgmjzqJCf9BX6TDlQzpSivIIfuX4zfS/HvoJAfNo1g
         ZptWzXaZy0x/ml8wAfp4e5WFN++M2ZS9ex61eaU2gsRvwfnW6IyygXBPSYR4jz781cJJ
         jmEN5XZw4jDFhUeZPpmZ2KE7YuNdHFh5j468arxBrHIXjEc4E7bHbRAP//QOH0QREYnr
         HaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aNpJEdsmIxt8JO1EQ10k4o8b0/hSqREdTeoRUsBMoRI=;
        b=qZd9hGlxzo3tjx/VnmxuWY8RSPUNlQUL/kQpIwFMTFOY7bCTYaUZ7gE5OJt/LlwUqf
         H5PoB57oQ+DhyieA+b1RaIj8qc8BEMmbFHfEL7I/K/a7FmzSG0PnE7UIneNUZoS076BH
         9VqFa0TjGkwC3gMEn4fvfRwLpZTyYTjXTz8Ii79BQykU65GJHjZcp8QPRkiM+17EvD4S
         Q3t9/MTLbY7H39xj5TuAKDHGXnzHu3Dv44afQx6uGoUbCCDQqrupSKB7CdqUr8LQjj9i
         aKUxfOQgrd0O7hhqI3wmYEsnd5X8hFARL5KDZRFiPoq2t7oABDQ9kdeBCEiqt51iDTbe
         lmgQ==
X-Gm-Message-State: APjAAAVX3xncn50DQVRdkoHGjBdZNhEdt3oN0lKqjnW6n+vkj/DylGiq
        3cwHs2LBpkSCltOJ7Q1dl1tgej+G
X-Google-Smtp-Source: APXvYqySJBFG9wT4rRvDTVsR9B3e2yAHcMtoqFKIJnLguJkE1IXGMYV0feYY0/gfEh5rH2Ul87/Lcw==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr10412124wmd.22.1555066813950;
        Fri, 12 Apr 2019 04:00:13 -0700 (PDT)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id 13sm10275568wmf.23.2019.04.12.04.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 04:00:13 -0700 (PDT)
Date:   Fri, 12 Apr 2019 13:00:03 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.1-rc5
Message-ID: <20190412110003.GA14630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The "usual" roughly-per-release .clang-format macro list update
(trivial). Feel free to pick it up in any rc.

Cheers,
Miguel

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.1-rc5

for you to fetch changes up to f16628d6e8c6616b071ffe775908b95e07404cab:

  clang-format: Update with the latest for_each macro list (2019-04-12 12:49:54 +0200)

----------------------------------------------------------------
The usual roughly-per-release .clang-format macro list update

----------------------------------------------------------------
Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

 .clang-format | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
