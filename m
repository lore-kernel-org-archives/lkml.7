Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C99C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0E920684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOLlVpJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfLCGsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:48:42 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:45685 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfLCGsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:48:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id r11so1097584pjp.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrUEQpnhjssA5H4ckLx1/FL4yMnKDJVtL3vS1urgk3c=;
        b=OOLlVpJm+w4AJN2yx2hZrTcrZJ3k3sy8lSHYPpvN6XZ9ploTJEIEA7bBYCzbBRt7yG
         24G1DjY1sW2lu77gPUtsz6b0HFGxKaD2CDltSF7FiVg5kyy0WpmKqHSo2uS1s9Qa0ZRI
         6F+OaGm8aksg028LhkmscCBPzYA1s+22EsdOvkMPfszSgKbHt0vqHVyByeBT31r1L9eu
         6ESyJXHpUka2Uj7ErZ7hg0iKSOdeypmLfgKoQ5qMSCSX7+yiKAzJKerBv5kNPr/PYc42
         F+oP+an8sZM6y4mFx1/AKjeYQZ5kNyGFVTretLd/mhbZmPFF82g/Wmwt1fKOT6SONTVV
         kQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrUEQpnhjssA5H4ckLx1/FL4yMnKDJVtL3vS1urgk3c=;
        b=OKI8xNo5TkGSZ0AM07QWkWRTvVm+hof6XvgL6CqshvzWooOu7mNMScmyj1oWAufu94
         8gOzhxWpQZNpZQaHZMuBDz6CekiRGVZQ3BbCSLYPDA4PqhGMb3h2pZz/mdgkCabqcGFV
         1E2B2GWb76utcgnC+2ghFgnn/I2KIVPIioQyefMBu18nx7GCLO+kqVOEyZIs6yoQ8b0q
         HyGQx/oMe/y3RwJP7g5hD9wilEUU9GiZq6p7rhW4BU6OnAR0NS+ofniM9GhlLNqgZ8Gj
         9C7+ghS5tRLKf+daCfFR9PJxRepclaBtlp8JbeLb/Mu9cGZGhxXQuSyefwMW77bUOZE+
         wIOA==
X-Gm-Message-State: APjAAAXXwSVkJk9DTqPli9kLz3R7Ssd3PR1foQ7eQ0vjj5EDtuLdMVoP
        4oSzN0H6/W/zdS9IyAlF8xbopnqDttIBRVy0kt06wA==
X-Google-Smtp-Source: APXvYqxg5MdII+ViMW9PQ/XsBs5+SO2UZbHgYTN/T+GWkJaALLpc5gamk8VhBLGEjzYRqnWtES6UF8zeBKnnFHqZ+9E=
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr3467227plq.325.1575355720790;
 Mon, 02 Dec 2019 22:48:40 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-6-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-6-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 22:48:29 -0800
Message-ID: <CAFd5g46TH31RkdFk5L4OFsuMmOA9SKJG_-g5bkehP1Z4uugrGQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] kunit: Place 'test.log' under the 'build_dir'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> 'kunit' writes the 'test.log' under the kernel source directory even
> though a 'build_dir' option is given.  As users who use the option might
> expect the outputs to be placed under the specified directory, this
> commit modifies the logic to write the log file under the 'build_dir'.

Good idea!

>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
