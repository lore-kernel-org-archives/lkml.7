Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF791FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FF32067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfFKuR5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393748AbfJPOG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:06:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39043 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfJPOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:06:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so22837144qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OV8M1D/TxXy4oGUbP8BzEAmD46S3DBGLQJESy6/GXeU=;
        b=UfFKuR5LAMCyoEYi+f9+s+Mh5PZY6ghn7wl89N+4RRU60bGweIE0fFGJUrJDbDInX7
         RLki6pINLythhgJ7RrL9msTqr57E0K1LJatgrpJnNyctINvqYro+Ifo8KNgyH1RxP55o
         GdxTAQaif4QPMo88jswMry5AnC+bLur1ZhTriS2y+EVjvF64CsU/PH9kU3g/C3bb8JQZ
         WmJ45bVIwc6pfZB31LLYWaGyzrUhJToG6+mHYyHgUv9c24jHabd2TPv96KDS9XDIDCgK
         hnHpogDGRBq/6wRPNWbsv1LwNd+XeH3Y7qzakjy/b36eLMnImHnKaCg14LfPZY85bofw
         yKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OV8M1D/TxXy4oGUbP8BzEAmD46S3DBGLQJESy6/GXeU=;
        b=tFuCpd1LenKTx79s/C7ZrYBZzOYV+2Thyyf1i4zrkKucs1jIO1ODgUUo2NoDdfHdvU
         Numzatf7MIGvIIj2f4c0UjnBIh7TlXZ4XVV+Lbeex+QZmPWOGSBrTXwvgv2VX9O81TrW
         M2jgiulxKAk2hyxhr76YnAzpOOxa4cch7w3MQzwInNb+WqSXMQ3rEaq6x/QVd3nma2k2
         /4jfM8F8ufW8JPIr/WfX2IkpXGBISv9h2N0HNF1ySfT3hO6Tcx3r3W2AO6z9WC3oFoZB
         dAqqwH9LQYGCbXfNcigILf12ytmaTw/8+QMRzqwAh7n7gOIiYLDliBV8RVIviOaLUV9m
         BD8A==
X-Gm-Message-State: APjAAAVXSebqerKsw7dwAN27LYMofbXYEHDk99kijaRp9hxbval+yMwd
        Q5kO4GGz2HS4YRfEmdbY1lM=
X-Google-Smtp-Source: APXvYqypuwINeVW9ebGUzWJbX1NGuwaXHGsmPX40GxEza2MOqKgWyyluL6SGBIToXT/VzxBdeUjUZA==
X-Received: by 2002:a37:f90e:: with SMTP id l14mr40331357qkj.68.1571234814792;
        Wed, 16 Oct 2019 07:06:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p22sm11418505qkk.92.2019.10.16.07.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:06:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D4EAD4DD66; Wed, 16 Oct 2019 11:06:51 -0300 (-03)
Date:   Wed, 16 Oct 2019 11:06:51 -0300
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2] perf kmem: Fix memory leak in compact_gfp_flags()
Message-ID: <20191016140651.GF22835@kernel.org>
References: <7fd48f77-fbc4-b99f-60c1-ccc7d8d287e9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd48f77-fbc4-b99f-60c1-ccc7d8d287e9@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 16, 2019 at 09:26:50PM +0800, Yunfeng Ye escreveu:
> The memory @orig_flags is allocated by strdup(), it is freed on the
> normal path, but leak to free on the error path.
> 
> Fix this by adding free(orig_flags) on the error path.
> 
> Fixes: 0e11115644b3 ("perf kmem: Print gfp flags in human readable string")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> v1 -> v2:
>  - add "Fixes:" message

No need for that, I did it already, just next time look for when the
problem you fixed was introduced, that way the various bots out there
can pick this up for backports, i.e. your fix has a higher chance of
being beneficial to more systems.

- Arnaldo
 
>  tools/perf/builtin-kmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 1e61e353f579..9661671cc26e 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -691,6 +691,7 @@ static char *compact_gfp_flags(char *gfp_flags)
>  			new = realloc(new_flags, len + strlen(cpt) + 2);
>  			if (new == NULL) {
>  				free(new_flags);
> +				free(orig_flags);
>  				return NULL;
>  			}
> 
> -- 
> 2.7.4.3

-- 

- Arnaldo
