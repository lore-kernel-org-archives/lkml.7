Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A734EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF052147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfCSBIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:08:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:1075 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSBIG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:08:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 18:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="329815760"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.91]) ([10.239.196.91])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2019 18:08:04 -0700
Subject: Re: [PATCH v2 1/4] perf: Add a 'percore' event qualifier
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1552754068-10325-1-git-send-email-yao.jin@linux.intel.com>
 <1552754068-10325-2-git-send-email-yao.jin@linux.intel.com>
 <20190318092117.GA25277@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ae583ce9-097b-c0a7-b183-84c08f8647ca@linux.intel.com>
Date:   Tue, 19 Mar 2019 09:08:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190318092117.GA25277@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2019 5:21 PM, Jiri Olsa wrote:
> On Sun, Mar 17, 2019 at 12:34:25AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   static bool config_term_shrinked;
>> @@ -950,6 +951,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
>>   	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>>   	case PARSE_EVENTS__TERM_TYPE_NAME:
>>   	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>> +	case PARSE_EVENTS__TERM_TYPE_PERCORE:
>>   		return true;
>>   	default:
>>   		if (!err)
>> @@ -1041,6 +1043,14 @@ do {									   \
>>   	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
>>   		CHECK_TYPE_VAL(NUM);
>>   		break;
>> +	case PARSE_EVENTS__TERM_TYPE_PERCORE:
>> +		CHECK_TYPE_VAL(NUM);
>> +		if ((unsigned int)term->val.num > 1) {
>> +			err->str = strdup("expected 0 or 1");
>> +			err->idx = term->err_val;
>> +			return -EINVAL;
>> +		}
>> +		break;
>>   	default:
>>   		err->str = strdup("unknown term");
>>   		err->idx = term->err_term;
>> @@ -1179,6 +1189,10 @@ do {								\
>>   		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>>   			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
>>   			break;
>> +		case PARSE_EVENTS__TERM_TYPE_PERCORE:
>> +			ADD_CONFIG_TERM(PERCORE, percore,
>> +					term->val.num ? 1 : 0);
> 
> 					term->val.num ? true : false
> 
>> +			break;
>>   		default:
>>   			break;
>>   		}
>> @@ -1233,6 +1247,18 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>>   			 get_config_name(head_config), &config_terms);
>>   }
>>   
>> +static bool config_term_percore(struct list_head *config_terms)
>> +{
>> +	struct perf_evsel_config_term *term;
>> +
>> +	list_for_each_entry(term, config_terms, list) {
>> +		if (term->type == PERF_EVSEL__CONFIG_TERM_PERCORE)
>> +			return term->val.percore ? true : false;
> 
> term->val.percore is bool right? so just simple
> 	return term->val.percore;
> 	
> should be enough.. together with above change
> 
> jirka
> 

Thanks Jiri, I add this change in v3.

Thanks
Jin Yao

