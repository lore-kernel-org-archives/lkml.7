Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A8CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236602173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jGcpXKRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfH1RgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:36:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37510 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfH1RgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so108880pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6UE+8RvEo5nUTpBHC8CVrwLN+hK169/Ej6xs9Gc2BAI=;
        b=jGcpXKRmPVCZNwCgO1nKcsqMI9U4SCt8DCyYgPL6wc+VGQ63jM0BIJCMV7ThpFqOaZ
         cgvtyiGt6H0rk0gbF9bRN6ZSIzWOzLBSdbiK52O5rc0b5BLumbczgrM8ly3V9PDP6hYU
         jMI+A15m1bcvya2vfCUPnRzyPb/KjtVZeMTVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6UE+8RvEo5nUTpBHC8CVrwLN+hK169/Ej6xs9Gc2BAI=;
        b=pb9JTomD6Pj4JnH/fgu2GDq5KcaTkFeo6elK36XkpS9xGvZm90cdLm0WttU/ug60Sz
         cQZGz0ESlrYf9kZQ53LXpTX7op3V4Y/j+SQFghdNfHrJVxGdX+sGCAFQyxy5gMU1elaS
         bZke6nxXtsdkzRVtVrYetlQ72k/qpVxzK3pHAZI737h7hUMrPNIbpv3JF0ECAOW1g8ju
         io8VBC7pPgNxQ4wBn69WtHFzz6bacCcFVHHpkvp+pb0EDKCc6wnKkWLPi70JrysssFoA
         uOXHknarANTiPAubN3F5y4tkKIl4LqsdqmQrxmRLXaqkalSUfgXkNyA2WJPPq/0P5igX
         qYqQ==
X-Gm-Message-State: APjAAAVqV70rmMUPOJLHYmIlzfgnMYv3lIXU+21RebPO/lti2B19xdLr
        d8OahNNwtyStZ8tvXWZv91DpZg==
X-Google-Smtp-Source: APXvYqybGGo4hAWY0liuPOvcwNQox+SaWvfE3bLs/NnEpsFAI6tgV4NR3avVNk4mBqRMpi6eJKW6vg==
X-Received: by 2002:a63:d301:: with SMTP id b1mr4386883pgg.379.1567013782132;
        Wed, 28 Aug 2019 10:36:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b24sm3173768pgw.66.2019.08.28.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:20 -0700 (PDT)
Date:   Sun, 25 Aug 2019 16:23:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>, Shuah Khan <shuah@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Alakesh Haloi <alakesh.haloi@gmail.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ptrace] 201766a20e: kernel_selftests.seccomp.make_fail
Message-ID: <201908251622.0EE8CE0E@keescook>
References: <20190729093530.GL22106@shao2-debian>
 <20190805094719.GA1693@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805094719.GA1693@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 12:47:19PM +0300, Dmitry V. Levin wrote:
> On Mon, Jul 29, 2019 at 05:35:30PM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 201766a20e30f982ccfe36bebfad9602c3ff574a ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: kernel_selftests
> > with following parameters:
> > 
> > 	group: kselftests-02
> > 
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> The URL above also says: "Tests are intended to be run after building,
> installing and booting a kernel".
> 
> Please build selftests with installed kernel headers corresponding to the
> installed kernel.
> 
> Alternatively, tools/testing/selftests/lib.mk could be extended
> to include uapi headers from the kernel tree into CPPFLAGS, e.g.
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 1c8a1963d03f..b5f4f0fb8eeb 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -10,6 +10,9 @@ ifeq (0,$(MAKELEVEL))
>  endif
>  selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>  
> +uapi_dir = $(realpath $(selfdir)/../../../include/uapi)
> +CPPFLAGS += -I$(uapi_dir)
> +
>  # The following are built by lib.mk common compile rules.
>  # TEST_CUSTOM_PROGS should be used by tests that require
>  # custom build rule and prevent common build rule use.

I like this solution, as it's a common problem and it solves it in one
place for all of the selftests.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
