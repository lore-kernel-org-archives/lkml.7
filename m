Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE36206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYB7nmW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfDWNLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:11:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41838 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfDWNLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:11:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id c12so13983394wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sQqfzzYNkH1i1tpoeR81xZy6EMQ1pQhdYKv+Dnyexfs=;
        b=aYB7nmW0jjXLx9F/nsB4YB3SOrQ5N9qJr3seqRhzgzdgTTLR30uRv3+Oom4srS/8Tw
         4taZQTNjeoaz+lSKflZXN7NL9Cv3tBAZZuUkZj5JNLXExLfyB6VkMVSBmDoR3x7anboW
         6I5f8wDU+ij+DF+tb63JgwuqOnxJqbnfChI7ropTN94fDwSIg+Gs0zyH1kCQ1ADLLLVB
         NMqySFGoO04rFe+C9K4InDTVaLxvNQgW2Tr6ITUXtbZJIrSPFxro7RO/VkVp6VoIfRpy
         5cVhxzxxwt8QSsoq6yvTW5Z8oa59mhkJyu827EhjkDJLrdu9Dk0VG2bUEVMgWgLkY4KM
         rEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sQqfzzYNkH1i1tpoeR81xZy6EMQ1pQhdYKv+Dnyexfs=;
        b=NSpTkNyM5gGIj9rTn8FimtcCefr6BN7yjJzS3lhMGcAoWj+2yEFlBGt2jAUHu/Qj1z
         3nLkJwsOeoJxAYpaZGDIKgxFm4eumd38M/cFfZu6GQg2Gm+us/B/ObGPYOS7a9mmEedJ
         aTzrY5kwaRBiJc/r/wUaEQw5qu8oW3WwQZIO8MuWI6k/anXaJx+vvnNt0zrwUoDHlcwO
         PNCoAzZvN9dorXczoI0YrkBlChp9cv6SRNuz8L4E3hSjVOznbwa3rMyP65SUW0a/8+1i
         tTg3p4DybJP/FiwZGdEAWdscqfsZwMq+qvLzDu8wvrgS1MET+sPI6iF6EHiRSMXPR6Aj
         0oOQ==
X-Gm-Message-State: APjAAAX7enMvKL2CMGvzuAbP/qAInvkj1QTJL4lAeOzOtWMKGy0V2bt0
        aYpnLJ9CdnerWb5yR/A+2sBzcQ==
X-Google-Smtp-Source: APXvYqwn8zHK0ED8/0nsbp9UjvgIrKX27voYinTuOHl5Pqhq09olAAwm78M9BpURldYS0rNuEBvang==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr11401380wrn.235.1556025071443;
        Tue, 23 Apr 2019 06:11:11 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 6sm436545wra.85.2019.04.23.06.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 06:11:10 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:11:08 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: kdb_io: Replace strcpy() by strscpy()
Message-ID: <20190423131108.mddepqxfy4yraog4@holly.lan>
References: <20190422162711.GA30856@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422162711.GA30856@embeddedor>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:27:11AM -0500, Gustavo A. R. Silva wrote:
> The strcpy() function is being deprecated. Replace it by the safer
> strscpy() and fix the following Coverity warning:
> 
> "You might overrun the 256-character fixed-size string kdb_buffer
> by copying cphold without checking the length."
> 
> Addresses-Coverity-ID: 138996 ("Copy into fixed size buffer")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/debug/kdb/kdb_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 6a4b41484afe..ebc4aa2d0737 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -836,7 +836,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  	 */
>  	if (kdb_grepping_flag && !suspend_grep) {
>  		*cphold = replaced_byte;
> -		strcpy(kdb_buffer, cphold);
> +		strscpy(kdb_buffer, cphold, sizeof(kdb_buffer));

This looks like a mechanical or semi-mechanical fix... I think it
misses a couple of things.

Firstly this code pattern appears twice in the file but you have only
fixed on of those instances. If this fix is required then both should
be changed.

Secondly cphold is a pointer into kdb_buffer itself which means that
*neither* strcpy() nor strscpy() are safe (since their behaviour is
undefined) so we should probably be using memmove() anyway.


Daniel.


PS there is an range change since a sub-string is always shorted than a
   string (albeit an implicit one based on correct termination handling)
   so a strlen()+memmove() fix is probably OK here.


Daniel.


>  		len = strlen(kdb_buffer);
>  		next_avail = kdb_buffer + len;
>  		size_avail = sizeof(kdb_buffer) - len;
> -- 
> 2.21.0
> 
