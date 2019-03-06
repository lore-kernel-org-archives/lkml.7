Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28278C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDFC20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1KN0SXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfCFVLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:11:41 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34105 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfCFVLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:11:40 -0500
Received: by mail-qt1-f173.google.com with SMTP id w4so14631613qtc.1;
        Wed, 06 Mar 2019 13:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ipNb2IqEk6/AAmcr6X8afZLtf3jT8dMQsJLGxIS4pa4=;
        b=Y1KN0SXXeBeaha9ZaYIT/pb5rGGGR6TS2wOMbwIYP3q0qLgZwl+VnAPRozOggLIogx
         cHTaffCYM6xrNZ0KqL+GThUtIKXJpfotc5Qd6mMQE/48CVNKkin5ND4yP7mMqwDbp2WS
         w3Lj5An4B7qoZOQpRFH+aPp0qg4QSYDPTKeSFJI31ddu/l7knVVzaMgMZWW3H13Bow9U
         jd1LVufh6Mh2N0ODT/hvtZ2730RrjE12sP5pitSydLpOPi+A3z5A4PbiMMAkdavGo5D0
         od2e6VGlsvFJOKzcXG2Gqay+jGJKMYB0Ehx6HgqxXt8DK8GiVVqyCz0u0xvq4PadbUQa
         +GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ipNb2IqEk6/AAmcr6X8afZLtf3jT8dMQsJLGxIS4pa4=;
        b=MM17X9WzbCsYrevpUitrNHvP6eM2zS3mnQY6jjtlBaN3PWkAnnD1/SC+YLgL3nBQAb
         5mkZab9PDggTmYV8I53TxhtdzK4t7vZoypmeUABX4Epwu/vBiYkGHGPrhAwtQ/MIvZol
         hWMXWMsOutzjliKBQJmuTnZ/H63/I690qHkiXeGUJ0EXPomxaZ8xht7Dt1W24qeLoLE+
         RL7NAU5rpMUVwoQC9m4tjq6XHF29s/DxjqS8RIY7ailzyMn+99GDiocvSjAHijxZsrMN
         zuxVPk4N5cGPRSBfV2rFpvJ7nwpN7dpXTdLJyw30r+6Cc+slcZhTlwrqZndESL3XUVf5
         xPzA==
X-Gm-Message-State: APjAAAX7YXX/KgSuV79sBokvYl01EiUqdjfsbEkCUReXqTJ7HN/unxLT
        ssWU0GJeByzgN7NviRRZ2BQ=
X-Google-Smtp-Source: APXvYqxBCIgshik5JSiWIv8y/qPKYlkbpC+s5+ymCVJsvt6p6Nz5FOx66tZgy1jo93NtbC/8NbF7eA==
X-Received: by 2002:ac8:2cd1:: with SMTP id 17mr7339431qtx.299.1551906699690;
        Wed, 06 Mar 2019 13:11:39 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id i33sm1788411qti.74.2019.03.06.13.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:11:39 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3BCA64039C; Wed,  6 Mar 2019 18:11:37 -0300 (-03)
Date:   Wed, 6 Mar 2019 18:11:37 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Tom Zanussi <tzanussi@gmail.com>
Subject: Re: [PATCH v2 3/7] perf script python: add Python3 support to
 check-perf-trace.py
Message-ID: <20190306211137.GO30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-4-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302011903.2416-4-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 01, 2019 at 05:18:59PM -0800, Tony Jones escreveu:
> Support both Python 2 and Python 3 in the check-perf-trace.py script.
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> The use of from __future__ implies the minimum supported version of
> Python2 is now v2.6

Thanks, applied
