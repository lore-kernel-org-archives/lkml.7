Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BF0C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8752084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2ulbqfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfFQNjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:39:18 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:35384 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfFQNjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:39:17 -0400
Received: by mail-pl1-f176.google.com with SMTP id p1so4115756plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fgHUs9kjH3FZpHlrbFs05iqP48Eq3TNSHKTRIJZ7Has=;
        b=g2ulbqfpyQKBQfPRgzwRDDicgkFjWeJHrFCNwqD0gtlhthmI8XuZ0LWywtLBFl2dvt
         HEvGFpC2CFd0tFxU4G8vsNEIIjRaI1DJk+d7nXm7GfxStmjfCqDynQl0nNwJADBKsi9o
         Ol6GVy9rIS5ycHPLV4vvq1sGeFyhFvF2iXLJmHF9YR8NV3prUSSLrkXw9j1rKI3yUvBY
         uVi+vL6Cf+09n9fHO5Wp+bQi8p0jvkmX5wy9MdqBF3917KJbAQ0RQglGjnrnpzTgWDoT
         1GoKq9GKyROXeg+kbth/yqhFjbRGbWFka32ffWjHJbsNRjaLxAd5Lxfz+2mbFocyviGn
         IpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgHUs9kjH3FZpHlrbFs05iqP48Eq3TNSHKTRIJZ7Has=;
        b=PT7t106mM34Chg5SWjP4jo5ZZtXVo4sPFPFAtnvxSlY49SxCQCXYTxuztnq6dQ6JbT
         YhdnSuf3pEfG9Z4JCQ/Cz5xyYLHfH7r8M/oiyeCOM26GkKpF5rllvJHHMvPp+uFF+KFO
         iGHoOoRiMz1BVhHGC70QkT8xk8Vm/LHvJw3tyum3oa1LxREUeDb52pC5IlSEHk2bQOTT
         Uxp1/Y+pUi0DNjQpYSszaUPKqpa8LHIZENSMpX5gjeJ40rOGjvBPornRAP/BnWl45D2w
         GnMeQ11zZFHxlroxVUAwXuDkTHNQC2D8LXT5kzzrkdGDJbdNkYpnN+L2Qr0qo/PTTrc6
         BPQQ==
X-Gm-Message-State: APjAAAWTKgcA4R+7/gxoxYUaE9QvMzKY/vPw1s+XehTXEIn9jCbsHyo7
        LqTDKDQQ+Sr2dP/YP8iVwpa7Mp4V
X-Google-Smtp-Source: APXvYqw0Qt/GtN5XRxtiYmkNSh7xBuXb4u0JWUto8tta7KkHxAdkPbw3aOtlUGu/l2ip/WyO+vL7wg==
X-Received: by 2002:a17:902:7618:: with SMTP id k24mr44797137pll.208.1560778756883;
        Mon, 17 Jun 2019 06:39:16 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id j13sm10895919pgh.44.2019.06.17.06.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 06:39:16 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To:     Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20190614102126.8402-1-hch@lst.de>
Message-ID: <ad248f50-bbf6-42a6-612c-85b288575dfb@linux-m68k.org>
Date:   Mon, 17 Jun 2019 23:39:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614102126.8402-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 14/6/19 8:21 pm, Christoph Hellwig wrote:
> Hi Geert and Greg,
> 
> can you take a look at the (untested) patches below?  They convert m68k
> to use the generic remapping DMA allocator, which is also used by
> arm64 and csky.

No impact to ColdFire targets, so I'll have to defer to Geert
for his thoughts on the legacy m68k impact.

Regards
Greg

