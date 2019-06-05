Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C528EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB2C206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfFELos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfFELoq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:44:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23F55A3B6C;
        Wed,  5 Jun 2019 11:44:46 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 339943796;
        Wed,  5 Jun 2019 11:44:43 +0000 (UTC)
Date:   Wed, 5 Jun 2019 13:44:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 6/7] perf diff: Print the basic block cycles diff
Message-ID: <20190605114442.GE5868@krava>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-7-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559572577-25436-7-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 05 Jun 2019 11:44:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:36:16PM +0800, Jin Yao wrote:

SNIP

> -				break;
>  			return setup_compute_opt(option);
>  		}
>  
> @@ -949,6 +953,14 @@ hist_entry__cmp_wdiff(struct perf_hpp_fmt *fmt,
>  }
>  
>  static int64_t
> +hist_entry__cmp_cycles(struct perf_hpp_fmt *fmt __maybe_unused,
> +		       struct hist_entry *left __maybe_unused,
> +		       struct hist_entry *right __maybe_unused)
> +{
> +	return 0;
> +}

we have hist_entry__cmp_nop for that

SNIP

>  	default:
>  		BUG_ON(1);
>  	}
> @@ -1407,6 +1452,12 @@ static int hpp__color_wdiff(struct perf_hpp_fmt *fmt,
>  	return __hpp__color_compare(fmt, hpp, he, COMPUTE_WEIGHTED_DIFF);
>  }
>  
> +static int hpp__color_cycles(struct perf_hpp_fmt *fmt,
> +			     struct perf_hpp *hpp, struct hist_entry *he)
> +{
> +	return __hpp__color_compare(fmt, hpp, he, COMPUTE_CYCLES);
> +}
> +
>  static void
>  hpp__entry_unpair(struct hist_entry *he, int idx, char *buf, size_t size)
>  {
> @@ -1608,6 +1659,10 @@ static void data__hpp_register(struct data__file *d, int idx)
>  		fmt->color = hpp__color_delta;
>  		fmt->sort  = hist_entry__cmp_delta_abs;
>  		break;
> +	case PERF_HPP_DIFF__CYCLES:
> +		fmt->color = hpp__color_cycles;
> +		fmt->sort  = hist_entry__cmp_cycles;

also please explain in comment why it's nop

jirka
