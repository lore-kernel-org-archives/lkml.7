Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B7F216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568755594;
	bh=+GaLR2c+O6Sr69wVkKs27CvH66duFbXZbNt5nPiuQ3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BmA6OuwRKVrALnnw10XaterbIKG3pmf7gOA3PDVk2/pTSyi3cWT51I0WAnnlZ0PcR
	 Mo29zT9GAcsWZYg3MgHVT7Tyh1cVYNna3ReMJYO1fcV5NJ2/t4OsyjlM10fSEqCgt4
	 Q7QVfPcVWS4u+yYEmPAuZ2NbLvCX/pl58pBkII4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfIQV0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 17:26:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39708 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfIQV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:26:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id s22so4437010otr.6;
        Tue, 17 Sep 2019 14:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M6Vlf3B/Wu+Dqubj8csb+4sXrYeJJ15HwZ4X+qhYifM=;
        b=OXKEa0H3kPAc9sZAj6Q+R4oNuR7CD1XE+UW7lqp32ifgJBCub1fg0nzKUmTs/BDEug
         DaaXCMA78eP0S8CsQogbVVkLkornvdshaITa1si08SpAxDAZeNm0ME/kj4RVglSFC6nb
         OriFt7dyRNlI+yuPQir2Vx/qaFQ0DXXJXoBefQQK1Wzc7+WLmE65t+6uxwvecu3vlp8T
         I12yox1oqNx7yDxN8CVr8d0xODF6cCZWEHcoR40ahT/CM8cijJcg0YigGSfwvsmUYqls
         0AgbL1TFww2rylHLzjXppV1HYGSv7AAzuhIlZ/E1/xnLlWqf9LB1YQ4uV7JLb74sYl5v
         UVLQ==
X-Gm-Message-State: APjAAAUQXrGtgJhsl1KdjOJatBxk6YG9hGuJHRuCBKZptNbOWW/kDVSL
        TX53IF8SKpPNJXoD+IZrW9adGZt1DQ==
X-Google-Smtp-Source: APXvYqxGhnxWSKx8g6RLUigEhllxaFKP/MIFSifQer6Teu1Lkf4ivYiaPqmggq/rJzcRGj1PEAoXGw==
X-Received: by 2002:a9d:3be3:: with SMTP id k90mr820128otc.180.1568755592864;
        Tue, 17 Sep 2019 14:26:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 5sm1164594otp.20.2019.09.17.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:26:31 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:26:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, chenhc@lemote.com,
        paul.burton@mips.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.co, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2 06/19] dt-bindings: interrupt-controller: Add
 Loongson-3 IOINTC
Message-ID: <20190917212631.GA3313@bogus>
References: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
 <20190905144316.12527-7-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905144316.12527-7-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Sep 2019 22:43:03 +0800, Jiaxun Yang wrote:
> Document Loongson-3 I/O Interrupt controller.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../loongson,ls3-iointc.yaml                  | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-iointc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
