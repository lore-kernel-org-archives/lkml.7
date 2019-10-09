Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E6ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D754420659
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570664044;
	bh=Pzz+k+/DGuS8ChQK4i00JWdETOj20wb7lFAI91HbXww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vh31kynO+6ViCCOVFWJk67Lw5jOSzAjCFrbQn3gO0pBap1DiTxeKFN0Ugor3ocbqE
	 f9li90MM+J8clfhQ3m+NBYn5RHt7A79ipLvpPv/DlVc9Ic7wBUBVJ//kVwKULvsjxv
	 tMQZauMvUWtkNQsS4wh5m0rt1ESGRhGkglNvrRBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfJIXeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:34:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38782 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfJIXeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:34:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so3264481otl.5;
        Wed, 09 Oct 2019 16:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPc6fpcwZsUc9Gutbs7P7oeYlZYQt/DPOxeaF8rIBfI=;
        b=JJvPonkCWue/kzFo2YgbgDutNxu/QBOm+R6OUD+crqVa/AIRi67hpWGm7/KgpyVzOZ
         oPDuP5APPHpsENSmY+czgYtA4ghy3F/BRBGjy3hsCcO7ljgRjAS/ffQM/A8CZxQXsFIv
         jRVDtjRs1n3pf3uuL0BGvPqG4wR4YmGUqWt8Tnw41Pvjcn+idjx6+nrhwHFu3x5FgHRE
         S6mG6UQYhf+qLZQRNTT9dcDXNEcOL9BkNpRN8OVXQnzvBQtnZ+pCMrD12cktcuKqYOej
         QyDpg0bXa7oeaAn5b146M6z4II9ycltB4n7mwKLK5mOcpGrLgL/2WX97wOoPDXlMGRcA
         fbMw==
X-Gm-Message-State: APjAAAVbfZEbZDXdHwKa6zns0ULwNOTS3Oig+szy8AQ/xC36LFRtvQKf
        YRFJ+Ya2f0JwewbcpbtQjw==
X-Google-Smtp-Source: APXvYqzjadRfoKvbeOh4piHSXFjFjIxcKYdBtSHwZOYiSb/x+QYN70jgIyRNnwBJ14txKmB+a9qLGQ==
X-Received: by 2002:a9d:6d11:: with SMTP id o17mr5294314otp.40.1570664042379;
        Wed, 09 Oct 2019 16:34:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 36sm1116076ott.66.2019.10.09.16.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:34:01 -0700 (PDT)
Date:   Wed, 9 Oct 2019 18:34:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: dmaengine: sf-pdma: add bindins for
 SiFive PDMA
Message-ID: <20191009233401.GA8805@bogus>
References: <20191003090945.29210-1-green.wan@sifive.com>
 <20191003090945.29210-2-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003090945.29210-2-green.wan@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Oct 2019 17:09:01 +0800, Green Wan wrote:
> Add DT bindings document for Platform DMA(PDMA) driver of board,
> HiFive Unleashed Rev A00.
> 
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
