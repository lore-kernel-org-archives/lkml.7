Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F7BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADCC20835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4CjIfoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCRS1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:27:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45898 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCRS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:27:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so19107210qtv.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GW0ZMKC8zqjJdPhdkhjNl+f2wQQIzgohT6b/X6Tc0N0=;
        b=U4CjIfoByT2cNyghQ3Z3TXRcZTH4hcG95KT4xt6fW8EHEg7fuTwS8+mPHPX/GURdqY
         37jf87RYZiqn6+tpF9cAoALut9iPAkgsEYUC7PyooWdL418hy87kVP73UyRo1DOcBq7z
         DAxtxN/g98vqTpT4RBgVfswhFvLZxSeKio0hAq3zIpRQKfiDhfoXJKVy00abCjJOxmDK
         AFLyiMy0ijjagFDU2yfy6ZXJ5RiQkRRLwPGOAFVcVepkrMLEXkqOMnvCPxejxOfuQP+H
         k3noihA1qShBgULuRdz0lBsNrcH1eG2L3yzJgBjxSPRPYEV4BRNwzvN2CjcwXhPHrAU5
         u2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GW0ZMKC8zqjJdPhdkhjNl+f2wQQIzgohT6b/X6Tc0N0=;
        b=EI4X1834+XjGhfZuMjyZzaUA18fNOz2lo//8SwU4Q7R8SEaRs318kBV2/nRaMY26s5
         hRLefARtvs4wE3j8gVUuBnk8ZUhFOHT2SypKJXmz2YK2JpLgpUt9IZ/SLqiuP0ZSeGf0
         rFdZx4Sg1DfjP3hIGYAIJqFViVGp7O9r/wfVHzl93Vb92tbl0kvs2FvDSmeMY8KhiA0v
         sGMwabBxY67hC+WnYhYVT6VuZf6vs8y+ckKLRSeKZ8LdUG6kQ/Q4nmsNxJPyyRIXelud
         jk1PBDKmW6jC+7CtoYfRrkIA9rHy+vr4FrQfkiQwM9fEH9050iNz2X6nw2jh16l1Y7pS
         tyZg==
X-Gm-Message-State: APjAAAVJbqT8MeqVt3cnSvxQ0wKvrrVQoyW9FD5YFLn26EsDQZphcqvO
        T5mwUYvOYVoyawUIj3mLRFo=
X-Google-Smtp-Source: APXvYqyDwiqlLVzVkNaYJRyAJC8R3H3emCi5XS8zxrFjkbtxtBdB6THl9Qjdd4SKMwKMwhcwc26r0A==
X-Received: by 2002:ac8:325c:: with SMTP id y28mr9500794qta.40.1552933619201;
        Mon, 18 Mar 2019 11:26:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:1b1:210a:504f:5027:31fa:e70e:3668])
        by smtp.gmail.com with ESMTPSA id 91sm5449711qtf.62.2019.03.18.11.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 11:26:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8898F4039C; Mon, 18 Mar 2019 15:26:55 -0300 (-03)
Date:   Mon, 18 Mar 2019 15:26:55 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        peterz@infradead.org, mpe@ellerman.id.au,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        namhyung@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH]perf:Remove P8 HW events which are not supported
Message-ID: <20190318182655.GB3967@kernel.org>
References: <154953186583.11022.14819560028300370163.stgit@localhost.localdomain>
 <d185d075-8589-5ec0-f3d7-4d5c79d12aed@linux.ibm.com>
 <20190318181430.GA3967@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318181430.GA3967@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 18, 2019 at 03:14:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Feb 26, 2019 at 09:25:40AM +0530, Ravi Bangoria escreveu:
> > 
> > 
> > On 2/7/19 3:09 PM, Mamatha Inamdar wrote:
> > > This patch is to remove following hardware events 
> > > from JSON file which are not supported on POWER8
> > > 
> > 
> > Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> I'm applying but next time please add a Fixes: tag for the cset where
> those events that shouldn't have been, this way the stable@ guys can get
> this fix, also, something like "According to documentation
> http://somewhere.ibm.com/DATA-sheet, etc
> 
> I'm trying to do the Fixes part.

I added this:

Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: 2a81fa3bb5ed ("perf vendor events: Add power8 PMU events")

- Arnaldo
