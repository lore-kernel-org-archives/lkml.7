Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D91C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E762084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfHOMvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731645AbfHOMvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:51:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7E06C057EC6;
        Thu, 15 Aug 2019 12:51:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0557A5D6A9;
        Thu, 15 Aug 2019 12:51:16 +0000 (UTC)
Date:   Thu, 15 Aug 2019 14:51:16 +0200
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
Message-ID: <20190815125116.GG30356@krava>
References: <20190814092654.7781.81601.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190814092654.7781.81601.stgit@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 15 Aug 2019 12:51:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:02:18PM +0530, Mamatha Inamdar wrote:

SNIP

>  		symbol_conf.pid_list_str = strdup(trace->opts.target.pid);
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index ddbcd59..dbc6dc2 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -1619,8 +1619,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  	err = -1;
>  	/* perf.data session */
>  	session = perf_session__new(&data, 0, &c.tool);
> -	if (!session)
> +	if (IS_ERR(session)) {
> +		err = PTR_ERR(session);
>  		goto free_writer;
> +	}
>  
>  	if (c.queue_size) {
>  		ordered_events__set_alloc_size(&session->ordered_events,

I'm getting:

  CC       util/data-convert-bt.o
util/data-convert-bt.c: In function ‘bt_convert__perf2ctf’:
util/data-convert-bt.c:1622:6: error: implicit declaration of function ‘IS_ERR’; did you mean ‘SIG_ERR’? [-Werror=implicit-function-declaration]
 1622 |  if (IS_ERR(session)) {
      |      ^~~~~~
      |      SIG_ERR
util/data-convert-bt.c:1622:6: error: nested extern declaration of ‘IS_ERR’ [-Werror=nested-externs]
util/data-convert-bt.c:1623:9: error: implicit declaration of function ‘PTR_ERR’ [-Werror=implicit-function-declaration]
 1623 |   err = PTR_ERR(session);


jirka

