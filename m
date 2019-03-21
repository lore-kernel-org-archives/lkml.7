Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C424C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2E218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma4qftxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfCUMqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:46:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36256 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfCUMqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:46:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id d18so4505276lfn.3;
        Thu, 21 Mar 2019 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECm2D+oRh0OMPLKmJ4UXHJ46/glzO8Nrm9QkkP7ievs=;
        b=ma4qftxnKnP866e8pI6W6FVZ9gavcvnvNyOsGydiWdH8241v+yrn7ZJkl7IpgxTPjr
         wX9W8pHXkYky/bGHaZZsEp2TtU8PlHflPDIBF8FbaQv7AN//z49+PuM5dxeREXAvrjc+
         aTUP7JMlDBZ/XA7a2QFj6YVkZ5hsDUzW7jh0ZQy6NQkdLQcn9c1zx+/i7Xg9XDJOVdpN
         gRl/3/IjL5GxcCaEowMVPTjkJVcfqCRrB6JfiULif9a9FjEAgcyAykRB8JSq56O5YArp
         VeMvEmW6qS61Npe551Y6xCX44ug+lSX+lVXD2H3ZTJIkCGrWf6eRYpoA8FLe7eC285AF
         jOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECm2D+oRh0OMPLKmJ4UXHJ46/glzO8Nrm9QkkP7ievs=;
        b=uRmTvqUNR4iO5A6wj64B97k2Csg1qOOqLqJZDzaZ1hgA0TpAP1QDLDlUeLZL+17DVs
         o18XhV0tRlf31Kio7vsEoOSXs9tBzRrxmx76c4Ot1DdGxuZ1+wHxIQGky37pVBmErfry
         g9e6kYyZLkvEekSIyRplhRFvW/YpItSK9Plcms05tq6GkhyNwzEBaCa2YINMwy4swE8A
         Pa6exzbuCVm3XkhZtq9PBb7De9TWotrqrJihLfTGHU2jQnXbbjqFDo0tnXMiJQmFWwhT
         D0Vsmgk5drYT8bf/Q9QzZ90rhCZgQAenRJGB8uK4OcEekgPypaeUBcKKY19h0eVv6fiv
         TSVg==
X-Gm-Message-State: APjAAAVvu3UIEsQ6jO54gCUOlrw1ETS6TP5EdqMZaTt/xX4fntO6PQWv
        zz06XJkanbbsfXePzuwpR6mljhLZY/lF/Jft80o=
X-Google-Smtp-Source: APXvYqwFYqH6xhW/jjtq9RLCjwgG8PMLCtLHQxjWSDoPFsc36jr4bKOrOUA4UWGFbR2qO/57BVmd/BQjWUh8jwzu8aU=
X-Received: by 2002:ac2:4825:: with SMTP id 5mr1925914lft.64.1553172392022;
 Thu, 21 Mar 2019 05:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190306161650.GA3155@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190306161650.GA3155@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 21 Mar 2019 18:16:19 +0530
Message-ID: <CAFqt6zYvbi0pSndg_VVmE0EK6PW-T=d+b05EWOf2iqxkezOxGA@mail.gmail.com>
Subject: Re: [PATCH v2] selftest/rseq: Remove duplicate header
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>, shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:42 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Remove duplicate header which is included twice
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> v2: Corrected format.

Any further comment on this ?
>
>  tools/testing/selftests/rseq/rseq.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> index c72eb70..6c1126e7 100644
> --- a/tools/testing/selftests/rseq/rseq.h
> +++ b/tools/testing/selftests/rseq/rseq.h
> @@ -16,7 +16,6 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <sched.h>
>  #include <linux/rseq.h>
>
>  /*
> --
> 1.9.1
>
