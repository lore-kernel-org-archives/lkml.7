Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C9C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc2j7Ld5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfEMJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:17:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32973 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfEMJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:17:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so10797282qtf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0TcyKMp5RYAO3Vmxht8Y8t9Cu1RXvH8j1oVgbu8WbE0=;
        b=Gc2j7Ld5EOmCs5WXAmiJYgMs4MsvWQMCabwirwH+dQyYXmGfwXbVnnGaC5Rssz/FoX
         91TCBdokTTTX7OaQtDOw3nqZc8FeGzA9gobMp/OErsWshyjTU4S5LvH7zp6KasihdBNN
         J2jtXJbQ1h8mK6WJ8jn9qDAyPTucUOjRHyWKrJPRdDEar+YNvHR4V3Bwpep987TeQO2V
         5Ot0zAjFUTSgoxWmB7s9818Z90dWrBFNDCjEBAJWcfAD+/OJevIAHe4W7wJwWoPVohRi
         TiJOSQQ3+AHjP9sUhyww46Kg9m4fhHjCZIjWX7yyfrHvLbvLASUfaasVdDRjkhkt2sSp
         NEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0TcyKMp5RYAO3Vmxht8Y8t9Cu1RXvH8j1oVgbu8WbE0=;
        b=PVzq9kzl1GeZiy/e0Vt1W4zBzTrE+MObTPPOehCLRFztko6q4a6Fug/7uRDnfisifU
         ZNjgUUb/d3lQl8NYWt6ApffjE5V75mgk288uyjuZ5PU3GaunrFtGV6jCOw7f3BHsj849
         RV78qOtu2uPHpKAlnx3jWS26zAxzzcgo2RPRJN5kL3btTCA+z1ekKZASO25VNgWTk8yZ
         CrancQu55rE+e5jZOwtowx7pOtrWGz59NFWIABkwVb43D5GwUVfDhusmxf087kWIAigB
         TgpwGQEBjj6JofSq2jmv7O6KuJsviQ3V87hse2XzfS3be9IfJk5akp7bdtCAozlRXms/
         1Flg==
X-Gm-Message-State: APjAAAVA2Vg+Jdh6OZ4h9n1yOokJMYYSxEhKAebiXkEfoX6HnYRmHG08
        lG7hAR5I4ncW5b/bowLaF6xy2rleII/hOQ3dVUU=
X-Google-Smtp-Source: APXvYqwTHUMRmmn3A5wZ2qGCq+HiH72Fh7pW5KJ6ySsIgngMj6HKmZw7cxBgZBs5ynz8jf2ayUazzc8Bhl5QAjgarqE=
X-Received: by 2002:ac8:701:: with SMTP id g1mr6091063qth.327.1557739066697;
 Mon, 13 May 2019 02:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190513091203.7299-1-duyuyang@gmail.com>
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Mon, 13 May 2019 17:17:35 +0800
Message-ID: <CAHttsrZkYHU5vejptty=nJs67F4R07JjBJUsY8e4vtzOhgXe2A@mail.gmail.com>
Subject: Re: [PATCH 00/17] Support for read-write lock deadlock detection
To:     Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com,
        Ingo Molnar <mingo@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to mention the patchset is based on my previous small
improvements:

[PATCH v2 00/23] locking/lockdep: Small improvements
(https://lkml.org/lkml/2019/5/6/106).

On Mon, 13 May 2019 at 17:13, Yuyang Du <duyuyang@gmail.com> wrote:
>
> Hi Peter and Ingo,
>
> Historically, the read-write locks (recursive-read locks included) are not
> well supported in lockdep. This patchset attempts to solve this problem
> sound and complete.
>
> The bulk of the algorithm is in patch #10, which is actually not complex at
> all. Hopefully, it simply works.
>
> Now that we have read-write locks suppported, we have all the 262 cases
> passed, though I have to flip some cases which, I think, are wrong.
>
> P.S. To Boqun, I haven't got time to read your patchset except that I did
> carefully read your design doc and learnt from it a lot. It is helpful.
> Please give this patchset at least a look.
>
> Thanks,
> Yuyang
>
> --
>
> Yuyang Du (17):
>   locking/lockdep: Add lock type enum to explicitly specify read or
>     write locks
>   locking/lockdep: Add read-write type for dependency
>   locking/lockdep: Add helper functions to operate on the searched path
>   locking/lockdep: Update direct dependency's read-write type if it
>     exists
>   locking/lockdep: Rename deadlock check functions
>   locking/lockdep: Adjust BFS algorithm to support multiple matches
>   locking/lockdep: Introduce mark_lock_unaccessed()
>   locking/lockdep: Introduce chain_hlocks_type for held lock's
>     read-write type
>   locking/lockdep: Hash held lock's read-write type into chain key
>   locking/lockdep: Support read-write lock's deadlock detection
>   locking/lockdep: Adjust lockdep selftest cases
>   locking/lockdep: Remove useless lock type assignment
>   locking/lockdep: Add nest lock type
>   locking/lockdep: Support recursive read locks
>   locking/lockdep: Adjust selftest case for recursive read lock
>   locking/lockdep: Add more lockdep selftest cases
>   locking/lockdep: Remove irq-safe to irq-unsafe read check
>
>  include/linux/lockdep.h            |   40 +-
>  kernel/locking/lockdep.c           |  454 +++++++++++----
>  kernel/locking/lockdep_internals.h |    4 +
>  lib/locking-selftest.c             | 1099 +++++++++++++++++++++++++++++++++++-
>  4 files changed, 1464 insertions(+), 133 deletions(-)
>
> --
> 1.8.3.1
>
