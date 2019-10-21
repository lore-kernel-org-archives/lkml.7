Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB9CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50D421A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="COLjEalP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJUQUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:20:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40844 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfJUQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:20:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id 15so2754322pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zLEL7dsDenynfjgsbXg0GRcq+FGIXiWp49qmwa6PWUY=;
        b=COLjEalPHT6tAkyGMrtBqQjqOofnF+3uPIuhh1phIXfevPs1f0IKX7ZuK789YaXptu
         yBkwsdP+50j2XNM/mEsGxLKyMnRhC5CbW+UTMH2LCgu9WVXdLg/KqUxChY0ROapw4YgJ
         dG3hCYiPgrPTVTFT5QTt5U9yDjFhzLyHjxp9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zLEL7dsDenynfjgsbXg0GRcq+FGIXiWp49qmwa6PWUY=;
        b=kX3Du0KBP9UXZxi4WacUMxpKT8tOxB20pYc5oAL4mRSjIF8BFwS15bDbEveLrV2KVt
         tzBnNzSnmqOd8yYGUeKw2Bh5Z4MYamPgMEsf2i+Z7dDOzUFK9OPuL7yfFy0iVKQ04CN8
         PhQDpqdpsVEJ6e50G1i4BBAlhS6919Atm0vfcrxGrmMRDv6m72FyeXzqyTqok19MxHFE
         awmLDPPbKTnl68kSdVUXy+O+CI6HmWWwc9YZTdJDZuRYaYnVYAr83Wh0gn5U8t1zob8V
         3AEkuLewzx756x2zSd5m8pCm7jtwmjEiu5O3Uqp1BdFeCRCN+3e7eL6hUj0Pw0gLrRnW
         wZPA==
X-Gm-Message-State: APjAAAXZK3EONXFy3FC/beQ5gYV3AFE2tJKCfS5H9Zy1pk4DutkNwEEH
        ptW7oSZuBQa83ZP0Q2ff8sK1xw==
X-Google-Smtp-Source: APXvYqz9cCvZapa3UUtQmIIq4otAzcu5EyoBwpoNlgbPU8XVnJFoJLAvWGSMoDt95Avmw7kJ1GSBXA==
X-Received: by 2002:a63:5b0c:: with SMTP id p12mr4553783pgb.196.1571674808952;
        Mon, 21 Oct 2019 09:20:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 30sm17461316pgz.2.2019.10.21.09.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 09:20:08 -0700 (PDT)
Date:   Mon, 21 Oct 2019 09:20:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, rong.a.chen@intel.com,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        lkp@lists.01.org, luto@amacapital.net, shuah@kernel.org,
        songliubraving@fb.com, tyhicks@canonical.com, wad@chromium.org,
        yhs@fb.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] seccomp: fix SECCOMP_USER_NOTIF_FLAG_CONTINUE test
Message-ID: <201910210919.9187DFE5@keescook>
References: <20191021084157.GG9296@shao2-debian>
 <20191021091055.4644-1-christian.brauner@ubuntu.com>
 <20191021135013.GD28452@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021135013.GD28452@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 07:50:13AM -0600, Tycho Andersen wrote:
> On Mon, Oct 21, 2019 at 11:10:55AM +0200, Christian Brauner wrote:
> > The ifndef for SECCOMP_USER_NOTIF_FLAG_CONTINUE was placed under the
> > ifndef for the SECCOMP_FILTER_FLAG_NEW_LISTENER feature. This will not
> > work on systems that do support SECCOMP_FILTER_FLAG_NEW_LISTENER but do not
> > support SECCOMP_USER_NOTIF_FLAG_CONTINUE. So move the latter ifndef out of
> > the former ifndef's scope.
> > 
> > 2019-10-20 11:14:01 make run_tests -C seccomp
> > make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-0eebfed2954f152259cae0ad57b91d3ea92968e8/tools/testing/selftests/seccomp'
> > gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
> > seccomp_bpf.c: In function ‘user_notification_continue’:
> > seccomp_bpf.c:3562:15: error: ‘SECCOMP_USER_NOTIF_FLAG_CONTINUE’ undeclared (first use in this function)
> >   resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > seccomp_bpf.c:3562:15: note: each undeclared identifier is reported only once for each function it appears in
> > Makefile:12: recipe for target 'seccomp_bpf' failed
> > make: *** [seccomp_bpf] Error 1
> > make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-0eebfed2954f152259cae0ad57b91d3ea92968e8/tools/testing/selftests/seccomp'
> > 
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Fixes: 0eebfed2954f ("seccomp: test SECCOMP_USER_NOTIF_FLAG_CONTINUE")
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>

Thanks! Applied to my for-next/seccomp tree.

-- 
Kees Cook
