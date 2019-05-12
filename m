Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FD4C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25A520C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwdFa64I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfELPsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:48:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32978 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfELPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:48:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so5814563pfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BA1Za5U5KfZQk8wsu+NsfRi5EQ03hIXikx32Ckah2CA=;
        b=OwdFa64IwXEmKAs9iKguG8rFcoiTqvLtuYUiFfcpnpe7dH2fbJjeSllNKGvgjqDa4m
         AfOKVUGeTvRLfBavE24rlBkDjTDCxn/elgisyywjwK3sFNfO+RVus0RLTrKZSO/y7b8X
         AFnmu/v0o8jtepmbmY5fwF+FErBNYKfQCVc2LHq3RRtjRaxg/Psi7wC90uTgoNzLlgtS
         1Xe756Zwb3QAQX8Ztx9m6/SJM2lfMivU3Xhwt956by7sB1rDPtc0HmVm304cBNLB77ir
         3cIFMmwpGz1dzS53NPAjLUj6CPQ/aU6NUBL9r6fy89eoITLoTtRKNrsPoKHO1SpxMmgn
         8T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BA1Za5U5KfZQk8wsu+NsfRi5EQ03hIXikx32Ckah2CA=;
        b=b6ePla6dVgnoQli4T9aRaI84xa8VrCih6ODegpFgCHiHMsoIHY+GSYan2rKKaORAzR
         E2xU/Pfv3F50gpL2BIFAjp0Q2VH4rLIHIk7Hstm6XXQFrkeL37/zfNzD4zHRrQLKOjTy
         jwqBlu20DYSc++aFh75ohRBb7z6iaDahbGyyjwNpO1HJT79tEjw8aVpmUsH1w4uz4fl4
         /bMZdhVBnI/QvAiXthAnR7flOiUrnIRtVYBY4XzEsfWMXzqh7ZeTe/clTWir7R12y/Yz
         CptZ/m2pKUIp9jICCUuRa9kEvPHdymqFUeGa2aLXD1BXz7bml+kaA0IQCfrARiSSIVam
         9kKQ==
X-Gm-Message-State: APjAAAXhKTdygHIQNNWayGb3Af8JpcoQA0ZD5tC7IoXTULcM0exr5lWo
        Vbp3jNoweF+LsmtLyPk4rwQ=
X-Google-Smtp-Source: APXvYqzt4SsMDZGm8d53Kdhe9kvMQxysA5Ld5CIf2/FlU1iEKljoQ0ic8+y2o2XJFiMV2AtpTYohfg==
X-Received: by 2002:a62:4ed8:: with SMTP id c207mr28513808pfb.241.1557676092441;
        Sun, 12 May 2019 08:48:12 -0700 (PDT)
Received: from [192.168.1.7] ([117.241.202.125])
        by smtp.gmail.com with ESMTPSA id e14sm7947489pff.60.2019.05.12.08.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 08:48:11 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] Staging: kpc2000: kpc_dma: resolve
 checkpath errors and warnings
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <CAKXUXMzJCmSZqJ+VFxEOgf_HNgKfPfKS7OECw_RzSxVrDZpCGw@mail.gmail.com>
From:   Vandana BN <bnvandana@gmail.com>
Message-ID: <311fb622-b6ea-f580-df55-c26c24823ef5@gmail.com>
Date:   Sun, 12 May 2019 21:18:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKXUXMzJCmSZqJ+VFxEOgf_HNgKfPfKS7OECw_RzSxVrDZpCGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/05/19 2:04 AM, Lukas Bulwahn wrote:
> On Fri, May 10, 2019 at 9:39 PM Vandana BN <bnvandana@gmail.com> wrote:
>> This patch resolves coding style errors and warnings reported by chechpatch
>>
> I did not look at the patch in detail, but you might want to also
> consider to replace the CamlCase (function) names by names in
> lower-case with underscores. That is the common style in the kernel.
>
> Lukas

With this path I wanted to fix Error and warning reported by checkpatch.pl

Is it ok if i do CamlCase fixes as separate patch than this ?

thanks,

Vandana.

