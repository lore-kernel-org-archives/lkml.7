Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C464C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6E524659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Z0IJ7MzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLFPLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:11:19 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37797 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfLFPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:11:19 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so7672037ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57pEqnXSldRzLvrDcH7m0RpCR7mrJMfc7+akKP2aM9M=;
        b=Z0IJ7MzW98V1EoUsqK/jwK58e+zbR3MCWwZW3HD+dbaIaiJJX/izGAH+xB8dCSFzaK
         DK8A4S3Gi5cLUNWfTnc7eBnKClwTl1IHJQddcZyg0/t6SYgWDgk+49P9vzOGqxNjoS3o
         0lsVkTR/ka6zEEKvv+OjuRXAcUfvPsvWmEg7K8iruy9nvPzyy5vG7h0iWdYHfij5YuYL
         uFDT9/lxvjgH2O21rzWrI4mDySbi1ksNKXiJNIZLrrPlW/ZSkSVm9OYpdUvhh0Q+sGJ6
         W50T/Ei3vLDesSTQpEImY9zug1Gb0C75wKwEx2iqaiCrzNdPGmuU97Dx0FPmVWz6Cndz
         4YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57pEqnXSldRzLvrDcH7m0RpCR7mrJMfc7+akKP2aM9M=;
        b=QqDV4KH1JC2BfUyuTER+0sOmFCqu7pP9Dr16tVmCHaQtbhByyehPKVnY4pNOBP+2mZ
         uxMQQyYIEAZyfTmD0Zb8saVlUFFJ3x098y3W5U+OkwDLaJJynuB6xfJ+ZBWWSjC9cblH
         kP5oK41yL0chD4rpe0BNVikH0KN9ea3RFTS+wvr2cuF407SZXHKBDo4nq2kj62bFRbqO
         LucWc8VIvKEn5NYaFuU+6dmV1MLogjVtIpa8qu6M4nSrklzDh4tGWvaHt7tLuboDCV+M
         fI44Qvx/0TYOgG6K48bokU4tljMOzXCq/W7s5fc6KoAxH7kc8InEDqBgrf28vHfVW4/d
         KpiQ==
X-Gm-Message-State: APjAAAW1tFzqIr86nNVpxDhylIZqzVd8YoOhuADTJYk3BYlvi7Tqwroh
        7LXp7W4Njxo6TLx8nOLcEEZN4nhauQsds+wsjT4jRA==
X-Google-Smtp-Source: APXvYqxrR56/jeNW5wfbXn3LAIfTS06TpB9+W8tRXSKJpjGFbmEs1ldrSVdUukpDamcdSKqNGjzJrDDaeSJSmy/UPww=
X-Received: by 2002:a02:6944:: with SMTP id e65mr13576018jac.11.1575645078544;
 Fri, 06 Dec 2019 07:11:18 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191206125123eucas1p1c1652484cbccef8d8df37e09affe4e25@eucas1p1.samsung.com>
 <20191206125112.11006-1-m.szyprowski@samsung.com>
In-Reply-To: <20191206125112.11006-1-m.szyprowski@samsung.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 6 Dec 2019 07:11:07 -0800
Message-ID: <CAOesGMgLrr_WBif-8jugA6jQL+zgJ27ruhLKeOR1aAN4BC1Yhw@mail.gmail.com>
Subject: Re: [PATCH] arm: multi_v7_config: Restore debugfs support
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 4:51 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Commit fd7d58f0dbc3 ("ARM: multi_v7_defconfig: renormalize based on recent
> additions") removed explicit enable line for CONFIG_DEBUG_FS, because
> that feature has been selected by other enabled options: CONFIG_TRACING,
> which were enabled by CONFIG_PERF_EVENTS.
>
> In meantime, commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS
> dependency") removed the dependency between CONFIG_DEBUG_FS and
> CONFIG_TRACING, so CONFIG_DEBUG_FS is no longer enabled in default builds.
>
> Enable it again explicitly, as debugfs support is essential for various
> automated testing tools.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Please cc patches you want us to apply to soc@kernel.org (and, if you
want, arm@kernel.org).

Applying. Thanks!


-Olof
