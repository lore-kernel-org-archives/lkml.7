Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B8C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F92067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Cc+rnM3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbfG2Ptz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:49:55 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36536 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbfG2Pty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:49:54 -0400
Received: by mail-vs1-f67.google.com with SMTP id y16so41073804vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uUW0YKHPLieEQydyNjaqE+DPJSP/Cf4fqcZtPwBzjUQ=;
        b=Cc+rnM3wvWjLyuINuMWXDGs5fxT5e9t10JNduKKSfTicMo308IATLLWRf1HbfpWVFJ
         b9HvoMhkEEadSy05edUEx8sn1mVyofmiYp6O2xYQvx9A1WtU4SuHaPssop3lf5ncDbCt
         yG5gMY4JLtex+4bR+Q44glXssu1lBsGRrlcGVKY1Zanm/FcxXPu9Lpcm8BrKG2Kqswp+
         rb3AJRXbn4R0hDAXhtZXs3XIx2+JoGwvRFnm4k9C4FTS9vMmF8Ya9luCi/wweOUwz+Vp
         ouAIcGKMhFgKox4L1g3oYilw3A/fOpStl9pHs6Z5h8qQlenPlAGWPeZVHxefOnX7b/y2
         zufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uUW0YKHPLieEQydyNjaqE+DPJSP/Cf4fqcZtPwBzjUQ=;
        b=ojFTR1eAoQ8nMNBUUWjrC1SJj8EjcT73B4Hj+xxSWTyb1b2W3IHCGaZXBhXQbXkU0y
         XYilIm/LzNfbd96wkeIAm6qzOVV83EfoD0DN62bSHNNxCbakHDWZc63ChkPD31YEEzHx
         E3gdl53GH8NBS/+/cmH/CjElI3Hn6M5vpIqur/b52SoJP3tLxUCyWnhAcS1uRaDEvT/V
         2axtMCz9VWnyXMNB1XGCcypLd56NFvScm/tN0RkY4aJGlT/VBsSXeFTyIIhJx5gFmL2D
         RwuzNOqqHr3IrPQ7H/p4tXUFBCeifswql7o7lxmqogNQyDJSphU5afcnYW/kSKxjWtIC
         RqmA==
X-Gm-Message-State: APjAAAVo5aZDSGt+Euwca15RRS47wBArMefLa8jJ6DpxsdSXCLbDQKF1
        DURIoefCfEBjVVBPdPqlYuk=
X-Google-Smtp-Source: APXvYqzvvmRlC370jmHcQF5fxfCKQPBjEkd1dfVOREKA/n9iD4FSeCbNS9niC5SCPNU2sBDZeyzhIA==
X-Received: by 2002:a67:7087:: with SMTP id l129mr68222271vsc.206.1564415393680;
        Mon, 29 Jul 2019 08:49:53 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id q15sm25893828vka.44.2019.07.29.08.49.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:49:53 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:49:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190729154952.GC21958@cmpxchg.org>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156431697805.3170.6377599347542228221.stgit@buzz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 03:29:38PM +0300, Konstantin Khlebnikov wrote:
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -847,8 +847,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  			ret = -ERESTARTSYS;
>  			goto out;
>  		}
> -		cond_resched();
>  
> +		/* Reclaim memory over high limit before stocking too much */
> +		mem_cgroup_handle_over_high(true);

I'd rather this remained part of the try_charge() call. The code
comment in try_charge says this:

	 * We can perform reclaim here if __GFP_RECLAIM but let's
	 * always punt for simplicity and so that GFP_KERNEL can
	 * consistently be used during reclaim.

The simplicity argument doesn't hold true anymore once we have to add
manual calls into allocation sites. We should instead fix try_charge()
to do synchronous reclaim for __GFP_RECLAIM and only punt to userspace
return when actually needed.
