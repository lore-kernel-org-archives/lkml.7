Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B3EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AA122C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564062839;
	bh=mS8IBFvnYQrWKc/GsN8tgboZttuv2U5VEawHM3flGp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZcBmVB3R1StKlB+yif87kEmO88fWtz402INV+HOLiTFu2KRuha5eNMmAdmK2u/hGs
	 utuVHGdMskDOPyXU203sPStbw93gKbFzicMsGzKiBMaKD0omCGSbk67sAPa2QQa7vv
	 s+8eDiLmGC4xrLB7WY4nH1RiogpqjjI9gVsiWRoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404118AbfGYNx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:53:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50378 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403804AbfGYNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:53:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so45111610wml.0;
        Thu, 25 Jul 2019 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GCYwHJCLOsYoyyik86R2Z6x2q4egJ0xmOYkZtSr5Et4=;
        b=IS0yrIsbzCZQC1jP26jRFo0g4nOCtbeBYrhyWET/czx/N3PXQHriKYe1jqGFSnEARp
         gBcSwxE4pl/mFpnDgKRnZgJOdb+Eyyl3uQekvIU2tsrJV4jTZU6qZQbeHyIyaMMdg9N/
         YSZSQHty4Etpi/Qv507Y9gxmTqwz/awhhozgI7wxwb8Y61KY01bYAa/hit5+jPUtV6/q
         Ei2yMP5zgt3sIkgsi2XGczqjmf4Cle4wKQIZan6/brv6TH2vbBMoMquCb9akA+6lhZtw
         e2tjtuXzfBiU2wgE+DjXs+6pc0P6+tbSF/2MR0vCd03WoyjL0Xcn2ZGRIli0CZKpDZFA
         abFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCYwHJCLOsYoyyik86R2Z6x2q4egJ0xmOYkZtSr5Et4=;
        b=SxV3JC8es1825gTKKzMkGI3jnTDONTe3V6qxzX4WP07KBWvOa4uXio3SAekp7fSNo0
         TDMmIpgJTUpNc/hDTTN6ok9CzqzOtyUI69FNyfWVrbfxWTT7xVEiiNX5nCj/XGAeyPmv
         /+WpuZ7pT73r20eFZS2IKlV1rzOpk/jKfgMi6bbcSJH0HAa8eaxN9ZJo1ivdf9G0qKeG
         LKMjjw3+dnrK9bBFqo3h3lZyOtTvDPbJd/ldt7dGl67CgMoae+ZxQ9pIWKuWSWliFfqO
         0lsnh7u0N00wfBIggBYchgatd2FNwqdKiWwYb1ftW+6xZu0H9Flg+K2An9qMM12m3TXj
         l18w==
X-Gm-Message-State: APjAAAVPT+G8LQNdWR2W/Y1LGI/CjeC08lafqwyqYEqMcA+QwB7FVOCp
        Q8bqzWq03ZoikN7LCw+jOz8=
X-Google-Smtp-Source: APXvYqxAfOcivn+U2a7IrJytSvx2dWf5Bs4Fypm6B+rPklb1sKuFAoEn63YogZXS7jvztrm7pV8Jfg==
X-Received: by 2002:a1c:968c:: with SMTP id y134mr75559079wmd.122.1564062834820;
        Thu, 25 Jul 2019 06:53:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g12sm69938967wrv.9.2019.07.25.06.53.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:53:54 -0700 (PDT)
Date:   Thu, 25 Jul 2019 15:53:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        dietmar.eggemann@arm.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20190725135351.GA108579@gmail.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719140000.31694-4-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juri Lelli <juri.lelli@redhat.com> wrote:

> When the topology of root domains is modified by CPUset or CPUhotplug
> operations information about the current deadline bandwidth held in the
> root domain is lost.
> 
> This patch addresses the issue by recalculating the lost deadline
> bandwidth information by circling through the deadline tasks held in
> CPUsets and adding their current load to the root domain they are
> associated with.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Was this commit written by Mathieu? If yes then it's missing a From line. 
If not then the Signed-off-by should probably be changed to Acked-by or 
Reviewed-by?

Thanks,

	Ingo
