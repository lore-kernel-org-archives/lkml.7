Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AC2C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062E62070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568971122;
	bh=BhEOnssDtCV+PbtEVH0MSY3gwbwb6TtByGWVPzEQVx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J6gduqiG4iwkYXTOAE1SyWJVf33IVCz4rnN+/pqQLR53iZnlzloI6Ambwp/QlO7n1
	 kdv0NF9dg18J6c/+kfbjwj2IU8mT2miBa+ajxINDPmwLyv3+PXQ568ozcQFIedsntS
	 u5UjfH78InlJgdJ4k/7HQ1Ix58MdDmKYKk+Ti11E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405683AbfITJSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:18:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33820 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405605AbfITJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:18:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so4889737lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a4sA6RSpU0AxRASUuenu7uY84AYTbx15W58lsLt98pE=;
        b=KU7FJHffYDXFNdV+4blUAhmK8iJa8HAQ5nIfvuSXFjrV6j9MwxV/1OrMwF9ioRHEKe
         EJIwNh1aBKAqbNbOqm+jgeXmuhNot7zB29HqApZshR4QRgROPZ6diiMpUybivjlrouXb
         XmGiDUXwBrQ3qyX1ttQY2xVVLsoHo3N5+aCTLfkUBrjj2pki2V9ImtfpPZElqMApZMu2
         RY6+0QTSnQAgpzTuFVbhartib3HUVWiDOr5deJoPgUi1jNHBkXJWiUMeB4kQJR+lRBvW
         NHywEdiDWNTeJBNnw7ugYOn7FRgxRa4R8EBwA8wqXODrBKEWmGgGSlRegOStmNCRO2PS
         Cuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4sA6RSpU0AxRASUuenu7uY84AYTbx15W58lsLt98pE=;
        b=BrbRgr8ScTroQ2StmnJEovmWdqMK5Ltk4DWp2zG6wr9EnflNNnJPhvF6qmmu7Gb9LD
         bsMeRMEhbVUBHzXCB/hG82aRt6xTDOvIZh/Bj5kwzBFjLVIDH874LUWBzTB/p9TTZgr0
         dqsrwQDhrkTNHxaRRWF2Q8noX9KmLKfCNsQ0P8PZbwXqB4YjOe9IsDJZYat08rkyh1Gi
         oWvHFJb+LsPhwehIfwyZg62wasaAI4oUav9p2oYPCdRqUwkdn8gQQvmnPbnmaB8yoSk+
         2ZGe/kFe/LhZh0nSj5OC0ZpIXgwX6AFKuRpfnhYfmtdyRfqKtPILXCfTdr30iIE99g7y
         A9Ng==
X-Gm-Message-State: APjAAAU0JEJpwjZCYYd5oR/WBWKYbQjt/ROWyC2nJfnQt/yGdqHCCgf2
        ogmHOPVRcY0WF4razawMT38=
X-Google-Smtp-Source: APXvYqzJlQUucHhG3vt3rc5Om+RExWk6bOnxcn2LVl1tRuTWSOWbCycDQYttygLwTWoKyD/mUs+Rhw==
X-Received: by 2002:a2e:b60b:: with SMTP id r11mr8696444ljn.117.1568971117607;
        Fri, 20 Sep 2019 02:18:37 -0700 (PDT)
Received: from rric.localdomain (31-208-96-227.cust.bredband2.com. [31.208.96.227])
        by smtp.gmail.com with ESMTPSA id j17sm347509lfb.11.2019.09.20.02.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 02:18:36 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:18:34 +0200
From:   Robert Richter <rric@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/32] oprofile: Use pr_warn instead of pr_warning
Message-ID: <20190920091833.emgecjute63drngz@rric.localdomain>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-18-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920062544.180997-18-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.19 14:25:29, Kefeng Wang wrote:
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.
> 
> Cc: Robert Richter <rric@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/oprofile/oprofile_perf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Robert Richter <rric@kernel.org>
