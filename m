Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BF320854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttdPdWHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfB1Nzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:55:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36786 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfB1Nzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:55:40 -0500
Received: by mail-qt1-f194.google.com with SMTP id p25so23533073qtb.3;
        Thu, 28 Feb 2019 05:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3gbkIhvVF1AH1z+WfY/qwoD1anC7NSB9emFlODUv0kQ=;
        b=ttdPdWHkXVD6z9n9tTmttepq00LBNrbDtp7tWmiTFo25hnQ3FdFuNMdyo/bvCQwJ0p
         SNtU6rEeuq56FBTaxVQYell6+5E5xaAxtQ/nI11yM7r0DNSSbo/fQg3hKMJ1k9Zhf/qA
         kVDz6AD9x9wploJCOOOvAFqRwfyo/nkarhBFzZFbB8nVqc31+y+LFkFCkcfc+1N0o+wg
         8U6TmZCUw8j4qLM1SkWLOcT/aMfyfVNFnbVNFd+sxGFagnrpOlwUNaILjG3aUSB9TQ87
         DdZFaj8x2aBiiRgGUTA4rvVF7XtjcdUE3aL0CBxECh1+QmVXHGgkx7e0GiovvBYP4SCs
         t4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gbkIhvVF1AH1z+WfY/qwoD1anC7NSB9emFlODUv0kQ=;
        b=Ep2bi/FGPr34V7G0OQJZhaQ84n8B2dUpKFtXGVGRZ2mFL+JV1V6SeRHl8bOm+VcVgU
         UDyegdFHyd9vnpBjBjYkwjjZ1ASpsoPt/GXSxq0JUTlHvv6Kic+q2/Ue5mZ6YWkivtcY
         jRiGoj2eu1LEFdEN1AgHnhrJfIzymkuezd4XIdGqo9/IGjY4Y1vIsZPrMJh4RlAmodv3
         ejFT+adjEj5o3J8F48m0L8ncALCndaNep9MNH5Lm8qqIQYWy456a4wCMt7xmp45Q8Sr0
         b8j0z0vSQYaOEmtHrCXaUQTDhfnfD/zW9oBBhUN64pKuVbothGnteo1Di2bEtpjgaVME
         krnQ==
X-Gm-Message-State: AHQUAuZbSIv4GoujY0T06a7lFyDIQI4NX8thwjOEHclf6qBk7jURtaSQ
        oRAFX7PZBiBSGQsma/uDOctFW8xU
X-Google-Smtp-Source: APXvYqwed09qVBfmc/51mPBlv9t2qk5ZcQXOdQ8awFREBN+TSn58dSdmPYeRBoQT8/b7UFaeYPQH7w==
X-Received: by 2002:aed:21c2:: with SMTP id m2mr6572834qtc.107.1551362138813;
        Thu, 28 Feb 2019 05:55:38 -0800 (PST)
Received: from localhost.localdomain ([2001:1284:f016:a307:76c1:1c91:d108:16d4])
        by smtp.gmail.com with ESMTPSA id l16sm10855160qke.20.2019.02.28.05.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 05:55:37 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 0573A180CD5; Thu, 28 Feb 2019 10:55:34 -0300 (-03)
Date:   Thu, 28 Feb 2019 10:55:34 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Matthias Maennich <maennich@google.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: chunk.c: correct format string for size_t in printk
Message-ID: <20190228135534.GC13343@localhost.localdomain>
References: <20190228113652.55552-1-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228113652.55552-1-maennich@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:36:52AM +0000, Matthias Maennich wrote:
> According to Documentation/core-api/printk-formats.rst, size_t should be
> printed with %zu, rather than %Zu.
> 
> In addition, using %Zu triggers a warning on clang (-Wformat-extra-args):
> 
> net/sctp/chunk.c:196:25: warning: data argument not used by format string [-Wformat-extra-args]
>                                     __func__, asoc, max_data);
>                                     ~~~~~~~~~~~~~~~~^~~~~~~~~
> ./include/linux/printk.h:440:49: note: expanded from macro 'pr_warn_ratelimited'
>         printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> ./include/linux/printk.h:424:17: note: expanded from macro 'printk_ratelimited'
>                 printk(fmt, ##__VA_ARGS__);                             \
>                        ~~~    ^
> 
> Fixes: 5b5e0928f742 ("lib/vsprintf.c: remove %Z support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Matthias Maennich <maennich@google.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

> ---
>  net/sctp/chunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sctp/chunk.c b/net/sctp/chunk.c
> index 64bef313d436..5cb7c1ff97e9 100644
> --- a/net/sctp/chunk.c
> +++ b/net/sctp/chunk.c
> @@ -192,7 +192,7 @@ struct sctp_datamsg *sctp_datamsg_from_user(struct sctp_association *asoc,
>  	if (unlikely(!max_data)) {
>  		max_data = sctp_min_frag_point(sctp_sk(asoc->base.sk),
>  					       sctp_datachk_len(&asoc->stream));
> -		pr_warn_ratelimited("%s: asoc:%p frag_point is zero, forcing max_data to default minimum (%Zu)",
> +		pr_warn_ratelimited("%s: asoc:%p frag_point is zero, forcing max_data to default minimum (%zu)",
>  				    __func__, asoc, max_data);
>  	}
>  
> -- 
> 2.21.0.rc2.261.ga7da99ff1b-goog
> 
