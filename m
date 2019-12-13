Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C61C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217B0206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkJUDoxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLMVhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:37:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39369 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:37:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id e10so233002ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 13:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6Cel1cpD0Jtu0AycJ47huuRD/DgMmGpodkanI6OR1bo=;
        b=BkJUDoxm4UTj76qbb34bMW8fVbz7oLUiI7HX3/57fDHmH3Uv+GHq3VcDR+vHKaAg5U
         MRvB2yJVN7+A61+KCixPlGkUzaVMQiuVTIlI172XVT5x+S7mtRuVBdgZMlZ52VvAd6w5
         8DS69v4jrJn0jMy9a5+r0cCy2lYUVl4XLKLiepprazD+qKqkNHo0ECt0YCpdRVGTyHz4
         VjAzgEPu/D/m8aE66lLDO+FNBU7D7ZHpuDWXX8Fl352r0ij5bbjS4FbTOJxn+TYzVZO7
         Bj3w9oapQScyHyiAMtgvC+M5Mq1e2F52BG03GzWhSggUR+7xTx4IhJagsXPmx1ye6JJI
         O/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Cel1cpD0Jtu0AycJ47huuRD/DgMmGpodkanI6OR1bo=;
        b=DCUpTKZREb5B4GfJ/KIf6MBaTjbxUjZuvq7BlX4KHzREodFhE0ocd2OBNWulKeeGJk
         uVB6DKumpDNdmNgkYX7oeE3w1KFeUQkyMukL8JAkVgeRAzW9z0YhLyETGuzRKXJ+wJdA
         qQ9YLHhkPmzJ6oqH+PxFeeBZdxJpyWaeFndsxcvEYnyyuwfaL3FryvlALZ12SKsauz14
         ZmfX8c0r0m/7q0MZiqml085kMfUEV4ZxnIuARROLTKNfP6GMhuPbn2bVo+rfLSQumpG7
         JwWfiTzlF1jPQbG4mNXwhH2PyIDVhAn/5dxumZ0ieQLeGRS/350VEqLUO5mELTOx0Csh
         GrFg==
X-Gm-Message-State: APjAAAV9/jRidtaUDcgKOS29B9/t8TM9JGrLLa1bInE+Kyrw5/0SzCRC
        m+mhQ5OYALK8DHgDLiq3nK4=
X-Google-Smtp-Source: APXvYqxsM40YoG7z6ZiJtPbz7asvMlxZ1g3vpJyflgNEYbZa2GiRD4WWokcH+Epr1Can0FbY1J66HQ==
X-Received: by 2002:a2e:165c:: with SMTP id 28mr10631069ljw.247.1576273048447;
        Fri, 13 Dec 2019 13:37:28 -0800 (PST)
Received: from [192.168.68.108] (115-64-122-209.tpgi.com.au. [115.64.122.209])
        by smtp.gmail.com with ESMTPSA id z7sm5774631lfa.81.2019.12.13.13.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 13:37:27 -0800 (PST)
Subject: Re: [PATCH v3 1/3] kasan: define and use MAX_PTRS_PER_* for early
 shadow tables
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com
References: <20191212151656.26151-1-dja@axtens.net>
 <20191212151656.26151-2-dja@axtens.net>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <37872cba-5cdf-2e28-df45-70df4e8ef5af@gmail.com>
Date:   Sat, 14 Dec 2019 08:37:20 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212151656.26151-2-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/19 2:16 am, Daniel Axtens wrote:
> powerpc has a variable number of PTRS_PER_*, set at runtime based
> on the MMU that the kernel is booted under.
> 
> This means the PTRS_PER_* are no longer constants, and therefore
> breaks the build.
> 
> Define default MAX_PTRS_PER_*s in the same style as MAX_PTRS_PER_P4D.
> As KASAN is the only user at the moment, just define them in the kasan
> header, and have them default to PTRS_PER_* unless overridden in arch
> code.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Suggested-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir
