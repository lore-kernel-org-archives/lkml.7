Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DEC2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBtD80Ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfCKU65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:58:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34387 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:58:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id x20so233001qto.1;
        Mon, 11 Mar 2019 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9an/t+t64HgvbEoe1ugAOOfJWBGKYBAyfg2mCKmAGGQ=;
        b=EBtD80FtPlDEqapJYPQw8e+GyJ6FaaQI237QY06B7mfCcBS8HryJS9mNEJ7Qbc+SDr
         Wng6NXEdwr51p1XmTmqcvvsMef2qGbP77W2JWpFSg7hX87IQldT7NOfqhltYZbnxxm/q
         rV/k26AMEyC0IbDPwSmLLRfZbYP4MOpg2c57DlYIvBYgEVPXjz2JfIMao3jxrzoUb9XM
         HiPTxNsOL8rI2YEcW3I8JgbGMrcbInlio7Vx9P76YsVRw6owXK9NsFuY84o2omrQ7CP3
         6D9UtzLlW5mS9WOzZIeEy/xJ5/5r0dBZsYSCUm7VV1b/C+xCCMJxgZuhNIBxrBlv5kao
         b6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9an/t+t64HgvbEoe1ugAOOfJWBGKYBAyfg2mCKmAGGQ=;
        b=NjGSL+H71W6cqw+09g1gTRNe5ei2ebp2uGxsTL+GUTyCKClWxagHnfL/IBt0VnHGk5
         kRJiE5Pd1+AnQ7PQ3jyBs1NBN38odjsNzOQ+cbx/z0EFAkxZU2QPYX/ePEjskuLg6IRL
         X+bDPJhPi3SsHlb1rbh4SUDBCC6MI0kz7n/fdqpjT6rsChXo2qLkCVSLL2aCDjlUgTlT
         pL3M44Af7sSoCS3SblFgxbkqNdh/IqQ5ylsPngdgKvO7lvC04au9iLshfgFqrCKDBjpf
         MnHkHO8uJMv7hntFpKBjwggEugitiYEgC0cYzjcVgsocFE7OEKzOSBAfvwbR3YF3X73G
         G/Gw==
X-Gm-Message-State: APjAAAVY4eCWy/Mkv7Kf+qHMJVBAkkuGBHVCIqq91FdUkjhJYLTdrlse
        dM+mJT10oPzWLcFIpTw7CFs=
X-Google-Smtp-Source: APXvYqwOdW/VuUxJ0783GmIITQ6C+UwYrD3Cfyfc7O+7RG3twiqHs17yYvBZ6NRhthejsLGjAAxjBw==
X-Received: by 2002:ac8:540f:: with SMTP id b15mr4828377qtq.209.1552337936001;
        Mon, 11 Mar 2019 13:58:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id t27sm31343qtb.60.2019.03.11.13.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 13:58:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD6D44039C; Mon, 11 Mar 2019 17:58:52 -0300 (-03)
Date:   Mon, 11 Mar 2019 17:58:52 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/10] perf, tools, report: Print better message for
 JITed code
Message-ID: <20190311205852.GE10690@kernel.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-7-andi@firstfloor.org>
 <20190311203302.GB10690@kernel.org>
 <20190311204856.GD29294@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311204856.GD29294@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 01:48:56PM -0700, Andi Kleen escreveu:
> On Mon, Mar 11, 2019 at 05:33:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Mar 11, 2019 at 01:24:42PM -0700, Andi Kleen escreveu:
> > > +		if (!strncmp(map->dso->name, "/tmp/perf-", 10)) {
> > > +			static bool warned;
> > > +			if (!warned) {
> > > +				pr_err("Cannot find executable, JITed code present? May need agent.\n");
> > > +				warned = true;
> > > +			}
 
> > Please use WARN_ON_ONCE(), we have it in tools/include/asm/bug.h, just
> > like the kernel.

> But that prints "assertation failed". This is not a perf bug, but can happen
> in normal operation.

Sorry, we also have WARN_ONCE() and that one doesn't have any extra
message printed, only what you pass to it, right?

- Arnaldo
