Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BCBC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5357B2467B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPGyFyS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:24:22 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:39996 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfLFOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:24:22 -0500
Received: by mail-ua1-f51.google.com with SMTP id p18so2874812uar.7;
        Fri, 06 Dec 2019 06:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qhm3+t7GK6/m83rY6QgqOB/4TSxKB24Zwb1q3yg7yOo=;
        b=FPGyFyS9D1rSA0MGHxen4cLv8K1aEy+AE893sjd4G+mQetsKMLL5opqkK86xRmF0+x
         dap/1W7PwWScMu3NIrAFFkmJ+jPF50n+73G0hD7vQvKXxw1B27iyMyC+/NHpJbMscN0k
         WiIznwnveFGN6Q0ZeiOQKMiWJl+V2x0QJd6nM2/e3ln474dKzScWiylg/bDcpg6TnNHS
         Vbg5MbvkSiHGQV61REYiY2PbjeAgczcXLaYX1RmmJzv49TVkiygp7TX2d2Gxqxv0RbV1
         22EtUpIPNOINyfkKrM7/8tdTFcG81nkKdVB9BizhanCi7SLPPShHdY99Gg9QadynemJp
         zwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qhm3+t7GK6/m83rY6QgqOB/4TSxKB24Zwb1q3yg7yOo=;
        b=EV+BI5NV6Kq2yTmMRJAHnq/fx2R9Qz+11srYaRCWyZh8yucINOnNW5XIDu8rjqmApg
         yYsDOMQcEjQrIRNHIN5KthQnmEbUJTrbEzV7Vt7ihm5ePvy/acD+3rfTzeMh0TRZdIEz
         ozFKBficImFaOeglOnXQr+6dZrxlhPFT3tE81ObEonMP0KaTYpSCi50WEjBbcX8iYjzw
         SqqO75BLEnTjPnYCS+sIce6NqsQJZeQunD0c5YJHI3PRMEJdMxCKeG6tqsaxUu1u6Ey5
         4GZXX2yHq6TeySkGyDY0KI0VbLWBkPAfmF+5vSnIzwiXcemyQ0rnTXLfR/1wOBBKQKHx
         2bEg==
X-Gm-Message-State: APjAAAWz1VJYQUMKnYdUZM0pDql9lGGl03id2wNfzGAjATjf2uF6qhdS
        ljIbTCtmohE8lfDN9+FD7lc=
X-Google-Smtp-Source: APXvYqwlyfqXgSIlHKyZ4N54x16QtF4n7CIGpLbVbluGqvGMDyVPxiEYX4fBerm0pdPGKL9Bqy61lg==
X-Received: by 2002:ab0:7007:: with SMTP id k7mr12605664ual.14.1575642260748;
        Fri, 06 Dec 2019 06:24:20 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r199sm1140427vke.41.2019.12.06.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:24:20 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D230940352; Fri,  6 Dec 2019 11:24:17 -0300 (-03)
Date:   Fri, 6 Dec 2019 11:24:17 -0300
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Message-ID: <20191206142417.GB30698@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
 <20191206075701.GA25384@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191206075701.GA25384@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 06, 2019 at 08:57:01AM +0100, Ingo Molnar escreveu:
> Pulled, thanks a lot Arnaldo!
 
> JFYI, on my system the default perf/urgent build still has this noise 
> generated by util/parse-events.y and util/expr.y:
 
>   util/parse-events.y:1.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
>       1 | %pure-parser
>       | ^~~~~~~~~~~~
>   util/parse-events.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
>   util/expr.y:15.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
>      15 | %pure-parser
>       | ^~~~~~~~~~~~
>   util/expr.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]

I'll get to this, I've been postponing dealing with this nuisance as,
IIRC, this will make perf not build in systems with older bisons.

- Arnaldo

