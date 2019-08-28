Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDCEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305282077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567003758;
	bh=fR/ztIRXPzU6vlU9yJlvpD2RgJvZELM1Z5RZ8BfCv8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sZgwDPdQNc+8gOFMsVLRBY8yBZMdFPzUOra85V2qd/QcXFE2UZ/wGbCO+tV+l2U97
	 vNSAUDZ+wwUvGO+MewNSIf+b95DlJX1H6K08wPvXjJzlx9pZtkn5/tT2vHKLoeGHCx
	 ulSJ18M7vtutYcq9DxL0KFPw/FbIl+1TZTW+xRKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfH1OtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:49:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47018 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfH1OtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:49:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id p13so2580385qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Skr6+/WM/15QADtYsTq1qtD4lhvb4OfddpIr+Z5H48M=;
        b=jdlIZ73CSe8MQXbkN4N2K7jjg+FjjLbLc7Y3KKPGoe5+eenPGJ+D8cSUaiKmGsyj+y
         Xl3Gv5piIx1tldyOm5iBryZhyj+bMRfK4OCkviVm7QivONLNPs7P6EPF4CS4qLLijXQV
         XbPkPG+JwuQefzTaVnHI45iaFZq3rmav7NnBqplHDPnDIYKKaJwUgAVNYL+73gndu+GN
         ejcdf9uAj4gzqBKhGf+/uTGQxu4IB2vbyUa2o5uj5NR+8PYkPUMr/FIavAtMW1j7Cr1K
         hHcjfX68GXW2HNquppSsW0EygjRtYBY6xkmdkd1WIDZBBvSe13LHRfD6NTUz8qdjPQ10
         +XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Skr6+/WM/15QADtYsTq1qtD4lhvb4OfddpIr+Z5H48M=;
        b=RNe4MSY0OdfAyn6pjA92IMHGAKTa+zGXHDSjx/OWA5TNJgy0TrbNQ+ykaSiG2Ide9L
         cMkETl/aSc0pFmRL7gI9uc6Hn5/aQ2mnvJ57ilF07VPFBPRgndNUEWWaMVf8KJaWWThs
         Ebmozzxqu5kQKqNJFvIYbU5ImFGVlPL9E9XCn/gjx4/Le6IyAhN3VaoeeNbWvaRAxZwR
         KftjgEcBxZENeOuiJPZscN5hw85q4l/C/GeuymAHPzf+aqzy7/8B0ctzugYI/1RaTqRt
         PsFsUKVeNiBz+At+bDSoudx0BiyKZaXOFSeUCh+KWVE48gszqxckPVk+jINLSs13rP8s
         Tz5g==
X-Gm-Message-State: APjAAAWxKIwWVpl0RkIO3lK773vf90jk8QRV9lW9TWYqxeiZ+87VjJNm
        9kwQPUTXnbm9HZaOZSSXpgBsvGdn
X-Google-Smtp-Source: APXvYqyyPL1/AqqqWGv0ttXyuRfyRRv1U5GVoK6C0oWQCWAkQZD1B0JSp1wJOqjkXVxdFCwzeugGdA==
X-Received: by 2002:a37:af82:: with SMTP id y124mr4324345qke.311.1567003753497;
        Wed, 28 Aug 2019 07:49:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id q6sm1105576qtr.23.2019.08.28.07.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 07:49:12 -0700 (PDT)
Date:   Wed, 28 Aug 2019 07:49:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828073130.83800-3-namhyung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:31:23PM +0900, Namhyung Kim wrote:
> @@ -958,6 +958,7 @@ struct perf_sample_data {
>  	u64				stack_user_size;
>  
>  	u64				phys_addr;
> +	u64				cgroup;

Ditto, please use fhandle as the identifier.

Thanks.

-- 
tejun
