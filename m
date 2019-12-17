Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C934C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530552067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="NBYb0wme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfLQNyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:54:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39465 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfLQNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:54:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id b72so3262892wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0tDf420l6OJe0Bwhn9GE+pW7tyo0iSFruHkLYhzOzAo=;
        b=NBYb0wmeeE28IfoeJrHNR1nDrO2AHN8CdVfPvDeRfkbZeQiKbRNDWRDE53oyz1Qvin
         1Z7E0QX1fhIgd7ApaTelr4wPdPP3JqfQJRxyV4VIziwJGIJr6WzgZDPtcapqvqlqReR7
         Ylo8CwcB1K3wbYJWKBlqC8Kc8tQAW16Bt76kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tDf420l6OJe0Bwhn9GE+pW7tyo0iSFruHkLYhzOzAo=;
        b=gYSPB0qvNkjZwXRIhdnque2CmHXRVLSCPDSe+4bcnF13FJHpWH8pYS6kKZbHCRqiPa
         MigjMwPekfX0lANfUARJfMJV/Lk2CAScUEDrOi7GZgX2iqVj2Xw//KH3iJXLNm4ES+vp
         Z6Ay4ab1IzwzZGJZVVXefifjzWW/Ux7l1LD3S+7HDJRN06J9BZUMqWbyeeoT9teAYOgB
         wj0wj/c7/0pwvVnRS3v5m+6DN3O9GNRXWB3t8G4/fENZCYjlb41KcVPEnhHOu4Blm+qQ
         quy3I0ng6voUqYUCnPKdsj1itUwFsJWyxWPzdvd5YzmJcDNdijjq+4Jd/XSlQBJ/TqzS
         HApg==
X-Gm-Message-State: APjAAAWcToyX7s2doY5hWQ9wHEFZWIh+rrsoEHjll9i/KRFR/E+3gG5b
        D57CjRF9TdiP1osEDA8K3mwYkJpCSnc=
X-Google-Smtp-Source: APXvYqymxQF288/hhyASLUrJbI0GnBe6CY2DqQcMtrvEJHtVaNq5Y+tyGlDwmL1e5t1aoJrxF06sxw==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr5703560wmb.47.1576590881556;
        Tue, 17 Dec 2019 05:54:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id z6sm26950594wrw.36.2019.12.17.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:54:40 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:54:40 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217135440.GB58496@chrisdown.name>
References: <87fthjh2ib.wl-kuninori.morimoto.gx@renesas.com>
 <20191217095329.GD31063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217095329.GD31063@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuninori,

Michal Hocko writes:
>On Tue 17-12-19 15:47:40, Kuninori Morimoto wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> mem_cgroup_id_get_many() is used under CONFIG_MMU.
>
>Not really. It is used when SWAP is enabled currently. But it is not
>really bound to the swap functionality by any means. It just happens
>that we do not have other users currently. We might put it under
>CONFIG_SWAP but I do not really think it is a big improvement.

Agreed, I think we shouldn't wrap this in preprocessor conditionals it since 
it's entirely possible it will end up used elsewhere and we'll end up with a 
mess of #ifdefs.

>> This patch moves it to under CONFIG_MMU.
>> We will get below warning without this patch
>> if .config doesn't have CONFIG_MMU.
>>
>> 	LINUX/mm/memcontrol.c:4814:13: warning: 'mem_cgroup_id_get_many'\
>> 		defined but not used [-Wunused-function]
>> 	static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>> 	^~~~~~~~~~~~~~~~~~~~~~
>
>Is this warning really a big deal? The function is not used, alright,
>and the compiler will likely just drop it.

Let's just add __maybe_unused, since it seems like what we want in this 
scenario -- it avoids new users having to enter preprocessor madness, while 
also not polluting the build output.

Once you've done that, I'll send over my ack. :-)

Thanks.
