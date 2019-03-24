Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD27C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6F920870
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfCXX4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:56:31 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47052 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727275AbfCXX4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:56:30 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2ONuT20011077
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:56:29 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2ONuOuv011181
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:56:29 -0400
Received: by mail-qt1-f200.google.com with SMTP id z34so8597755qtz.14
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=wgrEgdt1kG8viNf/9NRZYeT1drVr9t6S5RgZxCF7Y4k=;
        b=eidciJBMBUBQckT5lt/SOZYmFcYc3k1WGWHixVsZNoxIa8lNbEhLps7IxiE5nL4eV6
         Fku1EMcacUDopzlNJxjwXZ/3zpoNeioyy/AQjbNMWXFz+EGfE9Y8esBrGWc5y8DKmHqA
         hi4vzJlBKcLp7qtPaXoEvJeBoAkgKk+kglNxuv2E1G+iQyDj72o2OW7C1dtCktRS4a5Q
         0VVBzdT7YydMfROzInUhDcKm7ysakLDr6KSlmYXc20iZyP1aRHd9tL+1ShIBZ0XdBzGL
         9sf2TFB9QcZs/5OMop4SVw5mFE86E0i/2AUwfXQzZzoJMBqxSQVFRj4GypkTMyevHkkW
         bq1A==
X-Gm-Message-State: APjAAAX94LYzEk2zlewgtGcK1RdJBG+vhk+oiLZujwJRlNNZb84mtZIm
        zfmCjgvJxt7Rsl9F5cPjzR2yKhRldEr56Ho6tXPgh+4nbj81eGseizV5/LCM0Gi5HM0OfUpfC+n
        yEXh7rX8vBwlAuJM0sdfL9ez54efv9rhvmcs=
X-Received: by 2002:ae9:e515:: with SMTP id w21mr11732228qkf.200.1553471784208;
        Sun, 24 Mar 2019 16:56:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqznP1BqOVVs6kIR5Z/cqG1caFwvkevNrklX5T9m2yf3r5A1UFjx7WPCvT06wghT2dFdD4wSOw==
X-Received: by 2002:ae9:e515:: with SMTP id w21mr11732218qkf.200.1553471784026;
        Sun, 24 Mar 2019 16:56:24 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::ba0])
        by smtp.gmail.com with ESMTPSA id d17sm8047037qtl.43.2019.03.24.16.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 16:56:23 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Borislav Petkov <bp@suse.de>
Subject: Re: [tip:ras/core 2/2] drivers/ras/debugfs.c:9:5: error: redefinition of 'ras_userspace_consumers'
In-reply-to: <201903250644.2Nyq4fRf%lkp@intel.com>
References: <201903250644.2Nyq4fRf%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 24 Mar 2019 19:56:21 -0400
Message-ID: <5988.1553471781@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 06:41:49 +0800, kbuild test robot said:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
> head:   56baf8bd6c92819b1d89210fbfac2c6327a1271b
> commit: 56baf8bd6c92819b1d89210fbfac2c6327a1271b [2/2] ras/debugfs: Fix -Wmissing-prototypes warnings
> config: x86_64-randconfig-x003-201912 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0

OK.  Now to figure out why gcc-7.3 on Debian complains and gcc-9.0.1 on Fedora
is perfectly happy with the patch, or if there's something I didn't expect in
that randconfig, or if there's some other skew between what the test robot tree
has in it, and next-20190318 (the last linux-next I built, which didn't
complain...)

