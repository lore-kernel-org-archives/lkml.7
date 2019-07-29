Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC24B20651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cw5OnLdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfG2Qb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:31:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43823 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfG2Qb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:31:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so20723550pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vq1Kz8k0O51lzb+4+nT4SnOcDRvvPOMVuyD9fuPhFbU=;
        b=Cw5OnLdNSKm6b88kLuQsbNDuU1qthb2yQQwAtKotZ5fUhc+DTrvjuYqwCTVAGDtH1t
         1tsZSW12ZyO9fXG3YB3xN3XlFBsKRBOJ9QIMDkK+awpKYxWJwBzA5TDAhSNd2yEfZk/U
         A35fXtlk26AesBlPqkZO+pFSjuOe55jkRx73A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vq1Kz8k0O51lzb+4+nT4SnOcDRvvPOMVuyD9fuPhFbU=;
        b=Nz6RNYHOXvs1JzKZfAtnXWyj+eRjG2FGZBhoa/tlZstssaVVW6gBac7qz8bmbmYTLk
         MZQOxyD7rBXNq/r5IywjvbXZ54pcZNmUMShy9rzVMBveOM7DN65nvif/jpibzzTZ77De
         duT5mQFrNK3xQx5nrtBbDXEJtrmWyZz+yUHz04U7WDWPwpQSLwpJomS3oXigTiu3kp1Q
         JtvJKg54NFhYzEbSp6T81a17UI5a/Z26eUCamrh+0MMgHIHABwwvXU8FRCpHB7SqcjZc
         bTwMjtv//hnouHXxMXjbachk6C3HnhRIOgzcJ7qf7bANvRSccB2c6T/7KtxOHVASquOM
         Aktg==
X-Gm-Message-State: APjAAAVMqBQw2iAIn/PNXtnLPaCQz4MXx7nntPaJ5NdmrnRkgVXpuEBo
        UjgZndy0jO7wDiMkek7uzz2FCQ==
X-Google-Smtp-Source: APXvYqwBFstQTHiCdChdn7F2ZhZ2y89R5nQrYhZKFeYNPKq/ZhzQUR5UbsmgLdCLjqGWJ0L6iy+ORg==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr109536484plo.302.1564417885250;
        Mon, 29 Jul 2019 09:31:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y11sm64852299pfb.119.2019.07.29.09.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:31:24 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:31:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        torvalds@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com
Subject: Re: [PATCH v3 2/2] pidfd: add pidfd_wait tests
Message-ID: <201907290929.09B5189@keescook>
References: <20190727222229.6516-1-christian@brauner.io>
 <20190727222229.6516-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727222229.6516-3-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 12:22:30AM +0200, Christian Brauner wrote:
> Add tests for pidfd_wait() and CLONE_WAIT_PID:
> - test that waitid(P_PIDFD) can wait on a pidfd
> - test that waitid(P_PIDFD) can wait on a pidfd and return siginfo_t
> - test that waitid(P_PIDFD) works with WEXITED
> - test that waitid(P_PIDFD) works with WSTOPPED
> - test that waitid(P_PIDFD) works with WUNTRACED
> - test that waitid(P_PIDFD) works with WCONTINUED
> - test that waitid(P_PIDFD) works with WNOWAIT
> - test that waitid(P_PIDFD)works with WNOHANG

Reviewed-by: Kees Cook <keescook@chromium.org>

This all looks good to me! :) One note that doesn't apply to this patch
in particular, but might be nice to add (as I didn't see in the existing
tests) was testing for pathological conditions: passing in /dev/zero for
the pidfd, etc. (Maybe I missed those?)

-- 
Kees Cook
