Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C72DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC0E24679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0OXb6iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfLTMR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:17:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40155 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfLTMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:17:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id s21so1287087plr.7;
        Fri, 20 Dec 2019 04:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6WV/T6CpDhebP945cbfXE+MmOGoQMQ/88QhIuMiSFcg=;
        b=c0OXb6iZ79HWRkKlGD0qqeGNccVo4B5n6KO5almOyCp3OOi3+wkkXwZohfaqSv45su
         2pBUYe9ot3TP6VE0oH+rfwDsDQ+l5tEWG3CleaNz8SKGhSNUE2qu7QcgFdeB0nCLtlEx
         IlMjLYMq0CeEZyhep5aqPus31UsYRJES5zu/erisphniSGFWfP94yogsSJ2AeL6OVVez
         6+Dh1hbIVfEVA9Q8fHIrXg3mKquUcWgp+KfSY84VYG97B0Y+8Jm5MUlTUcBU2/QFXivh
         Sc2ElJgUKmRZlxiKb7xZtJstVB4LtmwHjGuqFUnh/wYW8G8DVLceJ8qreq5rgVDI+cty
         891A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6WV/T6CpDhebP945cbfXE+MmOGoQMQ/88QhIuMiSFcg=;
        b=N7Q0rGpWpw+Wg2CWVFSvXdd/IjTLbkaxzDA+mpehOdywZkNUMvsABPju3rercL/kb6
         ZsDRAtSNYh7uNda9s1hgLZ98PXI3rhfJwp2Jr1m8ZPQUE9doSznBX+wgB7B4wktcbrP/
         4d9vxx7VwPdMx2X9wRuAwtI2WyuKQAJ7bvVWMEKJM4GV3JeUQw0mGSK65sVQIm8Jze/V
         h4940Kb6toz6Uhm0jvaT649Tf2BTSWn0fwBxy4lNztKnP/9P5/EJSzR4vys4ZJd6lGu+
         LoafDk31snvZLkOt/dDUvIyp5+1RsigDT8E2PqlgSUR4Qr11C52N60WSDsoFhCm1RBkZ
         +SHQ==
X-Gm-Message-State: APjAAAXSGM7gCtRh1QFAGUL92iglg22E5q8HXD49x00nKaT5Zl3zODRr
        JkCjN8yJTkDUuAFDBt5mKwQ=
X-Google-Smtp-Source: APXvYqz/EVj3ToXk1wO3i1VkQUwjv2AoEJCSmXr8EqHlsWftQ/ner9u78glT5f8dGvFwkCyGOZcwvg==
X-Received: by 2002:a17:902:bd85:: with SMTP id q5mr14660399pls.17.1576844246000;
        Fri, 20 Dec 2019 04:17:26 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e16sm11053918pgk.77.2019.12.20.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 04:17:25 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CCB2B40CB9; Fri, 20 Dec 2019 09:17:23 -0300 (-03)
Date:   Fri, 20 Dec 2019 09:17:23 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 06/12] perf report/top: Add 'k' hotkey to zoom directly
 into the kernel map
Message-ID: <20191220121723.GC2032@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-7-acme@kernel.org>
 <CAM9d7ciL-Qnm5v3Tn1rsrNzW3mTWx5HY6W5XBU1MKnLQ7YBdkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciL-Qnm5v3Tn1rsrNzW3mTWx5HY6W5XBU1MKnLQ7YBdkw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 20, 2019 at 03:48:23PM +0900, Namhyung Kim escreveu:
> On Tue, Dec 17, 2019 at 11:49 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > As a convenience, equivalent to pressing Enter in a line with a kernel
> > symbol and then selecting "Zoom" into the kernel DSO.
 
> We already have 'd' key for 'zoom into current dso'.

Right, current DSO, 'k' is equivalent to:

1. Navigate to a kernel map entry
2. Press 'd'

And also to:

1. Navigate to a kernel map entry
2. Press ENTER
3. Navigate to "Zoom into Kernel DSO"
4. Press ENTER

One key versus 2 or four.

> Do you really want 'k' for kernel specially?

I thought kernel hackers would like the convenience, doing:

  perf top + k

To get the main kernel samples looks faster than:

  perf top -e cycles:k

And those are not even equivalent, as cycles:k will show everything in
ring 0, while 'perf top + k' will show just what is in the kernel _and_
in the main kernel map.

- Arnaldo
