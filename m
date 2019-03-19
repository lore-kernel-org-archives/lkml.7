Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6124CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C70B20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke5ruura"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCSTdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:33:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39565 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSTdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:33:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so23588558qte.6;
        Tue, 19 Mar 2019 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VDy6gkd9L4loaZEot7GoaFR+pmnyWSvVlrzb6EJpcVQ=;
        b=ke5ruura3de485lapj5+CBOjLmjwsS0gp/snVbxt0cNVfeh1FHoBdH/lyD2gsf8CHQ
         uHmrPvUN6SDGzkPdB6P1u92ZgSR6a+69TfNd9i0cWqchW3iJLIht8jHJDj+H+CBnppjx
         A0bVdo3RIbatBNtcoPmvz4MLccaE6lbeFdNThY/5vSigLWs+st8ETcRDJqBj141jRXEW
         qAqumwbQKwXSIIvSM1HTPYEkEyCFHtbDk+nQ3pPsne5jBIPm4TbcjVGnZPy0bkyRFpdB
         kUBU007YbutmvjRkgnuujwR3ZqS01dRF0/wZdBhlJLqPIg4u0QvOD4yJTVUZ4WAef4YM
         Q0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VDy6gkd9L4loaZEot7GoaFR+pmnyWSvVlrzb6EJpcVQ=;
        b=pk7srKgcBa+HnREs7t2rknn1m/z7bwJnUyQKkDourXRkhweh87f5BLmjSY8gWAmDKQ
         uw9aFY/Jwjht5wRUselmxOq5Q+9XrshsTqJyG8sA1R2AIIpp7JQiIco5Rct37otCm0CD
         LlQoysOtsc+KadD6sJQGkDnlbwk8UNhUME8v/Fo0c51mz4LMNIylUDgbIImbRetesguQ
         LH13/2vTOYoDZhPWKYuiOEIkgZ8VItviFGg1Gk731IaCjLI5sK7gtJqiKHlJTjjwOBd+
         HK/sJUNldUDFdwm/u/zToTT7tY/OiByjXEZgvMdsdXSl5PivSy0lP/ZPjm5kSKyUpHWM
         o4eQ==
X-Gm-Message-State: APjAAAUuqp43yTq47ePv0eHMC/mjp7YqF6K5sqe4E/ToeUfAQ6/j8sm6
        RQRphrYhNYwPtzSDwDOKff3ZrLJO
X-Google-Smtp-Source: APXvYqxZkzarALvolyrbLHxywFHoLE0BQ8hBgKM8X6uSpAeIbN+qfxDnb5qk46o2lmjJUqVU1WM58g==
X-Received: by 2002:ac8:1be6:: with SMTP id m35mr3456897qtk.258.1553024030521;
        Tue, 19 Mar 2019 12:33:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id k33sm8510651qte.8.2019.03.19.12.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 12:33:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 528FC4039C; Tue, 19 Mar 2019 16:33:46 -0300 (-03)
Date:   Tue, 19 Mar 2019 16:33:46 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] perf, tools, stat: Avoid memory overrun with -r
Message-ID: <20190319193346.GN3029@kernel.org>
References: <20190314225002.30108-1-andi@firstfloor.org>
 <20190314225002.30108-2-andi@firstfloor.org>
 <20190319191452.GM3029@kernel.org>
 <20190319192023.GX24002@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319192023.GX24002@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 12:20:23PM -0700, Andi Kleen escreveu:
> > mmap size 8192B
> > perf: util/evlist.c:533: perf_evlist__id_add: Assertion `evsel->ids < evsel->sample_id->max_x * evsel->sample_id->max_y' failed.
> 
> I suspect this is a latent bug just caught by my assert.
> 
> So it was already broken.
> 
> You could of course remove the assert, but it would merely
> hide it.

I'm removing it just for the moment, I'll definetely revisit this.

- Arnaldo
