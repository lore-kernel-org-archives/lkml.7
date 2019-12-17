Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A548C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5294F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="gJUT5JEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfLQP2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:28:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32923 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfLQP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:28:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id d139so2510737wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yZaScq9Meta77Nqt7I5hQ1kZiSA6MbL950o5EmEfNTs=;
        b=gJUT5JEsQl19+ZNt2Qx+/ZHcNIpwMpLwtmc3WAvlw5J9AGWaaFAnfS5qHUWnFdoq/Z
         Iu//JE+EtIRQpbdrMqEyYt1JCBMeCaj/mM58p+f9ACzA8KWvvykDijI2qRDt1Hyj90vf
         xXrj8zrMTMHBvMieWexBUEwa23r7dw16hd29k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZaScq9Meta77Nqt7I5hQ1kZiSA6MbL950o5EmEfNTs=;
        b=T/uUZzUmexhfrZzqsiibD8/3gZphxOS9pKQ0zsk481Nchsb8iKww75mGAGJUrfeiCN
         yYNUUD+ZIxmXc7THXzZSIKkm9s8JrNMmUg+VHSWU8lkotEbOZdW6HVkYBUbOefuufWqi
         OMTPFcqmfGglSM5RIh1u5v9c8wdxqIa2NBy4yFTWQOB3Wm4f+1B90Xa1Si7DNwoUOsHn
         qhRJt7GL2TzVH14mgt6dNeFq928Sqg92bnMSiZZMGcPEP2evm65c2jZiZZueBwSBDAyE
         WFyH7OUmulEW8octmCaO2BUpJu0ywS9IbcJzVqXlolKf4yB8X7iPOUtIUUn2+VxgR/RZ
         bqUg==
X-Gm-Message-State: APjAAAXXFGFH3HOVcsUhFsdtuxiDUo4iKrIuX+Zbh+1HXoF6cCqWXywM
        v0GcbzjSQG+eeQH6YmYPDqvVow==
X-Google-Smtp-Source: APXvYqziinXdsDWd25fUTn71tFQcAyW8kL5+5ZZ4tQ19HnR+LmDyJLSzMSxxsCE0HKdA/CJhZLV6Ig==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr6253388wmg.20.1576596495995;
        Tue, 17 Dec 2019 07:28:15 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id o194sm3477838wme.45.2019.12.17.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:28:15 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:28:14 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217152814.GB136178@chrisdown.name>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
 <20191217144652.GA7272@dhcp22.suse.cz>
 <20191217150921.GA136178@chrisdown.name>
 <20191217151931.GD7272@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217151931.GD7272@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>On Tue 17-12-19 15:09:21, Chris Down wrote:
>[...]
>> (Side note: I'm moderately baffled that a tightly scoped __maybe_unused is
>> considered sinister but somehow disabling -Wunused-function is on the table
>> :-))
>
>Well, I usually do not like to see __maybe_unused because that is prone
>to bit-rot and loses its usefulness. Looking into the recent git logs
>most -Wunused-function led to the code removal (which is really good
>but the compiler is likely to do that already so the overall impact is
>not that large) or more ifdefery. I do not really see many instance of
>__maybe_unused.

Hmm, but __maybe_unused is easy to find and document the reasons behind nearby, 
and then reevaluate at some later time. On the other hand, it's much *harder* 
to reevaluate which functions actually are unused in the long term if we remove 
-Wunused-function, because enabling it to find candidates will result in an 
incredibly amount of noise from those who have missed unused functions 
previously due to the lack of the warning.

Maybe Qian is right and we should just ignore such patches, but I think that 
comes with its own risks that we will alienate perfectly well intentioned new 
contributors to mm without them having any idea why we did that.
