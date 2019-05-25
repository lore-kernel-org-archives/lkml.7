Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33863C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F512133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558774095;
	bh=NhrkPqDZw32k6ZUi52aYFCV2KSZgUE02nq8CUtXoXNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SA29e6F71fXfIXs1rWlHB09Yq8ETG93GzGcOM7CwxjSHw5ptowyZvXUYnNbkRW0yW
	 +sRrQrxYcnXYUIx7DzkUgx7yQ/BBIkyW76mCTj+xTsvar7Jb9cp9GyO6MgWGhI7a2v
	 DxnCzJjwRa3pQceKXhMhi6DQd/NfzAr2Xe0zOGPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfEYIsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:48:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35666 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfEYIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:48:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so5174910wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YtHNbXkR8JRWk1Tkm7eGOHp/N9pmWt1Y/yd2UcLLjio=;
        b=JQdoHjYszNkd2PYIj4hELUly0wTg/imi9kZkVwciB7yyM50WriIaY5/4oezNW3MSHs
         Mf/eydrhaHAsUxyvkgtVQyd8SgoL+iB5q/fLhy0pNcBImYFmAbV/I5zA4jNz7C8h0iAD
         MIMxP6k3gBxzrtxkLwsCsngBBUTZU5tneeHSrQvCcgAykD25hNORB0NtseWYThSf5/Z/
         yJMRPsF/JdlCPH8c0loZ4QjpRimj2nZKm2ej/EId8pm8VCK1/vvzpAexr9J+VjtlzBNz
         LDe/0YOxBP8rfZ3Zab9fk5F6ONaWy20qmM59PTa9LWs7EZ3Zvx+hoJ7S4VL6tqrrbNRU
         C+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtHNbXkR8JRWk1Tkm7eGOHp/N9pmWt1Y/yd2UcLLjio=;
        b=KwuGAAB6DDYWdwdmVugusJ/05INg2VG5QS/RgiGt777kxHtrou+cIAlPZAl0pd318v
         1M0AOkwSLf8bH1yPisvBqcwWDyYXr8Voe0XA+EKsTwWeJJO3a1vy4v1yM9j9bTgNkHWQ
         rYcqnZIk3Ol4L9B8sVJ5g1Lm2HnmktstcGldZajG7UOIdNk0kZGioZdHA4DXdyFh2Wp6
         afZDTkIKkD7cOj2w/OaOELAeqfvoC5c8/6gjse5sc8gMMC8imv1Uexoe8KSIH7FglJZy
         JlQG+q3zBHAF2hXE7V6jMuLQ3kzlR61mIxnprqzumZ7PhBNvD9cSyz6VctZe/+e7hiIs
         2C7Q==
X-Gm-Message-State: APjAAAWOtfuTcJ1e35P3jC6vcvhL7p6zEu1k71rSv8bkKseCEOfaOSXD
        Yo3oxLEayl6HLIimhOBltJAsOoVx
X-Google-Smtp-Source: APXvYqyW+yuAmCbGQSbsTnHH75/FetS6cUuCnerfjTeM0vLdpFvHda+nrh041AWg6UelQssMUxFLVg==
X-Received: by 2002:a1c:cb05:: with SMTP id b5mr2933369wmg.146.1558774091594;
        Sat, 25 May 2019 01:48:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s11sm8649552wrb.71.2019.05.25.01.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 01:48:10 -0700 (PDT)
Date:   Sat, 25 May 2019 10:48:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     vincent.weaver@maine.edu, ak@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@redhat.com, eranian@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf/x86: Disable non generic regs for
 software/probe events
Message-ID: <20190525084808.GA15802@gmail.com>
References: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> @@ -57,6 +57,11 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
>  #endif
>  };
>  
> +u64 non_generic_regs_mask(void)
> +{
> +	return (~((1ULL << PERF_REG_X86_XMM0) - 1));
> +}
> +
>  u64 perf_reg_value(struct pt_regs *regs, int idx)
>  {
>  	struct x86_perf_regs *perf_regs;
> diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
> index 4767474..c1c3454 100644
> --- a/include/linux/perf_regs.h
> +++ b/include/linux/perf_regs.h
> @@ -9,6 +9,8 @@ struct perf_regs {
>  	struct pt_regs	*regs;
>  };
>  
> +u64 non_generic_regs_mask(void);

This is a *constant* value, why is it in a separate function, not an 
inline?

Or rather, since it's obviously a constant, name it in such a way. 
(PERF_REG_X86_NON_GENERIC_MASK or so.)

To the generic code define it as 0 if arch headers haven't overriden it.

> +u64 __weak non_generic_regs_mask(void)
> +{
> +	return 0;
> +}
> +
> +static inline bool has_non_generic_regs(struct perf_event *event)
> +{
> +	u64 mask = non_generic_regs_mask();
> +
> +	return ((event->attr.sample_regs_user & mask) ||
> +		(event->attr.sample_regs_intr & mask));

'return' is not a function ...

> +	/* only support generic regs */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;

In human readable comments please use complete sentences with no 
unnecessary abbreviations, i.e. "Only support generic registers".

Thanks,

	Ingo
