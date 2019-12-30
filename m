Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2283C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764192053B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HYJPn2l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfL3S3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:29:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36157 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfL3S3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:29:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id 19so34742386otz.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d9RUOUhHNYZ8b+xHO9R34q8NE4khkHtdBl8RVjB8OyE=;
        b=HYJPn2l+9Nf1Ii8FNdoU7z+ztmZohzKhAhCgRr3RN+6zN4u9yI7ORNKhiE9nqLDIvu
         IWUkPJ7hGmVUAiLEtRECq5FEm1puNA9nFehQeLwWvTl7RYAatnW0Q2zCYCK+pTU747A8
         p10sb5KUHvyBJXiRuAZ9hkkNC6Ql477LxPfws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d9RUOUhHNYZ8b+xHO9R34q8NE4khkHtdBl8RVjB8OyE=;
        b=YdRJOar2ffYtGPGAvc36SyxpAU4L4/JedALeZ+ctHiTwN4tmiLxnAbiQrHRRRHmiRS
         ARSV8f4C2226kwpHRo0Roe83UbVw2IUNNy4jGIGP2lga5ksTBXsdZaLDGJ+jQl57ivpa
         mbBXDr/3254u1+jBjqi94gho5y+HlaocSuDUEBSZz7hPwXxNPlmebOL0dEDwdlRaJny/
         znZ2N3y57JqY6C304TL9PQtxQOHow81539JOu6fsQVW02k7ZLNbx3jPFVQzLle8LRrBG
         j8EyHB8Hx4K2vY9R+5etSiqLE9Cm7iPBdw3uZLqhi8H5hiUeaGkFlWC4Xk3RoW8JmRtZ
         191A==
X-Gm-Message-State: APjAAAX/9r3UMepnpSSgLy3AbLfU49tYdbiySTh3sxYBWmMKxXQlIBZF
        Bv4QUQlWfegJutRzc3qtLoEYQA==
X-Google-Smtp-Source: APXvYqwDdsIS4g3FqEpGh+fozJ77By/dRChmx1Ui4Q8M7CdzFtu+0DPgHwxq0gwmCS5vUufaPGzMhQ==
X-Received: by 2002:a9d:4b05:: with SMTP id q5mr61198349otf.174.1577730586464;
        Mon, 30 Dec 2019 10:29:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w72sm14023710oie.49.2019.12.30.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:29:45 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:29:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 1/3] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <201912301029.46A91074BC@keescook>
References: <20191229062451.9467-1-sargun@sargun.me>
 <20191229161126.xcrnzdqu5frrov6q@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229161126.xcrnzdqu5frrov6q@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 05:11:28PM +0100, Christian Brauner wrote:
> On Sat, Dec 28, 2019 at 10:24:49PM -0800, Sargun Dhillon wrote:
> > The seccomp_notif structure should be zeroed out prior to calling the
> > SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
> > whether these structures were zeroed out or not, so these worked.
> > 
> > This patch zeroes out the seccomp_notif data structure prior to calling
> > the ioctl.
> > 
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Thanks!
> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks for this series and the discussion! :) I've applied this to my
tree for Linus.

-- 
Kees Cook
