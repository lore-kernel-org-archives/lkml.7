Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A748C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCE42184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhRzIbyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfCTQQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:16:41 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36186 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfCTQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:16:41 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so11216885itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0Q5v0g27OqjTrsikyXlwNLWDb86QwXAt6ZJ5t0b7FU=;
        b=EhRzIbygkP2nKs120Fa/Gfw2ft6Tkvurkc8bJD5Zh+1GRWegIPeVo9ZBNAEFgFsesu
         DKiZHPcuy1XCvgtVzviUmNjIuYR5njtUYQZ1ebZcf5O3Sy3QVe4jvzBekxGwHqCqCivh
         sXqqNdwkP/DoQcyhDRbioqUv5hWNbZlevm7cPLnWviFxMkInZKuB6izolOo5ooCFGF1b
         NfEmFGf86ww11gFrTajaEVMFaRL5JV/5ID/jVQyqE56lPcVZB+bVNNO0e7yHSrY9ainy
         Ic0HUmTXFnXPdqorb0Y7JcIWvR8atis5bbGC8r7ApVwIO4XkXZZOfGK0oSkzRKAxiTjt
         bqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0Q5v0g27OqjTrsikyXlwNLWDb86QwXAt6ZJ5t0b7FU=;
        b=N6l9YrZuScHQf4wpdyg7U9AEUe8MhbOfqvMrBFM+FNYHdgP5HBnPKM7reLUh4MtGBJ
         x+/k5gHtipRJ8SAsKWd5eRRQjD8FXT8LK6wtYJQy8G7hPvkSy+cqktNxmHGkArTuKUdh
         uEG/falXdVF3zkWGRCEizyyscro481C/FbN46/ijIprPKMZpYvkcrBDUX/1b8Jy61o6G
         V5Kvx2wXjcxUi4zHbiM8kGuJ8noD/9soKFdNwZZq3ZjcQhWoqCq+h14E5+BAY6in0Ua7
         MTTptG9R2CahJ/hB7r0RVg4GATRWlObVRq0R98GeOLBSC+dRb7BUvyaj/n3sZurQIw7T
         H9FQ==
X-Gm-Message-State: APjAAAW65utv1yuhlxN5AVzcUJxkMxLkFrDnt3ORkbAedZ4NhIkEC0qE
        54AtP2+GF9hkc++X7HppaSwut66aFdqhA0q+uYZgHQ==
X-Google-Smtp-Source: APXvYqywimmdkMa9HXrb/htDyl9S7R6qopAY/6kL75YPUN5hL26aePaPNETxSy96Rm+qFC4OdG4c8Zn4gDNuxvU9hSc=
X-Received: by 2002:a02:bb06:: with SMTP id y6mr5427507jan.98.1553098600454;
 Wed, 20 Mar 2019 09:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190320063626.14792-1-yuehaibing@huawei.com>
In-Reply-To: <20190320063626.14792-1-yuehaibing@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 20 Mar 2019 10:16:29 -0600
Message-ID: <CANLsYkwNz6sJVCSqCcNYJ+0nMDZcPyL9VxSc0a1dG5ghu9JBYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] minor fixes for perf cs-etm
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 at 00:37, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> This patch series fixes two issue:
> 1. fix pass-zero-to-ERR_PTR warning
> 2. return correct errcode to upstream callers
>
> YueHaibing (2):
>   perf cs-etm: Remove errnoeous ERR_PTR() usage in in
>     cs_etm__process_auxtrace_info
>   perf cs-etm: return errcode in cs_etm__process_auxtrace_info()
>
>  tools/perf/util/cs-etm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Please run your work through checkpatch and resend.

Mathieu

>
> --
> 2.7.0
>
>
