Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79880C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE6E217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JBSSNJBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEIU0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 16:26:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33692 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfEIU0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:26:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so4813119wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ihBJ0/fdU1eA6yYjvazr1eutl37ifhuKRklwOcMnkG4=;
        b=JBSSNJBpVQGLa6UlUwTKhug32nXe/y/VfWJV5O8/qVYhD6bzhR9ILlMSFrdIUsmbMT
         18o1C8UyKoh8Fyiz9lTbA48JBLHBD+1SxUxpnc7ZzbLY5WUptPYQaGiZlUeWubgoXBTS
         Qmd47R7IZjPI0APcYUKvXBXuhBFoRak6OnIig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ihBJ0/fdU1eA6yYjvazr1eutl37ifhuKRklwOcMnkG4=;
        b=Ie3siTeS5MAMv2FEqXZpW2C2G1flmkX6wZEm1cYermM132Rl43ICmLvJYwR9qX41hj
         QwmD0/VXrHEInYaeScI4r2IOETvFmfSCwmmjyT/xiQZ8RK3Aeqn/+nZ+Kg18FT4RCwEn
         KCtzF/N/18yJYNSt2gLghLZL+4+jJLYrBSEPWcZWf6kkE225nAw/EawEA5yTYZcfq7DG
         RvvWvtxnkrf1DLWx/01Zf50Zs0YXgc2u7Me6QAOTVeQQ4OPNjMfOY9XWnmVnT7GEvK67
         bmfmHQf58NKGh4wQ3WWhmkZlXs98QfhfcJas5nEXrycYAC2IpDevz8a8NalWBTndPb44
         1RLA==
X-Gm-Message-State: APjAAAWvhfdWMNDO3BEbNpNA7WaeDXRjn2OgH74JlEGOnJWG++cYhhOu
        /Nr+ZatRYJofEDo/bFNZMiDFYMKcTFTtcg==
X-Google-Smtp-Source: APXvYqy6uFPw6IdKOJvIDUCpd1ArMz5Sd0jJngShWfRsvJpepaKAdopsDMNvgXF2cU0zWXhohOPxyg==
X-Received: by 2002:adf:fe49:: with SMTP id m9mr4396113wrs.73.1557433588348;
        Thu, 09 May 2019 13:26:28 -0700 (PDT)
Received: from andrea ([91.252.228.170])
        by smtp.gmail.com with ESMTPSA id n15sm3822470wrp.58.2019.05.09.13.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:26:27 -0700 (PDT)
Date:   Thu, 9 May 2019 22:26:19 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] sbitmap: fix improper use of smp_mb__before_atomic()
Message-ID: <20190509202619.GA4201@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-4-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556568902-12464-4-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:14:59PM +0200, Andrea Parri wrote:
> This barrier only applies to the read-modify-write operations; in
> particular, it does not apply to the atomic_set() primitive.
> 
> Replace the barrier with an smp_mb().
> 
> Fixes: 6c0ca7ae292ad ("sbitmap: fix wakeup hang after sbq resize")
> Cc: stable@vger.kernel.org
> Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: linux-block@vger.kernel.org

Jens, Omar: any suggestions to move this patch forward?

Thanx,
  Andrea


> ---
>  lib/sbitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 155fe38756ecf..4a7fc4915dfc6 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -435,7 +435,7 @@ static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
>  		 * to ensure that the batch size is updated before the wait
>  		 * counts.
>  		 */
> -		smp_mb__before_atomic();
> +		smp_mb();
>  		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
>  			atomic_set(&sbq->ws[i].wait_cnt, 1);
>  	}
> -- 
> 2.7.4
> 
