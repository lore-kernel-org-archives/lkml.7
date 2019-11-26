Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A508C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F90020659
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qaoh3sUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKZTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:04:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38699 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfKZTEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:04:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id 14so22607464qtf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZK6xorJF4IjiLPkoRU4KWW0BlpCFZncWJvYQZh47BCM=;
        b=qaoh3sUBYt09c9IFsu2KfJdUpPYbqH+ObUm7aqZeeKpxrggEWuDwX8UATKLfHBOtIl
         ErDyEwzHl2wqme31vz80P6GwfK5l5c1F0ReMk/iTqNR3Zuv8bflH5AgPkkXPpdtnycsn
         srBHWLHOG7Ioo0yOQGp8SLs000LOOHYgNnNnE696sTHlDjeW5TcKN24c121jNlJ5paMh
         zg4WeMfVunKpI3wNrug3uRTCCGGGj//jySfmOpjyPl9z6aPlBdCi0tj0w6NKZVAaZjxk
         y3t+pBWYn/saoKAXVm9NJ4s2HXzO4+rTAAHh4xnUGpJVUJc+LqE6JNUDNRMzgs3Mj+eh
         c+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZK6xorJF4IjiLPkoRU4KWW0BlpCFZncWJvYQZh47BCM=;
        b=nsFvPTmPF1BywD8sDXrfZLnulX4vIKFNYRg0UxyDBBhtbTFRdoYuG5npKXZLFPTJ+/
         iwq/6NXkaU6IUDDOA8nAAGZrOyQ190yEVKsQ3nwwMfca9NeqOG93Z39juPMSny87kYrQ
         WCNVgc6TzQjMs3aOpQUfCVhMi1MgfwkOtZS+BdsBYma/fH3EZwEeDq6PigHs70tscx9t
         HfSwl6A/7wwiRtFFdYNalLURMq5UJcgKL4aFMiI/h7V84/AzTqRaG4rFEhWoLivwp9Mf
         zNkI1RbETs9xE8GzJLZ38q3ISqFe4mB32e3O4LpZiFxOtQk0iHI7pMWc4EIr957aSwYA
         Mjxw==
X-Gm-Message-State: APjAAAXfvf0G2ygtPsvGMMUupLUW5Qon120dywCZmgV/Kye2S0Ot77Rg
        Jq1mtGGs5cIrLxHnbfkGcGQuxQ==
X-Google-Smtp-Source: APXvYqx6AnTw16s05bK5rMZmCdoqPd+CvORBoorp4YGZJBX2CUqh9log0dD16gYbuUUFM6ZUSpp74A==
X-Received: by 2002:ac8:7492:: with SMTP id v18mr27893474qtq.282.1574795048058;
        Tue, 26 Nov 2019 11:04:08 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r37sm6412608qtj.44.2019.11.26.11.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 11:04:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191126154101.GJ20912@dhcp22.suse.cz>
Date:   Tue, 26 Nov 2019 14:04:06 -0500
Cc:     Pengfei Li <fly@kernel.page>,
        "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>,
        akpm <akpm@linux-foundation.org>,
        mgorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, cl <cl@linux.com>,
        "iamjoonsoo.kim" <iamjoonsoo.kim@lge.com>, guro <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B426079-6091-4898-8D77-609915C273E8@lca.pw>
References: <20191125083948.GC31714@dhcp22.suse.cz>
 <828BAB69-4B46-418F-A5E2-35B0756340D0@lca.pw>
 <20191126154101.GJ20912@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 26, 2019, at 10:41 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> On Tue 26-11-19 10:30:56, Qian Cai wrote:
>>=20
>>=20
>>> On Nov 25, 2019, at 3:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
>>>=20
>>> People do care about ZONE_MOVABLE and if there is a non-movable =
memory
>>> sitting there then it is a bug. Please report that.
>>=20
>> It is trivial to test yourself if you ever care. Just pass =
kernelcore=3D
>> to as many NUMA machines you could find, an then test if ever =
possible
>> to offline those memory.
>=20
> I definitely do care if you can provide more details (ideally in a
> separate email thread). I am using movable memory for memory hotplug
> usecases and so far I do not remember any kernel/non-movable =
allocations
> would make it in - modulo bugs when somebody might use __GFP_MOVABLE
> when it is not appropriate.
>=20

I don=E2=80=99t think it is anything to do with __GFP_MOVABLE. It is =
about booting a kernel
with either passing kernelcore=3D or movablecore=3D. Then, those =
ZONE_MOVABLE will
have non-movable pages which looks like those from vmemmap_populate(). =
How
do you create ZONE_MOVALBLE in this first place?=20=
