Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5BFC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BC020679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUgjGjqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfD1SRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:17:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37329 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1SRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:17:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so4076634pgc.4;
        Sun, 28 Apr 2019 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3T/SikFXr5qYm6w3sKrS+bzQuqkPNS0J8Ac7y9zSLA=;
        b=CUgjGjqRTqeu4iWrrWwJ5DD2ABCTtylN41Pem4Fzr5TrdBovXJWXuAa9zUblcBBUVO
         jgPNmlyvvX7aoCxccwLqJ/w3uy10qgVGXsfJ4IHb0+M4QBFuCMXLCC6+KtWGcncn+FGI
         72SYI+HPQhyc2L4bKWPxyenVnDR2v7FuQBndu2xFfxdfF3muu0JsfIYF2i7XUqf3kPtp
         HnG4Q4EeLqraHzekP6cvsw9+FnDHzqFz8F5aweBv0lV2zRZxFI6zFB0Vmu0FKqJLBzWK
         ocNurBTiLnIt2MjD9SH6QlSxVR4QP1Pu30coL1+wvR8bMK7NvUjkp7oFh4cPxqDwUdpr
         Gf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3T/SikFXr5qYm6w3sKrS+bzQuqkPNS0J8Ac7y9zSLA=;
        b=VjJz3pvy0+fDXqsk6zyvfssTFQNccBLXcKPl5q3TmpsTjcPZFc01NILMjU+WGTcfIt
         5dRPaDIrLbm7VnQwa0Hxd1OWVh0Thj2yAEiYfs6qhB7UkhZgt2Y2/k4yL55Qu4mJ8Cso
         pggUbuCzC5bD0NFz69b4RtoKv74oDm/QIsp9lOEd6MXMT1Bmr63ouc/u0z1zhkaIC2vj
         39CXVzXKEzmReOyZ8YHmnXzWYAflDE4x7Xa0AYjg2TRH4ndl0Vq0lIgYEQLrZQKVlWzw
         4D5B9A5cRDAyou/qkISu/sZ5btO2IksFcbjepk6waHihZJiCvVEXEV7bbqhDB1nhd5L+
         +lJA==
X-Gm-Message-State: APjAAAWf0RuKX0OCS8v+rDtYkjTJ6gg6GIHMOali3pcHyxeNDzquF3tJ
        LITA4mXoU4b+MGjwKyoqpAWOKe4+jGkB61PyMep9dg==
X-Google-Smtp-Source: APXvYqyKjhIViSH/oimdWnq8czYKZr9DrZtFcbbhIrCiD/I1VbZA3fsCurYmtaVkE4Jny6yHDbQrg0LXetxxOvtcU3w=
X-Received: by 2002:a63:1301:: with SMTP id i1mr9572892pgl.226.1556475436633;
 Sun, 28 Apr 2019 11:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <1556430899-11018-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1556430899-11018-1-git-send-email-hofrat@osadl.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun, 28 Apr 2019 11:17:05 -0700
Message-ID: <CAM_iQpXVv7THx7T+M=nvOt7y6D31=O4CS4s=2JS4yqfbTkqoyA@mail.gmail.com>
Subject: Re: [PATCH] net_sched: force endianness annotation
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 11:00 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> While the endiannes is being handled correctly sparse was unhappy with
> the missing annotation as be16_to_cpu()/be32_to_cpu() expects a __be16
> respectively __be32. To mitigate this annotation issue forced annotation
> is introduced. Note that this patch has no impact on the generated binary.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>


Thanks.
