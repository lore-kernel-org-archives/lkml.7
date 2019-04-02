Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3586C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FEB20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BdLifG04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbfDBOtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:49:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbfDBOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:49:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so17067167wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKpqAZk8ZPLTi+w4by/A8Sx+wgJCRI5IaCwsZ3rsIJ0=;
        b=BdLifG04va0ZcioS+cyiaj6h5/KXx1W/ZLC1O+Brt3fJ/cYFYnGCNkfWa/RDPYAXq8
         Ao9mB/JDrAEJMlpvz4hQJNG3Sgx7ggZC9ln7CtWmV+6EDDYY+N2RaO2jKioHd4DdEvl5
         wL/ENPXHSnnZAqB1jasENfnP5OtUDgXFgewK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKpqAZk8ZPLTi+w4by/A8Sx+wgJCRI5IaCwsZ3rsIJ0=;
        b=mDgHctURUtyNVu87zsq1qPO39yWX2iZ6Hfd2vFjfdjO+Xt4iZFNQ0C73qBi6zEf1Ob
         FbzgCjEI7qivkepT1DDOz4XJQ55ageD5rcIbRo0dG2F44oxbmk9fL19CeXlORHj3ylOM
         ww6WhrdJXraEvQvJzZrklC5WEPnbBVSg1ihdytZUcGdFxevIPeL8VZbUjeks28vgYiLm
         n5ikQMHhMoiIge7vpXmqfP8MMOvJK9GhXgRqM9eqKBOtcWv4Npe73GwGN84/L9+zCmA5
         AO44gRPGvuhbnFsDAkRIxq2/Q/kmXh6HdXXJBn4e5UFf++xD568z/Amchw5URqqGlu5g
         0nFg==
X-Gm-Message-State: APjAAAWMMJUg9DYV38k91IP1YnVyTTm4X58H6oaHyJsoIRR9fIGYwVHt
        u/Iu8eWXyxL78EC71it+ZgEwLQ==
X-Google-Smtp-Source: APXvYqzFG/gi2VTtm6uozMfLN1t0+Catgnql8boWnrGWwJ6AioTthn1cPup0HEPMaNbtcQt6WRghHw==
X-Received: by 2002:a5d:698b:: with SMTP id g11mr3728077wru.65.1554216559327;
        Tue, 02 Apr 2019 07:49:19 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id f11sm15267916wrm.30.2019.04.02.07.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 07:49:17 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:49:11 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: Re: [PATCH tip/core/rcu 08/21] tools/memory-model: Add support for
 synchronize_srcu_expedited()
Message-ID: <20190402144911.GA10044@andrea>
References: <20190326234114.GA23843@linux.ibm.com>
 <20190326234133.24962-8-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326234133.24962-8-paulmck@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 04:41:20PM -0700, Paul E. McKenney wrote:
> Given that synchronize_rcu_expedited() is supported, this commit adds
> support for synchronize_srcu_expedited().
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  tools/memory-model/linux-kernel.def | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index 0c3f0ef486f4..551eeaa389d4 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -51,6 +51,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
>  srcu_read_lock(X)  __srcu{srcu-lock}(X)
>  srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
>  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> +synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }

This and the other patches from the series do not apply to "tip/core/rcu"
(from the Subject), but this seems straightforward enough:

Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea


>  
>  // Atomic
>  atomic_read(X) READ_ONCE(*X)
> -- 
> 2.17.1
> 
