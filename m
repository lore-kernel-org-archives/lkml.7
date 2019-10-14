Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B6C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C5D20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eSu6PjSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfJNJRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:17:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:42751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbfJNJRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571044643;
        bh=4WxnJGGhPUp8zJdSS6vkKY+4fSuwHopgQ3qM6bfXxxU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eSu6PjSHSn8VWGUz9PPVC0eNVQXrCsbTltfazX4Zp37ELfuZ1ylgJ0KYEdkYLg4gI
         EzSfn8w9VnuCtajJWX5oOPs/qp2KHc2RAKVY5RulilYh51BcI/SZSYszpRVGSf6cvD
         RKeOFmwac3sysWbmXbN1ozUV7AoahpV8sHnC7bNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.0.0.132] ([212.88.11.189]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1iKDSc3Na5-000IBB; Mon, 14
 Oct 2019 11:17:23 +0200
Subject: Re: [PATCH] xhci: Don't use soft retry if slot id > 0
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191013003313.3497-1-bernhard.gebetsberger@gmx.at>
 <84476602-7551-b667-9803-55016e477b02@linux.intel.com>
From:   Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Message-ID: <8319a117-ed96-53f8-48ae-907c6c34898d@gmx.at>
Date:   Mon, 14 Oct 2019 11:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <84476602-7551-b667-9803-55016e477b02@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:GoxKe0s5Fo0XSTngGJAuRCkv+kTx0jXMfIYt275HkW7XJ2oKno2
 MldDbYZjHNoo0X5/NFjStH/XB4m7xaxtkCQ4NK2LMcvPBbsqSJQRkJ3nCJrdn/46FdzGS5b
 60lHuCnG8Bo9aMXAohgWX+327aWxyRKPzQlHgMWJdLErIEu7lDzu5ET02M6uS3Oz4l1MH7F
 jKKq9vQlxLU6mpvJiPl+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SKqbYSAIWHI=:Ea0pQxGQUgg/7puz61glmk
 tehrz1IgWj0PfaFWpFmYM0E9ZgJcRPrpTIqBjI5GWr9czeGtFYbEOPE+J7Y1ZDH2vtt0crekj
 899nfPtJGZJVESWroUAYdF7b/wN/hA+wV3te0wAw1et9gFo72rfUBvw1tqzkoPheYihcDm2zd
 fqtd5HS4METMLy5vQFdJ9Q3mTHvvVtsegtWoz0IAokUPtlKgVPSsdo6fs+VEVMF9xZouz2MXw
 otRPBmY+h8iydmnfASH4ntEleFOeoXtdhcc6wHYWAb4cxxC42AKEqoGZf8L0CPqsBEit7OaOf
 FOmFJ+dqJdS6xmKOfjewDh4Uk8LmzB7TCGpdO0j5/XRiglsgc8+HwR6iMahfRK7TBy/+9ZHbD
 yJ6jfzADehWfzfO0WkZTuNlWNRX2BwZf49PcF7q9pGCEGM+IHn0i1ZeLuYIkuQtFOp4zsH1/R
 yJH2w0SHt5V6NceTDHH57QVrA/0MbtsUQ1oOMBaCs5fAVFuIt1InsacQ/9ik7AB9JUSDOBrc9
 7gEdjlOU//sEx+gLx/sbMgVhwNpcG9QRh2ic9csa/0/I+iXRiAX9zHahxMz+gENRsOubq8TnB
 wzNNoXvOfs20d6Dou04uV9XlVLlHAf9hzhQFnmKJ1h9IjFd7Na4bml8w3EiBxsuvSASpqrrtM
 Nn8j/4zFvF5Z+fDUmO8URb7PoSghPrM6arWEHG5+SdL/LEi8+VRigYtcA+toY2maIr97CAc0g
 cpM+a799wFi1G4fwsR0ZVli5MV66xZUTCuqsukxGaPEyJ89XrdVz2QFy+/s8OQTawYXDrr3Zr
 wYS8soooZQdop8ap2C32ByUoEqdKRztHCr7LgFAFxtAzu4nX8NK59FSHld1UD4B8YNspGJMAg
 +ZhRLVBWB6o0OtGJZ6a7Ve1oCPr8x6DO8oNcg7j/Yhi0l3l8d5/6LoV47VX+eXk1NJ62tWosW
 wsJodljg0l+/FRnpMU08RoLlq2/OobO7q4AWcHuc84hvxiC9hVB6q+a0Jlg13AONgz2LsvI9i
 jg+rDs9HmfkTT+ONFmgOimzDkQUp2nI33A/5o0M3dfecAD2tw8lmYLMsnJd4QCm/9YZyNqtnQ
 brqi198yY+obYQ1e7RRVSo2z9MYNEmkJoabvgQ48EF34f54eRx7liht/YOdSslGaDXQw1yNP9
 f/M1a8/0q3Hr8LzNLZ2nY3r/6Qhah6Ok/UY7vvMA/M+z0FG58b57t3JZoQ+CME5V33rZjxBQx
 5vm35zKU9RXXS2IcGuhL1DQZ62xhMw1GIE1UQDq4LqO3izuadsaQPvrtOMsE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.10.19 um 10:06 schrieb Mathias Nyman:
> On 13.10.2019 3.33, Bernhard Gebetsberger wrote:
>> According to the xhci specification(chapter 4.6.8.1) soft retry
>> shouldn't be used if the slot id is higher than 0. Currently some usb
>> devices break on some systems because soft retry is being used when
>> there is a transaction error, without checking the slot id.
>>
> That is not correct
>
> Specs say that soft retry should not be used if we are dealing with a
> FS/LS device behind a HS hub, this can be checked from the "TT Hub Slot =
ID"
> field in the slot context, which we do.
>
> In xhci all devices have a slot id, so this change would prevent
> soft retry almost completely.
>
> Specs 4.6.8.1:
> "Soft Retry attempts shall not be performed if the device is behind a
> TT in a HS Hub (i.e. TT Hub Slot ID > =E2=80=980=E2=80=99)."
>
> -Mathias
Thanks for the explanation, I have misunderstood that part from the xhci

spec. Sorry.

- Bernhard



