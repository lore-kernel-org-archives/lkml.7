Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550EAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 23:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7C121848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 23:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaI6+Mhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfIRXJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 19:09:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38926 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfIRXJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 19:09:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so1854318qtb.6;
        Wed, 18 Sep 2019 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hz4UyQFQQPdm3I3IaFrX5aQr9o00Q9icQuCD8MrFVjc=;
        b=SaI6+MhpZo2TQOqMr4CX7OLC1FoRkBWepZh6Gn1mv2/9iaO6KbNUEUEvWzqaW0yISC
         Q+y3pmRLmVnL9KYjb7qr+4IvBJWyu1JDEZC0hQFtOMmsYQc4lLNrQOurFl825muj7Nfo
         2ry/OXNV0DDcZXROENefWf797DmXDL5o+WA7gTqx/KYS9umSgqfFY59IjghmNBQz9ZMY
         UjLDrwl1/1g6+s3kdbTAd48vaK+e5cI8p2F/XtyBaPsqIlK09L17bbfZslk3uFDFMt3e
         a1hDhMXVAWEW0ILUz/3PiMqZEgvc1v8zo8KeZmbDrFmOrp216d0DZ8N/OoM4fZDYSlQ+
         NC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hz4UyQFQQPdm3I3IaFrX5aQr9o00Q9icQuCD8MrFVjc=;
        b=ubmTDy5mA/kkp7i0MdShAPipZteN+t42goZKPcjroHytwtG4n1A1HonJW+wM06U+LH
         P1Y8NjGqcFSDsxoKvLBchpj0ni0D5W+SfLy+dXVfA124J+OvPctWnvNP+46BwVEGalZ3
         jvpwAQgFf5Bs37JEZxjLCyhn6+zjurIH5esn1o/cWKNhC87xkWEd2P967NTQwqrYfm2K
         M8tfTqXlW8FPXozExLyL8TiAlQkK16sHjZ5TTGC3hw5xbtecc6m2vLZQYX/RPstgO0Zd
         9AU7Cl4N+Kbf9KaZW4QjDi7O1Kxjv5dBHjKBy8W5YYEclT3Rgov2KTQLY9F1oK0+MKyE
         2lAw==
X-Gm-Message-State: APjAAAViaHPRXIsWTrTWJgvFs5IQBw+PYt6XeVTxjguQVV7Im+w5hgCI
        LibF6jOlv7nEcZRLJ0LSpQM=
X-Google-Smtp-Source: APXvYqxlR12/zWo/yohy/gyLi7jXYrHJxeMjCE2vyfmZJQOHn7BgcIHNE5FCp2rGwq6Sgma/DNHnLg==
X-Received: by 2002:aed:2da4:: with SMTP id i33mr268824qtd.320.1568848189820;
        Wed, 18 Sep 2019 16:09:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p11sm2996020qkj.124.2019.09.18.16.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 16:09:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 334CE40340; Wed, 18 Sep 2019 20:09:47 -0300 (-03)
Date:   Wed, 18 Sep 2019 20:09:47 -0300
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: fix spelling mistake "allos" -> "allocate"
Message-ID: <20190918230947.GD32051@kernel.org>
References: <20190911152148.17031-1-colin.king@canonical.com>
 <2b525705-317a-29a7-9fda-ca7896c8c038@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b525705-317a-29a7-9fda-ca7896c8c038@codeaurora.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 17, 2019 at 01:12:46PM +0530, Mukesh Ojha escreveu:
> 
> On 9/11/2019 8:51 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a spelling mistake in a TEST_ASSERT_VAL message. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks, applied.
 
> Thanks,
> Mukesh
> 
> > ---
> >   tools/perf/tests/event_update.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> > index cac4290e233a..7f0868a31a7f 100644
> > --- a/tools/perf/tests/event_update.c
> > +++ b/tools/perf/tests/event_update.c
> > @@ -92,7 +92,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
> >   	evsel = perf_evlist__first(evlist);
> > -	TEST_ASSERT_VAL("failed to allos ids",
> > +	TEST_ASSERT_VAL("failed to allocate ids",
> >   			!perf_evsel__alloc_id(evsel, 1, 1));
> >   	perf_evlist__id_add(evlist, evsel, 0, 0, 123);

-- 

- Arnaldo
