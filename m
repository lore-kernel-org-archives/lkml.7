Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F79C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8986D208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb/9WGxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfITNkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:40:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45052 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfITNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:40:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so7072795ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/aF2m3SxvNf9OogoNs4YAr50tbC02AaJWORVsjothxQ=;
        b=Lb/9WGxlH0JyZSbH9fNIGJZn+7/vJ8eDxI/+hGw8mzuCrpGEVzs3JmR/chew3x0r6J
         RSVDsm4gzyXxEnn+oSnd5P3fGDT+l+//WAoSJoe1CNpZnGfcjtwbcIqLGMRvhmNoW3PQ
         YpAlcU5uvS1h6EI0vqHzLLCrBXIT7PT+teo/ewUXz/0ptHMpVtnJ0NUU2vFdg4J2SafD
         AHsEhF3pfvsKUBbPaHSvbIPs2RjUqK6VWPB5hxI1h9IUn/eYUYpdpw+bGr0sOxDU3QhY
         Gn1No8y/KR8K6Ptip+RuXHpfvOTmVRO32VIgu9bSEvqcJsIJS76JgMAJNXdjkXzyDkWO
         IVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/aF2m3SxvNf9OogoNs4YAr50tbC02AaJWORVsjothxQ=;
        b=pBnhrcb07znrKoHoK3hSAjCG1ncDsjxwJxhiO81bJJSkU8g/MqTHhyHzj1T5MgBwga
         mPAUgk11dm/cZ7/4XNlv3MtZKnHQ3jwu0IsrdVT7QF9qskJl1oPApCZuAtxEvm0k3RxA
         rWfzmRbw/ELcsRV8BHQ5/XuaVZLHjnGKIGXJr0cKSpeAcfqN5bUqpPoZehbGVooo+TQd
         diD2UQNm5h4EYk2/htl8dVaehGs9Liw2QvoQu8QvLj5rgsEv5c1D6by7kOi61HYREUMe
         LGVF8hGN3ttFbycGtVO+4HjuRyG6wSEXI/TOKFjnc3cEnU45reqvCpe7Q769TZZIoSqS
         HXcw==
X-Gm-Message-State: APjAAAUwu8NkQGN5G0XVFNruVTYEf7UCPO5jk/E/7aIBwqOOrdFJAhw9
        nfiRB6lh25awfsyzpd6ZKeI=
X-Google-Smtp-Source: APXvYqxh0ksapdjSV61T6tQiw1XbUJqUqeacsI6+QX2vpoPU8wuLGI7dzdVkUigS1GP2TKO9lwqZIg==
X-Received: by 2002:a2e:442:: with SMTP id 63mr9352432lje.66.1568986809445;
        Fri, 20 Sep 2019 06:40:09 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id k13sm450582ljc.96.2019.09.20.06.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 06:40:08 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 9F8FC460473; Fri, 20 Sep 2019 16:40:06 +0300 (MSK)
Date:   Fri, 20 Sep 2019 16:40:06 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH] mm, memcg: assign shrinker_map before kvfree
Message-ID: <20190920134006.GH2507@uranus.lan>
References: <20190920122907.GG2507@uranus.lan>
 <20190920132114.ofzphp53vqqjb3fs@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920132114.ofzphp53vqqjb3fs@box>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:21:14PM +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 20, 2019 at 03:29:07PM +0300, Cyrill Gorcunov wrote:
> > Currently there is a small gap between fetching pointer, calling
> > kvfree and assign its value to nil. In current callgraph it is
> > not a problem (since memcg_free_shrinker_maps is running from
> > memcg_alloc_shrinker_maps and mem_cgroup_css_free only) still
> > this looks suspicious and we can easily eliminate the gap at all.
> 
> With this logic it will still look suspicious since you don't wait
> a grace period before freeing the map.

Probably, but as far as I see we're using mutex here to order
requests. I'm not sure, maybe ktkhai@ made the code to use free
before the assign intentionally? As I said there is no bug it
the code right now just forced me to stop and reread it several
times due to this gap. If you look into other code places where
we use similar technique we always assign before free.
