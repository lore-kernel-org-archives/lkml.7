Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE711C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B2F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="vrapgFdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfCVWvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:51:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53378 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:51:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so3596196wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=losYwk/KnyYBXmqLLyIEJufi/8wg0iZYh/lFm2rrato=;
        b=vrapgFdTIfpT8XWFnIH1/GLXnuTAw40ZeVke3Yc0Z7QMZ5/Lb0zs8qCSPqghWJK9Qs
         GpkaCsqzi3mLS8zOASlqm0nzs2tmmRmILYWDayt/SwE2+swwnX0taFqcD+9XuGJvSE8G
         OfR8xGLbN93EsKI3jxWaNQkOCWDePK32gNlLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=losYwk/KnyYBXmqLLyIEJufi/8wg0iZYh/lFm2rrato=;
        b=lydptkeD1l+aDslUXB8ONf5INDpUx44Rjui+ioAHyA6sWjs++c7nMBBbfE/Z8Nnm6k
         gnItXmO0qJMPCm5bPH76Yj/7hllHoiuhGLdLbRPqiRoRoV1NGvYz8nnxlZlAc9nWrQeN
         /2ys+TCiufg8djcwJppdMyXjOZzBfOE1bA1ihnCPHk4iIuXqCkUtTHWPfy9aZBGENhFW
         r0C2wBZHKfjcg236gJpUzwILAKSAvfldoPqv/tjXplaEsHc/f1lFjqQBuWCrWoL11BMv
         ZhleR6f+gXEhmfm09kkKe5HUY+YM1b/jrydRRdnMoUU5h0fAtR/oEIJYqGSBT+EBZQMN
         XdsA==
X-Gm-Message-State: APjAAAU99FuL5hLbDq/ruzTQyAAV3BF8gXFA+RGNTGd01In6EXAhSYvp
        5srQ+9P1KOSj+ToCElZ8t0i5TQ==
X-Google-Smtp-Source: APXvYqwf8UKcetCKDuArWodMQzyGrYiEaHyrN7VvfQjQJmF/nB7qUNX7kI/1I5k/PxmVK44hxXSbhw==
X-Received: by 2002:a1c:ef1a:: with SMTP id n26mr4421627wmh.104.1553295066245;
        Fri, 22 Mar 2019 15:51:06 -0700 (PDT)
Received: from localhost ([89.36.66.5])
        by smtp.gmail.com with ESMTPSA id a82sm9301106wmf.11.2019.03.22.15.51.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 15:51:05 -0700 (PDT)
Date:   Fri, 22 Mar 2019 22:51:05 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190322225105.GA21729@chrisdown.name>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190322222907.GA17496@tower.DHCP.thefacebook.com>
 <20190322224922.GA7729@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190322224922.GA7729@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin writes:
>However, we can race with the emin/elow update and end up with negative scan,
>especially if cgroup_size is about the effective protection size

Yeah, it's possible but unlikely, hence the TOCTOU check. :-)
