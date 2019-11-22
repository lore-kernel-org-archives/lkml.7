Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E353C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5E62068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uvxWXcQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfKVOOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:14:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58461 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:14:02 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191122141400euoutp02026697b1a44583321aa9b3e16f907460~ZgZlkUJAt3181131811euoutp02e
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 14:14:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191122141400euoutp02026697b1a44583321aa9b3e16f907460~ZgZlkUJAt3181131811euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574432040;
        bh=koJT0jT6+xu5Q0BETzPpXfosXeXXwgd8qTs28i1q90Q=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=uvxWXcQXjNvzuvxuf+C1kM4U0yrvYL58DCCex7NV0+bAuTFSHpXFy6qmOjDTbETuq
         giwdCv3U4lX3SA/l8X/x25r9Hp649DhP3UL5jRj6Uwzf8ozRl9oLV9zE9sO2CGzCce
         3FBZLARe9J4Be5ASeuI1P+ryjMT4vh1aixq6bfKk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191122141400eucas1p25b152d31c8eec2df76c33062060fa464~ZgZlXRje03060630606eucas1p27;
        Fri, 22 Nov 2019 14:14:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.4A.60698.82DE7DD5; Fri, 22
        Nov 2019 14:14:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191122141359eucas1p12add83d2ac9112cf4692bd3688e150cf~ZgZk3pjzs2484524845eucas1p1N;
        Fri, 22 Nov 2019 14:13:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191122141359eusmtrp25bf0f0ba546441cf75ae277d7fb57e6e~ZgZk2_Na90136501365eusmtrp2O;
        Fri, 22 Nov 2019 14:13:59 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-5a-5dd7ed288230
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8A.09.08375.72DE7DD5; Fri, 22
        Nov 2019 14:13:59 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191122141359eusmtip2f8f90400ce1abd63f8c8646cdca70f1c~ZgZkf7UBs2323523235eusmtip2b;
        Fri, 22 Nov 2019 14:13:59 +0000 (GMT)
Subject: Re: [PATCH v2] tty: serial: samsung: remove variable 'ufstat' set
 but not used
To:     Jiri Slaby <jslaby@suse.com>, Chen Wandun <chenwandun@huawei.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, beomho.seo@samsung.com,
        sw0312.kim@samsung.com, youngmin.nam@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4a5c6729-30f3-bcf1-9092-1ea810324f92@samsung.com>
Date:   Fri, 22 Nov 2019 15:13:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d7a42300-6c67-70c4-4c90-5f05c65c421c@suse.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7oab6/HGpx8ymtx+tM2dosv71Yx
        WTQvXs9mMWXDByaLy7vmsFmcWdzLbjFj8ks2i8UHPrE7cHi0HHnL6rF/7hp2j74tqxg91m+5
        yuLxeZNcAGsUl01Kak5mWWqRvl0CV8bCn+2MBe18FZc+JzUwPuDuYuTkkBAwkfjz4A97FyMX
        h5DACkaJSzPPQTlfGCX2rDzGAuF8ZpR4dOYoM0zLg30z2SASy4Fa9u1khXDeMkq8bX4KViUs
        ECnxenEbG4gtApLoXGQOYrMJGEp0ve0Ci/MK2Ek07VwJZrMIqEr83z4XyObgEBWIlehYngFR
        IihxcuYTFhCbU8BG4un86ewgNrOAvMT2t3OYIWxxiVtP5jOB3CAhsIxdonXjSUaIS10kpr1e
        zQphC0u8Or6FHcKWkfi/E6ahmVHi4bm17BBOD6PE5aYZUN3WEoePX2QFuYhZQFNi/S59iLCj
        xKz1u9hBwhICfBI33gpCHMEnMWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwCRqIHhIPd/xmmsCo
        OAvJm7OQvDYLyWuzEG5YwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzAZnf53/OsO
        xn1/kg4xCnAwKvHwnrhyPVaINbGsuDL3EKMEB7OSCO+e61dihXhTEiurUovy44tKc1KLDzFK
        c7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTCui39m8X2C2hJxvhPpOqvitq4/FhVwT2sN
        sxj3l7rGoxoLgj++n9H2eM+Lf/sEzktNOCxxc88p7Z29LGoiTF7ud+2Whrx6caqARWtip6rV
        3e2xh3Orv3IXaFb+/5Ud8uLo+9Ssw1dsyrQ5DrZPmKjauOSibOoZj6ONqV0zn18x5Y68ryB2
        9pm/EktxRqKhFnNRcSIAjOq33EIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7rqb6/HGiydoG9x+tM2dosv71Yx
        WTQvXs9mMWXDByaLy7vmsFmcWdzLbjFj8ks2i8UHPrE7cHi0HHnL6rF/7hp2j74tqxg91m+5
        yuLxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
        vl2CXsbCn+2MBe18FZc+JzUwPuDuYuTkkBAwkXiwbyYbiC0ksJRRYsYtIYi4jMTJaQ2sELaw
        xJ9rXVA1rxklpn0Fs4UFIiX2X93FCGKLCLxllFi7wraLkQuoppNJ4vGUR+wgCTYBQ4mutxDN
        vAJ2Ek07V4LZLAKqEv+3zwWzRQViJb6v/MQIUSMocXLmExYQm1PARuLp/Olgc5gFzCTmbX7I
        DGHLS2x/OwfKFpe49WQ+0wRGwVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS
        9ZLzczcxAmNs27Gfm3cwXtoYfIhRgINRiYf3xJXrsUKsiWXFlbmHGCU4mJVEePdcvxIrxJuS
        WFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnA+M8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliS
        mp2aWpBaBNPHxMEp1cDId1jbMtZ2tbvWxLPRNmtiL037t3a5bs2qQDuuPTxfD9+Vbtlz9/jE
        6c3mTTc+Vj9wyHg6c6N7waed6jlvfol0l0gXnGefUWz92TF3p3OlwOWLGmLrbhqn7vLzeqrJ
        JFhQe+3Hr6bIrbIpmjpZhy+KNm3d9j4377Sz7K2LO8WkjgTWTFww0X+rEktxRqKhFnNRcSIA
        xeUrkscCAAA=
X-CMS-MailID: 20191122141359eucas1p12add83d2ac9112cf4692bd3688e150cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191122120844eucas1p1be315e7baadf270d2c783a6a81b8ea1b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191122120844eucas1p1be315e7baadf270d2c783a6a81b8ea1b
References: <1574421159-113624-1-git-send-email-chenwandun@huawei.com>
        <1574424258-138975-1-git-send-email-chenwandun@huawei.com>
        <CGME20191122120844eucas1p1be315e7baadf270d2c783a6a81b8ea1b@eucas1p1.samsung.com>
        <d7a42300-6c67-70c4-4c90-5f05c65c421c@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 22.11.2019 13:08, Jiri Slaby wrote:
> On 22. 11. 19, 13:04, Chen Wandun wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/tty/serial/samsung_tty.c: In function s3c24xx_serial_rx_chars_dma:
>> drivers/tty/serial/samsung_tty.c:549:24: warning: variable ufstat set but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> ---
>>   drivers/tty/serial/samsung_tty.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index 83fd516..ab3c7d1 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -546,7 +546,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport);
>>   
>>   static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
>>   {
>> -	unsigned int utrstat, ufstat, received;
>> +	unsigned int utrstat, received;
>>   	struct s3c24xx_uart_port *ourport = dev_id;
>>   	struct uart_port *port = &ourport->port;
>>   	struct s3c24xx_uart_dma *dma = ourport->dma;
>> @@ -556,7 +556,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
>>   	struct dma_tx_state state;
>>   
>>   	utrstat = rd_regl(port, S3C2410_UTRSTAT);
>> -	ufstat = rd_regl(port, S3C2410_UFSTAT);
>> +	rd_regl(port, S3C2410_UFSTAT);
> The question (CCed some samsung people) is whether we have to spend the
> cycles reading the register at all? Does it have side-effects?

Reading this register doesn't have any side effects, so it is safe to 
remove rd_regl(port, S3C2410_UFSTAT) at all in this function. Tested on 
Exynos5422-based OdroidXU3 board.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

