Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AC7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606BC206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjR2Le/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLTQvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:51:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42545 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:51:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so5505143pfz.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ajRMXmSY5Z78AT9GSMVh3nOVbX/834wxTwFR9fI4zHM=;
        b=OjR2Le/o8ntDEe4xbiK3QMrmk+HoKDxJ0eX6ZW6uIbmNkMBvA2Z8QZalLMPolr8CS1
         FiBW3JQZj6ltgIkwlUvZN/NHSGaBUqD9NMYO6izQH4+ml+1NDa4GHJiL9LQYWnzK41Nh
         jlAFb/SgNTGjwGuzVneS6l/gAgh0jFhf5PTgp2c3qUDD1KDGLyQC0aY0b6ISZa6biH3d
         D/AunXca2raciTtijZRIH9twGkMZH7UPNCYX91KJRETCionZN5JhCioVgvZ9gvQtLvhy
         k/vhAvp3spGeR8dztmCLBrUC2iA/62Sj3jkk+eCCzBFe/UuBBER9lXhJQTn92jE2c5iw
         emmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ajRMXmSY5Z78AT9GSMVh3nOVbX/834wxTwFR9fI4zHM=;
        b=X1lpUl2q9rtRG8lwahNxqqR/NraTYbFtWbSVRfmK8koZGSX/x2l4TA3tEWKxYegBVj
         FmzEwPWctsUNHJOse02weV7gCI5bzMsJ4wj7/aWeHIJA1jvJgUdKRPyhcIgHL5ZxIyPl
         9zNEjdZbp6aSMejXvppNx2PuptR/TewhfMf3w5MY3F3RUfLC+gHFEcXnu0x4uvRlJt+w
         x9D75qGkWztXauIjrUqdRC1OXpyAXxAKep0nSlTH16GlVoIOeGw8/xDfXZhVuKyDCndU
         r7F+cpnnLu1HysYO0SLZh1mG9v2wSdSXh12G8NTztmQpLhq1VFC9DgNaslUBgU8XsjA4
         uV3w==
X-Gm-Message-State: APjAAAVKG0bNe8Xrhk01MRVQgg7ydDkARL/ptPb3LzlMzPGL+r5Kcy3X
        Fht06o6CUYwhdpC2zCm2uA+Cj74UUlM=
X-Google-Smtp-Source: APXvYqypTThp0pUp6TQBM9XQVvoIm7eBim6W3UjiAvmDFfaPROzaFbZBONE6R+TZkrT0a8P4LuoIBg==
X-Received: by 2002:a62:296:: with SMTP id 144mr17326034pfc.120.1576860677016;
        Fri, 20 Dec 2019 08:51:17 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g9sm13930844pfm.150.2019.12.20.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 08:51:16 -0800 (PST)
Date:   Fri, 20 Dec 2019 08:51:13 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Print the tag in the debugfs summary
Message-ID: <20191220165113.GB549437@yoga>
References: <20191220163846.6485-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220163846.6485-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Dec 08:38 PST 2019, Georgi Djakov wrote:

> Now we can have a tag associated with the path. Add this information
> to the interconnect_summary file, as the current information in debugfs
> is incomplete.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/interconnect/core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 1867fad56c0f..ae80fbea5d2d 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -34,7 +34,7 @@ static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
>  	if (!n)
>  		return;
>  
> -	seq_printf(s, "%-30s %12u %12u\n",
> +	seq_printf(s, "%-42s %12u %12u\n",
>  		   n->name, n->avg_bw, n->peak_bw);
>  }
>  
> @@ -42,8 +42,8 @@ static int icc_summary_show(struct seq_file *s, void *data)
>  {
>  	struct icc_provider *provider;
>  
> -	seq_puts(s, " node                                   avg         peak\n");
> -	seq_puts(s, "--------------------------------------------------------\n");
> +	seq_puts(s, " node                                  tag          avg         peak\n");
> +	seq_puts(s, "--------------------------------------------------------------------\n");
>  
>  	mutex_lock(&icc_lock);
>  
> @@ -58,8 +58,8 @@ static int icc_summary_show(struct seq_file *s, void *data)
>  				if (!r->dev)
>  					continue;
>  
> -				seq_printf(s, "    %-26s %12u %12u\n",
> -					   dev_name(r->dev), r->avg_bw,
> +				seq_printf(s, "  %-27s %12u %12u %12u\n",
> +					   dev_name(r->dev), r->tag, r->avg_bw,
>  					   r->peak_bw);
>  			}
>  		}
