Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03A2C31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ED120861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ElB77Qbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfFQBlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 21:41:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38692 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfFQBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 21:41:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so5255454qkk.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yDNJnnWMnvyj74KJjqDNrTKP8BhcNS3oCZ7kmmIyfm4=;
        b=ElB77QbjwicalLDAC/XLHtEXw3/UU+ToIyPskfkAUH1tIu/U9suKHVBjE+Gra7qlu4
         SfROdnCJnmHBNN1JY8yyqKoevbAf71SEXwBAiHw3MoEKCkCFmzyQIstM4lJPVL9bE8sW
         ol+INiBZwwHD7Vssk4wOLmuefAvt1+xQjPKj2pJEK/KBp0tmoraLJv3cwMQBU5ozFYrL
         xqBlsK9d2XGk7Z//uN9nMV29HByV5hsqpWrEhHX5TfIdxdq9Kf7bd/MVMdbDKuKazbM0
         w5ctKa0w7flVcDSgU+A3S9ntfWhtBXdpMaClcKumhtGa6lxEnKfQttxesKMVHWox44ln
         1VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yDNJnnWMnvyj74KJjqDNrTKP8BhcNS3oCZ7kmmIyfm4=;
        b=pjGtfFpYWJHWvjzkK6bk8ylD0OWT17XVvTjVix4AwXlPYmkgH+9u83eBjABKVkLs7w
         5tqKKOeQW7LFi7sAmHoZ9MkjEmiPoIzyvU5+TjjJ/R6dDDgPQzrSxB0dmZqwOwyTvj+z
         v4/WPfvSF5dUIUPdc6ybgjK5DTXQPo6Rgp1LPsFNeKtQdgBp7kEYGe+GvB+iAZEwnn2G
         kawO+h+TxinPxH7GorhZPv4AsLOgrdTroHZlTZQwpl3lzYg3AdKF0SVitJzY4OA5h8Ny
         vZhly2Ar1XFSnSr0oKhszjcjPP7h/kqjnHt4uHzO14eaDTBuLxRCEEF9L/uHJD91SD7f
         PI0Q==
X-Gm-Message-State: APjAAAU5u/Mlec4lQw9BWayd1Dc+i4o1TBXpy86y71LHH7RfZEaaxRcT
        yO5vNHwmg402Dtm6dcHCf7yJWUNkJAE=
X-Google-Smtp-Source: APXvYqz+ah+V71vGndXB9PVxkYf68i4b83LtgwwezyYhS64hdWj/C2Et4tvVQq+ACar89DMNZAxCaw==
X-Received: by 2002:a37:4887:: with SMTP id v129mr6511552qka.17.1560735671205;
        Sun, 16 Jun 2019 18:41:11 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l6sm5718357qkf.83.2019.06.16.18.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 18:41:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <054b6532-a867-ec7c-0a72-6a58d4b2723e@arm.com>
Date:   Sun, 16 Jun 2019 21:41:09 -0400
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC704BC3-62FF-4DCE-8127-40279ED50D65@lca.pw>
References: <1560461641.5154.19.camel@lca.pw>
 <20190614102017.GC10659@fuggles.cambridge.arm.com>
 <1560514539.5154.20.camel@lca.pw>
 <054b6532-a867-ec7c-0a72-6a58d4b2723e@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2019, at 9:32 PM, Anshuman Khandual =
<anshuman.khandual@arm.com> wrote:
>=20
> Hello Qian,
>=20
> On 06/14/2019 05:45 PM, Qian Cai wrote:
>> On Fri, 2019-06-14 at 11:20 +0100, Will Deacon wrote:
>>> Hi Qian,
>>>=20
>>> On Thu, Jun 13, 2019 at 05:34:01PM -0400, Qian Cai wrote:
>>>> LTP hugemmap05 test case [1] could not exit itself properly and =
then degrade
>>>> the
>>>> system performance on arm64 with linux-next (next-20190613). The =
bisection
>>>> so
>>>> far indicates,
>>>>=20
>>>> BAD:  30bafbc357f1 Merge remote-tracking branch =
'arm64/for-next/core'
>>>> GOOD: 0c3d124a3043 Merge remote-tracking branch =
'arm64-fixes/for-next/fixes'
>>>=20
>>> Did you finish the bisection in the end? Also, what config are you =
using
>>> (you usually have something fairly esoteric ;)?
>>=20
>> No, it is still running.
>>=20
>> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
>>=20
>=20
> Were you able to bisect the problem till a particular commit ?

Not yet, it turned out the test case needs to run a few times (usually =
within 5) to reproduce, so the previous bisection was totally wrong =
where it assume the bad commit will fail every time. Once reproduced, =
the test case becomes unkillable stuck in the D state.

I am still in the middle of running a new round of bisection. The =
current progress is,

35c99ffa20ed GOOD (survived 20 times)
def0fdae813d BAD=
