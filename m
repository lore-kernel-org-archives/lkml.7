Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB3CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4509F206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574877235;
	bh=JfWnuXNYCweVVFZN9RYE263ssw2BwVLwUk9wjbDP96Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zq1hqdMW7hqj3Q2hS5XeFjxAGjKSfwj92gPkvCTRIsAGCt0+vnPO70wCpbjtxNEG9
	 PrBW6VnGqur68gOLYAl8cmmPCou5uftQYBbMaIpksktlkuJydsUBpw6KOIIQdrWhhi
	 oAmz1hn0kqYDARQ5/T6prZpwkxISYTpPVfQLdlMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0Rxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:53:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40059 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfK0Rxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:53:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id a137so18480074qkc.7;
        Wed, 27 Nov 2019 09:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mvcvqAyxnSZryj2Pg3WEqsLIQ5VR9B7EJrbepjuqado=;
        b=bmz680+k1+q1KN+2jAAYJrY2Z0axaXAwr4PHnqhEhtEQtW9x1yjI9wAepxZqXefIaW
         AHQ3Jh1TlsWYOf3BuCI4iaDl0mIOI28Mx66c+xGlP9yHiIjNC/xzmy+UhE3n71I8CJvJ
         kGyZDAxoXgDrFtoVrnN5+3YKclRPPYWitXNzMKmDW5J7kjA4nIPXaDVSvkXT2CPvxYeF
         Tvkzh/j5XXtbuQUABP4AH4z99mrLDd1MOpIUTOBSkQgfFfO643mtzVwP5E5TLezkiBh3
         aI27zxJH599psJnmeyVgcfsuMmZqEGM/p5238PHnKnb2GcKPc2kOadmgKuth4Mu6ZDlh
         UAFg==
X-Gm-Message-State: APjAAAXzi3J9pC2RdmJYcs98xriax3MlFBAjQ7PmR1oNsBh/WqIMnafR
        8GFFpaCVicbbvoByuNLnt4hOWogAUryAfg==
X-Google-Smtp-Source: APXvYqx1ydnTAqF+INfT6B21G3Q/vw6SwwyLIWPUXlaPvZVcicUQJpS82K31+x9H8FIqsZUPgreTGw==
X-Received: by 2002:a37:a947:: with SMTP id s68mr5823051qke.168.1574877232909;
        Wed, 27 Nov 2019 09:53:52 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::3:5762])
        by smtp.gmail.com with ESMTPSA id l186sm7208107qkc.58.2019.11.27.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:53:52 -0800 (PST)
Date:   Wed, 27 Nov 2019 12:53:50 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 03:55:19PM +0000, Christopher Lameter wrote:
> On Tue, 26 Nov 2019, Luc Van Oostenryck wrote:
> 
> > So, fix the declaration of the 'pcp' variable to its correct type:
> > the plain (non-percpu) pointer corresponding to its address.
> > Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
> > raw_cpu_generic_cmpxchg_double().
> 
> Acked-by: Christoph Lameter <cl@linux.com>
> 
> Maybe a better fix is to come up with a typeof_strip_percu() or so
> macro for all the places where this needs to be done?

I like the idea of typeof_strip_percpu(). Luc do you mind spinning v2
with a macro for this instead?

Thanks,
Dennis
