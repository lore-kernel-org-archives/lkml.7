Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78638C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560A62133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfHOMvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfHOMvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:51:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CEA23001596;
        Thu, 15 Aug 2019 12:51:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D1567D3E8;
        Thu, 15 Aug 2019 12:51:02 +0000 (UTC)
Date:   Thu, 15 Aug 2019 14:51:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, jeremie.galarneau@efficios.com,
        shawn@git.icu, tstoyanov@vmware.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        songliubraving@fb.com, ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH]Perf: Return error code for perf_session__new function on
 failure
Message-ID: <20190815125101.GE30356@krava>
References: <20190814092654.7781.81601.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814092654.7781.81601.stgit@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 12:51:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:02:18PM +0530, Mamatha Inamdar wrote:

SNIP

>  #ifdef HAVE_ZSTD_SUPPORT
>  static int perf_session__process_compressed_event(struct perf_session *session,
> @@ -181,6 +182,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
>  struct perf_session *perf_session__new(struct perf_data *data,
>  				       bool repipe, struct perf_tool *tool)
>  {
> +	int ret = 0;

hum, should ret be initialized to -ENOMEM instead?

jirka

>  	struct perf_session *session = zalloc(sizeof(*session));
>  
>  	if (!session)
> @@ -195,13 +197,15 @@ struct perf_session *perf_session__new(struct perf_data *data,
>  
>  	perf_env__init(&session->header.env);
>  	if (data) {
> -		if (perf_data__open(data))
> +		ret = perf_data__open(data);
> +		if (ret < 0)
>  			goto out_delete;
>  
>  		session->data = data;
>  
>  		if (perf_data__is_read(data)) {
> -			if (perf_session__open(session) < 0)
> +			ret = perf_session__open(session);
> +			if (ret < 0)
>  				goto out_delete;
>  
>  			/*
> @@ -216,7 +220,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
>  			perf_evlist__init_trace_event_sample_raw(session->evlist);
>  
>  			/* Open the directory data. */
> -			if (data->is_dir && perf_data__open_dir(data))
> +			ret = data->is_dir && perf_data__open_dir(data);
> +			if (ret)
>  				goto out_delete;
>  		}
>  	} else  {
> @@ -250,7 +255,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
>   out_delete:
>  	perf_session__delete(session);
>   out:
> -	return NULL;
> +	return ERR_PTR(ret);
>  }
>  
>  static void perf_session__delete_threads(struct perf_session *session)
> 
