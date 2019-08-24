Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F0C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCDF2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1/sIPUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfHXDwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 23:52:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39030 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfHXDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 23:52:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so6892977pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Syad2iPtdLZLKQPwC2EQhBs9/OI7kvb9K6gEE+BBruE=;
        b=X1/sIPUj0fzr0BM3fFzEqMryzHdzp6gRdi8TsRSBKs+ftysd7IABbTojQxRf/j+Eb7
         pHHnPdMY0uAoXzCjnLVExLt9DbuoM0BtAvSeCRHWgL0UE8zig96z3zysb90uNyDWOIbW
         oMbbqOwPKKLWTdbqOiRQYzdq5CxV8768KEr9CM+Zx7NrLrVwMVOwR9RJON3EM0qhC5Dx
         q2a4JU/yStuoYaV+lE1q/jSI3fGXeEs/cFPScr+TUgGn+WDdTU1MQH69xl0UvTtD7RcC
         qlF0nTKDSHAFdZPbmESrPqehmFwAZpM328p2o1pL9kUehbPTV9URCIPs3jLX45MkYPDb
         z1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Syad2iPtdLZLKQPwC2EQhBs9/OI7kvb9K6gEE+BBruE=;
        b=MEuy56Bcw5jCL4jbo8JlrxdtwExNcLu/ICip1QzkcqKW9kcPhlXgEpdS3ssZeWHF4j
         nZ0vrWCtvQ17BfvHBVEGrvXUagkojua4cD/TCOj4b87YzkJaViouiUuZ0wu8q2oOhz/j
         +ouWuUBp42/e2w+0wtSWT96EeHkY6x2WxSRfE/IMA/yweIjPuYVWVihhzwjBbXCQSUao
         C0dDo4a7g3+eNZi7pFpdt2C8OQ+xGvOUo65ySw6recnDO8hAxWqBz5rjKh4BAeH44Bf+
         T8xeHxMARDYIzGqcEFxIo3wnxQAnag62lfefBXdOuBsSY6YcH4ijFukZ1w1xyWuv/1rB
         n+xw==
X-Gm-Message-State: APjAAAW0fzVTByTm+F7yXdXjnDlncYAtPt7swEjQYnYcq3MCENisK9OZ
        HGOzfunvV9GeLdU//hxMixY=
X-Google-Smtp-Source: APXvYqy1eJmoXR6J5YoBthflZsSngyo21PqhntK319rgmYiR42uWn7csPibk7er1GPJm/u+s3sy8sA==
X-Received: by 2002:aa7:8106:: with SMTP id b6mr8906009pfi.5.1566618761111;
        Fri, 23 Aug 2019 20:52:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:9d6:5ad6:c421:f555:f963:8f89])
        by smtp.gmail.com with ESMTPSA id c71sm4835015pfc.106.2019.08.23.20.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 20:52:40 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] [semaphore] Removed redundant code from semaphore's down family of function
Date:   Sat, 24 Aug 2019 09:20:59 +0530
Message-Id: <20190824035100.7969-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822155112.GU2369@hirez.programming.kicks-ass.net>
References: <20190822155112.GU2369@hirez.programming.kicks-ass.net>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 17:51:12 +0200, Peter Zijlstra wrote:
> On Mon, Aug 12, 2019 at 07:18:59PM +0530, Satendra Singh Thakur wrote:
> > -The semaphore code has four funcs
> > down,
> > down_interruptible,
> > down_killable,
> > down_timeout
> > -These four funcs have almost similar code except that
> > they all call lower level function __down_xyz.
> > -This lower level func in-turn call inline func
> > __down_common with appropriate arguments.
> > -This patch creates a common macro for above family of funcs
> > so that duplicate code is eliminated.
> > -Also, __down_common has been made noinline so that code is
> > functionally similar to previous one
> > -For example, earlier down_killable would call __down_killable
> > , which in-turn would call inline func __down_common
> > Now, down_killable calls noinline __down_common directly
> > through a macro
> > -The funcs __down_interruptible, __down_killable etc have been
> > removed as they were just wrapper to __down_common
>
> The above is unreadable and seems to lack a reason for this change.
Hi Mr Peter,
Thanks for the comments.
I will try to explain it further:

The semaphore has four functions named down*.
The call flow of the functions is

down* ----> __down* ----> inline __down_common

The code of down* and __down* is redundant/duplicate except that
the __down_common is called with different arguments from __down*
functions.

This patch defines a macro down_common which contain this common
code of all down* functions.

new call flow is

down* ----> noinline __down_common (through a macro down_common).

> AFAICT from the actual patch, you're destroying the explicit
> instantiation of the __down*() functions
> through constant propagation into __down_common().
Intead of instantiation of __down* functions, we are instaintiating
__down_common, is it a problem ?

Thanks
Satendra
