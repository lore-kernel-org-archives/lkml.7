Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEEEC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4342072C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eCHYX35v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3QNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 11:13:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36474 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfK3QNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 11:13:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so16128761pfd.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODJuHGe9WgQW36Ci2aMzJGsTEI0RMME9CeNAPNQ613E=;
        b=eCHYX35v0tNsJ8Wyr7huWqSL/Q7uu9HMJts4X7sI/QKLD3KSpwVU1yKPvnWbgBDkck
         w55L5neeBImSshB4MOgvDxkc/9a3orK3a1S1HHbjOdPtVF8JRjkP0b1vdUZecBgtQ4Bb
         d660NmRHJmW/YEooGXS1R++4WmwRxc6UkSjVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODJuHGe9WgQW36Ci2aMzJGsTEI0RMME9CeNAPNQ613E=;
        b=e4VySywJUHmMNJg8TnJ5AGbtB+XK5GHgte7zuV7vDYEjDNmnQdSksGkHF5VN4+WtHj
         4i+FDqI4it+9giXOFf81AO84t65gc4DytJPGYgRjQbvHfZrIX1WOOsrUQ5jg/Xhv9UXL
         FXwRlY65eKC/mgd4x/ZRfPe8vvQQ/HMCuprgQZSfa2kTzpjFUAh2Xr+7qFmt0bQkIY//
         2kKA9ekUQ2ctx7jwi8jePIxeAJUI29/+5x+RAWUIyT7q9oHW1E4nBw3UNOhMSuNgxTZH
         wG1p+y7Oj95lbX4JWed5O/dgknisWt1a6YMXA7VrLA+XZSTsd3Q8CylWi2qT+EE1YuDY
         +a1w==
X-Gm-Message-State: APjAAAXk9ElRg+6+DB6WXuq6EAUy5RDablKebf36R6FoMS8PKvyTHOEj
        IpmEd8FqvURiTRZlsLXFAcE/7w==
X-Google-Smtp-Source: APXvYqwvXF4TzszA69py9gZ9mkRu3KVHToAXHaiaVpGpYAkkePvJ1gRXWxfBHEFfpcptgaOJhaJtkw==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr64130438pfb.63.1575130383668;
        Sat, 30 Nov 2019 08:13:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67sm19071797pfw.82.2019.11.30.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 08:13:02 -0800 (PST)
Date:   Sat, 30 Nov 2019 08:13:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] tools/testing/selftests/seccomp: change USER_NOTIF_MAGIC
 definition
Message-ID: <201911300811.7D70D30@keescook>
References: <20191129055128.25952-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129055128.25952-1-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 09:51:28PM -0800, Max Filippov wrote:
> USER_NOTIF_MAGIC is used to both initialize seccomp_notif_resp::val and
> verify syscall resturn value. On 32-bit architectures syscall return
> value has type long, but the value of USER_NOTIF_MAGIC has type long
> long because it doesn't fit into long. As a result all syscall return
> value comparisons with USER_NOTIF_MAGIC are false. This is also reported
> by the compiler when '-W' is added to CFLAGS.

Hi! Thanks for sending this. There is already a patch in the pipeline
for getting it fixed; it should show up in Linus's tree soon:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/seccomp&id=223e660bc7638d126a0e4fbace4f33f2895788c4

-- 
Kees Cook
