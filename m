Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A2C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4114F2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568134628;
	bh=UMv65zBvlpgle8E7mO8AeZIREr1Yo4NYVJ1nbN8qSVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EdWvs5YotHYNGhLkyW7LBKvCGB3spmlC1gfIe+NfJLlMimCPh/ndunqxH7YfcFF8S
	 w8464tPyj218wQ2n3GprbLYS4skWVrTpVVcPPZ1b1vg+Bv6E04SGcToPayTE0Ix/g4
	 UnZjz3195HCQfOgvd+gZ+hxO+ZUHznB0YuJy73Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436969AbfIJQ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436952AbfIJQ5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:57:07 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C054F2082C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568134626;
        bh=UMv65zBvlpgle8E7mO8AeZIREr1Yo4NYVJ1nbN8qSVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e1hX7isN+rAXTlm06BSmdEGyCvO3oQbCh6L/9Olfhzt4Y+y59rIpiBCm8PJpxCChO
         FCRcJF/2xU+q8Phok/2XXMX76E8p/JMAZlEGTHgtnqAVI+aswneboowGT8wmpPbbnn
         iARZ/NI6MaxQrc1CMVLcrjgzH43Kye41dyNNNz6I=
Received: by mail-wr1-f48.google.com with SMTP id t16so21416642wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:57:05 -0700 (PDT)
X-Gm-Message-State: APjAAAXxV08m6mJYF1SjHQUvt5JuR9ed+WU4lMbxvfg51bnGGy2KavY7
        esG9Who1KSbSd1t05PuRI5SPsCqP1aUs5e/CsM/WIw==
X-Google-Smtp-Source: APXvYqzfNckRdcOeF31SlRnVdskoQYKf5gkvVGtyy8lb/m05shVLaJXCnbiercrrU11/uQLbaerxQn/FCbkMHMmLr+k=
X-Received: by 2002:adf:dcc4:: with SMTP id x4mr19271602wrm.221.1568134624270;
 Tue, 10 Sep 2019 09:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190905005313.126823-1-dancol@google.com>
In-Reply-To: <20190905005313.126823-1-dancol@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 10 Sep 2019 09:56:53 -0700
X-Gmail-Original-Message-ID: <CALCETrU2Wycgdfo8vLZQUnx1J9ro=6ddSkP37BhsfBkKL1mbMA@mail.gmail.com>
Message-ID: <CALCETrU2Wycgdfo8vLZQUnx1J9ro=6ddSkP37BhsfBkKL1mbMA@mail.gmail.com>
Subject: Re: [RFC] Add critical process prctl
To:     Daniel Colascione <dancol@google.com>
Cc:     Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 5:53 PM Daniel Colascione <dancol@google.com> wrote:
>
> A task with CAP_SYS_ADMIN can mark itself PR_SET_TASK_CRITICAL,
> meaning that if the task ever exits, the kernel panics. This facility
> is intended for use by low-level core system processes that cannot
> gracefully restart without a reboot. This prctl allows these processes
> to ensure that the system restarts when they die regardless of whether
> the rest of userspace is operational.

The kind of panic produced by init crashing is awful -- logs don't get
written, etc.  I'm wondering if you would be better off with a new
watchdog-like device that, when closed, kills the system in a
configurable way (e.g. after a certain amount of time, while still
logging something and having a decent chance of getting the logs
written out.)  This could plausibly even be an extension to the
existing /dev/watchdog API.

--Andy
