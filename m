Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B816EC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2C121920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmQ/UWjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfJBQvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:51:40 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:52024 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfJBQvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:51:40 -0400
Received: by mail-pl1-f202.google.com with SMTP id 99so9563678plc.18
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4INGfYLGyLALjI2XEapvgZEklVw6KiRSbjc8hD/raH0=;
        b=rmQ/UWjpQ9gSzRQMAE9Z2Xm1qYUhMcoVPefDNgkutcuhAi3dYBTO5gO3X0gTikcFBt
         A8aFY6lBh4YRc3ZV78aFfn9mcnZk7KNABwAsbR4rBLPsjkz7FkAd4W8JABWZtgwBuDRS
         qLf+e3Do4U0t5RzrMax6zl4/qxX2a2ca9jKJoTV9YMXCqsefR/zm+i6MoA40bIgWs0ef
         idGAQnt76kWKxc+sp4VlCpn/uEpphTcefYNTFu78VhpGeQerpQMrMGWrw4FOiaEEgZL+
         V6lhDzqU96Aa4+a1Wl2AY5D/AwQK7X6SwZaeXfsW6M/84YBqf1QCSC9wCDOjcD5nWs4w
         VBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4INGfYLGyLALjI2XEapvgZEklVw6KiRSbjc8hD/raH0=;
        b=lLv+3uvx+FFvwAdDJ5Vppu3iz6KtGlZ8XN6ljE0hDUOf9aidnNxJ5dQyqLYkXFMQ8v
         K+cw0zWFYeMghiPawF/+cZGYS9DwGbeQlMu8fvovbvgQR4W2GlA/I54j8szeZ4YHLaYc
         EAXcxGi+q4CJcgVJmQ4kKp6itcj6JL993NeWV+Sv1VMpg3RFqCwN0zLUIywgf6asztrC
         Exf86iOT3OsMWd0//tEOBJiGa7+8RJ7ew2zqKYJp9d+xAsPBpVDDWSCSah73/13qehQ7
         hdi5Elj26Z0VqyuTyW6nsCduHqkmU/+Sgi/U1QQNRIJT4wOWdkPihplv16c/I84leiSn
         A2gA==
X-Gm-Message-State: APjAAAU+Yv05ilQC1nMcOZZHS8xlTz3Pv2wus41Gg65pWXxRFNBuLspL
        aqoxHbrVN7H8ezPHnJx+B5zEECpu1CDlgDr9v6o=
X-Google-Smtp-Source: APXvYqzqokz2U9Wh/jeAoe5hFd5+Jm6Iq6mS+TfQ3qt8KuD3T5573f6jW+N2W7bdqA+tpZGrZLlRlVZZvHAt9/vymno=
X-Received: by 2002:a63:dd0c:: with SMTP id t12mr4611244pgg.82.1570035099268;
 Wed, 02 Oct 2019 09:51:39 -0700 (PDT)
Date:   Wed,  2 Oct 2019 09:51:37 -0700
In-Reply-To: <20191002120136.1777161-7-arnd@arndb.de>
Message-Id: <20191002165137.15726-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20191002120136.1777161-7-arnd@arndb.de>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: Re: [PATCH 6/6] [RESEND] drm/amdgpu: work around llvm bug #42576
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     arnd@arndb.de
Cc:     David1.Zhou@amd.com, Hawking.Zhang@amd.com, airlied@linux.ie,
        alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        christian.koenig@amd.com, clang-built-linux@googlegroups.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, le.ma@amd.com,
        linux-kernel@vger.kernel.org, ray.huang@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Apparently this bug is still present in both the released clang-9
> and the current development version of clang-10.
> I was hoping we would not need a workaround in clang-9+, but
> it seems that we do.

I think I'd rather:
1. mark AMDGPU BROKEN if CC_IS_CLANG. There are numerous other issues building
   a working driver here.
2. Fix the compiler bug.
