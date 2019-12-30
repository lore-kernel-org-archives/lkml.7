Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF70C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22162053B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n4SWnhu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfL3S37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:29:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42964 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfL3S37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:29:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so47187218otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zfxgfsqm1SJE4TcJmYRwd0qOITSW8/a6fexRTjW5qIA=;
        b=n4SWnhu/BznKX8qVa8EVmGkKn7yo9GEeI8hzW1AoM4LbRJ9fqWrWsUAXA7igDJALtc
         1DQMqYL+U4ynftk3nwB1VgDbUBfcLgLsL53dif8B94TG4L1+y7woRTR6y5mnR5IMlMNj
         ww5OiPYJaet6qx5sFxwJJG2fiQcvJOLhAQ8LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zfxgfsqm1SJE4TcJmYRwd0qOITSW8/a6fexRTjW5qIA=;
        b=P9QLaPsHSUUOaMGQbiXcMn6YAFyd3lVIn9WVjqpjZPSRYcft34mHsTJ2dNGdq1ND7x
         Db/lhqqi5Dx6zdAXl0eEzfMydFnwl2w6pxhgAjqyvzuWFxoCN8/0zHaVcC4Lc2Sqd2Tm
         MQnNC5Yi3BwLkPAlNHOSsD6p9+7Omk6F+FZTllrS6EGadr+Bc9n7XqGAk5NhSgSXeqPW
         8GVy5O8o025agTGdMc/qQCP53xiPXlCIL+f3pR8DDBtPrt6O0EsGF17d+kPo+F7vlM6D
         m7grSniy9Emjyx18B/6tTbxkYC/EzLPj8RCN8CJZFj5SWiobKTABL/vJKj6/eh2PPYt7
         2OVg==
X-Gm-Message-State: APjAAAUdLl/GX8Zq4qoGlXue/37GF9IwsJrSgg1glzQ2UO9NCrHewc9S
        McWm/ODDFFzncNp0j1nKFcTpww==
X-Google-Smtp-Source: APXvYqxhKs3RF28JdXdrd1kkJLiQz7ewiOWTRKqumqPgpFOFYzu9ZLQBdr5vMThF5m3/AI+NAIVidw==
X-Received: by 2002:a05:6830:1cc5:: with SMTP id p5mr51090774otg.218.1577730598657;
        Mon, 30 Dec 2019 10:29:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p16sm15957208otq.79.2019.12.30.10.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:29:57 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:29:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 2/3] seccomp: Check that seccomp_notif is zeroed out
 by the user
Message-ID: <201912301029.E9739655@keescook>
References: <20191229062451.9467-1-sargun@sargun.me>
 <20191229062451.9467-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229062451.9467-2-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 10:24:50PM -0800, Sargun Dhillon wrote:
> This patch is a small change in enforcement of the uapi for
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Specifically, the datastructure which
> is passed (seccomp_notif) must be zeroed out. Previously any of its
> members could be set to nonsense values, and we would ignore it.
> 
> This ensures all fields are set to their zero value.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> Acked-by: Tycho Andersen <tycho@tycho.ws>

Applied!

-- 
Kees Cook
