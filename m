Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B1ECA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE56521928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="APN3kNGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfKEEt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 23:49:26 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:28592 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfKEEt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:49:26 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191105044924epoutp041cd29e6e6a97b14197086ca6b879fa86~UKuxlAc2s0851008510epoutp04a
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 04:49:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191105044924epoutp041cd29e6e6a97b14197086ca6b879fa86~UKuxlAc2s0851008510epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572929364;
        bh=/yNIPH5l+9dRjWTf11IbEEEVd7DWkyX/BtXR/9xoy00=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=APN3kNGj4uTYsPXaJ2oAlD0HnefRwz3Zg1NFsh58Ec2S5Bg1s1oPk/7ArhqnSESOe
         3A3C0vcAJJN2g0pJvAIxlueTamQRozn9xQUrvLhmOucOCqeE+iuArWLAvGBs0DZGas
         LeQWUy71zfkq6no2UFoaZybdBI4ZzkolvL47CX+E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191105044924epcas1p1113d217c0e8ac9dd356809b56634908c~UKuxUivSe3209432094epcas1p1P;
        Tue,  5 Nov 2019 04:49:24 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 476cdZ1dPJzMqYl5; Tue,  5 Nov
        2019 04:49:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.75.04085.25FF0CD5; Tue,  5 Nov 2019 13:49:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191105044921epcas1p2869157cceaf45351adf9dd2e59161db7~UKuvDMhmr0616106161epcas1p2C;
        Tue,  5 Nov 2019 04:49:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191105044921epsmtrp23f043ae9707f50aced37a299abb9ae34~UKuvCiNu-2138221382epsmtrp22;
        Tue,  5 Nov 2019 04:49:21 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-3e-5dc0ff526427
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.C4.24756.15FF0CD5; Tue,  5 Nov 2019 13:49:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191105044921epsmtip1295c733aadebbc1fdd0affd6161836f9~UKuuxLHAj1966519665epsmtip1k;
        Tue,  5 Nov 2019 04:49:21 +0000 (GMT)
Subject: Re:
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Organization: Samsung Electronics
Message-ID: <838915ed-55ba-6630-be7d-1c2b36210b10@samsung.com>
Date:   Tue, 5 Nov 2019 13:54:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f618ed4d-05ce-75cd-8cd9-24d8fe5a2551@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTXzfo/4FYg1tLeSwm3rjCYtG8eD2b
        xeVdc9gsbjeuYHNg8di0qpPNY//cNewefVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ0x//JUpoK/fBVf3jg0MP7k7mLk
        5JAQMJE4tuIXaxcjF4eQwA5GiR1X5rFAOJ8YJVp3XmCDcL4xSkyZ+hzI4QBrabrkDxHfyyix
        avEzZgjnPaPE3SvdjCBzhQV4JD4fm8gCYrMJaEnsf3GDDcQWEdCQeHn0FtgKZoEtjBKv3+wA
        K+IXUJS4+uMxWDOvgJ3E3GkHweIsAioSE5fsAtssKhAhcfprIkSJoMTJmU9YQMKcAvYSk9pF
        QMLMAuISt57MZ4Kw5SWat84Gu01C4DKbxKbGiywQP7tI7H76kgnCFpZ4dXwLO4QtJfH53V42
        CLtaYuXJI2wQzR2MElv2X2CFSBhL7F86mQlkMbOApsT6XfoQYUWJnb/nMkIs5pN497WHFRJY
        vBIdbUIQJcoSlx/chVorKbG4vZNtAqPSLCTfzELywiwkL8xCWLaAkWUVo1hqQXFuemqxYYEx
        clxvYgQnRi3zHYwbzvkcYhTgYFTi4f3QfiBWiDWxrLgy9xCjBAezkgjvxRl7Y4V4UxIrq1KL
        8uOLSnNSiw8xmgLDeiKzlGhyPjBp55XEG5oaGRsbW5gYmpkaGiqJ8zouXxorJJCeWJKanZpa
        kFoE08fEwSnVwNi99F7R23nmvgXpE2bbxfT0ejcni648xnLOMf5Rz0zuhbEPFLSe5ZwNCnvS
        5n3578uslbotM4x7vh0R7DbXqOM7vKtnUlpZTszbnzdMDO5ENf4/4ycs4+V8+azy0UlChwvi
        96+yq2u1/fDNozDIcLpJx6rFq562/D3u+sDhxouZ/kf9570++FmJpTgj0VCLuag4EQAn/i9U
        ogMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnG7g/wOxBnO/GVlMvHGFxaJ58Xo2
        i8u75rBZ3G5cwebA4rFpVSebx/65a9g9+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK2P+5alM
        BX/5Kr68cWhg/MndxcjBISFgItF0yb+LkYtDSGA3o8TqVfNZuhg5geKSEtMuHmWGqBGWOHy4
        GKLmLaPE1AX/GUFqhAV4JD4fmwhWzyagJbH/xQ02EFtEQEPi5dFbLCANzAJbGCXaJs1kAkkI
        CdhJ3L69DczmF1CUuPrjMdggXqD43GkHwQaxCKhITFyyC2yQqECExPPtN6BqBCVOznzCAnIQ
        p4C9xKR2EZAws4C6xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkexaSlllIWmYhaVnAyLKK
        UTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4QrQ0dzBeXhJ/iFGAg1GJh/dD+4FYIdbE
        suLK3EOMEhzMSiK8F2fsjRXiTUmsrEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampB
        ahFMlomDU6qBceaK4qunqucXJbP6nJ3ueeJbZYrjw1xFhUtyvCcY1jZMdN7Ab7xf6sN6fobA
        fZ6sGf8mKbqcWrOW89o9jz/sHd/Kitu3ZK+++DvngIBX1tvyZrmA1xbm3isufNm5NT5tZsS9
        fQwGE00T739xviKnvG1mUMPcVfXv33Wn2L6dk+HDsrqe4fDpNUosxRmJhlrMRcWJAMNwXqiM
        AgAA
X-CMS-MailID: 20191105044921epcas1p2869157cceaf45351adf9dd2e59161db7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191105044921epcas1p2869157cceaf45351adf9dd2e59161db7
References: <f618ed4d-05ce-75cd-8cd9-24d8fe5a2551@samsung.com>
        <CGME20191105044921epcas1p2869157cceaf45351adf9dd2e59161db7@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

I'm sorry for this pull request. I've missed the patch title.
I'll resend the pull-request.

Best Regards,
Chanwoo Choi

On 19. 11. 5. 오후 1:52, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.5. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Detailed description for this pull request:
> 1. Clean up the and fix the minor issue of extcon provider driver
> - extcon-intel-cht-wc don't reset the USB data connection at probe time
>   in order to prevent the removing all devices from bus.
> - extcon-sm5502 reset the registers at proble time in order to
>   prevent the some stuck state. And remove the redundant variable
>   initialization.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.5
> 
> for you to fetch changes up to ddd1bbbae486ff5913c8fc72c853dcea60713236:
> 
>   extcon: sm5502: remove redundant assignment to variable cable_type (2019-10-31 13:47:42 +0900)
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       extcon: sm5502: remove redundant assignment to variable cable_type
> 
> Stephan Gerhold (1):
>       extcon: sm5502: Reset registers during initialization
> 
> Yauhen Kharuzhy (1):
>       extcon-intel-cht-wc: Don't reset USB data connection at probe
> 
>  drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
>  drivers/extcon/extcon-sm5502.c       |  6 +++++-
>  drivers/extcon/extcon-sm5502.h       |  2 ++
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
