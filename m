Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB25C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1663620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfDQF4s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:56:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37636 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfDQF4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:56:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so11568938pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=7j0+ojx4hcJIDnWfT3xpu3SZRzGN//FLGQ4ISdiuboU=;
        b=sOjcpHTSdaiPubzKjUA4cNEUsBeCbrPVsKsk9+4cuKlONxJSBaho0NjCmp59uDFx+G
         +ppNiRXb229EOboF7Vv0lwdCz28lnrdPPFA3sHB3BI7zYqOuQCXXi3Chnt3p3hYQELUH
         bn55kRlpzEEsWaawiT0obQp+H4oWBVHgAu7dsQLl+5sneH4glSMJ+8f+jnPy9K+rZ3gZ
         SSxjx3t5ppESkEOBWKA44h6nB4niTY1da7HeVODqleCsVsIsl5069mNdTJn/GXnhPf/D
         mbo6sPgKUDpeI80GZdhmIMGscjstUFM0iNm72iBbKc012kAMQS/gmmBToBpfTD7hZye6
         3Opw==
X-Gm-Message-State: APjAAAVOueIg+JWbW0dfBzq8Nkt5fvTrU8HsGtZdQtlrXD+9ZoiXxSMo
        cE6i2Oh8TZjqXGDVtMYwauVTTg==
X-Google-Smtp-Source: APXvYqx68YtZiLQ3VpyLpZadcjkH9R8daR8fS+l9yYuT/8arHn3z7OcJPhIUxk4CWFdWAOCyBYx4LA==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr72168314pgs.258.1555480607473;
        Tue, 16 Apr 2019 22:56:47 -0700 (PDT)
Received: from [10.36.237.165] ([103.5.140.153])
        by smtp.gmail.com with ESMTPSA id c3sm99676585pfg.88.2019.04.16.22.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 22:56:46 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:56:41 +0900
User-Agent: K-9 Mail for Android
In-Reply-To: <20190416201741.19395c715a1cb0f2130e795a@linux-foundation.org>
References: <20190417005943.17448-1-mcroce@redhat.com> <20190416201741.19395c715a1cb0f2130e795a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] proc/sysctl: add shared variables for range check
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
From:   Matteo Croce <mcroce@redhat.com>
Message-ID: <E57B4283-D12E-4C8B-9064-7598B9945148@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 17, 2019 12:17:41 PM GMT+09:00, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 17 Apr 2019 02:59:43 +0200 Matteo Croce <mcroce@redhat.com>
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
> 
> Nice.  A few thoughts:
> 
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
> 
> The casts are ugly, and by casting away constness they introduce the
> risk that some errant could could change the value of 0, 1 and
> INT_MAX!
> Maybe - perhaps trying to do that would cause a segv but still,
> they're ugly.
> 
> A proper fix would require changing extra1 and extra2 to const void *.
> 
> Perhaps that would be unfeasibly extensive?
> 

Hi Andrew,

I agree that the casts are ugly, but the "casts discards const qualifier" is way more ugly, so I have no choice.

I though about declaring extra1,2 as const, I quickly checked for code which write into these pointers and I found none, but I only looked for one, two and int_max values.

We could do a deeper search to see if other values are safe to turn to const.

> > ...
> >
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -21,6 +21,11 @@ static const struct inode_operations
> proc_sys_inode_operations;
> >  static const struct file_operations proc_sys_dir_file_operations;
> >  static const struct inode_operations proc_sys_dir_operations;
> >  
> > +/* shared constants to be used in various sysctls */
> > +const int sysctl_zero = 0;
> > +const int sysctl_one = 1;
> > +const int sysctl_int_max = INT_MAX;
> 
> Don't these require EXPORT_SYMBOL()?

Yes, for kernel modules, as the kbuild bot just pointed out.

Regards,
-- 
Matteo Croce
per aspera ad upstream
