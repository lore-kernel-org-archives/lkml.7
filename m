Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54810C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2644A20833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qy1XX0NQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfLBRJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:09:43 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39106 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfLBRJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:09:40 -0500
Received: by mail-pj1-f68.google.com with SMTP id v93so13909371pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDGGQHWpdkZIj81hxXdfawczIBgk86TVXpxZEqNBkKw=;
        b=qy1XX0NQtaJmJIk1WSswX5pJZErX2pRnSRnoUqnlqrxvfEfIdPE2rOIZfXv4W1NZX4
         rGki7kDJGQgC9QNz5h/BMIDI8PcBEHBAET/FtufdP8qVa+7E0j1+0gueUKOZvey7xV40
         ipOq2+hRM8AUag4zbb8uui/TQI7YALdkbuBkUeU2jw0/LwEC5TJd2lIYmAZsEWM6h4Kz
         ULeuV/etAnPSASnzO8ReR0Ve6D0Slh2WeHYBc634bc1ZtUxqWo9SnOYUzl/Dg+LIpiOb
         siGdXVqIA1rMRUNUnhlfzuAqV3jyDSRhDCDSLfFBAfTM+f2wK5f7F3+WE59nxKFLE2nW
         buHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDGGQHWpdkZIj81hxXdfawczIBgk86TVXpxZEqNBkKw=;
        b=Rpm7Gao9u+bgP6By51UKvdDrbp/N+JqXr8VxaNR8ZzqHTAwtuG8QO6eKm0ZvWVAXX9
         ZfvpKu5y4c8hEZgrqJQsGRn5YCSItNpmifyiRNxBxtAUHGOJra4DoRdkZgRzf2xLKwMt
         khNutM5NFUmElHXOAUk3GQ2Lv1HU3lrcQ9XmOyBQ+GeNkOcCPDUjGIIdgnzsM9oIqOW8
         7Uvg2z+cCgZb4oBh1JwDsrjc7whj8kus4nbKLoPi11vt+Z3FyTxezfVEaZaJBz+Ykim6
         e3rrE4/no+9elHFkoczD5p4JXZeNFglBDETgl32v/8unMPcTwaxWVd7EfXSkFnlV2Nzm
         gpog==
X-Gm-Message-State: APjAAAWOMk2/xvXBe+iQUc6HNTgFLLLRH9gpPMQ08SUfynKyVpw/KEFs
        CB/RbgJfMTQLu4fDd3b1+KjmE6ENyxXo9EUT+95x1w==
X-Google-Smtp-Source: APXvYqzqsLYh95mI5pQBPTRCrUh++E3DAxgln/usIn0Xc7WWl8bqC9mEjf/KwCQBB6K3knP54p0s/dChqA2Dqaj6CAI=
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr264576pjb.117.1575306578192;
 Mon, 02 Dec 2019 09:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20191127231926.162437-1-heidifahim@google.com>
In-Reply-To: <20191127231926.162437-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 09:09:29 -0800
Message-ID: <CAFd5g46TG-+baJE29dR8iUdBdWViO_BygKbwUQ5fHv8X3Jkpfw@mail.gmail.com>
Subject: Re: [PATCH] kunit: testing kunit: Bug fix in test_run_timeout function
To:     Heidi Fahim <heidifahim@google.com>
Cc:     David Gow <davidgow@google.com>, shuah <shuah@kernel.org>,
        SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 3:19 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Assert in test_run_timeout was not updated with the build_dir argument
> and caused the following error:
> AssertionError: Expected call: run_kernel(timeout=3453)
> Actual call: run_kernel(build_dir=None, timeout=3453)
>
> Needed to update kunit_tool_test to reflect this fix
> https://lkml.org/lkml/2019/9/6/3
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>
> Change-Id: I6f161c72c6a5f071a4dc31582ba08b91974502ce

Change-Id should not be used on LKML patches. Did you run checkpatch?
