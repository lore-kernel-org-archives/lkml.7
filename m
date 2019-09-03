Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4A3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1B822CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567532438;
	bh=j6FqaTZL1ZklgejwNas2l4P6J7eVxlUURvv6jGzRPIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ddHl6YYKcZ1FIS1SvKLz6mxjvJ4oZLi4EL8CvR+7Obu6TNYJjehLnroSg8FxBcAH0
	 3M8CutF9UVOKMtdkNjAfNDDVquyDASLt2s3lzPWkGpOm/k7qvzD2SuZ5imsajtRG92
	 QZFxBKQ/FTWrqpavA0L493zqOwni6JdVmI+AOrhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfICRkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:40:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40248 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICRkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:40:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so18395626wrd.7;
        Tue, 03 Sep 2019 10:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIXNCxOIrCyXT5hESp+rCLjjuePFlAI37CT+jEDV5Q4=;
        b=bPKkCeks8SPtr7XnNPmsl5idRdW4F2P+UxxbOZc0iPdhvXZ4jEEEF1sE3I3jxbyNQA
         iSQUbe+KHdlBv5RURwteJjwl9pzKmdjEgjoC3CX9scqrTXXmEFahbJu8tMgaI0dx+io8
         wjOJT0BfZzf4HDQwEIl9Xv12UbKQdR56hYNhxPn689/RllNC9nt1+hIGhxSqja5Zit5g
         F0o96OymkrSCpoFpm2nOaXQiSJYcVnV3LIClh4436iSF15euPL9WXzEy52CGDO7mtF4L
         37PjFuG3BqE/JMjH5PT4Vsbgbi5yiXXte1KidubVp1mqFVeH7Tds7LtBvNEn/UOKeCej
         xliw==
X-Gm-Message-State: APjAAAV+M0eUgBgjz1CIGuqXi1RM5d6FglT1gytdpQRnOatUkEA2PH8a
        Mb+WfmFPvEdqRyExmQ9QUg==
X-Google-Smtp-Source: APXvYqyO5yb0kzqqfbrHDmZsNBwidTPMmrsGe7bYyTxXuBCFzT6DUgmP1xCcjTCyTgekuMtpl8lSOw==
X-Received: by 2002:adf:f507:: with SMTP id q7mr44817756wro.210.1567532435032;
        Tue, 03 Sep 2019 10:40:35 -0700 (PDT)
Received: from localhost ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id e15sm10079955wru.93.2019.09.03.10.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:40:34 -0700 (PDT)
Date:   Tue, 3 Sep 2019 18:40:24 +0100
From:   Rob Herring <robh@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org, bbrezillon@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, pgaj@cadence.com,
        Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: i3c: Make 'assigned-address' valid
 if static address == 0
Message-ID: <20190903174024.GA1480@bogus>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
 <c0505ef73add4512ce1ee2a71b1c8bc8f771151b.1567437955.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0505ef73add4512ce1ee2a71b1c8bc8f771151b.1567437955.git.vitor.soares@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Sep 2019 12:35:52 +0200, Vitor Soares wrote:
> The I3C devices without a static address can require a specific dynamic
> address for priority reasons.
> 
> Let's update the binding document to make the 'assigned-address' property
> valid if static address == 0 and add an example with this use case.
> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  Documentation/devicetree/bindings/i3c/i3c.txt | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
