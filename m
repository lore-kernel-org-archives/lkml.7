Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2963AC76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BD820665
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CONRw+ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfGSAy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:54:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43311 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSAy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:54:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so29245323qto.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K31Jec0W2mQbHyXuEIzSZRFeM3U2FIL0QtGmgtdl6yI=;
        b=CONRw+ZDbyL6SigjzXgbs22T5kD96B4YkxXVm2v+BWfBooVj5EHT6qerx928f0yxNs
         mELaZH42520yRXTr07RvgDzpayrKWE32Pdqgh1E2P6oJDnWlzuq72qSyfYR0xM7/jmuy
         UFTsodSQ0aU9yok0aqnHUw/w30/bGKg5sRhoWexAh1R0IuRU+H+MOgD9gXxWqUgjE5y1
         FMQv8iRAzUBW/HGajYme7/QdPLhByxWWiP3SnCOQgg7FZwmz2tAvISx6kmGOaAms+CBd
         f6qubvenbDwLyh6PQxVkRCor+CXncXKtbs6Aw3LKzXBjtJe7EZoZ2NlqpDW0jPr1Kgfy
         SgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=K31Jec0W2mQbHyXuEIzSZRFeM3U2FIL0QtGmgtdl6yI=;
        b=o8zDdhuWHKG19GGgfjIBOO8a6N7VTFSk9Q8mDFmX8k1Sdet2hK9uLoloNHbQvhkUr8
         YRchMzSTJFEzbVBMy1Q621oSE8xMgKmgJoqBW2PQlFqqaQkXKgokGS/WlkPei/I8/SFN
         3nieVJ0Ge3HEZKB4Ywt9ZGYH+bOPlv5cbjun2whSbZYSGaFk7sqD4DvThAF9xqNRBmQn
         RX5eEgY6TYdplgdbexgzzeF+aQgOo9oG7vBOD0/eDBiypd0GMq1oza54Oxm09kXj7UXZ
         lI7xhb6syiT59KWtMatWkkvivWLiRP3XrfaNeltQGReHYxm2LwBwfT9aMnsmW39uwxRu
         wKEg==
X-Gm-Message-State: APjAAAXAlET2o/0JYMF+nVlwP2prYeei/hs7v1gDMFHslVty1IDvrR4m
        dq4g+Uaur5q0i/4hIjNRUoe8JPSPFNm2zQ==
X-Google-Smtp-Source: APXvYqzALV1XPPR4i5aqgRIPRRb+IDBHew//lXaUHh/2wKGi/FH2zhHYKNj2BVqecoPG+aOz3nB1Uw==
X-Received: by 2002:ac8:3378:: with SMTP id u53mr33464649qta.318.1563497668282;
        Thu, 18 Jul 2019 17:54:28 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o71sm12320194qke.18.2019.07.18.17.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 17:54:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: list corruption in deferred_split_scan()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <b38ee633-f8e0-00ee-55ee-2f0aaea9ed6b@linux.alibaba.com>
Date:   Thu, 18 Jul 2019 20:54:25 -0400
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F50D703-FF08-44FA-B1E5-4F8A2F8C7061@lca.pw>
References: <1562795006.8510.19.camel@lca.pw>
 <cd6e10bc-cb79-65c5-ff2b-4c244ae5eb1c@linux.alibaba.com>
 <1562879229.8510.24.camel@lca.pw>
 <b38ee633-f8e0-00ee-55ee-2f0aaea9ed6b@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2019, at 3:12 PM, Yang Shi <yang.shi@linux.alibaba.com> =
wrote:
>=20
>=20
>=20
> On 7/11/19 2:07 PM, Qian Cai wrote:
>> On Wed, 2019-07-10 at 17:16 -0700, Yang Shi wrote:
>>> Hi Qian,
>>>=20
>>>=20
>>> Thanks for reporting the issue. But, I can't reproduce it on my =
machine.
>>> Could you please share more details about your test? How often did =
you
>>> run into this problem?
>> I can almost reproduce it every time on a HPE ProLiant DL385 Gen10 =
server. Here
>> is some more information.
>>=20
>> # cat .config
>>=20
>> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
>=20
> I tried your kernel config, but I still can't reproduce it. My =
compiler doesn't have retpoline support, so CONFIG_RETPOLINE is disabled =
in my test, but I don't think this would make any difference for this =
case.
>=20
> According to the bug call trace in the earlier email, it looks =
deferred _split_scan lost race with put_compound_page. The =
put_compound_page would call free_transhuge_page() which delete the page =
from the deferred split queue, but it may still appear on the deferred =
list due to some reason.
>=20
> Would you please try the below patch?
>=20
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b7f709d..66bd9db 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2765,7 +2765,7 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
>         if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
>                 if (!list_empty(page_deferred_list(head))) {
>                         ds_queue->split_queue_len--;
> -                       list_del(page_deferred_list(head));
> +                       list_del_init(page_deferred_list(head));
>                 }
>                 if (mapping)
>                         __dec_node_page_state(page, NR_SHMEM_THPS);
> @@ -2814,7 +2814,7 @@ void free_transhuge_page(struct page *page)
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         if (!list_empty(page_deferred_list(page))) {
>                 ds_queue->split_queue_len--;
> -               list_del(page_deferred_list(page));
> +               list_del_init(page_deferred_list(page));
>         }
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>         free_compound_page(page);

Unfortunately, I am no longer be able to reproduce the original list =
corruption with today=E2=80=99s linux-next.=
