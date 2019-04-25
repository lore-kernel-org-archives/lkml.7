Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2CAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80DE20651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556174356;
	bh=gegyX4cOOMMxlxYmd37rT1ZX3/5qrHTkC7/BaOLUC3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TQj7fdcILkO39+mjhcavO1RQMCIL6FKhxvuoWy4GFOxiqQDk7VrTzJk6Khf6uhUhe
	 e4Q2z91ZFI49YsrEXOMSpf4My80XllA+7NzcwCnH7v81zgbnssfKagp8VpM8cYjUdb
	 Kw7t8OJuB1t71tZB5dq0sjkim8x2Vzh4QjZTfrYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfDYGjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:39:15 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36203 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfDYGjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:39:15 -0400
Received: by mail-wr1-f41.google.com with SMTP id b1so17277667wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=49jyvm4jbSuvTm0ekjcyI5ABuC9QUpA5l+m6y30ike4=;
        b=l/84KkULHRRSr+R2THoVAtpGeXhkH3D7cH7sImUc/rCUcr9gnXbYnipiZkdf6Hsx5n
         B1eOr4gpCWHQsyRRtsj8fm0+sICTWkkFgvlCGUVvPmwRn6+PcuxMgcvTkzoF6I4I4ysC
         VNOa/EozxLi2VNhdcDIBkEW+6yHQDd3O9UthJZ9e5P7oc8Lr8kgQKJnvEYXJXW6SWw1g
         g8KcG8HBmsKziTtfV0R/BQ732SJqtg7/PLihM2REN7FOLLTZvZ/D7tL/8+BL4JUm+WHN
         QpF1226QO7oBCBaaTdm+wTIkKKq+9ie5XKF7FOLazeNoJyIxby/QoPaTBq0zMdzXklJs
         LQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=49jyvm4jbSuvTm0ekjcyI5ABuC9QUpA5l+m6y30ike4=;
        b=Vxwww7wJqSJ8hdffIbo/1V8m04kFXhaRX9+TPydiYx+hkTibObKxg+DexILC1Qcg6q
         ZTW3Ie34RFq8e9gS+oIu6pk4ivYPKn4N+7kalMamf4AFmITIXvhSQtPqmeHV2mmdSN/j
         E59XRTIWN7wSbmp3xTHYdJunBzuaDSCSeAgEFQ3lBe9q2nZcAJSMF664xhK4rGGMtjjO
         D13YuplHzGorQfy+5jrINzkTLWCZ5EXuChkfza7h1oIC8R99DtXxCQI0NRfvw9AZ4eh1
         yQ6sU2YF0gIx6dnIqQA1zsUIZRMtiq+OJgjORLZ6vaCXL3tg50DweVnhPzOac4RJDaj9
         szOA==
X-Gm-Message-State: APjAAAUhYEEdzRawlkecfeO9m20YJNpKvueckG+ZAMvJGkg3X1xZOqRp
        76jhzlgXZojIEpj12pSrt48iILSx
X-Google-Smtp-Source: APXvYqxFlngF18ZfSHpY6NKkN7fS92liLwogZ6klzSj0ohH0wxvq7E3nrTeHK/GeCbYBr/24KT+onQ==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr25694364wrr.27.1556174353471;
        Wed, 24 Apr 2019 23:39:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y197sm22396040wmd.34.2019.04.24.23.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 23:39:12 -0700 (PDT)
Date:   Thu, 25 Apr 2019 08:39:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@gmail.com, lgoncalv@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH] perf stat: Add hint for SMI cost measurement
Message-ID: <20190425063910.GA85646@gmail.com>
References: <1556120792-35415-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556120792-35415-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> +static void smi_env_check(void)
> +{
> +	char *name;
> +	size_t len;
> +
> +	if (sysfs__read_str(CPUIDLE_CUR_DRV, &name, &len)) {
> +		pr_warning("Failed to check cstate status.\n");

What a meaningless message. What did we want to do, what happened, and 
why did it fail?

> +		return;
> +	}
> +
> +	if (strncmp(name, "none", 4)) {
> +		pr_warning("Cstate may cause drift between aperf and cycles. "
> +			   "Please completely disable cstate, "
> +			   "E.g. set idle=poll in grub\n");

Please keep user-visible strings in the same form that the user sees 
them, i.e. in a single line.

By doing that you'll also note a capitalization error.

Also what does 'Cstate may cause drift' mean? What aspect of cstates 
causes the drift - entering/exiting deeper cstates that are not C0? If so 
then say so.

Thanks,

	Ingo
