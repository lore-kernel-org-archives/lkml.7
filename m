Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D3CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA50214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2w3kuZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbfJ1Rq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:46:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51940 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbfJ1Rq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:46:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so10449885wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kTqsNbX8N4/+tKo0tfrcCNjH51MhQhLsOa9YrJD5zj0=;
        b=F2w3kuZUze6C88Rtsmh3Mhaj1Q23RKXWFnErHtknY0GcHadB2ptfiw8+jfgktawpYY
         GxA+S09pISwBlnp8aYIyyvp9LNG4XRt4LVH2rqiL74KDx54jtzlBXpaNqxVQQDbil41L
         hlKRwwnE/px0j7f+pLNoo0eAchljc4s2x4NI1TKEJnABhrwWQtpTCIX68G7nwIKGO0jC
         be2hxz2wnvVayDP2Ei3EfFZcW2DBwITeb+eUcGmirQ+l/zqDmOxx1TsIRVrl2TZGWSk0
         n94yJQzDHUt8AwxFoNHFP3v7cJqIylYJ9VaSy763H0g9I1kOY0yWPG4+wpaPtw2R3mIG
         hU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTqsNbX8N4/+tKo0tfrcCNjH51MhQhLsOa9YrJD5zj0=;
        b=ZhOKQr6icPW0LpkDklPjqLUiSGSgV+O3fOI7G3Lh3o5sy9AIXYdQePXdRRGM+3qV5B
         8m56bV93KcHn/ByT+aIWo9uDjjWwX98TDe8+6NTdh8ow5840YBOIh8qghs3tvI74k1SX
         MTvtHqyk5Egr6xCHfdsexl0yKZeBmHgTtBgBRHR98F5vcgbvtwzSB5hPHTsx9HgYG+Or
         dJUtAsgmVkyQnLrAyLy1tgzDUlNtT4b946N+z6HxHyiT23UhBnOMWu4ijI4xAsHPINRU
         kjYHB56QYdkB53MPMxYmitz5BktyZm/8L3sfIn6T1AfbQBUTtzmNCedYtHFhoD9c4QTO
         CgRw==
X-Gm-Message-State: APjAAAXwZ8tBgBlotZYUF6cL95HWumsm5hC8A3ZxEOKfHPKpzCTc2Ijl
        9Pja3GCk8HqenJAFsqREALKU7Q==
X-Google-Smtp-Source: APXvYqx6EKY5iVC1Y+vzz0E0soWNQFjW0aBCt1fx8az/wKxtKcqb64MDEMnFHUNzQ13rDe7I/o79dA==
X-Received: by 2002:a05:600c:228b:: with SMTP id 11mr466368wmf.112.1572284816342;
        Mon, 28 Oct 2019 10:46:56 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id q12sm11567587wrj.87.2019.10.28.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 10:46:55 -0700 (PDT)
Date:   Mon, 28 Oct 2019 18:46:49 +0100
From:   Marco Elver <elver@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, dvyukov@google.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191028174649.GA63741@google.com>
References: <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
 <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
 <20191025133358.pxpzxkhqc3mboi5x@wittgenstein>
 <20191025141325.GB6020@redhat.com>
 <20191025143224.wtwkkimqq4644iqq@wittgenstein>
 <20191025155224.GC6020@redhat.com>
 <20191025170523.u43rkulrui22ynix@wittgenstein>
 <20191028164852.GA17900@redhat.com>
 <20191028173031.m32p5e3ek764hnre@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028173031.m32p5e3ek764hnre@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Oct 2019, Christian Brauner wrote:

> On Mon, Oct 28, 2019 at 05:48:52PM +0100, Oleg Nesterov wrote:
> > On 10/25, Christian Brauner wrote:
> > 
> > It is not that this code lacked READ_ONCE(). I am sure me and others
> > understood that this code can read ->exit_state more than once, just
> > nobody noticed that in this case this is really wrong.
> > 
> > IOW, if we simply change the code before 3245d6acab98 to use READ_ONCE()
> > the code will be equally wrong, and
> > 
> > > and as far as I understand this would also help kcsan to better detect
> > > races.
> > 
> > this change will simply hide the problem from kcsan.
> 
> I can't speak to that since the claim that read_once() helps them even
> if it's not really doing anything. But maybe I misunderstood the
> k{c,t}san manpage.

What Oleg said is right: marking things _ONCE will make these accesses
no longer be data races, and  KCSAN would then no longer report these as
data race, even if the code is still buggy due to there being a race
condition. In this case, the race condition would stop also being a data
race, and we'd no longer find it.

Thanks,
-- Marco
