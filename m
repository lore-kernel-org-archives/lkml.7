Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E25C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6AC208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRXwJmZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfLLBY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:24:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38868 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfLLBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:24:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id a17so308691pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxfmdDL7T65vpl8mxodCbmEtdWkrwaTZC5+tzyhVGaA=;
        b=bRXwJmZHFv0/DvcR8LfYtM1OzaacaOYEZFWDRRvs+auLJumkDckP/tK4HXzXX0EDsA
         5a+xu78dCM+F+leSzcpQcllZzKsh/bltxO7tR0PDqSlBEzwhxPMDZOCjfPxKOdqjMzH4
         hjZKFpu0D9hv3HL6Y6H33Q949WW4CYgG0kQz0l5EwDy9d5WW9JCw0XngN9mLAZAYW/bh
         mD9VlPuPCpzqEdwPBII9BTNK2VTOEj+y0ixQXJX3Xj+qc6MaZ6txvGH5zovaunDkhpeo
         0gZzNR5sxFf+mbnAwvYvp/ZabyNwah5oDZ1c5ZUfoo+Co9G+yemh/eV7s0OFZL8Ix+5V
         j/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxfmdDL7T65vpl8mxodCbmEtdWkrwaTZC5+tzyhVGaA=;
        b=Ybe9kjZatYeAn9SM6yXfsmSOxaT4P1naa7oWgRbzK3RjV1qhA0wnm58ARoIjyxT8xf
         5MBT/ArTn5futFdBeA/hgw44Np5IWlxjE6lOx/2luiQH6P4UUYMZJHLwS7aTJeWLVHaT
         XcJ2tjmVYxEYMwMBeTB4/W+7XuXsQOmdmsjPogq8uidsHhO71WYxrdbZ0p7xgC6xL+EE
         9uQCqznJbL0uxTMAMoDLtIf0YWCNdi/uaxGyJh4zEuLG4UP6LX+AUujDEM7QAEKDQ+nA
         vOPJXS+b9PuhJsIcnhg2A0PcQU+rtbfm25Itb9DspTk8fVulZbjj9Z4VF16I5o/0vSSy
         uE1g==
X-Gm-Message-State: APjAAAVUQsTHxrV200a++ek3qi6d5OAHhriI8zBRm3M++peE1F/iv3Ff
        EkgiUkrC5IBCDeXJhnDAk0BvVSTtjxglw/pxco8PQg==
X-Google-Smtp-Source: APXvYqwh1XJUkOPCF0dyTQQeW2Obj5SdR1i9KBjXveDUQi9/tEWPhx3U7JPzGxqbNmrqdb2cgomvPt7qSdwYBUlbqFc=
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr6788276plq.325.1576113864508;
 Wed, 11 Dec 2019 17:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20191205093440.21824-1-sjpark@amazon.com> <20191205093440.21824-5-sjpark@amazon.com>
In-Reply-To: <20191205093440.21824-5-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Dec 2019 17:24:13 -0800
Message-ID: <CAFd5g46j137egWyACg-op7q1gQVMhYzbUdG9_a0hO8Zc9By0sw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] kunit: Place 'test.log' under the 'build_dir'
To:     SeongJae Park <sjpark@amazon.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 1:35 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> 'kunit' writes the 'test.log' under the kernel source directory even
> though a 'build_dir' option is given.  As users who use the option might
> expect the outputs to be placed under the specified directory, this
> commit modifies the logic to write the log file under the 'build_dir'.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
