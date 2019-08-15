Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288EEC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051352084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfHONWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:22:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731306AbfHONWj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:22:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E90073003715;
        Thu, 15 Aug 2019 13:22:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0C69160F8C;
        Thu, 15 Aug 2019 13:22:36 +0000 (UTC)
Date:   Thu, 15 Aug 2019 15:22:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4] perf diff: Report noisy for cycles diff
Message-ID: <20190815132236.GH30356@krava>
References: <20190813073037.3420-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813073037.3420-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 15 Aug 2019 13:22:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 03:30:37PM +0800, Jin Yao wrote:

SNIP

>  static void
>  hpp__entry_unpair(struct hist_entry *he, int idx, char *buf, size_t size)
>  {
> @@ -1662,6 +1794,10 @@ static void data__hpp_register(struct data__file *d, int idx)
>  		fmt->color = hpp__color_cycles;
>  		fmt->sort  = hist_entry__cmp_nop;
>  		break;
> +	case PERF_HPP_DIFF__CYCLES_HIST:
> +		fmt->color = hpp__color_cycles_hist;
> +		fmt->sort  = hist_entry__cmp_nop;
> +		break;
>  	default:
>  		fmt->sort  = hist_entry__cmp_nop;
>  		break;
> @@ -1688,8 +1824,15 @@ static int ui_init(void)
>  		 *   PERF_HPP_DIFF__RATIO
>  		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
>  		 */
> -		data__hpp_register(d, i ? compute_2_hpp[compute] :
> -					  PERF_HPP_DIFF__BASELINE);
> +		if (cycles_hist && (compute == COMPUTE_CYCLES)) {
> +			data__hpp_register(d, i ? PERF_HPP_DIFF__CYCLES :
> +						  PERF_HPP_DIFF__BASELINE);
> +			data__hpp_register(d, i ? PERF_HPP_DIFF__CYCLES_HIST :
> +						  PERF_HPP_DIFF__BASELINE);
> +		} else {
> +			data__hpp_register(d, i ? compute_2_hpp[compute] :
> +						  PERF_HPP_DIFF__BASELINE);
> +		}

I tink that something like this might be less confusing instead of above:

                if (cycles_hist && i && (compute == COMPUTE_CYCLES)) 
                        data__hpp_register(d, PERF_HPP_DIFF__CYCLES);

other than that the patch looks ok to me

jirka
