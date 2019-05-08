Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32478C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A2E205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z6LvqpeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEHAZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:25:42 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:25883 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHAZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:25:42 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190508002539epoutp04a0e0444b38295908abb1e71b8104acf5~cjX0tWckH0526805268epoutp044
        for <linux-kernel@vger.kernel.org>; Wed,  8 May 2019 00:25:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190508002539epoutp04a0e0444b38295908abb1e71b8104acf5~cjX0tWckH0526805268epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557275139;
        bh=KOFXNp3YdVudGio3ms3L3EHkZOK4kF38DEZPb5dGSho=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Z6LvqpeJZmgKLQxCECNLAWEaH0OJnQ5MueVJ4pMCPKCKH+Z//9UkYYxJi5QSUcWB0
         FM6kmy6GWviz/6c1wAer/yBzdmVesdFdgntt4M33VCMYXjAvDicMDrRDDT569e8VSv
         gwbIzbWW30GxefxVlsCTAKJGJplqRV1z/2s6GVg0=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.189]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190508002536epcas2p10feb8a852a695e6c6d95c267c9fc95e3~cjXxF55i61873218732epcas2p1F;
        Wed,  8 May 2019 00:25:36 +0000 (GMT)
X-AuditID: b6c32a46-d63ff7000000106f-c7-5cd221fea1bf
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.D4.04207.EF122DC5; Wed,  8 May 2019 09:25:34 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2 6/7] nvme-pci: add device coredump support
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     Keith Busch <kbusch@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Minwoo Im <minwoo.im@samsung.com>
CC:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190507170733.GA6783@localhost.localdomain>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190508002534epcms2p3acacda8460fcfb7f2b978411b74bbbd5@epcms2p3>
Date:   Wed, 08 May 2019 09:25:34 +0900
X-CMS-MailID: 20190508002534epcms2p3acacda8460fcfb7f2b978411b74bbbd5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmue4/xUsxBq87TS1eHehgtPi/5xib
        xcrVR5ksPm74xGIx6dA1Rot7R78wWVzeNYfNYv6yp+wWvzq5LZ6dPsBsse71exYHbo+Jze/Y
        PXbOusvucf7eRhaPxXteMnlsWtXJ5rF5Sb3H7psNbB59W1YxevT3bmPx+LxJLoArKscmIzUx
        JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
        YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BoWGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsbzXduY
        C16wVLzf6dHA+I65i5GTQ0LARGLd5W5GEFtIYAejxNY/2l2MHBy8AoISf3cIg4SFBRwlDq45
        zAgSFhKQl/jxygAirCnxbvcZVhCbTUBdomHqKxYQW0QgX6J7yVamLkYuDmaBe0wSzx91M0Gs
        4pWY0f6UBcKWlti+fCvYTE4BK4mF/0IhwqISN1e/ZYex3x+bzwhhi0i03jsLdbGgxIOfu8Fa
        JQQkJO69s4Mw6yW2rLAA2Soh0MIocePNWqhWfYnG5x/BtvIK+EpsXDwNzGYRUJWY8mMOVI2L
        xPkb09hAbGagD7e/ncMMMpMZ6MX1u/QhxitLHLnFAlHBJ9Fx+C87zE875j2B+k9Z4uOhQ1BH
        Skosv/SaDaLVQ2Lbf1+Qy4QEfjJK3Fv5hXECo8IsRCjPQrJ3FsLeBYzMqxjFUguKc9NTi40K
        jJCjdRMjON1que1gXHLO5xCjAAejEg/vhLyLMUKsiWXFlbmHGCU4mJVEeI32AYV4UxIrq1KL
        8uOLSnNSiw8xmgK9P5FZSjQ5H5gL8kriDU2NzMwMLE0tTM2MLJTEeR9Kz40WEkhPLEnNTk0t
        SC2C6WPi4JRqYDxxQa2m3C3pzNmQ+C4jvrbv8U0CKWt3lFyouOc58+XSUrGEf+zF3ydZV2ys
        ETO6evATR4Mih5+OAHOwc/fHNvWQh+XXH+ZbO8csvsl59byuYtYG/ZhkN8Z9S8rMowqmvZzH
        4PnuQ9ic59IBRzoDPCey6fJYr8r+zNBo3Fdwk/dLlXBa8RcFJZbijERDLeai4kQAdmyF8c0D
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190507171318epcas5p129bb73b39447d62a7d266ed461687488
References: <20190507170733.GA6783@localhost.localdomain>
        <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
        <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
        <CGME20190507171318epcas5p129bb73b39447d62a7d266ed461687488@epcms2p3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a bit of a mine field. The shutdown_lock is held when reclaiming
> requests that didn't see a response. If you're holding it here and your
> telemetry log page times out, we're going to deadlock. And since the
> controller is probably in a buggered state when you try to retrieve one,
> I would guess an unrecoverable timeout is the most likely outcome.

Akinobu,

I actually agree with Keith's one.  In my experience, there was always internal
error inside device when timeout occurs in nvme driver which means the
following command might not be completed due to lack of response from
device.
