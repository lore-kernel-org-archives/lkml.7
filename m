Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA631C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AB221900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfCURNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:13:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCURNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:13:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A95A3082B4D;
        Thu, 21 Mar 2019 17:13:08 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 144F6608A6;
        Thu, 21 Mar 2019 17:13:08 +0000 (UTC)
Subject: Re: [PATCH 0/6] sysctl: add pending proc_do_large_bitmap fix
To:     Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
        keescook@chromium.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190320222831.8243-1-mcgrof@kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <2c1811ae-1cad-8ec8-7948-519517cf4eba@redhat.com>
Date:   Thu, 21 Mar 2019 12:13:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190320222831.8243-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 21 Mar 2019 17:13:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/19 5:28 PM, Luis Chamberlain wrote:
> Andrew, Kees,
> 
> Eric sent a fix out for proc_do_large_bitmap() last month for when
> using a large input buffer. After patch review a test case for the issue
> was built and submitted. I noticed there were a few issues with the
> tests, but instead of just asking Eric to address them I've taken
> care of them and ammended the commit where necessary. There's a
> few issues he reported which I also address and fix in this series.
> 
> Since we *do* expect users of these scripts to also use them on older
> kernels, I've also addressed not breaking calling the script for them,
> and gives us an easy way to easily extend our tests cases for future
> kernels as well.
> 
> Before anyone considers these for stable as minor fixes, I'd recommend
> we also address the discrepancy on the read side of things: modify the
> test script to use diff against the target file instead of using the
> temp file.
> 
> Eric Sandeen (2):
>   test_sysctl: add proc_do_large_bitmap() test case
>   sysctl: Fix proc_do_large_bitmap for large input buffers

Isn't this missing:

[PATCH] sysctl: add proc_do_large_bitmap test node

?

> Luis Chamberlain (4):
>   test_sysctl: remove superfluous test_reqs()
>   test_sysctl: load module before testing for it
>   test_sysctl: ignore diff output on verify_diff_w()
>   test_sysctl: allow graceful use on older kernels
> 
>  kernel/sysctl.c                          |  30 ++++-
>  lib/test_sysctl.c                        |  18 ++-
>  tools/testing/selftests/sysctl/sysctl.sh | 161 +++++++++++++++++++----
>  3 files changed, 178 insertions(+), 31 deletions(-)
> 

