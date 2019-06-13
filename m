Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DC9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0868E207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWH+zJrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFMPjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:39:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35604 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfFMJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:56:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so21808527qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yUTqUBqkax5PLka8rAGeJRVrCzT0V8TyFvJFo1GfWPg=;
        b=FWH+zJrP5W9h0Ud+e694o5fSDxhYnVFhew5pr91jcr3G1zi/JDQcxoFaBilGW1NI5I
         ziPGqBHzdRLWY41yY/opDPe99zxFJ4Qgo2SonC3toojHroR6VMK5rb/+lZbgxWpgFVMW
         9lAHMks/mSNFdO5NfwP8B3T/OLDTTxtH8vQLBgvRRDo1ImOr3LqooZCpacZYiI7xCF3y
         qeDa1ZeiAzxgNQH8uUot3PCo/knONG+fiYBG0uwRVRmspvkrFfKYTCigrYII57UHP33K
         7w23p+HIibNCB8f3wfyQlcJgEbTVqCxULRdUmms4Pd6fCY3A4CVT3YEZAtX3m7sXJ2S7
         jIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yUTqUBqkax5PLka8rAGeJRVrCzT0V8TyFvJFo1GfWPg=;
        b=l7VfJ+Md8lwbk7bmCzsWst2gKg7o1hGdJ5XtL9oprgRhnGspZIC2fM3b3/6mCFc2qO
         HzzupM7s5+5Q/b6AFqZ8Goo5nab3j2yQjaOvDwT5vot7KWSqR4zLH2aVqjmPR4tDvvy6
         mzJuh+s3nNlg4TYyi1KdT95qgIL0BjLRqrnZ0jHFJmbnz36kVaEJEOy2ZfrqaI5y5wTv
         cjLRWnCph57jRZQFNZfKneuhNskNo2Yb31jKJ7Jqyog+No/OqeYQOTPEznAJRKQpW/R3
         bstlM4tFMm7aE383ZqJNGKKV9bcTB5yjJh41QHKf0fLyOgTwvebQrXUG0JOfDBCCISah
         iDgw==
X-Gm-Message-State: APjAAAVdn5s5oKhnNH2/6Okw58xWnOahrvL8bRU8NFIN1SwYxt/ekPLl
        gfwKJuVm4a5hB4z6DHsD+DCdLQ==
X-Google-Smtp-Source: APXvYqyWgqhc0JZ0USh1kD+qATL5bjIR0yQg9niUku+JiOu1hqEfFKRFoCHLaS4M6k0J1VQQlNyFlw==
X-Received: by 2002:ac8:34ce:: with SMTP id x14mr76029799qtb.33.1560419805121;
        Thu, 13 Jun 2019 02:56:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id a15sm1522337qtb.43.2019.06.13.02.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 02:56:44 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:56:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coresight: potential uninitialized variable in probe()
Message-ID: <20190613095637.GA5242@leoy-ThinkPad-X240s>
References: <20190613065815.GF16334@mwanda>
 <20190613074922.GB21113@leoy-ThinkPad-X240s>
 <20190613081419.GG1893@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613081419.GG1893@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Jun 13, 2019 at 11:14:19AM +0300, Dan Carpenter wrote:
> On Thu, Jun 13, 2019 at 03:49:22PM +0800, Leo Yan wrote:
> > Hi Dan,
> > 
> > On Wed, Jun 12, 2019 at 11:58:15PM -0700, Dan Carpenter wrote:
> > > The "drvdata->atclk" clock is optional, but if it gets set to an error
> > > pointer then we're accidentally return an uninitialized variable instead
> > > of success.
> > 
> > You are right, thanks a lot for pointing out.
> > 
> > I'd like to initialize 'ret = 0' at the head of function, so we can
> > has the same fashion with other CoreSight drivers (e.g. replicator).
> > 
> >  static int funnel_probe(struct device *dev, struct resource *res)
> >  {
> > -	int ret;
> > +	int ret = 0;
> > 
> > If you agree, could you send a new patch for this?
> 
> Obviously that's an option I considered...  The reason I didn't go with
> that is that a common bug that I see is:
> 
> 	int ret = 0;
> 
> 	p = kmalloc();
> 	if (!p)
> 		goto free_whatever;
> 
> In my experience it's better to initialize the return as late as
> possible so that you get static checker warnings when you forget to set
> the error code.

Just want to check one thing, which static checker you are using?
I use sparse but it doesn't report this issue (I learned coccinelle
also can do this but it outputs verbose logs).

To be honest, I didn't often run static checker when committed patches,
but hope later can improve for this.

> Also I think my way is more readable.  I like to make the success path
> as explicit as possible.  I hate when people do things like:
> 
> 	if (!ret)
> 		return ret;
> 
> About 10% of the time when you see this it is a bug, but it's hard to
> tell because it's not readable like it would be if people did:
> 
> 	if (!ret)
> 		return 0;
> 
> Or sometimes you see things like:
> 
> 	if (corner_case)
> 		goto free; /* success path */
> 
> Without the "/* success path */ comment explaining why we're returning
> zero most readers will assume it's a mistake.

Thanks for sharing much knowledge; your change is okay for me.

I think the point is the good habit can avoid pitfall and traps :) [1]

Thanks,
Leo Yan

[1] https://www.amazon.com/C-Traps-Pitfalls-Andrew-Koenig/dp/0201179288
