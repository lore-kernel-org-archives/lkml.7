Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE459C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E43206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpFDpgQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfEDG5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 02:57:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43786 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfEDG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 02:57:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id u27so5595275lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h6HmZn6f8FxosixHM79+I4jh/Dsytwl+YRpeHiqpaiQ=;
        b=qpFDpgQFfRqt2vxujIdX/p70aXZ406OKP/jAnakQQVsYxkvZwBSq/wkxlu88c8Gxpi
         nolmmaCmD8qxmtxRTmC+Kv0AJ9uFNP1k8HnhCbZvz8HZ0GytEfNkwiiX6L4mLZFim9be
         kZjYCGgATWqQw8ie66Tp6JWslFRseEZIseZMqmcb6r0gv/YCbauJj99gyB5lDw6WtB8W
         MUqq8r/tftKjTemN75MQRUECBHYViXtQY/eCJ+I4CJSPP4n9PM9oH2jAuEvn9osAYcV4
         FFCZxYSq9AOhEvBJe5vnrmhoWJ4rOAD5LpXOizFgrK7ZP6uOtCV/s8z0cWNCBBLyA98b
         9xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h6HmZn6f8FxosixHM79+I4jh/Dsytwl+YRpeHiqpaiQ=;
        b=SL6xHYgb1pxP1CMRofyKJJDM2dng9+Bu0Gn/DVMMYcBtGPGhyvg6p7jdiG8xGGly6X
         NOvIGZhLprM+eRYKTYVIgwi78dsmNaTElBqKDXEUitzgL05nUjDLESAsFtYYaTSpWbhr
         Ycrmw1A7eCJbrd9GPsYN/ukDaIDMt20s83Qc6cbt8UbDw95TzgpJf3W4Z7S/BXJU5EQA
         c7FqsmlVqwswUPtRMH+B6AbD+Ybp2SN0iA7u0QqtqyFy70V50kF9KUH2D6vHhNaoqG63
         fB61ExSb1iW++I6xGZKgrTWxpGgU3EkZC06TT8EX30v5l2ZYwEjzSJ9JiU3Cilm+ZtTl
         XuFg==
X-Gm-Message-State: APjAAAWyZ0ECZx5KgcRN+BjZBHoLgnh40sLcx4bUywklpqTliaX4lz3q
        j4Sm+AwsHZIbymFn4QlRoQ==
X-Google-Smtp-Source: APXvYqzUEusID7J47sLUJCdrU82VZBUEcGrS8t+rF4RNSicmQguPbQr+C6tG8A7H8xKVlEmlTEArzQ==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr7321456lfc.153.1556953024592;
        Fri, 03 May 2019 23:57:04 -0700 (PDT)
Received: from avx2 ([46.53.254.98])
        by smtp.gmail.com with ESMTPSA id c19sm791498lfj.96.2019.05.03.23.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 23:57:03 -0700 (PDT)
Date:   Sat, 4 May 2019 09:56:59 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 1/2] kernel/sys: add PR_GET_TASK_SIZE option to
 prctl(2)
Message-ID: <20190504065659.GA4156@avx2>
References: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
 <1556907021-29730-2-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1556907021-29730-2-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 02:10:20PM -0400, Joel Savitz wrote:
> +/* Get the process virtual memory size (i.e. the highest usable VM address) */
> +#define PR_GET_TASK_SIZE               55

TASK_SIZE is in fact the lowest _un_usable address. :^)
