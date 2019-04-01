Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7919DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFD620840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JWkJ29Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfDAOmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:42:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52118 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:42:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401144203euoutp01ab54a19f50e774448908744c5416fb09~RYL-QO2PN0567105671euoutp01p
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 14:42:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401144203euoutp01ab54a19f50e774448908744c5416fb09~RYL-QO2PN0567105671euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554129723;
        bh=j+C/Esus3gaQopFHRe8OcCAYob/8oH3wlVbHRGyHUfs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JWkJ29Nnf1FtMOfEQxV685VMxSgJG/me7cLl4AfbFkNzGeXmuYiVB0QeitrjqR8/l
         IqVXLtqpDSybYcuWMBg5nWRFiFUKLJytmckQSYtQBO1/2N9Jx0fBhIRUgCWcPM1Q+/
         LNduoROenzmoXNlyJziQ+mzNE5OlBebeN+lt8BU0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401144202eucas1p28e1c48bbb46b64e7a44e436da832cc73~RYL_phjSA2573925739eucas1p2M;
        Mon,  1 Apr 2019 14:42:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3B.3C.04325.A3322AC5; Mon,  1
        Apr 2019 15:42:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401144201eucas1p2a0a3ae3c7424596a4cba0f57f4864ab0~RYL94OnOy2575925759eucas1p2K;
        Mon,  1 Apr 2019 14:42:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401144201eusmtrp2f751ad8c756eb19157f3cd5f66a76f7a~RYL9qHszA1427614276eusmtrp2D;
        Mon,  1 Apr 2019 14:42:01 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-d6-5ca2233aef0f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.D1.04140.93322AC5; Mon,  1
        Apr 2019 15:42:01 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190401144201eusmtip1ec49d7056d24d7c02c0628414b4dd1ac~RYL9S_8sq1774117741eusmtip1L;
        Mon,  1 Apr 2019 14:42:01 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: fix potential NULL pointer dereferences
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Finn Thain <fthain@telegraphics.com.au>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d4e4253a-05e8-c857-1632-8dc3a4040ca9@samsung.com>
Date:   Mon, 1 Apr 2019 16:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190314073319.23209-1-kjlu@umn.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7pWyotiDL5dkrC48vU9m8XE3qUs
        Fs2L17NZnJh3lt3iRN8HVovLu+awWSxe/pPR4v+eHewOHB6bVnWyeeyfu4bd4373cSaPZwcf
        snpcXdjE7vF5k1wAWxSXTUpqTmZZapG+XQJXxsRj75kLNjNXHNm6jbGB8SlTFyMnh4SAicSR
        91NZuxi5OIQEVjBKbNt0hg3C+cIoMe3HIkYI5zOjxN1/+9lhWj70bGMEsYUEljNKfFkUBlH0
        llFizsXnrCAJYQEviWktj1hAbBEBWYmPNx+CjWUWeM8osfbXCbBuNgEriYntq8BsXgE7iW03
        m8COYhFQkTi+9zHQIA4OUYEIif4z6hAlghInZz4Bm8kpYCRxc+oFsIOYBQwkjiyawwphy0ts
        fzuHGWSXhMA2donPF+6wQFztIrG8u58NwhaWeHV8C9Q3MhL/d85ngmhYxyjxt+MFVPd2Ronl
        k/9BdVhLHD5+kRXCdpQ4+rqdHeQ6CQE+iRtvBSE280lM2jadGSLMK9HRJgRRrSaxYdkGNphd
        XTtXMkPYHhLzzyximsCoOAvJb7OQ/DMLyT8LGJlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn
        525iBCah0/+Of93BuO9P0iFGAQ5GJR5eDvFFMUKsiWXFlbmHGCU4mJVEeM/0L4gR4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwHjZctrW/6Jr3DivHnGd
        FfUmIUN22uHYdK6ZQZ+SF59257RZVCl/N6dK62TZO+8rRk0t/v+52dZPvPAlJnunUKrK98Lv
        G4tm/q0NX5EivW72c/Hl2qwN/3huPdt7/2rxuiamTo59lx/Nlwzwfvv2T5dQ/fnAyGNLptj7
        7FgdsPX1n5P2O+R0371RYinOSDTUYi4qTgQASkWdeD4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7qWyotiDM4vVrO48vU9m8XE3qUs
        Fs2L17NZnJh3lt3iRN8HVovLu+awWSxe/pPR4v+eHewOHB6bVnWyeeyfu4bd4373cSaPZwcf
        snpcXdjE7vF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJexsRj75kLNjNXHNm6jbGB8SlTFyMnh4SAicSHnm2MXYxcHEICSxklXr05w97F
        yAGUkJE4vr4MokZY4s+1LjYQW0jgNaPE0TfyILawgJfEtJZHLCC2iICsxMebD9kg5rQySqx9
        2gQ2lFngI6NEZ+NUVpAqNgEriYntqxhBbF4BO4ltN5vArmARUJE4vvcxWI2oQITErYcdLBA1
        ghInZz4BszkFjCRuTr3ADmIzC+hJ7Lj+ixXClpfY/nYO8wRGwVlIWmYhKZuFpGwBI/MqRpHU
        0uLc9NxiI73ixNzi0rx0veT83E2MwMjaduznlh2MXe+CDzEKcDAq8fBGCC2KEWJNLCuuzD3E
        KMHBrCTCe6Z/QYwQb0piZVVqUX58UWlOavEhRlOgJyYyS4km5wOjPq8k3tDU0NzC0tDc2NzY
        zEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUAyOT7yW5dvkdj+/vfcJWw1w/VWDBVSvToB0l
        0dJqEs3bAuQbuUpebn8o3BuhPbd0cuz2t7NZLSwDTiutzgsrO6Zwc9UctgaulT1v0nzPaORK
        b6+1XfD0pXPP1pIHbnLVbWfyXDIL6i59PbtjaYZjQ+jr/rk9ks9Nty7XErkVOUVpU9iDoEtM
        35VYijMSDbWYi4oTATnPeJjCAgAA
X-CMS-MailID: 20190401144201eucas1p2a0a3ae3c7424596a4cba0f57f4864ab0
X-Msg-Generator: CA
X-RootMTR: 20190314073330epcas5p3ac243599bdd87be63b94f9d75b396a9e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190314073330epcas5p3ac243599bdd87be63b94f9d75b396a9e
References: <CGME20190314073330epcas5p3ac243599bdd87be63b94f9d75b396a9e@epcas5p3.samsung.com>
        <20190314073319.23209-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/14/2019 08:33 AM, Kangjie Lu wrote:
> In case ioremap fails, the fix releases resources and returns
> -ENOMEM to avoid NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Patch queued for v5.2 with minor change in the patch summary
("video: imsttfb: fix potential NULL pointer dereference"), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
