Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCCB20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lnwho8bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCDJDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:03:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60987 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:03:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190304090331euoutp027b29da6a7bdf9cacf15f78494fb86bfd~ItgaUrmSQ1539615396euoutp02U
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 09:03:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190304090331euoutp027b29da6a7bdf9cacf15f78494fb86bfd~ItgaUrmSQ1539615396euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551690211;
        bh=nwOumAwPcP7vlmwx+ohrkmuipfj4cLo/fD6g7NCCVkQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lnwho8bcC5uv5PdCWgHmU+odBfL58FtOsOO59iRRcEWPV9aN9bOE5Dc887Ww5PQVz
         70Ylb5VIPlUxKXavDqMy9Q4/sAtuZKDv/4Rrm8VkCtm8lqnL5QGjilU8249FCiWbnf
         vvYmBioeL8q2bSNNh2x4mxMYuqiphcSaH2yrOupg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190304090330eucas1p1a0507a7e7436c967da95d4744e2c70bf~ItgZrN32m2302123021eucas1p1Z;
        Mon,  4 Mar 2019 09:03:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 47.2F.04806.2E9EC7C5; Mon,  4
        Mar 2019 09:03:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190304090329eucas1p2ff0ead1486d09d059765fe793a0c99b9~ItgY3o8LL3164731647eucas1p2h;
        Mon,  4 Mar 2019 09:03:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190304090329eusmtrp1d10041107e1de7108f82ebb3a6bead32~ItgYpP-8S1359313593eusmtrp16;
        Mon,  4 Mar 2019 09:03:29 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-5f-5c7ce9e22f93
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.D8.04128.1E9EC7C5; Mon,  4
        Mar 2019 09:03:29 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190304090328eusmtip28ecc1c5c814a25428a5ae8772e9d6acf~ItgYMKZcv2720727207eusmtip2U;
        Mon,  4 Mar 2019 09:03:28 +0000 (GMT)
Subject: Re: [PATCH 4.20 12/88] usb: dwc3: gadget: synchronize_irq dwc irq
 in suspend
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "He, Bo" <bo.he@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wang, Yu Y" <yu.y.wang@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a3d017c7-d671-3ba9-15d6-0028595d5d59@samsung.com>
Date:   Mon, 4 Mar 2019 10:03:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304085350.GA18354@kroah.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7qPXtbEGOxbz2xx5+lLFov5N5Ms
        mhevZ7O4vGsOm8WmNdfYLBZsfMRose3kNxYHdo/Fe14yeWxa1cnmMe9koMf+uWvYPT5vkgtg
        jeKySUnNySxLLdK3S+DK2Dl5N3vBBLaKVSvUGhjfs3QxcnJICJhIvHsxnR3EFhJYwSix9QVH
        FyMXkP2FUeLAqrlsEM5nRonGO02MMB3Pl+9hhkgsZ5R4dPoHO4TznlHiVNMLZpAqYYFwiVtn
        Z4DNFREIlLj7uResiFngDaPEpy/XwRJsAoYSXW+72EBsXgE7iZUvW8GOYhFQkTg9cTbQOg4O
        UYEYiUOLyyBKBCVOznwCVsIpoC+xc3cnWCuzgLzE9rdzmCFscYlbT+YzgeySEFjHLtH27AMz
        xNkuEg/mbod6QVji1fEt7BC2jMTpyT0sEA3NjBLtM2axQzg9wNCYs4MNospa4vDxi6wgFzEL
        aEqs36UPEXaUaFx8hQUkLCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuXmCcw
        Ks1C8tosJO/MQvLOLIS9CxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSmn9P/jn/d
        wbjvT9IhRgEORiUeXgOVmhgh1sSy4srcQ4wSHMxKIrzOd4FCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGFPKVIQkHqdyu+3han5c/comtsxx5/rGSl7B
        /T9v/vXdKnRh+19Rn++VhQvD5RcEHJn2akd5YWWM847zabGT7K4n9eixTfhj8ct5+ROfTzEt
        H/VjT52fr7nzysRFB/KPfl98uE493OrFrrLJIttl8zaF/pd+niT4MDKBJU7vtWzwtsVJN01y
        dJVYijMSDbWYi4oTARrza407AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7oPX9bEGHz+yWpx5+lLFov5N5Ms
        mhevZ7O4vGsOm8WmNdfYLBZsfMRose3kNxYHdo/Fe14yeWxa1cnmMe9koMf+uWvYPT5vkgtg
        jdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL2Dl5
        N3vBBLaKVSvUGhjfs3QxcnJICJhIPF++h7mLkYtDSGApo8TUMxsYIRIyEienNbBC2MISf651
        sUEUvWWUmLRsJTtIQlggXOLIzYNMILaIQKBES/cqFpAiZoE3jBKvPzRBjV3HJDF971awDjYB
        Q4mutyCjODl4BewkVr5sBbuDRUBF4vTE2WCrRQViJD7cvcEEUSMocXLmE7AaTgF9iZ27O8F6
        mQXUJf7Mu8QMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN
        9IoTc4tL89L1kvNzNzECY27bsZ9bdjB2vQs+xCjAwajEw2ugUhMjxJpYVlyZe4hRgoNZSYTX
        +S5QiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OB6SCvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFl
        lJBAemJJanZqakFqEUwfEwenVAOj+u2PJn9n7/At4Sr33eCce6px2TeF+ZLm9b3FMZ90Ty3a
        uCXzGcPGHap68orsadqKfAaV1+2tz1f2bTS3zWEvnbB8/725U3/u9m3bF7FUgX3W1T0rDnws
        U7pe8O6bqb8qA9fiU0un8/jXdPy99/toG1tqXq3pp47d5snnsyZ+YDygPWnj0quhSizFGYmG
        WsxFxYkAwpoZJc8CAAA=
X-CMS-MailID: 20190304090329eucas1p2ff0ead1486d09d059765fe793a0c99b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190304085654epcas2p1284f13532438678e8ba53d232ca02a34
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190304085654epcas2p1284f13532438678e8ba53d232ca02a34
References: <20190304081630.610632175@linuxfoundation.org>
        <20190304081631.046461963@linuxfoundation.org>
        <CD6925E8781EFD4D8E11882D20FC406D52A5C632@SHSMSX104.ccr.corp.intel.com>
        <CGME20190304085654epcas2p1284f13532438678e8ba53d232ca02a34@epcas2p1.samsung.com>
        <20190304085350.GA18354@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2019-03-04 09:53, Greg Kroah-Hartman wrote:
> On Mon, Mar 04, 2019 at 08:46:30AM +0000, He, Bo wrote:
>> Hi, Greg:
>> 	Marek Szyprowski report the patch has issue that calling synchronize_irq() under dwc->lock spinlock, he has upload the below patch for the issue:
>>
>> dwc3_gadget_suspend() is called under dwc->lock spinlock. In such context calling synchronize_irq() is not allowed. Move the problematic call out of the protected block to fix the following kernel BUG during system
> <snip>
>
> Is this patch in Linus's tree yet?  If so, what is the git commit id?
>
> If not, is this also an issue in 5.0?

The fix has not been merged yet. The issue is also present in v5.0.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

