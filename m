Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277DAC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CBC2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565567178;
	bh=hxZGXq+1QClkJfpjPXEQ6VhU1iaPfgemO6jldgiK4ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HQ7oK+LU/xVN6fI3e5/pHXU6ACv2luMxCVwJxf96SZDFSSYEZ+277LMhwyHdBqaCJ
	 t1JPkn+xVyX2IGk6DFNJ4S6ydKmDA0YJW/bAQU6AiadxsZj5Dub/lR7CZCrAWhMkb1
	 WTUmRNRmuudwW6fOFmXevffr1im60JlNJs+2qlAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfHKXqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 19:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfHKXqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 19:46:16 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79CB52084D;
        Sun, 11 Aug 2019 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565567176;
        bh=hxZGXq+1QClkJfpjPXEQ6VhU1iaPfgemO6jldgiK4ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MprxUavY8cQ6/cK9n6f1O0oHgjE9X38sSHpyXM3LvHswaNqflKU9ROrO5pDwSRbEk
         yAG/II7kSV3UVtPsliGyxkWlwMFGyTM4FcFFi2CkTMAI+HNoOsQwAmKvCqdn41gf+b
         clMk2UeA9ioWkiLaJJpl4S0Sa7srBhLMO2ljV9K8=
Date:   Sun, 11 Aug 2019 19:46:14 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race causing
 SIGBUS
Message-ID: <20190811234614.GZ17747@sasha-vm>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
 <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
 <20190808185313.GG18351@dhcp22.suse.cz>
 <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
 <20190809064633.GK18351@dhcp22.suse.cz>
 <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 03:17:18PM -0700, Andrew Morton wrote:
>On Fri, 9 Aug 2019 08:46:33 +0200 Michal Hocko <mhocko@kernel.org> wrote:
>
>> > Maybe we should introduce the Fixes-no-stable: tag.  That should get
>> > their attention.
>>
>> No please, Fixes shouldn't be really tight to any stable tree rules. It
>> is a very useful indication of which commit has introduced bug/problem
>> or whatever that the patch follows up to. We in Suse are using this tag
>> to evaluate potential fixes as the stable is not reliable. We could live
>> with Fixes-no-stable or whatever other name but does it really makes
>> sense to complicate the existing state when stable maintainers are doing
>> whatever they want anyway? Does a tag like that force AI from selecting
>> a patch? I am not really convinced.
>
>It should work if we ask stable trees maintainers not to backport
>such patches.
>
>Sasha, please don't backport patches which are marked Fixes-no-stable:
>and which lack a cc:stable tag.

I'll add it to my filter, thank you!

--
Thanks,
Sasha
