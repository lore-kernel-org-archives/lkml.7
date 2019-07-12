Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F55CC742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DAB2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqHfbu8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfGLJW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:22:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33718 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfGLJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:22:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so4285285pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AZZrwf4czTogrdqW6lDH+L8NIxtCdpEI/ZTpyTZPAl8=;
        b=jqHfbu8C6u4dFuNovGi+alcC3DMpZH24fLYxcjuhKVP6D1Fcj9W4dbcymMB3mHofmJ
         kCwjcOsRjkh8wwB7dlWvmjJS7z1KvIXJpMKT1oM/jZNMqvaPx8wmpE2+KuhK+MmUPcgj
         dlqg+gY/tz62KRfNxinm5v7C7qmlEdSbdLjUMBgnbII/NYdOnNYUCASi80M67FhictSu
         8jIzIHxjVNiiL6Y0/+1CRYRjZIrDybMTE/zkVYJK6eaA1OqJ/2t2L+q6pWcIHSHuyxu2
         rw0XZX06fnWob0Vw4ahoRkI2M/5Kgd6LtYRfzf0T+mTNR3UnAmRcSlHFbpLlVco20jS0
         qd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AZZrwf4czTogrdqW6lDH+L8NIxtCdpEI/ZTpyTZPAl8=;
        b=Q80MR/x2LD3SK//hVSLPS59a79FFB0IedQYCxjAFayKeQeYHyw5yoOrnztk+rUjW4Y
         nBZtRv3nGfW8texL5MJLF/r8ls3SFEcf6V66fxRRFmil6cLaQivZbCwBfZ0R2s/Jh8g/
         qjFYH+hJANxUAk9XKIxrmZQ8UeFryTB/9EyrcQkBkaoimRD3kWfvSLqpHFFwVKhGTZi0
         0Intw1nSh/L/wVQu71QFU6GpkJSwu4JfFo7zDu+feEz8WDSyrscCEOyR4QlEpXpDonM2
         KUTY0af4axYwnUbswMl5lR25zu3rjBkVrY0/WCXZ9xHzR6nxrifDO0i80/fqt3Jo1RxL
         /S1A==
X-Gm-Message-State: APjAAAXgGjmPjWQVz/DNfu7XTHLc/KyRakS/bsCV9I2TCcU2JJlyt/2/
        asWfhPlietayE786FZtS3c5+qcWu
X-Google-Smtp-Source: APXvYqwfnCEetk/X2bvBjMvhqM89ZSPWQEvisISF4Pnw5g0nmH+fux/FUGkVGTBfiliP7kVOQaVh4Q==
X-Received: by 2002:a63:6f8f:: with SMTP id k137mr9609727pgc.90.1562923377902;
        Fri, 12 Jul 2019 02:22:57 -0700 (PDT)
Received: from localhost ([110.70.51.104])
        by smtp.gmail.com with ESMTPSA id b26sm10938548pfo.129.2019.07.12.02.22.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 02:22:56 -0700 (PDT)
Date:   Fri, 12 Jul 2019 18:22:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Vincent Whitchurch <rabinv@axis.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Do not lose last line in kmsg buffer dump
Message-ID: <20190712092253.GA7922@jagdpanzerIV>
References: <20190711142937.4083-1-vincent.whitchurch@axis.com>
 <20190712091251.or4bitunknzhrigf@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712091251.or4bitunknzhrigf@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/12/19 11:12), Petr Mladek wrote:
> > For example, with the following two final prints:
> > 
> > [    6.427502] AAAAAAAAAAAAA
> > [    6.427769] BBBBBBBB12345
> > 
> > A dump of a 64-byte buffer filled by kmsg_dump_get_buffer(), before this
> > patch:
> > 
> >  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 35 32 32 31 39 37  <0>[    6.522197
> >  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
> >  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > 
> > After this patch:
> > 
> >  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 35 36 36 37 38  <0>[    6.456678
> >  00000010: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.
> >  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> I think that I need vacation. I have got lost in all the checks
> and got it wrongly in the morning.
> 
> This patch fixes the calculation of messages that might fit
> into the buffer. It makes sure that the function that writes
> the messages will really allow to write them.
> 
> It seems to be the correct fix.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Looks correct to me as well.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
