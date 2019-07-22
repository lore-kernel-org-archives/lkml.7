Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A41C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46DF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hocfqtSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfGVNxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:53:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51140 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfGVNxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:53:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722135303euoutp02d2a2a6138a6c791d2fa2f3360c712e2c~zvxLvlJU-0540605406euoutp02n
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722135303euoutp02d2a2a6138a6c791d2fa2f3360c712e2c~zvxLvlJU-0540605406euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563803583;
        bh=+3Tk5iOm0W8JTrOZ9SZseZOnDzDIJpQ/TXOX8kSrdoM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hocfqtSLdVtdb2QdoYbroYl+heWxAt5OEryMZfJyLAO+IHgstdynpaO858P4Fzea5
         4J9CmLADZIXX0GTNrw/ec8w88l8Nw6AkRHH56NSzb+qYbhLPFats296yq/u/M+Y5m9
         PagsTEjuHWcr/wHJlYA60XxDcqGqHJGriIcmmX1g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190722135302eucas1p139956bc07fe600afda0a47e37a1c3284~zvxKx6Xc_1319113191eucas1p1c;
        Mon, 22 Jul 2019 13:53:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.63.04325.EBFB53D5; Mon, 22
        Jul 2019 14:53:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190722135301eucas1p2190b3f28552030bbf267dc9963059ddc~zvxJ4X6Cy1061410614eucas1p2h;
        Mon, 22 Jul 2019 13:53:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190722135301eusmtrp17b1d49a54131d28f1ebda2550054bf25~zvxJp-FDe2902729027eusmtrp1Q;
        Mon, 22 Jul 2019 13:53:01 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-5b-5d35bfbe93e2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 40.5C.04140.DBFB53D5; Mon, 22
        Jul 2019 14:53:01 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722135301eusmtip2c6e087dac5a78ef9e173e306f366c339~zvxJVpDHE3197731977eusmtip23;
        Mon, 22 Jul 2019 13:53:01 +0000 (GMT)
Subject: Re: [PATCH] fbdev: Ditch fb_edid_add_monspecs
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tavis Ormandy <taviso@gmail.com>, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8d925bb9-0769-bc1a-20df-a7fa33e84bae@samsung.com>
Date:   Mon, 22 Jul 2019 15:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiaHB_0bS_x=p-xeyp7bW7bGgkZ9QkXe6SS9axu7OP95w@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87r79pvGGiyeJGax8OFdZovlZ9Yx
        W1z5+p7N4kTfB1aLy7vmsFksa57PaPGo7y27A7vH3m8LWDx2zrrL7rF4z0smjxMzfrN43O8+
        zuTxeZNcAFsUl01Kak5mWWqRvl0CV0b3lkVMBXeYKl7um8vewDiZqYuRk0NCwETi6PM37F2M
        XBxCAisYJc7MeMEG4XxhlOiY9RHK+cwose9pMzNMy+WPJ9lBbCGB5YwS8x5VQhS9ZZTYe+Q8
        WJGwgJnEjMs3WUFsEYEYiWW7VzCCFDELHGOUmHymlwUkwSZgJTGxfRUjiM0rYCfR39gJ1MzB
        wSKgKvHptg1IWFQgQuL+sQ2sECWCEidnPgFr5RQIlHgzaSkbiM0sIC5x68l8JghbXmL72znM
        ILskBPaxS7zf9YcdZKaEgIvE1D9WEA8IS7w6voUdwpaROD25hwWifh2jxN+OF1DN2xkllk/+
        xwZRZS1x+PhFVpBBzAKaEut36UOEHSUWzr7DBDGfT+LGW0GIG/gkJm2bzgwR5pXoaBOCqFaT
        2LBsAxvM2q6dK5knMCrNQvLZLCTfzELyzSyEvQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXr
        JefnbmIEJqPT/45/3cG470/SIUYBDkYlHt4Ne0xjhVgTy4orcw8xSnAwK4nw5hkAhXhTEiur
        Uovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTDWnpwf/OjdigZV1gUS
        kubzcuUEGURCmm+sel9h4SLduSAq6qbmtn47nbs6i2Qyt8pyGBVqvn4yvZI9+8PRd/ckt793
        ypO0uy5j9bD1qDVfz8PuqjnTWm5PDlI8oOT9/kO6oPa5NWLq1Yn+taf//c187mhguXaKwWd3
        lgcrFvKy9/fmVTWknFJiKc5INNRiLipOBADarBCQQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7p795vGGjSslbRY+PAus8XyM+uY
        La58fc9mcaLvA6vF5V1z2CyWNc9ntHjU95bdgd1j77cFLB47Z91l91i85yWTx4kZv1k87ncf
        Z/L4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI
        3y5BL6N7yyKmgjtMFS/3zWVvYJzM1MXIySEhYCJx+eNJ9i5GLg4hgaWMEsvWLAdKcAAlZCSO
        ry+DqBGW+HOtiw2i5jWjxKMf25hBEsICZhIzLt9kBbFFBGIk7l79DDaIWeAYo0R/2xeojiuM
        Eptmz2cBqWITsJKY2L6KEcTmFbCT6G/sZAbZxiKgKvHptg1IWFQgQuLM+xUsECWCEidnPgGz
        OQUCJd5MWsoGYjMLqEv8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjEKzkLTPQtIyC0nLLCQtCxhZ
        VjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG37ZjP7fsYOx6F3yIUYCDUYmHd8Me01gh1sSy
        4srcQ4wSHMxKIrx5BkAh3pTEyqrUovz4otKc1OJDjKZAv01klhJNzgemhrySeENTQ3MLS0Nz
        Y3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYzNvMGp0tKrsyeYTOvr3ywmcdVsqbxk
        nVkLqwWX9s6jZhMnPV4puebN2XMnF0nePSvHabChb/LEw96H3JmMN1k5Gh5Uid0pef/SX+Hn
        pef+6D0XW28j1hO996OE3y8J5d/zJS8f6JaoaX0TaKvBtNd+Cf+bz3efM21Y8WC+WqnN/pLd
        Gnv7G0KUWIozEg21mIuKEwHCwBB01QIAAA==
X-CMS-MailID: 20190722135301eucas1p2190b3f28552030bbf267dc9963059ddc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190721203902epcas2p22e8ac33f84bcfb1a414c02d6c8770d91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190721203902epcas2p22e8ac33f84bcfb1a414c02d6c8770d91
References: <20190721201956.941-1-daniel.vetter@ffwll.ch>
        <CGME20190721203902epcas2p22e8ac33f84bcfb1a414c02d6c8770d91@epcas2p2.samsung.com>
        <CAHk-=wiaHB_0bS_x=p-xeyp7bW7bGgkZ9QkXe6SS9axu7OP95w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/21/19 10:38 PM, Linus Torvalds wrote:
> On Sun, Jul 21, 2019 at 1:20 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>>
>> It's dead code ever since
> 
> Lovely. Ack.

Good catch indeed.

Thanks Daniel, I'll queue it for v5.4 later.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
