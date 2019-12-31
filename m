Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0B7C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 03:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FA32077B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 03:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLaDuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 22:50:16 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39438 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfLaDuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 22:50:16 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1im8Xu-0005Oc-AF; Mon, 30 Dec 2019 20:50:14 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1im8Xt-0002v1-Dx; Mon, 30 Dec 2019 20:50:14 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        cl@linux.com, cai@lca.pw, akpm@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
        <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
        <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
        <092adc11-7039-9343-7067-0e0199c9dc13@gmail.com>
        <51dd767a-221f-882d-c7f6-45bd0c217a67@nvidia.com>
        <20191218101711.GB21485@dhcp22.suse.cz>
        <0059a598-5726-2488-cd37-b4b7f9b3353e@linux.alibaba.com>
Date:   Mon, 30 Dec 2019 21:49:03 -0600
In-Reply-To: <0059a598-5726-2488-cd37-b4b7f9b3353e@linux.alibaba.com> (Yang
        Shi's message of "Mon, 30 Dec 2019 19:00:43 -0800")
Message-ID: <87lfqtcfyo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1im8Xt-0002v1-Dx;;;mid=<87lfqtcfyo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+uhutDF4Ukz8J1ef+/uLeFxpg4smyiZiY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already on the target nodes
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <yang.shi@linux.alibaba.com> writes:

> On 12/18/19 2:17 AM, Michal Hocko wrote:
>> On Tue 17-12-19 23:36:09, John Hubbard wrote:
>> [...]
>>> diff --git a/man2/move_pages.2 b/man2/move_pages.2
>>> index 2d96468fa..1bf1053f2 100644
>>> --- a/man2/move_pages.2
>>> +++ b/man2/move_pages.2
>>> @@ -191,12 +191,6 @@ was specified or an attempt was made to migrate pages of a kernel thread.
>>>   .B ENODEV
>>>   One of the target nodes is not online.
>>>   .TP
>>> -.B ENOENT
>>> -No pages were found that require moving.
>>> -All pages are either already
>>> -on the target node, not present, had an invalid address or could not be
>>> -moved because they were mapped by multiple processes.
>>> -.TP
>>>   .B EPERM
>>>   The caller specified
>>>   .B MPOL_MF_MOVE_ALL
>>>
>>> ...But I'm not sure if we should change the implementation, instead, so
>>> that it *can* return ENOENT. That's the main question to resolve before
>>> creating any more patches, I think.
>> I would start by dropping any note about ENOENT first. I am not really
>> sure there is a reasonable usecase for it but maybe somebody comes up
>> with something and only then we should consider it.
>>
>> Feel free to add
>> Acked-by: Michal Hocko <mhocko@suse.com>
>>
>> ideally with a kernel commit which removed the ENOENT.
>
> A quick audit doesn't show kernel code or comment notes about ENOENT
> wrongly. The status could be set as ENOENT if the page is not present
> (follow_page() returns NULL), and man page does match what kernel
> does.

Doesn't the function one layer up then consume the ENOENT?

Eric

