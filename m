Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89307C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6225621743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="PicqJS4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbfGQRxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:53:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35683 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfGQRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:53:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so11219463pfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z2SSmhd68h87dQhwvWTjUlLYyoXB//o48emXKDITCxQ=;
        b=PicqJS4oQ5peSgXROAA8eXF277L4r7XmQo7cZukrfLSYdqLgbwsEd5Dqzk8QpxK7iV
         Jr7zEtrtR7thmPO+J1QqTaT3j+I0++ACo6TT6aLs2O6D/+ubRqwsDUj8iqkYUHlSu3uP
         S2KX/7zlhOpvgyqTAThJQxGs1jnQy4eGdv0gbpjnWh/cRorbYj9HH98ccTyznWgcEXac
         q+hc0yDQCCnUJLqZHjU4NiRzAjIzNBE+SyaYhXxaMZoParySRgAtaVZmE7db4nbJWShy
         2wprrKIAvpplpmvdMXRr1OD5xBE/XjJHL4qajuxjvrPz4tpMfAgYgXaVJxT7SoPPfBK0
         oskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z2SSmhd68h87dQhwvWTjUlLYyoXB//o48emXKDITCxQ=;
        b=OGfAmv4DA98GIfNRvKfktw8Z2b3VYWcJiS5KSXnKnzHU9ZSU2Uhc9PEgtGfl28L8KM
         tHm1fz65+J7oTiLvNfCKW+Vw9Fp1NchiFhIqDH4JbsKz1MlIzxpRvztt/ukrp3dhhHMP
         7gwvcUkx0/eUIe6V9kOEjUNcjUDZd4nbnyu8ZmU4NRIEiPBpEMZEbTU4ZpclTT8E1Sh4
         q7Na1yq3nyqgD90uq9M1pSU7lJkgcmZAYsegCcwj7AVV8pvFSehS5QtjBObBrjVdly2B
         ZsHmB5KvpWM4nPnQTUxee6Dskbjb+7GeDDYsiLpa0SfFDNsHuB0+ADyTAuvUn2UDVaGK
         TW2Q==
X-Gm-Message-State: APjAAAXGrDlbKJBAdSwB+TVh1aDD4bwc0ldeiHo9Qub7p7IH17/C7F6k
        pM3TXk94WYoXBMFemcuGKuI=
X-Google-Smtp-Source: APXvYqws5y1Y3Qi2XGvjYV4PuosbGfC72ojawETni+lagfagIVzMSmpCmtv3mdSH5rkpTds+RX2eng==
X-Received: by 2002:a65:4d4e:: with SMTP id j14mr42320858pgt.50.1563386002312;
        Wed, 17 Jul 2019 10:53:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:4db])
        by smtp.gmail.com with ESMTPSA id b26sm29434788pfo.129.2019.07.17.10.53.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:53:21 -0700 (PDT)
Date:   Wed, 17 Jul 2019 13:53:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 2/2] mm/memcontrol: split local and nested atomic
 vmstats/vmevents counters
Message-ID: <20190717175319.GB25882@cmpxchg.org>
References: <156336655741.2828.4721531901883313745.stgit@buzz>
 <156336655979.2828.15196553724473875230.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156336655979.2828.15196553724473875230.stgit@buzz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 03:29:19PM +0300, Konstantin Khlebnikov wrote:
> This is alternative solution for problem addressed in commit 815744d75152
> ("mm: memcontrol: don't batch updates of local VM stats and events").
> 
> Instead of adding second set of percpu counters which wastes memory and
> slows down showing statistics in cgroup-v1 this patch use two arrays of
> atomic counters: local and nested statistics.
> 
> Then update has the same amount of atomic operations: local update and
> one nested for each parent cgroup. Readers of hierarchical statistics
> have to sum two atomics which isn't a big deal.
> 
> All updates are still batched using one set of percpu counters.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Yeah that looks better. Note that it was never about the atomics,
though, but rather the number of cachelines dirtied. Your patch should
solve this problem as well, but it might be a good idea to run
will-it-scale on it to make sure the struct layout is still fine.
