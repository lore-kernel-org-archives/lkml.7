Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E4AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D2D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilihGdHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfEPSZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:25:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46758 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPSZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:25:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id t187so1943956pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8D5391fetjU3ekpZDrWHFkxYRoxxpYevMJ+dYscZYgI=;
        b=ilihGdHq5nQwNlLktCUC/vVKyU1fXVJWqW87byC165CM1EZpJ+aQU+VjKQ4UlcmK++
         Zq31eXM8DYdkbJzeg3PHI3FBu5REMWBhtKn3eAoDsspM792laAqSyP5ye071TMt5NS6M
         bjUNkpMoBc36rNGhIsRoT/0QOYwkVNQErPCei61/UURXQ3ekhE8Bza1O+SxnWhFo/dYs
         r57oCB9gZmDIC7DtTtcXPcAaMosN9i6TBQ4tftJhNHHDsKfENrBjd8jycqItl1zDu794
         ivVNhPRFBzFFTJE6PAY2b2KP+frsz69Y4dBtr5rwEe1IoyseLhLtNhdEPwTZzfdI6Rbf
         FO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8D5391fetjU3ekpZDrWHFkxYRoxxpYevMJ+dYscZYgI=;
        b=d5WCoySc34V7zYt3NQwSnBXH/Ssf2eqaHstU1SpYPQ0LpSP6VGnSTxy1yCbi7wVm3P
         lc6OIg2zYEsyDfgxRck4tFQsWzgOYab1bUkUUlAhJkg+UyjTGU6pG6yETsv9Ef4sAPhG
         kyZnQZsHrVt+L877qgMSU0p1NmBLBl9VeY8LI9Ms1gakr3/6DCbRdagoff+uEt5jBSp3
         9PMxXGtIufwI/nbTd+SQelcB3YXRPeQx5e/OF5NRem9eNl/LY47UrGAgXUAahZ8AT9Uh
         Ml3sJawDpFNw0BHGAObOaVhWQOwYOsGIA8JwN3We8xxSMbBmke2AuT6NfDEmJEYjE1CJ
         r/cg==
X-Gm-Message-State: APjAAAWAJqv9oZiGCugkKKDLdmTZGwTOB8P/SM2eZrw0Re30CUW5d7H9
        Tc0/SLEr9N19bjE22ML1/d/Jacn+
X-Google-Smtp-Source: APXvYqzCa3PHgMcdhgxs0zbPcf6J8Iy1f6cUT3SqlMGD586iDTYpr1mSBOuiWTmJ/BsJ9jrdQfGlVg==
X-Received: by 2002:a63:1316:: with SMTP id i22mr51726562pgl.274.1558031144325;
        Thu, 16 May 2019 11:25:44 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id s9sm9226513pfa.31.2019.05.16.11.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 11:25:43 -0700 (PDT)
Date:   Thu, 16 May 2019 23:55:39 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_recv: fix warning
 Comparison to NULL
Message-ID: <20190516182538.GA4025@hari-Inspiron-1545>
References: <20190515174536.GA4965@hari-Inspiron-1545>
 <20190516080056.GH31203@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516080056.GH31203@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:00:56AM +0300, Dan Carpenter wrote:
> On Wed, May 15, 2019 at 11:15:36PM +0530, Hariprasad Kelam wrote:
> > @@ -1042,7 +1042,7 @@ sint sta2ap_data_frame(
> >  		}
> >  
> >  		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
> > -		if (*psta == NULL) {
> > +		if (!*psta == NULL) {
>                     ^^^^^^^^^^^^^^
> It's surprising that this didn't cause some kind of warning somewhere...

Thanks for pointing out this error. Here my intention is to write
                if(!*psta) 
but somehow i missed it .

Will resend this patch after correcting the same.Like below

> -           if (*psta == NULL) {
> > +           if (!*psta) {


Do let me know if the above propose change is fine or not.
> 
> >  			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
> >  			DBG_871X("issue_deauth to sta =" MAC_FMT " for the reason(7)\n", MAC_ARG(pattrib->src));
> >  
> 
> regards,
> dan carpenter
