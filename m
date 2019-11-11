Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01F8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9AC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1S+sgbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKIVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:21:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40115 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfKKIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:21:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so10175943pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nfjsyq2Iq/Rw9u6HFg97pk+5ilhQojT1W/XVqRvMGCI=;
        b=l1S+sgbDmKwsK3KdNOInjmrTtKoY+QFQDoK3J7scMGzoRJETn4h+veC+eMcmkjUVDY
         7TcbMVC0WW70zXUr6CxwXO0/a7EWTyrhRj33bQB2MKWI38ScfJtAbMRYFkTrbGasRO/j
         D2w6pLBAW0eKonVrwIW4FpiEvML7zkecMmCIk7654QfSPF4lt7lbYP73wtTdAEY+mzmv
         it2vGHrGG+cA2Sf1s9ONhihNPk6mu0oBrWdQ+xzP5PbIKIvTM35NJsKmCb6+hHCKFZFu
         nLT9jM3h/o0EQ0Mxx3ujDl57b5zLhm3JAqtroSe9WhE9ELh2TlrZGERTV5IddKQ2cv/d
         AIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nfjsyq2Iq/Rw9u6HFg97pk+5ilhQojT1W/XVqRvMGCI=;
        b=JJEyT6Pg4h6ELEUngNZAUtdflX1Yrna9GjTUXG9VeA3bC5gOPULfUdNOJ7WaygtZx+
         oUOHIZb+rREwwhsvl7Ri9BybNV2Izcvp4vp7ElBzd62cj2yKJ7gbf06GQO5lD6oLfV3k
         tCBSMEPfwjcZtwL6h8PJt6siGEkl6BLsxdFFsfGK0l/4SKfveHtAvfdY2npGuCnLWEP7
         iB206zRbitTbCu3i8z1DxJQTYFx6Q3J+0SpbphTZeBbM5KB3MocCv1d7M+D+62Y3ofkL
         l787UkQWE2tD585vxmV2IuodPWXxvIi2LBoOBwFR+TSed028KM4155sAGk49ZT7WWAXv
         dWeQ==
X-Gm-Message-State: APjAAAVQ0q07JR3eLrlXF1nt7lkck0CBEoOoVrwtAc+Rxx4VPbl9CVZq
        mXGJsJxN35NMuuKdQ+EKOqNrzQ==
X-Google-Smtp-Source: APXvYqxbPpX+ZDuwq064KytIpco8Gqd8luDwvH9dqnhPt3x5p0nKMfogB4vWGZgRM01d07R/WWIyiA==
X-Received: by 2002:a63:d405:: with SMTP id a5mr27375485pgh.79.1573460499492;
        Mon, 11 Nov 2019 00:21:39 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id l62sm15251440pgl.24.2019.11.11.00.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 00:21:37 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:51:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static
 OPPs again
Message-ID: <20191111082131.ysngb7dfal6fpu2h@vireshk-i7>
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
 <20191018211214.444D32089C@mail.kernel.org>
 <20191021022516.gecunkpahu7okvm5@vireshk-i7>
 <20191028120133.3E85F2086D@mail.kernel.org>
 <CAKohpo=ky8FR4thsuW1xPnZrEW8zgXL0n4e+9rkRE0RLKKk1uQ@mail.gmail.com>
 <20191030143400.1680D20656@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030143400.1680D20656@mail.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-10-19, 07:33, Stephen Boyd wrote:
> I agree a simple refcount_t makes more sense here instead of using a
> kref. That would be clearer.

I was using kref as I wanted to call the cleanup routine when kref
reaches 0. A refcount_t will have the same problem as the warning in
this came from refcount mechanism only (which is used by kref). You
can't increment a refcount_t if it is zero :)

Any other suggestions other than local counting ?

-- 
viresh
