Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83692C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C8720718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee9rXHdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKNTPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:15:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43698 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:15:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so4927867pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zv6LI4Ql+HVAW1nYni4FKAmqM6usFkERBI/Nwxr+Lyo=;
        b=ee9rXHdwZkxyKubw3Nz8skuM+eO29Dk7Dwksgi3qRZj8ilBGcnMw8xknr2JMhJf9OM
         D6htLDkdgE/jruqmBzdpqMAyMXpL6pdJnciQF8vEYJTcmrqIfdWTBnOi7OY52gNsyRcQ
         OyfQ/m/AQf1H2oJgR8J1egT1rz517JBdTvPLgFaejhS046NuCki8n6cucxgWXoPaebCh
         XqvSLpoEgB62uhuW+djoS/It4IKiRHFWC9gQjkRrJTGhzbOusQ3Tx9M6QqO/BFlVP9Kc
         DI+1HvO6UXW2kgm0dms5UFMwf3G454nfrY45aPHhWr4k+ekc3uhSswjsngZWH3Hky6/n
         YUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zv6LI4Ql+HVAW1nYni4FKAmqM6usFkERBI/Nwxr+Lyo=;
        b=aUKRFF7WENeaJmY5yAnR5XqkWR+OFu5HErp/IlMmpZm3PqfQOlsi9hIQhNM0HvlCPF
         xQuam61Lu7oyz54x0iGfNf3ASq0He+gkIQe6ucBbx/Rlhnz8GxjbdV6cOhesfnPDNM+W
         M6Eqa7rkiN0hq7u6K1LlW8pxSCAud2+Flg4o9aPGS5WyV9/qaDpXVVRHrjDvs9amM1YW
         XEcjS5L6tZ8xJIKGB7YrEchcQWiYJUNMv/HDwxDTRhOJsY1TKtE0yX5jxP4P/iPKHXcj
         zeWhVpOjehX+9Ebc09NsYkbdhHMQ4UMW9CUJVpbTVu6CANchE2duBtOv8b7yCasStBiS
         M62A==
X-Gm-Message-State: APjAAAVWKXmqFc9vWqCHwlGODAl9jhBaKvhFdPITiE5DsWBemyhx2q/T
        bc1S4UeCDH0Gc8N88s9mBJE=
X-Google-Smtp-Source: APXvYqzyzWtv7LCl5lILWSObx+ngwicoJ0cqa/D518nW6TzwlXYnvn1WfCp92uDVMIaUevXw0qow5w==
X-Received: by 2002:a62:174b:: with SMTP id 72mr100747pfx.179.1573758941922;
        Thu, 14 Nov 2019 11:15:41 -0800 (PST)
Received: from gmail.com ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id a25sm7222499pff.50.2019.11.14.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:15:41 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:15:38 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v10 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191114191538.GC171963@gmail.com>
References: <20191114142707.1608679-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20191114142707.1608679-1-areber@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:27:06PM +0100, Adrian Reber wrote:
...
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 1d500ed03c63..2e649cfa07f4 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
...
> @@ -174,24 +186,51 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  	pid->level = ns->level;
>  
>  	for (i = ns->level; i >= 0; i--) {
> -		int pid_min = 1;
> +		int tid = 0;
> +
> +		if (set_tid_size) {
> +			tid = set_tid[ns->level - i];
> +			if (tid < 1 || tid >= pid_max)
> +				return ERR_PTR(-EINVAL);

do we need to release pids what have been allocated on previous levels?

nr = -EINVAL;
goto out_free;

Could you add a test for this case?

