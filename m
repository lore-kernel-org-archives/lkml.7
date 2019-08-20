Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5694EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D18239BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfHTIev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfHTIeu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:34:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DAA61FAA6C;
        Tue, 20 Aug 2019 08:34:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 65FBA39C8;
        Tue, 20 Aug 2019 08:34:48 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:34:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5] perf diff: Report noisy for cycles diff
Message-ID: <20190820083447.GA19265@krava>
References: <20190816021343.27160-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816021343.27160-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 20 Aug 2019 08:34:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:13:43AM +0800, Jin Yao wrote:

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
> @@ -1688,8 +1824,13 @@ static int ui_init(void)
>  		 *   PERF_HPP_DIFF__RATIO
>  		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
>  		 */
> -		data__hpp_register(d, i ? compute_2_hpp[compute] :
> -					  PERF_HPP_DIFF__BASELINE);
> +		if (cycles_hist && i && (compute == COMPUTE_CYCLES)) {
> +			data__hpp_register(d, PERF_HPP_DIFF__CYCLES);
> +			data__hpp_register(d, PERF_HPP_DIFF__CYCLES_HIST);
> +		} else {
> +			data__hpp_register(d, i ? compute_2_hpp[compute] :
> +						  PERF_HPP_DIFF__BASELINE);
> +		}


hum, why can't it be just like we treat other extra columns:

---
@@ -1687,6 +1823,7 @@ static int ui_init(void)
 		 *   PERF_HPP_DIFF__DELTA
 		 *   PERF_HPP_DIFF__RATIO
 		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
+		 *   PERF_HPP_DIFF__CYCLES
 		 */
 		data__hpp_register(d, i ? compute_2_hpp[compute] :
 					  PERF_HPP_DIFF__BASELINE);
@@ -1704,6 +1841,9 @@ static int ui_init(void)
 		if (show_period)
 			data__hpp_register(d, i ? PERF_HPP_DIFF__PERIOD :
 						  PERF_HPP_DIFF__PERIOD_BASELINE);
+
+		if (cycles_hist && i)
+			data__hpp_register(d, PERF_HPP_DIFF__CYCLES_HIST);


thanks,
jirka
