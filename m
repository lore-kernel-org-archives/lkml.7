Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AADC76194
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97022166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="pfbLE1V+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGZB2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 21:28:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41996 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfGZB2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 21:28:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so37923500qkm.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 18:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1kvoyJ4k0+maq773nHpbwCH4VPrO52C+mUKMi08tPsU=;
        b=pfbLE1V+EcWTEDCNXKkwjcb8UAtPFm2f61SEu4Gzc/rFTpmkFO3sX36JOFxbmaAgAl
         y1wn0DSqZJ5V9XthUQS5a85qSpJ1yevfFOHTiWJxgqvd75P8AzkFo2PIL8OjPzDbbCpG
         xtqZrpFubUWOaFq/y4TdINmsGhbWXhuBcutprLqaDeapFYIdMVJNK7lowZN0T1muzg6Y
         4qjjSki0cSGXe6BkVKCws7I6fBfaafFMAm71vtadD7FXjSv91ude0b49ouxVDKKG2G0/
         6dxWF8McZ86mzApxJ4FPORxVxgbW+SAz0Fozm/t01PfWiBQWeRjisPXph9WXSz+aM+eO
         KS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1kvoyJ4k0+maq773nHpbwCH4VPrO52C+mUKMi08tPsU=;
        b=Zk6w1YxwlkwuxmhLC0ysbdaLxTX087o/b83Z4jiayl9TqUJp+HWulgo+YCfuFCNqTp
         W65RRwSL5cj8K138z/eAQSaLsNVwOJ3d09LWRtJo53LVbKcPiHdtlKMEo4OCbc+/jXrF
         P7OXhYRFxu+gTd6LZ8gt/pdSlVkwMGU5BdToejDZCpFlsQHwWxAFX9zkE41LJkq2Nr8t
         WxdE/6O9J2cNt0vbvCe1DCOP3psGWtNB/ioli7QdB5Pc46BuGD3pgrj3LR6qBaOO5lsD
         jxYVDB3up8ud35MOGQYuLC5KTFDG8ddR4BCWVBl3vNtfeol9ux046n8TBr5gpMW1cABH
         x0HQ==
X-Gm-Message-State: APjAAAUMHbDfHr4MJFVHWtmsZP2OyEDJisTHQKeNBXRqNwgGxY0IGaKN
        KHuLX8tCkxnj0DMGh1i9/oxC4Q==
X-Google-Smtp-Source: APXvYqy6YZO4i7Xe+r9UhZ+sYCedQybq0a32JZQwh0EWwwod7A88AFafCdwo7kmtrBQzOBEq1SHgZw==
X-Received: by 2002:ae9:ea09:: with SMTP id f9mr62064340qkg.379.1564104532292;
        Thu, 25 Jul 2019 18:28:52 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i62sm23773734qke.52.2019.07.25.18.28.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 18:28:52 -0700 (PDT)
Date:   Thu, 25 Jul 2019 18:28:46 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "tanhuazhong@huawei.com" <tanhuazhong@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
        "lipeng321@huawei.com" <lipeng321@huawei.com>,
        "yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 07/11] net: hns3: adds debug messages to
 identify eth down cause
Message-ID: <20190725182846.253ae93f@cakuba.netronome.com>
In-Reply-To: <75a02bbe5b3b0f2755cd901a8830d4a3026f9383.camel@mellanox.com>
References: <1563938327-9865-1-git-send-email-tanhuazhong@huawei.com>
        <1563938327-9865-8-git-send-email-tanhuazhong@huawei.com>
        <ffd942e7d7442549a3a6d469709b7f7405928afe.camel@mellanox.com>
        <30483e38-5e4a-0111-f431-4742ceb1aa62@huawei.com>
        <75a02bbe5b3b0f2755cd901a8830d4a3026f9383.camel@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 21:59:08 +0000, Saeed Mahameed wrote:
> I couldn't find any rules regarding what to put in kernel log, Maybe
> someone can share ?. but i vaguely remember that the recommendation
> for device drivers is to put nothing, only error/warning messages.

FWIW my understanding is also that only error/warning messages should
be printed. IOW things which should "never happen".

There are some historical exceptions. Probe logs for instance may be
useful, because its not trivial to get to the device if probe fails.

Another one is ethtool flashing, if it takes time we used to print into
logs some message like "please wait patiently". But since Jiri added
the progress messages in devlink that's no longer necessary.

For the messages which are basically printing the name of the function
or name of the function and their args - we have ftrace.

That's my $0.02 :)
