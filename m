Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CDA2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552418708;
	bh=SdAo7yWuy5+L3D2VxnOywEKbqHUQEUxH53sXnZDfqEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LEWHwdh6hbgBztDExFhzemeTg1hSuZepsQSrv5U4rk7PFg678llB6RS+WCzzZUcmS
	 Gu2lNzmDl7Jsn1I4jf6FUVCt9HkKBngMNln01qTYQcFa7sd5TJCzTGp1z2VLNrsnPt
	 O13giPu1ctv+GKw3hm/ysLkhYDiOi0u3CPmX9xt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCLTZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:25:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45227 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfCLTZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:25:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id t82so3050639oie.12;
        Tue, 12 Mar 2019 12:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a7gBo5sH+h81iykXwWt6txC9PsiC8kKh8eTEofPC3/8=;
        b=sAYRSxDVbYS0Sxh/EYfWs2Z5CkS8eCK8Yh4gmGb+8xxU9hnqccLqnf4uolQ1LrOgMW
         j5teFKq6xCatnp/TwzQs4cnzugwk6G0lNPCdG+n5bR36IVsXBGw3vJpXW1dCbmqEYI7u
         Pfu5iHWiWy650k5nVEKEGkaZ5ryMjV8yRjyWa24afS3rkpimZQxnrQnlRR9DsmjCNSSU
         elb4Z3qY62gtTtYbq3RRhjp8Y9V+uU7wnX6vbMN4CPWBnKpvkhhXU35ordLUsO6ScGwr
         QxI2qTjLCNSMhiTTei7cIA92dHz2fYLw4ZCIZbBaA1Mwz8IKKG60pj5qmcq1GDuMwQE9
         ED8w==
X-Gm-Message-State: APjAAAWG9wOx8KT3xLsy30gLUMWx+drNJ3WrTI5dIjVHARJC/R4T8iML
        /qTsznSpIvOyD25RAXKJLw==
X-Google-Smtp-Source: APXvYqw8z5dfX4Jlo8ttAkSmG7CVjN+792UirvcHmj2CxBNPwMUM2izmIjK5LxBSZMkjVm0/IGZ9pA==
X-Received: by 2002:aca:bac1:: with SMTP id k184mr2816445oif.56.1552418706014;
        Tue, 12 Mar 2019 12:25:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w18sm3659837otp.70.2019.03.12.12.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 12:25:05 -0700 (PDT)
Date:   Tue, 12 Mar 2019 14:25:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: i2c: pca9541: extend with compatible
 for  PCA9641
Message-ID: <20190312192505.GA17266@bogus>
References: <20190306231521.29367-1-peda@axentia.se>
 <20190306231521.29367-5-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306231521.29367-5-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 23:15:50 +0000, Peter Rosin wrote:
> The binding is equivalent apart from the compatible.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/i2c/nxp,pca9541.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
