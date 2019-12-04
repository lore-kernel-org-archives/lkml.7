Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B0CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883AC2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+9UpCGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfLDP07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:26:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44115 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfLDP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:26:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id b5so71947qtt.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VVB7sg/egRZkYeLhzCaU0db30HtolX/BM3CG9VJuGVY=;
        b=k+9UpCGGEYmbgjkH7hojSHHSO3igP57J3E4/yBECR20V9jP+K3Ifmz3yS4NsKFUzUo
         Y+B/CWw6VF4eL6StLD1/2oFIJbvrQdXD/h+Y8/aNt75KYSy3tv9tRAi9BKrSbTDhlDff
         wYYpmY6SDWJkYFdmfselgz26NUQeMue9jUFRsS3dAj8V820Im+TVRbAMPuEilYuSz/r7
         50Y38dwn5FBc0WLA/4PdaBCErvs3Gd80D1XDzLWOe2BvI1z0IWtNEEdAI419WFWNQY8F
         AvF2BBJfgsH0+akg9gqSFJzbklcCfJexprhiK+wNaoGAoBXHw2DiYcDlv+QFh74wZ1zo
         0A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VVB7sg/egRZkYeLhzCaU0db30HtolX/BM3CG9VJuGVY=;
        b=geT24e+y4fOVo4paRdqGB82l7j4d34K0z8lRLPN0PiM+WkbeIioygn8hH7kRINujMs
         e4TPD4GmKD718hsfdKpRafp5Fcf36I5bSwnheCgOGfdiGFrqfG2djDy2ces3+hn7xh8g
         eMCZ141twrX7T1DnZru5xgca6cPi0C6ac0bzRV/4MEmCTRt8+a3nAoYNMawEv03VOsK1
         rOSzSC7RsbKHxKkd/ISaGK+xeAqNmOGiE2zyKL81VdSEjHE3nwk2biv7eVI2QSOa4+gr
         f5Za7eg/7FPPwC1RaMxBu4ToNLeR2+FksPoQdHOgOa2mGbnWoE6X1eE2fjeP9Y6DTrr+
         6mLg==
X-Gm-Message-State: APjAAAUbP7uZLtPvQ+n/uUCk1WBZfyOEAZkukDwkkakDP2hdKceQMpZU
        XaWxnlJA+w7YK+7fVv8YFSo=
X-Google-Smtp-Source: APXvYqwpsoOQvohAeHjGYFFq+jLzt4Ya4N0UALmuu2AyKlo2GtH9rHQjhR1BklXHqODysr77atFPAQ==
X-Received: by 2002:aed:204d:: with SMTP id 71mr3266104qta.116.1575473218234;
        Wed, 04 Dec 2019 07:26:58 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e189sm3762219qkd.126.2019.12.04.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:26:57 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BAF94121E; Wed,  4 Dec 2019 12:26:54 -0300 (-03)
Date:   Wed, 4 Dec 2019 12:26:54 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, kan.liang@intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf hists: Replace pr_err with ui__error
Message-ID: <20191204152654.GC31283@kernel.org>
References: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
 <20191114132213.5419-2-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191114132213.5419-2-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 14, 2019 at 06:52:11PM +0530, Ravi Bangoria escreveu:
> pr_err() in tui mode does not print anyting on the screen and
> just quits. Replace such pr_err with ui__error.
> 
> Before:
>   $ ./perf report -s +
>   $
> 
> After:
>   $ ./perf report -s +
> 
>     ┌─Error:────────────────┐
>     │Invalid --sort key: `+'│
>     │                       │
>     │Press any key...       │
>     └───────────────────────┘

Cool, I've seen this before and should have investigated, even today it
happened... Thanks for fixing it, tested and applied.

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/util/sort.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 43d1d410854a..cba8f22e4ffb 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2696,12 +2696,12 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
>  			ret = sort_dimension__add(list, tok, evlist, level);
>  			if (ret == -EINVAL) {
>  				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
> -					pr_err("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
> +					ui__error("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
>  				else
> -					pr_err("Invalid --sort key: `%s'", tok);
> +					ui__error("Invalid --sort key: `%s'", tok);
>  				break;
>  			} else if (ret == -ESRCH) {
> -				pr_err("Unknown --sort key: `%s'", tok);
> +				ui__error("Unknown --sort key: `%s'", tok);
>  				break;
>  			}
>  		}
> @@ -2758,7 +2758,7 @@ static int setup_sort_order(struct evlist *evlist)
>  		return 0;
>  
>  	if (sort_order[1] == '\0') {
> -		pr_err("Invalid --sort key: `+'");
> +		ui__error("Invalid --sort key: `+'");
>  		return -EINVAL;
>  	}
>  
> @@ -3049,7 +3049,7 @@ static int __setup_output_field(void)
>  		strp++;
>  
>  	if (!strlen(strp)) {
> -		pr_err("Invalid --fields key: `+'");
> +		ui__error("Invalid --fields key: `+'");
>  		goto out;
>  	}
>  
> -- 
> 2.21.0

-- 

- Arnaldo
