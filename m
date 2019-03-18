Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE33C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD12720857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCRJVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:21:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfCRJVU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:21:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30A7A3082AED;
        Mon, 18 Mar 2019 09:21:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3D94469281;
        Mon, 18 Mar 2019 09:21:18 +0000 (UTC)
Date:   Mon, 18 Mar 2019 10:21:17 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/4] perf: Add a 'percore' event qualifier
Message-ID: <20190318092117.GA25277@krava>
References: <1552754068-10325-1-git-send-email-yao.jin@linux.intel.com>
 <1552754068-10325-2-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552754068-10325-2-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 18 Mar 2019 09:21:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 12:34:25AM +0800, Jin Yao wrote:

SNIP

>  static bool config_term_shrinked;
> @@ -950,6 +951,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
>  	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>  	case PARSE_EVENTS__TERM_TYPE_NAME:
>  	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> +	case PARSE_EVENTS__TERM_TYPE_PERCORE:
>  		return true;
>  	default:
>  		if (!err)
> @@ -1041,6 +1043,14 @@ do {									   \
>  	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
>  		CHECK_TYPE_VAL(NUM);
>  		break;
> +	case PARSE_EVENTS__TERM_TYPE_PERCORE:
> +		CHECK_TYPE_VAL(NUM);
> +		if ((unsigned int)term->val.num > 1) {
> +			err->str = strdup("expected 0 or 1");
> +			err->idx = term->err_val;
> +			return -EINVAL;
> +		}
> +		break;
>  	default:
>  		err->str = strdup("unknown term");
>  		err->idx = term->err_term;
> @@ -1179,6 +1189,10 @@ do {								\
>  		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>  			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
>  			break;
> +		case PARSE_EVENTS__TERM_TYPE_PERCORE:
> +			ADD_CONFIG_TERM(PERCORE, percore,
> +					term->val.num ? 1 : 0);

					term->val.num ? true : false

> +			break;
>  		default:
>  			break;
>  		}
> @@ -1233,6 +1247,18 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  			 get_config_name(head_config), &config_terms);
>  }
>  
> +static bool config_term_percore(struct list_head *config_terms)
> +{
> +	struct perf_evsel_config_term *term;
> +
> +	list_for_each_entry(term, config_terms, list) {
> +		if (term->type == PERF_EVSEL__CONFIG_TERM_PERCORE)
> +			return term->val.percore ? true : false;

term->val.percore is bool right? so just simple
	return term->val.percore;
	
should be enough.. together with above change

jirka
