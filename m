Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D4FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB853222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joNac9DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKMBMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:12:31 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33596 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKMBMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:12:31 -0500
Received: by mail-yw1-f65.google.com with SMTP id q140so165760ywg.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=DML7y3ZgeawbCghKl2/U9gcID5bkzvxXQZvoeM1CZYk=;
        b=joNac9DApN0htbfASeTvQ+Ie9Ozq1A6iOn4xXW9Cj0ebnLmzKXvH9BUtqi5z2ViadC
         TfRJ4MpWgNw3/ZL/mlclWCy3dV6/oGgk9V9L3wKf6+jhtV7jQ8S4pLwLJFvsFQVNRLUV
         8WOCWrJFXSPlcjQQOaFBcjMwQ5ozHyZR12NstjBCqASlFRrfk4NcfOrVZfP6lQCM4Axy
         WtnyHgHw1N/+q+pPFWvW9Q68o1QM7gRfYvdQgfcKuK44CHLDFFrkhpwRSs+7ZZbYR/KP
         HRt9GHYAu2hEE6G3DxHaN4WIq3fClIyoCV2InYXgeaGIvVRA8J3eYsDQQZWjwvM+1xhM
         GDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DML7y3ZgeawbCghKl2/U9gcID5bkzvxXQZvoeM1CZYk=;
        b=B2m6aUStA8OmX6uDekj9P98apAkx6w/K321p3AtyZxPUemDqdJ6HbvIMpGDPQ706hv
         cT5pYZOHBg1h8Ze3vRy99AEmGU+MUeOA7sTdYf1mB1Z+KGhSwne8Y4pCmCsEKowkwJrh
         wPB+hegCZIyB0tBYPl109f2aHHatCUMqJIF64u9x0j44YlJpM8hXJHZxuvgvz9BiPfVM
         ks42UGZFRfV7ewefjQDqueCZJXVmW7Q/uncXLYBTlze6UB+bgDBaBu/hC0jVl0hbNMtJ
         /BQZBfaxm25k2ZvniH8JfdAmgu0GQSRGykyNSDmdPXistEfTVvy0K1OwyjIqkSwgCDJ7
         Fywg==
X-Gm-Message-State: APjAAAVjd+etyPeyNEBL37uou4aVvClQSwJvqphbNO7bU3RUHQVrvZ4e
        uOuu0WV8noKwzW64c8F/gCV93xrFvNTKcA==
X-Google-Smtp-Source: APXvYqwYhQHAI0u8Q70c2G5qysEs5laUdqZaIMhbe42bNoU+FfJNxrMt37oHKrt9rLPp5E9YsSYP8Q==
X-Received: by 2002:a0d:c207:: with SMTP id e7mr594797ywd.101.1573607550217;
        Tue, 12 Nov 2019 17:12:30 -0800 (PST)
Received: from gmail.com ([196.247.56.44])
        by smtp.gmail.com with ESMTPSA id t15sm290269ywf.69.2019.11.12.17.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 17:12:29 -0800 (PST)
Date:   Tue, 12 Nov 2019 20:12:26 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] Re: [PATCH 7/9] staging: rtl8723bs: Fix
 incorrect type in argument warnings
Message-ID: <20191113011226.fw5ohzpchgizhpen@gmail.com>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <cover.1573577309.git.jarias.linux@gmail.com>
 <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
 <20191112203343.GA1833645@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112203343.GA1833645@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 09:33:43PM +0100, Greg KH wrote:
> On Tue, Nov 12, 2019 at 11:55:27AM -0500, Javier F. Arias wrote:
> > Fix incorrect type in declarations to solve the 'incorrect
> > type in argument 3' warnings in the rtw_get_ie function calls.
> > Issue found by Sparse.
> > 
> > Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > index db6528a01229..bb63295e8d4e 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > @@ -83,7 +83,7 @@ static char *translate_scan(struct adapter *padapter,
> >  {
> >  	struct iw_event iwe;
> >  	u16 cap;
> > -	u32 ht_ielen = 0;
> > +	sint ht_ielen = 0;
> 
> sint?  Ick, try fixing up the function call itself please.
> 
> thanks,
> 
> greg k-h

Hello Greg,

I found that rtw_get_ie is called 62 times and the passed argument
can be declared as sint, uint, u32, u8 and probably a couple more.
I'll drop this patch for now and check more carefully if this fix
would require more changes, as changing the argument type wouldn't
solve the warning described in the commit.

> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191112203343.GA1833645%40kroah.com.
