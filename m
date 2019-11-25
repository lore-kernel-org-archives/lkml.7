Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25580C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89832068F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iGw7/Cej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfKYPbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:31:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43753 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfKYPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:31:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191125153108euoutp010ec037890f39bfc744b661b73e6e421a~acYyu35Lc2047520475euoutp01k
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 15:31:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191125153108euoutp010ec037890f39bfc744b661b73e6e421a~acYyu35Lc2047520475euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574695868;
        bh=zyQApnRr5/uY+OBifPWLgMt43tJ6dLGKcvYE+WFaW0k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iGw7/Cej8iAST/6OSrr1G8ZxDTDsQtYSvI3KiO0E4SBpgmeuUgBgHFnfjNu5wUs6q
         ZJIOiqNlsVRM0qvTen879W1n1JUuZHmAJEtASIyuHwRC6wmeFMZ1e2QhKcVrNnkfvl
         tzktXaPz5SHW75Uwd6ZMC7us4VjYephs8pn5xBHE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191125153108eucas1p24ef93f99b96a7c5235af004772091d46~acYyjofOT0854108541eucas1p2e;
        Mon, 25 Nov 2019 15:31:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9C.1E.60698.CB3FBDD5; Mon, 25
        Nov 2019 15:31:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191125153108eucas1p23b303e27870b77e79260e1ea01ab03f8~acYyQJNaG0854108541eucas1p2d;
        Mon, 25 Nov 2019 15:31:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191125153108eusmtrp168f20da1d257e8c77e5c34570c043e8f~acYyPjVsp0379503795eusmtrp1z;
        Mon, 25 Nov 2019 15:31:08 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-fa-5ddbf3bcea1a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.71.07950.CB3FBDD5; Mon, 25
        Nov 2019 15:31:08 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191125153107eusmtip19b8d155e9ec3d4cea4c3ec1dfed444e1~acYxxUc3_0345503455eusmtip1Q;
        Mon, 25 Nov 2019 15:31:07 +0000 (GMT)
Subject: Re: [PATCH] arm: exynos_config: Restore debugfs support
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5fdca7d0-c130-457a-2ce2-74f645b60f8d@samsung.com>
Date:   Mon, 25 Nov 2019 16:31:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191125093932.4a111dc8@gandalf.local.home>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7p7Pt+ONZh7QsHi/PkN7BaXd81h
        s5hxfh+Txdojd9kt9nU8YLJ4/uosswObx4pFe9k9WvbdYvfYtKqTzaNvyypGj8+b5AJYo7hs
        UlJzMstSi/TtErgyTu2ezViwmqfi5eGfjA2MPzm7GDk5JARMJA4c+cPSxcjFISSwglHi7vWj
        bBDOF0aJuUf/sEI4nxkltvScZ+pi5ABrOfY0F6RbSGA5o0TP/wqImreMEq1Xz7GCJIQFHCQe
        dC5nBrFFBDQkWhY8B1vBLHCUUaJ9xyx2kASbgJXExPZVjCA2r4CdxJ1V89hAbBYBVYmnz16D
        xUUFIiQ+PTjMClEjKHFy5hMWkCM4BSwlDr62BQkzC4hL3HoynwnClpfY/nYOM8guCYF17BJH
        Hj9mg/jTRWLptk+sELawxKvjW9ghbBmJ05N7WKAaGCX+dryA6t7OKLF88j+obmuJw8cvsoJs
        ZhbQlFi/Sx8i7Chx7GITKyRU+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5
        AqPSLCSfzULyziwk78xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYOI5/e/4
        1x2M+/4kHWIU4GBU4uH9cfZ2rBBrYllxZe4hRgkOZiURXrezN2KFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MN5UNXtgGXRxqhvTCtN3LLlr/Kbttg5M
        uqwh/W51KffL7CXR5ap1jm23/k7+f+5LjeU1A765efwq03ekq4tFCU+J5VuSnhm96MUad/45
        cxyNfU/e/PzV79fLm+/v5QkZvvGYG/JXtDFBW+nnnKkPVeQtFXcsZ4z342LaHiJmEOG2sSD7
        AOOUyUosxRmJhlrMRcWJAEjkiCw4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7p7Pt+ONXi+iNfi/PkN7BaXd81h
        s5hxfh+Txdojd9kt9nU8YLJ4/uosswObx4pFe9k9WvbdYvfYtKqTzaNvyypGj8+b5AJYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyTu2ezViw
        mqfi5eGfjA2MPzm7GDk4JARMJI49ze1i5OIQEljKKHHj9U0WiLiMxPH1ZV2MnECmsMSfa11s
        ILaQwGtGid5WZhBbWMBB4kHncjBbREBDomXBcxaQOcwCxxklzp06xggx9CujxMqLm8Cq2ASs
        JCa2r2IEsXkF7CTurJoHNpVFQFXi6bPXYHFRgQiJwztmQdUISpyc+QTsIE4BS4mDr21BwswC
        6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo9AsJN2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6
        xYm5xaV56XrJ+bmbGIFxtu3Yzy07GLveBR9iFOBgVOLh/XH2dqwQa2JZcWXuIUYJDmYlEV63
        szdihXhTEiurUovy44tKc1KLDzGaAv02kVlKNDkfmALySuINTQ3NLSwNzY3Njc0slMR5OwQO
        xggJpCeWpGanphakFsH0MXFwSjUw8l5dmfJ8iq/Eed6f9+U1X/3c2mqrZXt5xdd0bTn/6oMT
        98fNzaueVO6arhaQzfto9vqtJQ9tm+es94hcMvNfXP3015MNHkXfDT++cIdxZw1j51QRdR/D
        OfcvTNGvENo8m8/d6o+i4EFBySsuUQeYGjae333ZS7/aOMtj2/xmob3rmXc8YXDoVGIpzkg0
        1GIuKk4EAPOa+YvJAgAA
X-CMS-MailID: 20191125153108eucas1p23b303e27870b77e79260e1ea01ab03f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191125125531eucas1p17f4044301903eeafe56865ed63738798
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191125125531eucas1p17f4044301903eeafe56865ed63738798
References: <CGME20191125125531eucas1p17f4044301903eeafe56865ed63738798@eucas1p1.samsung.com>
        <20191125125515.30795-1-m.szyprowski@samsung.com>
        <7f6a5924-58f9-aafb-18c5-c749ad355a02@samsung.com>
        <20191125093932.4a111dc8@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/25/19 3:39 PM, Steven Rostedt wrote:
> On Mon, 25 Nov 2019 15:30:39 +0100
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:
> 
>> It seems that commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS
>> dependency") disabled DEBUG_FS also in some other ARM defconfigs.
>>
>> For some of them it may be a correct change but a preferred way to
>> introduce such changes would be to:
>>
>> - add explicit CONFIG_DEBUG_FS=y instances to all affected defconfigs
>>   while removing DEBUG_FS selection from TRACING config item
>>
> 
> I strongly disagree. It was wrong to assume DEBUG_FS is attached to
> TRACING. If someone wanted DEBUG_FS in their def config, they should
> have added it specifically. The addition of DEBUG_FS to defconfigs no

There is a theory and a practice.

In theory you are are correct. ;-)

In practice people don't manually edit configuration files nowadays.

They do 'make menuconfig' and enable what they need and disable what
they do not need.  Then they do 'make savedefconfig' and copy resulting
"stripped" defconfig file as their new platform defconfig. As a result
defconfigs rely on many default settings (also they explicitly disable
only items that are enabled by default but you don't want them).

> way belongs to the patch that removed DEBUG_FS from TRACING.
> 
> -- Steve
> 
> 
>> - let platform maintainers disable DEBUG_FS manually in corresponding
>>   defconfigs later if desirable

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
