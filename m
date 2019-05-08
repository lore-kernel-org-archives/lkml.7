Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86487C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB5B21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="fyhKJivb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfEHWPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 18:15:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44057 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfEHWPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:15:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so79106pgv.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=j5oqTOZfM/wzYkzYzHKN4Rn4v0RHvVg75TpBk2POYs8=;
        b=fyhKJivbwhCNIxGWD9VvTgGZQKjleKYyb9Mn+KQlAHxbqmDCtpFfjUN+uV+YZydqi6
         6QNoy9xTULEVo7egm+6oSo/kP1mma7wOVte3SkokmKZpTqcGUSdSrJofu+C7TGf77luN
         7hqDemaQ+tC7BD2IsCHwP/6/zOl8D9PIgQG8PZsxyjlTpvM0NfJ1wk9l5IdVnmd0ebEY
         JGa3qbnMtOiSQ5QGWd2wzjZB/XZHf3Jtv4LGKjfOxLO91YWz8YzNUh/KICQl1FbTbwGM
         sahQDpNsbW2EBDgbLR4Lmi0uxMxyAOey+VHa5qodIMBEx4Lk8LxRb8E1Z7A6ISs4Ok9B
         P38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=j5oqTOZfM/wzYkzYzHKN4Rn4v0RHvVg75TpBk2POYs8=;
        b=DqYGtldPbCjeJ+nYgqQLAMmOIlHIDzmxgiJVDbtKaQHqdphQfytNeKa9yfQkShTNae
         rHxsg8qNgUbQj2Fg0W0DRubZzot8JUYd40snx9rCqWw0fa8TB5vSk/YSL6Js3xyXVyec
         gEE8uEuaRklaZvcZM30pSGdDHuLXPwG6AYfysPj9+R4ob87JsnZxTbWIqHqt+ATYw2zH
         F7k2zbWD0FoB1XTX7DlWXHQbwoSHfv4zfd/rMzYF71l1++uRL680oKDjKZprVz+Cf84e
         Ze8Pds7bB9KtOH9+j7olmCyBSGHEmKN9rrsFSvnykVoOA+G0mMu4sUT+OFh15t2byL70
         r5dw==
X-Gm-Message-State: APjAAAU95GL9rUARLn6LgUMXdbpsz3X+4MsL22iRNkVTMYyuCky/IZ1q
        fqa9sbO1jhXBfDEdXy8VL66hHQ==
X-Google-Smtp-Source: APXvYqxxMN7qFq9/AX3hvnuCjjJhcGy7LMd0mKniOf3SMu7iVKLc5c62dSki5omVauPXQnvl0Rs9uQ==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr53782264pff.135.1557353723141;
        Wed, 08 May 2019 15:15:23 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r138sm347933pfr.2.2019.05.08.15.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 15:15:21 -0700 (PDT)
Date:   Wed, 08 May 2019 15:15:21 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:06:47 PDT (-0700)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
In-Reply-To: <20190509074745.65336288@canb.auug.org.au>
CC:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-11a7c796-1d78-4c6f-8b27-e85a6aab3a45@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 May 2019 14:47:45 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Commits
>
>   da8e7c379659 ("riscv: Support BUG() in kernel module")
>   564bd22ea4e5 ("riscv: Add the support for c.ebreak check in is_valid_bugaddr()")
>   67363778b72c ("riscv: support trap-based WARN()")
>   efd48cf0b393 ("riscv: fix sbi_remote_sfence_vma{,_asid}.")
>   89f7840cf346 ("riscv: move switch_mm to its own file")
>   8c0e1593f15d ("riscv: move flush_icache_{all,mm} to cacheflush.c")
>
> are missing a Signed-off-by from their committer.

Sorry about that, these should be fixed now.
