Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC71C4360C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782EF2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnBW4+yN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfJGDAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 23:00:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42570 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJGDAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:00:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so7279347pgp.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vTvh0FQZ/KhCJ68up9YEl9SX+BeG73ASVfHO5zvMDJM=;
        b=pnBW4+yNeJiOvFev/FBahaxuA/+IKA/Rf8nRcxzB4pKZONAC2XLm/hnyyDBsGjehcg
         wm8TGc/FQXnVFemowR75iS6+8TAVudcc/tBCLYGtCXx0I1phqvpnwlxx9bhiQ/VBNyDZ
         6MWPBECh8S8kw6mPxsNixJ8AblZckIusrtc3cmIfxg98IubDa+fy0ldWi3aulLmVn7eF
         GJ82B37gvl+J/1leoRKWvb0nnUSMCyyYRD9H1bCgrmtNCKMKyTljCRAoia6v2BdX0ReQ
         vO6yfijhIUUPCY2Dk/tRMTrIVZBp5+LUv+qtEd07neyox/ANflXgDb7m9wQf1nKId045
         OKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vTvh0FQZ/KhCJ68up9YEl9SX+BeG73ASVfHO5zvMDJM=;
        b=frW3aAQaW3XMfJf2cCxzJuCn/LYlixkq4556MS3VyYU1aM7WOaYkqDgoiJeoa1Rwpk
         MsqFgZmMKOQyo7cHtG0A3qUkMVusTYd1/nF8kIRgqNJV9/df4RuNe+pyCUJWgDKtRc1i
         LYry08GLKbIdGUDJj83mSb2qTeOTYGrjkRoFxCKse6B9OA85/0ICmH3ZS4SMIuVp5FIR
         n2nQF79ItW8czYnSWZz+wfjPH9Mi6FfKBM28pGbWdHsaBqgt5CY9TjCQxb66nBbfYmno
         XA37RDmMWFi3pRjBYIV3wf3zTlsYuioRMJlfCkcCsLWtPi+kLqXzG8/VCZ5AqAVnT2Gs
         FIhg==
X-Gm-Message-State: APjAAAXRiAsDvU8aPTF5x4kdD5LE2FbRm9my62BUcWI5YWUX0pQxVBTm
        vndPhy6Y7bGw2hkzZ9on38+yFA==
X-Google-Smtp-Source: APXvYqw1T1sFm6H6Vjb3uGu/gG/MP1nBY1c5P92A6GhL0ICys7/bELhWv37NMbR6VjUTvd442kiViQ==
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr30314340pja.135.1570417241029;
        Sun, 06 Oct 2019 20:00:41 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id u9sm11554379pjb.4.2019.10.06.20.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 20:00:40 -0700 (PDT)
Date:   Mon, 7 Oct 2019 12:04:38 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: kexec_file: add kdump
Message-ID: <20191007030436.GW18778@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com, james.morse@arm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190912060150.10818-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912060150.10818-1-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reminder.
This patch set is still applicable to v5.4-rc although there is one minor
conflict in a comment; It is trivial and can easily be fixed.

While this patch works on v5.4, we cannot read a generated core dump
file with crash command, even, of the latest v7.2.7. This is due to
a newly added 52-bit address support (and related changes in mm).
The issue, as a nature of kdump, does exist with *legacy*
(non-kexec_file_load-based) kdump, too.
(We will need a kernel patch as well as patches on crash to fix the issue
and some guys have already been working.)

So I'd like to request you to keep reviewing my patch.

Thanks,
-Takahiro Akashi


On Thu, Sep 12, 2019 at 03:01:47PM +0900, AKASHI Takahiro wrote:
> This is the last piece of my kexec_file_load implementation for arm64.
> It is now ready for being merged as some relevant patch to dtc/libfdt[1]
> has finally been integrated in v5.3-rc1.
> (Nothing changed since kexec_file v16[2] except adding Patch#1 and #2.)
> 
> Patch#1 and #2 are preliminary patches for libfdt component.
> Patch#3 is to add kdump support.
> 
> [1] commit 9bb9c6a110ea ("scripts/dtc: Update to upstream version
>     v1.5.0-23-g87963ee20693"), in particular
> 	7fcf8208b8a9 libfdt: add fdt_append_addrrange()
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612641.html
> 
> AKASHI Takahiro (3):
>   libfdt: define UINT32_MAX in libfdt_env.h
>   libfdt: include fdt_addresses.c
>   arm64: kexec_file: add crash dump support
> 
>  arch/arm64/include/asm/kexec.h         |   4 +
>  arch/arm64/kernel/kexec_image.c        |   4 -
>  arch/arm64/kernel/machine_kexec_file.c | 105 ++++++++++++++++++++++++-
>  include/linux/libfdt_env.h             |   3 +
>  lib/Makefile                           |   2 +-
>  lib/fdt_addresses.c                    |   2 +
>  6 files changed, 112 insertions(+), 8 deletions(-)
>  create mode 100644 lib/fdt_addresses.c
> 
> -- 
> 2.21.0
> 
