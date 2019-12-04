Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEECF20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFe7mD/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfLDNtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:49:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46651 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfLDNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:49:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id f5so7103935qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/0qggl8Qfx1sGOKIUuMhcgVnjQ03MmdH56rEv45DUUE=;
        b=fFe7mD/us4cmdd4Er5X1vBQPwjlVgHncxM5CfRBl3XdEFCTxMcngltDvL3rWCeanDR
         SduuujY+88DaboY+qc8rv9xbN/13Mw3anhWGcYSNspba4H3zpU08gGanRcl2Xs2HbIMr
         SgdeA/fHJLXN5cAgnyacOu5xLeHUaSw2MgD6VxAxRz35fAGvpgBIOS0TSSZCHlL0WqCX
         96JbN9FqNzK3H5tcLI2u2tkOi/EGeLyJoJWGEglOlvQJ99/9cFaDzwe9OTFMcOmlyy68
         4bgdxUhsbFNH0gjCOAJTUCFxwraq5t3Esn6l5QZ7luRyC5LWrDxoTjyRiRslT1ZcqpjE
         wNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0qggl8Qfx1sGOKIUuMhcgVnjQ03MmdH56rEv45DUUE=;
        b=q8ZzshmlAq22LC1Ul4ADC10PXIj67PQdsAbmNUyieoGzzjLjui6JdVnuVjsn4j11Uy
         Fw2A1xj/Te7Q4v6xiTa97MVcApC+MG6Xdldy+ObkWjmhQeraOiqGFC3AM/tULAQBTWHH
         PH5JXgxPlvW0g4MbGF/V3yAb9loQ93+xIH8RQiDACu2WmjCcTGq8vP6sOF9aRozG9HW0
         83h4KlPs8S2WTD3oIVwALCS77A1YggFWUV1GuswHLver2yd/cS20lD7tOJQGI8e9RKGM
         sSkCXgEqHHTkgHdIvp6lWT77RibdH5fbJS1KuCb0weDvhVxm20RF9jlGMS/3hnx07sS6
         NzGg==
X-Gm-Message-State: APjAAAVqbC1Y6UKaROkvSm62AHB8E6MsEHXV3sGJZ6B5Eb1sJfeYAaeS
        +ET82Wja3N5+k6FB2uT0hrE=
X-Google-Smtp-Source: APXvYqwdF5S/ICn+cD04TCjhxy71OxJbQxjKjxAz99DShuaQt3+1R9erQ7VXHHG2bR6dZKx6pBv6PA==
X-Received: by 2002:a37:b602:: with SMTP id g2mr3026172qkf.174.1575467354488;
        Wed, 04 Dec 2019 05:49:14 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id s27sm2245490qkm.97.2019.12.04.05.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 05:49:13 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3FDF74121E; Wed,  4 Dec 2019 10:49:11 -0300 (-03)
Date:   Wed, 4 Dec 2019 10:49:11 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] perf mmap: declare type for cpu mask of arbitrary
 length
Message-ID: <20191204134911.GB31283@kernel.org>
References: <d1aead99-474a-46d3-36be-36dbb8e5581b@linux.intel.com>
 <0fd2454f-477f-d15a-f4ee-79bcbd2585ff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd2454f-477f-d15a-f4ee-79bcbd2585ff@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 03, 2019 at 02:44:18PM +0300, Alexey Budankov escreveu:
> 
> Declare a dedicated struct map_cpu_mask type for cpu masks of
> arbitrary length. Mask is available thru bits pointer and the
> mask length is kept in nbits field. MMAP_CPU_MASK_BYTES() macro
> returns mask storage size in bytes. mmap_cpu_mask__scnprintf()
> function can be used to log text representation of the mask.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/mmap.c | 12 ++++++++++++
>  tools/perf/util/mmap.h | 11 +++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 063d1b93c53d..43c12b4a3e17 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -23,6 +23,18 @@
>  #include "mmap.h"
>  #include "../perf.h"
>  #include <internal/lib.h> /* page_size */
> +#include <linux/bitmap.h>
> +
> +#define MASK_SIZE 1023
> +void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
> +{
> +	char buf[MASK_SIZE + 1];
> +	size_t len;
> +
> +	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
> +	buf[len] = '\0';
> +	pr_debug("%p: %s mask[%ld]: %s\n", mask, tag, mask->nbits, buf);
> +}

Above should also be %zd, fixed.

- Arnaldo
