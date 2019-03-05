Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E102C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD2620684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551801466;
	bh=CLKsrj+W17X0M2NOOjAcxtCfHIr6qKN3z3Wav3UumuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0MfMS4fOdF0qQIYD8C77XoBqVRXCfjGs5lT6gmMwIyeHo5IQj8G+MMHouTedblvdb
	 PtHm1EfzMGbCXiI192LEkC2DAHf2MGOJkKn+JbIVCFitDZ5Pt+ea3u4E2i6+97DQ0x
	 np7QP1463uS0QuUrWwlRa4KtbJZdmxGpm7ZJ7zdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfCEP5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:57:45 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35413 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfCEP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:57:44 -0500
Received: by mail-yw1-f65.google.com with SMTP id s204so7329584ywg.2;
        Tue, 05 Mar 2019 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=syRrJyrzdH1UYbfxWfOIJvjLptgRVfLhLRUPUjg3L7s=;
        b=EQsCqpfidQxapqW9s4jBSno94ibaGoIcfxQ5cPy/5iS4QNTEI2HUd3D+HdCouw7hv3
         WQv+F3V3L9PfVu3e+0GY/cSN6HwnORmgD1+Kvze28M2njyJKa4UigfWN/dRXIU/jiuQg
         5sjH67N5QCuJ7SiOj4JgN44LJk9d338uIU0NjJpRUiIG3UOfP11HClkH8X3ztHLmDlZQ
         BRBVH69Xh+rPxNcQdzj7Qg5kmdF3/flssNQei9Dr6KAfQzfKFHR5dfzNzRI9O4MhRZ/w
         OixLjBtmcDMVU+y1NzeNYZ0XaH1EpwSJzjPoJYN0iEUqQw6GI+WbDboLBpMZqnLAb4Rx
         NGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=syRrJyrzdH1UYbfxWfOIJvjLptgRVfLhLRUPUjg3L7s=;
        b=KwzDSfXih2ZVa/nJ/Om/J4ExzO+T0EfXW7Hgi+dZh8oTnQw6n57rxO2heayjXQ5yB4
         l6fq4R6mHJFBAxHeTk/6XrrfFh+Igs79JOCOd6EX6iNVU5TawFcYOhESPAava/CF4kPm
         2zqgIKYcIvbbgja5qQ5u6Z/Te6N3D0ESf3B81KQWtIfOWlLUkJ4QfgHMf13Ofq8NltEv
         gvOmcJKq+R2gSIcRNWLo9Nwg6CMW964rvXF/9NranaOt1LHsCcFvw67iUxGVnfMz0Fyx
         wphuOhCI/HNmeYidqlSzZAjORFjaZ9i76UYo3eAe1VTETqASN5R56bc03laMOhqodz2R
         IOzA==
X-Gm-Message-State: APjAAAWePmoA+zyg7Cwh2bgATu3IE85RSH5q9lyXrB4kfjWTfy7zEyw8
        RS2fMN0CLo14G+JjZKEVEiw=
X-Google-Smtp-Source: APXvYqwcor4ACvREikKuw3b/qJb394qghG+L4Q+YkWR4C2MgpmpjC/NSey/SVkZLExC1PSgxd59OTw==
X-Received: by 2002:a25:8705:: with SMTP id a5mr2754309ybl.62.1551801463631;
        Tue, 05 Mar 2019 07:57:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1676])
        by smtp.gmail.com with ESMTPSA id t136sm3572800ywe.101.2019.03.05.07.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 07:57:42 -0800 (PST)
Date:   Tue, 5 Mar 2019 07:57:41 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/core: check format and overflows in cgroup2 cpu.max
Message-ID: <20190305155741.GD50184@devbig004.ftw2.facebook.com>
References: <155125520155.293746.7017401430432481979.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155125520155.293746.7017401430432481979.stgit@buzz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Feb 27, 2019 at 11:13:21AM +0300, Konstantin Khlebnikov wrote:
> Cgroup2 interface for cpu bandwidth limit has some flaws:
> 
> - on stack buffer overflow
> - no checks for valid format or trailing garbage
> - no checks for integer overflows
> 
> This patch fixes all these flaws.

Ditto as the blkio patch.  Unless there is a correctness problem, my
preference is towards keeping the parsing functions simple and I don't
think the kernel needs to play the role of strict input verifier here
as long as the only foot getting shot is the user's own.

Thanks.

-- 
tejun
