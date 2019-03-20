Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A615E2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwfb5AIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCTU27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:28:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56092 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfCTU26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:28:58 -0400
Received: by mail-it1-f193.google.com with SMTP id z126so955682itd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipetAED701k6O/QX9z0W2QXyUgTzSezTx2Yj2h9vxT0=;
        b=nwfb5AIhrvnpLExlRjGhbEHDoEc1Rk68fZSxiyPPf82fwhNrOlBG42i59CuASRem/8
         qKlutmbcecKVR+7JUi4lhZZSGRhhinLYEJSodhcENRQFYuPYerU3lltC3N+mOPZ7/F9p
         DjFryrEgzAuRYza7wOhObs210Bcxzx/rvTDBMUhwifce7Cr2c/TaeBDl07p6Gf7YcUVU
         I5Jysy2KctmW8r51Iw+P+FfyiUui3WRAn711ieS2do4AUoVf+RUpfEZ7/cCf+HJ3a1qB
         JOX8AmPWLf43R9lI9eXotb/xCAwB+TJ+KRw03Qcnns0FJYKjxwnYtwSw5X0OHjVaMX03
         32uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipetAED701k6O/QX9z0W2QXyUgTzSezTx2Yj2h9vxT0=;
        b=GpdFniUXteHvK4OmMat+sFJrV5g3bB58K24/JrMRHzwjUWy8+i5bxRpH/hWLsMV60E
         FG0RB/8+vLKY4jorjQLeVD5zS78XR5N2uQ6kE2bTRdQEHRfgYLBbjkzzw2AYYaKs1/Od
         JiDUTSUMv+wZP27oNLoCyD1husV+JKQ+5Gzw8PNrv2AOYO3AtM6N4GwLY2xyjJWrLxEm
         mGaR/qkVYHkmBNDwOWT/h/Dvvpcqa8kl6G4FszNzBHAg2/dKq4VyjL4XyiH+1BkJcCeV
         01aM+7A7tQveieqX+rnP9y5mSWDLYvg4sNeWq+/7ESPitKfzsgulLyeWoQpVu2s2cMqe
         G6RA==
X-Gm-Message-State: APjAAAWmeecZsrXtUfZhlByM8rT54Rkv2+o4mMYG1a7MyFdxFJsBIbVv
        C5ZdUOlEzHy+/GDtJwkqMdY=
X-Google-Smtp-Source: APXvYqyYGvyj9jNT1tBntvnfVUqAXGHai/48CSGAOl3x5g/YmayK81bHSRu7EgfSqq9o2Lqc0ABlPg==
X-Received: by 2002:a24:35ce:: with SMTP id k197mr181684ita.2.1553113738229;
        Wed, 20 Mar 2019 13:28:58 -0700 (PDT)
Received: from tzanussi-mobl ([2601:246:0:7004:98e9:b645:1289:9c63])
        by smtp.googlemail.com with ESMTPSA id z22sm1307029ioc.68.2019.03.20.13.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:28:57 -0700 (PDT)
Message-ID: <1553113736.2015.2.camel@gmail.com>
Subject: Re: dell_smbios KASAN bug
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 15:28:56 -0500
In-Reply-To: <20190320154534.46ebab51@gandalf.local.home>
References: <1553106560.2080.5.camel@gmail.com>
         <20190320144146.08ecd5e4@gandalf.local.home>
         <1553108749.2079.1.camel@gmail.com>
         <20190320151353.1a223c0e@gandalf.local.home>
         <1553110221.2034.1.camel@gmail.com>
         <20190320154534.46ebab51@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 15:45 -0400, Steven Rostedt wrote:
> On Wed, 20 Mar 2019 14:30:21 -0500
> Tom Zanussi <tzanussi@gmail.com> wrote:
> 
> > > diff --git a/drivers/platform/x86/dell-smbios-base.c
> > > b/drivers/platform/x86/dell-smbios-base.c
> > > index 9dc282ed5a9e..c3825c674522 100644
> > > --- a/drivers/platform/x86/dell-smbios-base.c
> > > +++ b/drivers/platform/x86/dell-smbios-base.c
> > > @@ -619,6 +619,7 @@ static int __init dell_smbios_init(void)
> > >  
> > >  fail_platform_driver:
> > >  	kfree(da_tokens);
> > > +	da_num_tokens = 0;
> > >  	return ret;
> > >  }
> > >    
> > 
> > 
> > Unfortunately, no.
> 
> That's really weird. I would recommend throwing in a bunch of printks
> to see if things are being freed and set, to make sure this code is
> hit
> and something else isn't just corrupting it.
> 

Actually the patch does make the KASAN bug go away - I'm so used to
building without modules that I forgot to rebuild the module after
applying the patch, sigh.

Tom

> -- Steve
