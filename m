Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F4921530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="edKs/tC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFULIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:08:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40129 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFULIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:08:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190621110841euoutp018e7e086f3af0045bca9c230e28e7827e~qMh06tcMq2864828648euoutp01E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 11:08:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190621110841euoutp018e7e086f3af0045bca9c230e28e7827e~qMh06tcMq2864828648euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561115321;
        bh=PYvYB4jlbXD7L5rJUgTIrBKgUBZKDmc11MRjrtdc1iE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=edKs/tC2dkeoN2tNVQtwyy8+AB1ACspQ+TuTF9QFdd3qxXPZYaocB/yCaM8XPL6k/
         ShB80tGgYXKV58xClP0TsdH8hePbibXVb46AFNMOk9vFbEF82JjUGdj6g0vYzWjhrJ
         f2hVejPZeuLr5QKvBz2vR5j/v+zi16dgjEYe5tSU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190621110841eucas1p2d780574dd42abd5179866b099d50a484~qMh0oXayg2380823808eucas1p2a;
        Fri, 21 Jun 2019 11:08:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EF.DA.04325.9BABC0D5; Fri, 21
        Jun 2019 12:08:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190621110840eucas1p1aec34b78eac2350995b86009d4300884~qMhz23QDu2778927789eucas1p13;
        Fri, 21 Jun 2019 11:08:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190621110840eusmtrp2ccd2a7951bb3f1f1cd01398e1839dc66~qMhzo2kGb0212802128eusmtrp2v;
        Fri, 21 Jun 2019 11:08:40 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-9b-5d0cbab95ae5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FB.4B.04146.8BABC0D5; Fri, 21
        Jun 2019 12:08:40 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190621110840eusmtip2e6b769a2cb106d236136233df2e35453~qMhzXTGaV3226132261eusmtip2U;
        Fri, 21 Jun 2019 11:08:40 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: s3c-fb: add COMPILE_TEST support
To:     Jingoo Han <jingoohan1@gmail.com>
Cc:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <421308e1-a4b0-f294-e581-79fb4ef811b3@samsung.com>
Date:   Fri, 21 Jun 2019 13:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0662B10864E4DDEC1EC1823CAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGfT1nZ8e1xes0fbAyGBgpflLQ1NBKfyx/+TOqUSsPKm3TNrWs
        JINKW5Jl+TUtJXJ+UY6VHxtlOmlzJEpoZYUoohXh/GATM2rm2VHy3/0+z3Xz3De8NCGu4IXQ
        2eo8RqNWKCWUgOyyrQ5HmS1CeexSc5B0bHmBkra4a/nSwbuLPOmopZ46TMrM+gm+bPKO3Vfm
        MoWmEycEhzIYZXYBo4lJOiPI8nwykLlzxKXbDb/4xUhP6JAfDfgAlFimkA4JaDFuQdDdOU5w
        DzeCodqyjY0LQfvDTt6mpaGmmmK1GDcjaJrncZATgeFZD6lDNB2AU8D4+SrLBOIwKB5xeBkC
        2xFUfh9F7ILCCXC/pM2rRTgJOldm+awm1w0dc43efDvwcZi0GXkc4w+O2hmS1X74FNQ4Hnt5
        AgfDl5kGX07vgW5nvbcC4HI+PJr9uJE6FWzl8ySnA+Cn/SWf07tgzcyaWcNzBH9Lf2y4uxE0
        P/BQHJUIA/b3PLYagcOhwxLDjY+AqcJFsWPA22Hc6c+F2A4VXdUENxZB6S0xR+8Fo8FIbZ7V
        mVuJe0ii31JNv6WOfksd/f+7jYhsQ8FMvlaVyWj3q5mL0VqFSpuvzow+l6MyofWf8s5jX+5B
        vX/OWhGmkUQo6tNvk4t5igJtocqKgCYkgSKhUigXizIUhZcZTc5pTb6S0VrRTpqUBIuu+Eyd
        FONMRR5znmFyGc3m1pf2CylGpokby5F+JVPHWiPfxIe3WyJ8xpNldekp4Qb7waoJT+XXCN2a
        5Vvoi1cJF/hLv21F2F03NGKOix0XpBpWHOqnpvgox8pIUNXRZJfg7fTYqjw7zbK7dtp5s8/d
        lDhf1N/vY1pcsJYWRg30pw32LlOvqWu+ZdefrA4OQ5hmdN8HCanNUsRFEBqt4h/18tbPJQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7o7dvHEGnx/Jm9x5et7NosVX2ay
        W5zo+8BqcXnXHDYHFo+ds+6ye9zvPs7k8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gv+vLWAreMFd0zv/B3sA4i7mLkZNDQsBEYv6M
        6WwgtpDAUkaJSeutuxg5gOIyEsfXl0GUCEv8udYFVMIFVPKaUeLp9O1sIDXCAs4SG27WgNSI
        CKhKNJw/yQpSwyxwnFFiy+V5TBANTxglfvxoYwGpYhOwkpjYvooRxOYVsJPY+v0pO4jNAtS9
        /s0CsINEBSIkzrxfwQJRIyhxcuYTMJtTIEZixsl5YPXMAuoSf+ZdYoawxSVuPZnPBGHLS2x/
        O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBEbTt2M/N
        OxgvbQw+xCjAwajEw3tgFnesEGtiWXFl7iFGCQ5mJRFenhyeWCHelMTKqtSi/Pii0pzU4kOM
        pkDPTWSWEk3OB0Z3Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkG
        xjKzS+Ums0+yef88nKL5kVtnjeFfDZWEup9uQcvnX7XO6TM2D+h8mfbfL3VtjPy62gmqUj/a
        lG8031V9P/e5hNWGNR3p10X33Wi22txz87qVNqvFa7nOlFImNVnb3QJiTF3eK68faT5/9S1z
        j8r7XufcZeKiy29odFz9UeNcPPfDib8rrAN5lFiKMxINtZiLihMBjRGi1bYCAAA=
X-CMS-MailID: 20190621110840eucas1p1aec34b78eac2350995b86009d4300884
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b
References: <CGME20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b@eucas1p1.samsung.com>
        <e771b89b-0e38-a712-b635-8d53cbf95a8e@samsung.com>
        <PSXP216MB0662B10864E4DDEC1EC1823CAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/18/19 8:12 AM, Jingoo Han wrote:
> On 6/14/19, 11:46 PM, Bartlomiej Zolnierkiewicz wrote:
>>
>> Add COMPILE_TEST support to s3c-fb driver for better compile
>> testing coverage.
>>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks, I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
