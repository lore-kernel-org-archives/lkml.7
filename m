Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC2E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555594840;
	bh=IGUjQSURO5YDnaz2VTErTiR41bINljIchs+1W886sv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ep8H6X3bBG0MzcTydO5y0v8oKlImRG0oU02lWiBypwOcA0AEeEiG3wTnlAvlQu7HS
	 s3+3VnLrkasfORM6iOBlillo1wv3CzZJXn6NlkVS/h+EJDd4coX3FpQUGmEoY1pDvu
	 inx9k889LnJyn0IKojE3ruLJjahR0sX37QEvPnjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbfDRNki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:40:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389130AbfDRNkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:40:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id w16so3073428wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zz2w+Q1nnHGXaWsWJcjtscRV/TUzqzEi6pZFTd6A228=;
        b=kDE+8XSpJlQSc6slxnjaZGky1Egi6A0rwbCTbbK1Z/kFoghnaoiqLumSYrDgAMommm
         onO8lteMQ5EwdaYdiw+ZY+vbuMVlrfIIq2tnB243wPU5jBTRHy7RC+ElEHdE2MTHXerK
         w5HI6IXd85XkeCyd++PuQDWnMaunUQlDqsjDFRo4CpQfGSeOhiSsHJ8YLV8sdEe9bcd6
         ozy9MkT05juYiFx7ozsoXRoxTFL+atRvCrAC7US2BGoedXw+dFRl5E9rgt17euxv0ajI
         w0IgQ4qXVx+vCTUN70PrAifDt2MViJMpAlloU0tptJbqrr/6dZoxUoxWn0dTzkT3rHQE
         E8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zz2w+Q1nnHGXaWsWJcjtscRV/TUzqzEi6pZFTd6A228=;
        b=HY7op9/TZtWT3sy2Rr+TRQXeHEMHk85Wf1b0ATKG73h7xLmUYSHCmi5o7R1aetCnOA
         7EzZeoejtThO+Pm15uGRA8GyaKHamA5hOmaIlocxyFx1CSRHhs+Ci/yBeow8Ct87NKRv
         juWAk8rE1UVW5hGy//4IFbcdqkFDeJ6D1PKqBjSEnQAM2nWhGVlLVk1VWYlPSKYNOTJW
         rUyJ+85MldeG12xPqNSGVx9IJuQ7y0gapFsPR41r6I8g8ayfZNOWRAyf4aBt2aJQCWUB
         bZ6N0DWCWyvhWYJCXuzaMKhQ4PWGL5LmAZEX3h/sJTQNsa5UpxYPdahfZOzKfGotwla1
         8UZw==
X-Gm-Message-State: APjAAAVzp37Wssk4d4AgHwIW7Ugetbhe4HUragDku9jsvqYnlXWl4K+A
        j4MDBrJarg5F8CfJGQP9NvY=
X-Google-Smtp-Source: APXvYqztjZmnFl8+xUgc0AtgtnhV+EIrfRmfeC1sVcqpOaS14zkzsGSPVyqaQUwiX0IxRZBj/wfWMQ==
X-Received: by 2002:adf:f70e:: with SMTP id r14mr4553523wrp.37.1555594834874;
        Thu, 18 Apr 2019 06:40:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y132sm2343749wmg.38.2019.04.18.06.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 06:40:34 -0700 (PDT)
Date:   Thu, 18 Apr 2019 15:40:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] sched/core: Make some functions static
Message-ID: <20190418134031.GA59073@gmail.com>
References: <20190322143153.14416-1-yuehaibing@huawei.com>
 <20190418132937.36324-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418132937.36324-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> kernel/sched/core.c:6524:11: warning: symbol 'min_cfs_quota_period' was not declared. Should it be static?
> kernel/sched/core.c:6604:5: warning: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
> kernel/sched/core.c:6617:6: warning: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
> kernel/sched/core.c:6630:5: warning: symbol 'tg_set_cfs_period' was not declared. Should it be static?
> kernel/sched/core.c:6640:6: warning: symbol 'tg_get_cfs_period' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Could you please also use the updated commit message I edited for v1, 
instead of just reverting to the old one?

Thanks,

	Ingo
