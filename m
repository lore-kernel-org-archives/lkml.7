Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6551C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA38214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfDSARZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:17:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38279 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDSARZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:17:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id f36so1881437plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 17:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=EI0Z6tTTZtHou+ddBuW2q5/I4T5ckgzWn0pKpWFfDic=;
        b=rnMRYrACxlnm2GJkjwU9MrSDCho11+FGzle6XApMBr/q1wFax19a/Dm7ksrtRnJ9Wq
         ydCwbuULk8z3NFcKJ6C3HiM2GFuZCk6w91Yqr5xB9p552YD4GNxMaR/fbVFrw4O44Rg8
         t49K2U5typQ1Nvr2dl8aIZL+3TT2H9l5um9d38KxU+PfZzailae1MhGAslDkRlxGjdUX
         C93vCoat2GXt9wQoiFY20HzuWLqVzbqErHetPXb+VVNbTgmU0Sj/rDm+J0afRJeHsw+U
         B2r9rEGMeg60ooXDGb8FIgIll3PMUwLV1H9VI3z7G4M5+uT14b+wHyIqscOLYv+ONcYc
         s+ow==
X-Gm-Message-State: APjAAAV3n4K80g2KxYPmPTOnZuXb5jI25ghHQwH9QJ6dR3i/w3gF05di
        J/s4CFTzfuNyFnizFhkUdTsZ4Q==
X-Google-Smtp-Source: APXvYqwLBJO580DxIms78I2IA+KimlAlcGotMl7QATxRMSGr+lIYshYIJNoc9b7scbXuZ6CdTqkxmA==
X-Received: by 2002:a17:902:822:: with SMTP id 31mr569190plk.41.1555633043969;
        Thu, 18 Apr 2019 17:17:23 -0700 (PDT)
Received: from [10.99.178.44] (p3300202-ipngn21401hodogaya.kanagawa.ocn.ne.jp. [153.129.48.202])
        by smtp.gmail.com with ESMTPSA id a3sm3480824pgj.89.2019.04.18.17.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 17:17:22 -0700 (PDT)
Date:   Fri, 19 Apr 2019 09:17:17 +0900
User-Agent: K-9 Mail for Android
In-Reply-To: <20190418154045.2ad0bd50e73a6e71c0fac768@linux-foundation.org>
References: <20190417131531.9525-1-mcroce@redhat.com> <20190418154045.2ad0bd50e73a6e71c0fac768@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3] proc/sysctl: add shared variables for range check
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
From:   Matteo Croce <mcroce@redhat.com>
Message-ID: <1109DAD2-E25B-47A3-8381-E02260FE51B9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 19, 2019 7:40:45 AM GMT+09:00, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 17 Apr 2019 15:15:31 +0200 Matteo Croce <mcroce@redhat.com>
> wrote:
> 
> > In the sysctl code the proc_dointvec_minmax() function is often used
> to
> > validate the user supplied value between an allowed range. This
> function
> > uses the extra1 and extra2 members from struct ctl_table as minimum
> and
> > maximum allowed value.
> > 
> > On sysctl handler declaration, in every source file there are some
> readonly
> > variables containing just an integer which address is assigned to
> the
> > extra1 and extra2 members, so the sysctl range is enforced.
> > 
> > The special values 0, 1 and INT_MAX are very often used as range
> boundary,
> > leading duplication of variables like zero=0, one=1, int_max=INT_MAX
> in
> > different source files:
> > 
> >     $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
> >     245
> > 
> > This patch adds three const variables for the most commonly used
> values,
> > and use them instead of creating a local one for every object file.
> > 
> > ...
> >
> > --- a/arch/s390/appldata/appldata_base.c
> > +++ b/arch/s390/appldata/appldata_base.c
> > @@ -220,15 +220,13 @@ appldata_timer_handler(struct ctl_table *ctl,
> int write,
> >  			   void __user *buffer, size_t *lenp, loff_t *ppos)
> >  {
> >  	int timer_active = appldata_timer_active;
> > -	int zero = 0;
> > -	int one = 1;
> >  	int rc;
> >  	struct ctl_table ctl_entry = {
> >  		.procname	= ctl->procname,
> >  		.data		= &timer_active,
> >  		.maxlen		= sizeof(int),
> > -		.extra1		= &zero,
> > -		.extra2		= &one,
> > +		.extra1		= (void *)&sysctl_zero,
> > +		.extra2		= (void *)&sysctl_one,
> >  	};
> 
> Still not liking the casts :(
> 
> Did we decide whether making extra1&2 const void*'s was feasible?
> 
> I'm wondering if it would be better to do
> 
> extern const int sysctl_zero;
> /* comment goes here */
> #define SYSCTL_ZERO ((void *)&sysctl_zero)
> 
> and then use SYSCTL_ZERO everywhere.  That centralizes the ugliness
> and
> makes it easier to switch over if/when extra1&2 are constified.
> 
> But it's all a bit sad and lame :( 

No, we didn't decide yet. I need to check for all extra1,2 assignment. Not an impossible task, anyway.

I agree that the casts are ugly. Your suggested macro moves the ugliness in a single point, which is good. Or maybe we can do a single macro like:

#define SYSCTL_VAL(x) ((void *)&sysctl_##x)

to avoid defining one for every value. And when we decide that everything can be const, we just update the macro.

Regards,
-- 
Matteo Croce
per aspera ad upstream
