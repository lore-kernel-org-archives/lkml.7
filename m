Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D65C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DB120B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G7woC0Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfEMHl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:41:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40110 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfEMHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:41:26 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190513074123epoutp03133422c672c2a5895d66d832583cae10~eLislOLPz0548805488epoutp03P
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:41:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190513074123epoutp03133422c672c2a5895d66d832583cae10~eLislOLPz0548805488epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557733284;
        bh=Ly2+CtUHlh9VKjJj5l7H9wZwvMbrXkQCopgrlQk7ffs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=G7woC0Qo4Zmvk6B3dAIOXdlwmY9gTDZSbpknpPWLk4Ai2OEBk/sjsqvrSqIHT/Fii
         gAv6zxsVLPWqq/I+ixGKXFVGQKylBWetU/ohW0b25CHtt8MtB2gUWWG4aAMd8GVdi5
         TVBxhWl4is9ALdvRVDSuI+QgrTQy34dKvYjtvD4Q=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.187]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190513074121epcas2p297d091ace7c5acb260a258db1aeff786~eLiqBrZVm0996009960epcas2p23;
        Mon, 13 May 2019 07:41:21 +0000 (GMT)
X-AuditID: b6c32a47-133ff7000000106e-a1-5cd91fa15cff
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.EA.04206.1AF19DC5; Mon, 13 May 2019 16:41:21 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v3 6/7] nvme-pci: trigger device coredump on command
 timeout
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minwoo Im <minwoo.im@samsung.com>
CC:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190513074120epcms2p54e3a031668274ac1ebace6c5edc0a3f7@epcms2p5>
Date:   Mon, 13 May 2019 16:41:20 +0900
X-CMS-MailID: 20190513074120epcms2p54e3a031668274ac1ebace6c5edc0a3f7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmhe5C+ZsxBi//c1i8OtDBaPF/zzE2
        i5WrjzJZfNzwicXi3tEvTBaHPrlYXN41h81i/rKn7Ba/Orktnp0+wGyx7vV7Fgduj4nN79g9
        ds66y+5x/t5GFo/Fe14yeWxeUu+x+2YDm0ffllWMHv2921g8Pm+SC+CMyrHJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgaFigV5yYW1yal66XnJ9rZWhgYGQKVJmQk7H/72HWgk/MFXPv
        9zI1MK5n7mLk5JAQMJFYd+wnWxcjF4eQwA5GibNnzwAlODh4BQQl/u4QBqkRFgiS+PR6FztI
        WEhAXuLHKwOIsKbEu91nWEFsNgF1iYapr1hAbBGB1YwSry5ZgIxkFljDJHHp5GdWiF28EjPa
        n7JA2NIS25dvZQSxOQXcJHqebGGHiItK3Fz9Fs5+f2w+I4QtItF67yzUzYISD37uZgS5R0JA
        QuLeOzsIs15iywqwtRICLYwSN96shWrVl2h8/pEF4itfiZ8HBUHCLAKqEjP2bmeDKHGR2Ljz
        Flg5M9CH29/OAQcCM9CL63fpQ0xXljhyiwWigk+i4/Bfdpifdsx7wgRhK0t8PHQI6kZJieWX
        XkNN95BouzmRCRLGJxklvi6fxziBUWEWIphnIVk8C2HxAkbmVYxiqQXFuempxUYFxsgxu4kR
        nGi13Hcwbjvnc4hRgINRiYd3x5MbMUKsiWXFlbmHGCU4mJVEeKMUgUK8KYmVValF+fFFpTmp
        xYcYTYH+n8gsJZqcD8wCeSXxhqZGZmYGlqYWpmZGFkrivJu4b8YICaQnlqRmp6YWpBbB9DFx
        cEo1MM54t/7y3YBju3ksM984v15UcP30/S6Pb7tZt5zPXeUwt5zNJfjgnl9Bi89k+1zUa8j4
        tyK+oKNiZ94LU9EbJ17Ni1tnXV+S0akp0SDAKeXcerAoUPCp5RyTJJXuC/O4ze+tMbBZPrls
        Q4yIYFx40qQ0ab+vZyZ0PV+hcCfZakKM/+eUKy6LLJVYijMSDbWYi4oTAd2nc+TKAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190512155533epcas4p110edff15ebf5b2efae32e43f0f10ab59
References: <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
        <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
        <CGME20190512155533epcas4p110edff15ebf5b2efae32e43f0f10ab59@epcms2p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void __maybe_unused nvme_coredump_init(struct nvme_dev *dev);
> -static void __maybe_unused nvme_coredump_logs(struct nvme_dev *dev);
> -static void __maybe_unused nvme_coredump_complete(struct nvme_dev
> *dev);
> +static void nvme_coredump_init(struct nvme_dev *dev);
> +static void nvme_coredump_logs(struct nvme_dev *dev);
> +static void nvme_coredump_complete(struct nvme_dev *dev);

You just have added those three prototypes in previous patch.  Did I miss
something here?
