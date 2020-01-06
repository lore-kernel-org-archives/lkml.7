Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36EC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6157B20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="P8pk1o9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAFNYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:24:39 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37886 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAFNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:24:39 -0500
Received: by mail-wm1-f49.google.com with SMTP id f129so15246005wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wC9BOXYjk4udfBrvJm6JGmvN7DTg2mdl9SY6BiiM5CI=;
        b=P8pk1o9y6+tG5KTqZ9qfFyt85i2CdbvG8XOjpzH+VC1HkPFsLurbZEyYmkqNh4UWcL
         Eux3W369x5DtVrAYs80Bc1RAmUy6R70BJT8sQX3DdDeJZ0mV0VAsZwbqETyluYbf+uTl
         koNyRRhxh4i5PhdlCabKLdZQ3LgVHGQS9sW0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wC9BOXYjk4udfBrvJm6JGmvN7DTg2mdl9SY6BiiM5CI=;
        b=NRfw982ZFD1CZGylsC1jqawGHGSRbLdamDMTefU8Nd70n0Q2wVSLl41iLDhPEkbhB3
         NMVHFvISVUPogbQfQdOPhYHMYy5xwOYRsZwGCalV1u+IlMW06IDxDOK6ivU0XcS5wa9K
         kX4UNOcCDxC0bGcCUVg2OjNhtrUTjtu/hrxJf2usYDqatauxwQmfT6wytrRScmpwED10
         Z8dYiPxunelA4vyCvUTkNz7mjwq4/WE9UDGaEQBEdCODkpOlfV0kX7WFECkj04L+GOXN
         MU5KJwe1fuLl95QLysrBgJh3ORTkWiiI/BSZvlHakdfRzZl3phrCplc9AIDGVR7G+FNC
         x4eA==
X-Gm-Message-State: APjAAAUouhWdyD0Kmlno4bFhf+Tv6nuA/ViPt+a+6oZkfhNzSBElieyk
        NQ/FPtrG04jobtD8iE1970lGDg==
X-Google-Smtp-Source: APXvYqxiB5J5yZSQ8qnPvaI29s4X3LKS+PySqiuL7STuXEvvcVUEmF6Z+6C0eNwuDiq3exnvuiyqIg==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr35558851wmc.171.1578317077752;
        Mon, 06 Jan 2020 05:24:37 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id b137sm23689296wme.26.2020.01.06.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:24:37 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:24:36 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Hui Zhu <teawater@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
Message-ID: <20200106132436.GC361303@chrisdown.name>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
 <20191225140546.GA311630@chrisdown.name>
 <20200106131020.GC9198@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200106131020.GC9198@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>I am not really sure I agree here though. Swappiness has been
>traditionally more about workload because it has been believed that it
>is a preference of the workload whether the anonymous or disk based
>memory is more important. Whether this is a good interface is debatable
>of course but time has shown that it is extremely hard to tune.

Sure, it can theoretically be hardware- and workload-specific -- I don't think 
we disagree here. The reason I suggest it's a generally hardware-specific 
tunable rather than a workload-specific tunable is it's pretty rare to see 
anyone who's meaningfully used it for workload-specific tuning :-)
