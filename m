Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99763C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729BC20678
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="L2KfYkOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfKZPa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:30:59 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34758 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfKZPa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:30:59 -0500
Received: by mail-qt1-f173.google.com with SMTP id i17so21846784qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=/g4ZXLwK+A/FE8q6bxvvagQJw9r1wy5JryPpTD2bgYs=;
        b=L2KfYkORncPtySaCDV3j8U8ZveUxn1I4iVZHqEOd+98M22E+2ApAL/khtMjrwFYjcN
         4iYqiXfoME0FEHXuiWXmE+khHzryThZwqUf/+15aJXF3OL9plyGRDdt01ZoR+nzZkWUD
         79Fb99TyHE/3j7vjuvBiwAibbddIr2qCEQxPIwWTtzu8M3ecgKUeORIIzoOcOyrS1kU6
         qXK2+fXwS+H+likVr1enJ+kqPg48VlRqP9oYZJwIlYe0QL7mgaZQH8k1ARfYCkFuyXvA
         CsbGXt2EudbU3g3w/ZTk0zn0rYGScPi40zofpuVrzl1RYAy9FOMU+LjhoMERgQhHnJ7g
         gu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=/g4ZXLwK+A/FE8q6bxvvagQJw9r1wy5JryPpTD2bgYs=;
        b=HWszbhjz7Dx5/snBGqi55pednUCULIzROd3OSAjzkry9XvZfdPitMXz8xxO6VnxGyw
         E5r9QQIuB/yEkh1xKH09Y15SIbyLHfQX1nMS/I9YsZ90mI6IhJNwRPQvXyGsC+YjeqVa
         dExJZPq9jUZ3Ts4WSvvuCPEb7oOJRYYbntenhs0zd9oWuc2kgnfxTfAvgTFgfW9KeWFQ
         tWiVHp1TurtKgpKGmPHBLbfQENbqVEd3NPrzSoCoNZ7scWSpKejaNtoj17x8io5SD7dD
         SqNrKq2RaEEBsywpJNBXsi9JXaEVo0TAfUPoXOp/YzB8pYqjprVdjAj3L40p/rOz6XXp
         Ajww==
X-Gm-Message-State: APjAAAWNkTofckPTKv+aHM05xEJMdb9jvMApW+4Rn5TVKbh7Xy2bjFoE
        6S8g1q1DSxEnWv76XdlDGy1i+Q==
X-Google-Smtp-Source: APXvYqyu3mbNFY1nQkQM19sadjdPy7gEJM5B0DZYlRvW5Ab3B0SS/OSkFigbO/5R6HLQ2R54qMbMCA==
X-Received: by 2002:ac8:610d:: with SMTP id a13mr31421605qtm.21.1574782258240;
        Tue, 26 Nov 2019 07:30:58 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r4sm6010520qtd.17.2019.11.26.07.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 07:30:57 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Date:   Tue, 26 Nov 2019 10:30:56 -0500
Message-Id: <828BAB69-4B46-418F-A5E2-35B0756340D0@lca.pw>
References: <20191125083948.GC31714@dhcp22.suse.cz>
Cc:     Pengfei Li <fly@kernel.page>,
        "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>,
        akpm <akpm@linux-foundation.org>,
        mgorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, cl <cl@linux.com>,
        "iamjoonsoo.kim" <iamjoonsoo.kim@lge.com>, guro <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
In-Reply-To: <20191125083948.GC31714@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 25, 2019, at 3:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> People do care about ZONE_MOVABLE and if there is a non-movable memory
> sitting there then it is a bug. Please report that.

It is trivial to test yourself if you ever care. Just pass kernelcore=3D to a=
s many NUMA machines you could find, an then test if ever possible to offlin=
e those memory.=
