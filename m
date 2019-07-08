Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102DBC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70D52166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIsVRnmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbfGHQjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:39:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33524 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfGHQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:39:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so8547101plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HANEys3LwMMarvQrMRgIUfN0qDIaxMbeh5Zb+J/99Zg=;
        b=VIsVRnmGojer3AbNkAsEx36TTWcdbcz6fKFtvDsuT3/i99lJq5zpV4awq3pZRIjdbb
         tArfVrO98RZEn2/OO68iwAdDwnc9PN7km3mg9d+cYHbk0KUmhhoZgfr/PqVd/KBpEs+x
         JHUd16JMhS7QCF4dQjc3caD6anztPkYFK9mf0vs7DNJBO9EH8E8q6shaLnTIFtZPDljO
         iHdizd1lHAVv8oJlLvdpL8PhN51v+GYMro8gM2Ax/jAbg/0uAauDtyFKFq/D5tpjN+r1
         EMjRdElWcbc9pf+6ewrjGty08MNVW5cVFe+JaLqdoeE8HZxJrhI80i3w54z1FXWhNWb6
         Gzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HANEys3LwMMarvQrMRgIUfN0qDIaxMbeh5Zb+J/99Zg=;
        b=RRDCl/05P/P/OqodkBVf77FFkCYexk1C/pRCrh+HD6NfW68vW/NpiN/EcBlgJtOqZx
         tG5azuuZ5knPkljExbh8IkEvhOdGhR0D5U8KSAq/J1wTTclmPkVS1J+6trjFggUrhLSl
         1VU+BVnYKM03EmMOaiPQqrvoC0fP6b+8YkbhV0Zgn6khv947eTcS48EwRS9cwTW0jXve
         DR+KdSYK1kWYi6i9KykTt2DrffYoWSa9KoVohubPFQd+cYnmAA15asyo500s+JYTii3L
         c9mFLJoLydzwFMzKIAA+RxSSHO7vOGcbL8P/cXtsvWX4wD71I8p5dVcfKLdHklrCALxL
         vcVQ==
X-Gm-Message-State: APjAAAUCbxWOQVLc+XWYVrrS1PqnHStknMi/IK+epwslQ139k5Dk59s3
        VcdhT7U/sYukPyO2TW/iR7A=
X-Google-Smtp-Source: APXvYqwaXNbD0uLKvspsc3YUfNdMcyiSiLnbDM+va2rxYovj0CY9KcGQ+WpAzFZRzolkYj1GBeQjiw==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr27081665ply.261.1562603943955;
        Mon, 08 Jul 2019 09:39:03 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id d2sm17639026pgo.0.2019.07.08.09.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 09:39:03 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:39:00 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time: Validate the usec before covert to nsec in
 do_adjtimex
Message-ID: <20190708163900.yhzb2qh7w5mlcqkc@localhost>
References: <1562572504-142115-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562572504-142115-1-git-send-email-zhangxiaoxu5@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 03:55:04PM +0800, ZhangXiaoxu wrote:
> When covert the usec to nsec, it will multiple 1000, it maybe
> overflow and lead an undefined behavior.
> 
> For example, users may input an negative tv_usec values when
> call adjtimex syscall, then multiple 1000 maybe overflow it
> to a positive and legal number.
> 
> So, we should validate the usec before coverted it to nsec.
> 
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  kernel/time/timekeeping.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 44b726b..e5c1d00 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1272,9 +1272,6 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
>  	struct timespec64 tmp;
>  	int ret = 0;
>  
> -	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
> -		return -EINVAL;
> -
>  	raw_spin_lock_irqsave(&timekeeper_lock, flags);
>  	write_seqcount_begin(&tk_core.seq);
>  
> @@ -2321,6 +2318,9 @@ int do_adjtimex(struct __kernel_timex *txc)
>  
>  	if (txc->modes & ADJ_SETOFFSET) {
>  		struct timespec64 delta;
> +
> +		if (txc->time.tv_usec < 0 || txc->time.tv_usec >= USEC_PER_SEC)
> +			return -EINVAL;

This test is wrong.  If the tv_usec field is in nanoseconds, then the
value can easily be greater than USEC_PER_SEC.

>  		delta.tv_sec  = txc->time.tv_sec;
>  		delta.tv_nsec = txc->time.tv_usec;
>  		if (!(txc->modes & ADJ_NANO))
> -- 
> 2.7.4
> 

Thanks,
Richard
