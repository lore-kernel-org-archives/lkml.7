Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B16C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE9921479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHR/EYO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfJGWDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:03:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43637 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:03:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so9502928pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZGzcGWSg7j1xVwFlul4lYcpfYvPiRRuiper8S6eU8I=;
        b=OHR/EYO3cx6EzPLG+F/+e+l1QFiXnAScx7C66XtHVA4XkmhUKC8GCyCrw7porywgnY
         G52UMxivFJ3ALT04VoTi+K9+uuJlh/wG2mFaMuwE1MEax0cvsjjShc4khXPVh4hHfaPC
         MJWsVeU9IwaEM5alXFzudcZCuLv9f7HlfNXiTVP5q8HP0CMxVn5Z0xvYWY5j4YyIx35n
         skIA2xwOCPTtHRZR9D7bw++okRR0sytqs8Aie70egpUaO4SDNSz5qd63ZmEM5JIYeRP3
         VRvH4ETFFPrsUZ4CTtji1vrAzMLrnv3Bv+stoP0+uZEWJzKMC1E3fng9tz/Q5E9Cgtuh
         0rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZGzcGWSg7j1xVwFlul4lYcpfYvPiRRuiper8S6eU8I=;
        b=m0yNZLdHcSnJyMKo8T9YM3Xvn+D1xcmcjAXggxfxL4ivMn5DCXS2xmuG6ES+bpnh55
         MOZlrSidSLcCZFJVTeyc04NuXrhkzt5MqCQMRlAW+FqwrCzSKum7D8JETT2DHUxudbFm
         yxhn5vbaPQluQplA+mT1JFfRvO1AkG4pCFtXS5GLC0RnptsjuE16TiWj3kFGiRA/cP3u
         XmeaGqj5sc1QBNTHlin5GKbfQScG/yGUGzYkqpfYXxgMoPjJltVKOtvLIz5n28F5+MOC
         lDkVwZfE4h1H4bwivVXQsRZVo+mjCuFk/6arSP8KtKxUjVhnxFGuA0uz3HDbdh9uujj/
         3WGA==
X-Gm-Message-State: APjAAAVDE7GNqrF8I1Ez4P2qTyexkyqzRR5dlbyeU7niHqxMzgiAMrc0
        QDMmB6Bhb6DMQztyjxTFCE2tomgA3uK5CTXp5RDDJw==
X-Google-Smtp-Source: APXvYqymIFmH/VdtekqcD7IGssXBBT3ftOgwACxjQDDGzT3sa3TN5XbpsxVHSgFRKPMOa6CZsa+r/b9Fhw8989/rN3o=
X-Received: by 2002:a63:6641:: with SMTP id a62mr31888287pgc.384.1570485821624;
 Mon, 07 Oct 2019 15:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjAshr=JqVpF651eSZYFhwVAMNZ29LWcfrH07K_M9GU=hPnvg@mail.gmail.com>
 <1567786314-12330-1-git-send-email-sj38.park@gmail.com> <CAFd5g44=8TV4VciMkcD2DHR+UsnpwyEFbw2Xucwo7-as6Py_4g@mail.gmail.com>
 <1bc1c5da-2810-60d3-4e76-8d0b73fdd521@kernel.org>
In-Reply-To: <1bc1c5da-2810-60d3-4e76-8d0b73fdd521@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Oct 2019 15:03:29 -0700
Message-ID: <CAFd5g47GXbVk4AbRgKb5voG+DLyEEM+KEb+Fgw3u1qjRY2ZhmQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix '--build_dir' option
To:     shuah <shuah@kernel.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 7:33 PM shuah <shuah@kernel.org> wrote:
>
> On 9/6/19 7:16 PM, Brendan Higgins wrote:
> > On Fri, Sep 6, 2019 at 9:12 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >>
> >> Running kunit with '--build_dir' option gives following error message:
> >>
> >> ```
> >> $ ./tools/testing/kunit/kunit.py run --build_dir ../linux.out.kunit/
> >> [00:57:24] Building KUnit Kernel ...
> >> [00:57:29] Starting KUnit Kernel ...
> >> Traceback (most recent call last):
> >>    File "./tools/testing/kunit/kunit.py", line 136, in <module>
> >>      main(sys.argv[1:])
> >>    File "./tools/testing/kunit/kunit.py", line 129, in main
> >>      result = run_tests(linux, request)
> >>    File "./tools/testing/kunit/kunit.py", line 68, in run_tests
> >>      test_result = kunit_parser.parse_run_tests(kunit_output)
> >>    File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
> >> 283, in parse_run_tests
> >>      test_result =
> >> parse_test_result(list(isolate_kunit_output(kernel_output)))
> >>    File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
> >> 54, in isolate_kunit_output
> >>      for line in kernel_output:
> >>    File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
> >> 145, in run_kernel
> >>      process = self._ops.linux_bin(args, timeout, build_dir)
> >>    File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
> >> 69, in linux_bin
> >>      stderr=subprocess.PIPE)
> >>    File "/usr/lib/python3.5/subprocess.py", line 947, in __init__
> >>      restore_signals, start_new_session)
> >>    File "/usr/lib/python3.5/subprocess.py", line 1551, in _execute_child
> >>      raise child_exception_type(errno_num, err_msg)
> >> FileNotFoundError: [Errno 2] No such file or directory: './linux'
> >> ```
> >>
> >> This error occurs because the '--build_dir' option value is not passed
> >> to the 'run_kernel()' function.  Consequently, the function assumes
> >> the kernel image that built for the tests, which is under the
> >> '--build_dir' directory, is in kernel source directory and finally raises
> >> the 'FileNotFoundError'.
> >>
> >> This commit fixes the problem by properly passing the '--build_dir'
> >> option value to the 'run_kernel()'.
> >>
> >> Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > Thanks!
> >
>
> Thanks Brendan! I will apply the patch for 5.4-rc1.

Shuah, can you apply this to the kselftest KUnit branch? This should
not require a resend.
