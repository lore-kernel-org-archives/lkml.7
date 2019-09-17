Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF581C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7780E21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YlRcGLEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390980AbfIQFFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 01:05:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfIQFFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ojhynOeAxnR1dnfSk+M4BfJ0Fe7m4oLvhsSvo+gD7Lw=; b=YlRcGLEevt44FWVfme5NFIn0M
        5yefhikk8KrtCEhKt6Heshu5ywG5OYxPXi/8RBlzptR19YRGHDC2bFyIIZuSr7YGsi5pzsX5wSy5m
        PunmX5lKVQ8GdSRE5J6XXtZoqgUA10PgOYv/HMmOIaMWB+LGvvrL8qvgqwbqJ1yNUX3/Fr9Oe5BHJ
        6su6LH4kGUaVCYyoxJDtl/rkJbIuvwCfch/u31rb3cnP2gWfhV9cYPfkLjIWvnatEzzDVqB+wp5nL
        caOtrlLgC1/1GG5QeqNERnQHgw0EGSRMWnXzJP17W97vEbpYKSU4MhRAvipy73FNVM54imGrY0/oQ
        sDttrPhMw==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA5fy-00016Y-1f; Tue, 17 Sep 2019 05:05:18 +0000
Subject: Re: linux-next: Tree for Sep 16 (kernel/sched/core.c)
To:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190916223850.GQ4352@sirena.co.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1898d3c9-1997-17ce-a022-a5e28c8dc115@infradead.org>
Date:   Mon, 16 Sep 2019 22:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916223850.GQ4352@sirena.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/19 3:38 PM, Mark Brown wrote:
> Hi all,
> 
> Changes since 20190915:
> 

on x86_64:

when CONFIG_CGROUPS is not set:

  CC      kernel/sched/core.o
../kernel/sched/core.c: In function ‘uclamp_update_active_tasks’:
../kernel/sched/core.c:1081:23: error: storage size of ‘it’ isn’t known
  struct css_task_iter it;
                       ^~
  CC      kernel/printk/printk_safe.o
../kernel/sched/core.c:1084:2: error: implicit declaration of function ‘css_task_iter_start’; did you mean ‘__sg_page_iter_start’? [-Werror=implicit-function-declaration]
  css_task_iter_start(css, 0, &it);
  ^~~~~~~~~~~~~~~~~~~
  __sg_page_iter_start
../kernel/sched/core.c:1085:14: error: implicit declaration of function ‘css_task_iter_next’; did you mean ‘__sg_page_iter_next’? [-Werror=implicit-function-declaration]
  while ((p = css_task_iter_next(&it))) {
              ^~~~~~~~~~~~~~~~~~
              __sg_page_iter_next
../kernel/sched/core.c:1091:2: error: implicit declaration of function ‘css_task_iter_end’; did you mean ‘get_task_cred’? [-Werror=implicit-function-declaration]
  css_task_iter_end(&it);
  ^~~~~~~~~~~~~~~~~
  get_task_cred
../kernel/sched/core.c:1081:23: warning: unused variable ‘it’ [-Wunused-variable]
  struct css_task_iter it;
                       ^~


-- 
~Randy
