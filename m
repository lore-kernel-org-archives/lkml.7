Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FEEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BB720661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGgIMMj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfCFVNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:13:02 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:42104 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfCFVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:13:01 -0500
Received: by mail-qt1-f174.google.com with SMTP id u7so14622013qtg.9;
        Wed, 06 Mar 2019 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EukjDy9c7SvftzNriC6LZ02QMk88D9KgydjwJRQrqig=;
        b=vGgIMMj0xgPoLSgVBg8+ZTCFW4N2AN+2ZNjjFS+T1mJQ9acA7cGlfg/v5YupDjCeMn
         91CZuLrsLZMhPoIgBWrrW1Zzz4qzWU0P5XhO+9uR/9mYkICLqGqQ34shzPnseAZ4akZF
         1qerUnpjyvbmm4Y8LrXJV5PXUpmLp2X0slPhrVKm3Yaua/GcHuTccsExM+VRdKb+ZBne
         tAaDfzlw/NjU8s97+hI05PJ7FU2id/SungVf2z1BbcQcjMbUNkEXYjwiPTD5JOmnl5ZQ
         8rJz/j2v98Tcs9aKXpFzb1IZ9D8BezVzfzPVerddASGVuEf7pXrUSSff6TpjQVFgfrUg
         JiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EukjDy9c7SvftzNriC6LZ02QMk88D9KgydjwJRQrqig=;
        b=CmK8jY/70zawP8srTyDi/NB68ydjKas4rI0U+9bMQpahTkbIP06pfYCwAB5D5wX5hd
         Hpber8Rgy4CZi2eO8gQ1CDEOxoHqyacquju6EpBgH6eiApAPflChnewteHfTBUe+yuY9
         gQs5NP3bS/hO61yb+nKRUrwnWDWSQ34UynbZbjdT6IK1gPt/WAhbFT6l8ok2TbJZ+3q6
         v9kwHYfjbzzgThbo1+U3vaLiR1MsHLLK4dFro9KVLtYPOx2RDyJYRHirlFNck4g4kO+R
         Lcbyg0Ej53pMm1S2kc3aOOTnmLz5+8cHwA+zhiVB5PWnzskaDVpA48OquDtuZBRwFqP5
         ih1Q==
X-Gm-Message-State: APjAAAXZPWN71NpV4iuW35lv/f9ZMKRZhsnbC3jkK8HURl+yJVm5tsRD
        pGLGVAKbc8mBuw8uQnLlgB4=
X-Google-Smtp-Source: APXvYqy3EArE5dPAQYyNOqSJyzi8hWDZqBgtFNFGLMJfRsR32FeOpNXTmpSgecySKiDErSiNMpEpRQ==
X-Received: by 2002:ac8:2273:: with SMTP id p48mr7374930qtp.7.1551906780373;
        Wed, 06 Mar 2019 13:13:00 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id o2sm1817938qtf.46.2019.03.06.13.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:12:59 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A402C4039C; Wed,  6 Mar 2019 18:12:56 -0300 (-03)
Date:   Wed, 6 Mar 2019 18:12:56 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/7] perf script python: add Python3 support to
 intel-pt-events.py
Message-ID: <20190306211256.GQ30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-6-tonyj@suse.de>
 <6fe06c75-5f98-4829-e139-af2bfcda24f3@intel.com>
 <dfa719d4-0d9e-ad08-536f-17b3da116b19@suse.de>
 <18913237-75f2-731b-940d-1fccc43d1b4a@suse.de>
 <fd26acf9-0c0f-717f-9664-a3c33043ce19@suse.de>
 <d3920c9a-3990-6111-ca4f-58d96a929bf4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3920c9a-3990-6111-ca4f-58d96a929bf4@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 06, 2019 at 11:28:35AM +0200, Adrian Hunter escreveu:
> On 5/03/19 6:19 PM, Tony Jones wrote:
> > On 3/5/19 8:10 AM, Tony Jones wrote:
> > 
> >>
> >> Sure enough, I managed to attach the wrong patch. Sorry. I'll attach revised (v3) 
> >> to this thread as the change is trivial.
> > 
> > From: Tony Jones <tonyj@suse.de>
> > Date: Tue, 05 Mar 2019 08:31:30 -0800
> > Subject: [PATCH v3] perf script python: add Python3 support to intel-pt-events.py
> > 
> > Support both Python2 and Python3 in the intel-pt-events.py script
> > 
> > There may be differences in the ordering of output lines due to
> > differences in dictionary ordering etc.  However the format within lines
> > should be unchanged.
> > 
> > The use of 'from __future__' implies the minimum supported Python2 version
> > is now v2.6
> > 
> > Signed-off-by: Tony Jones <tonyj@suse.de>
> > Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.
