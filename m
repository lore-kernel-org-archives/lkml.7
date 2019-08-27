Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3742C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67D22064A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566944832;
	bh=v/cdxjtbWCSfQfw5lgvxMnGldWIoaFc4tOUBnsIjnNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yu4yugvJTIbOcOSk5Vqj+aXAsYdW8qTG9jLZIpId0WXpwhfdMmAt32T2cbLadjz8p
	 bEpIQmGuNhCNjnqinOKfqopWxQD12ACRfyk/I7jOmXdILiEkMdJv+oXmm1Ftlm30gV
	 x3jqV3iR08TeFHIGCFPbis3v1WsIw9VP9n+bEShY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH0W1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:27:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43836 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfH0W1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:27:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id e12so749846otp.10;
        Tue, 27 Aug 2019 15:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dMNimwoZsVMLe9Sk4wjDaxpLxr9vjTQQotZn0Qr8nVg=;
        b=WClnV0v9q7wYlJfq/PtAvtTEjH0Qv/oJSu9rRJVjufazDf2k8V81EUqwmJ1ZnZCpmm
         LpsUvACXSV/t534dsZEhVu1PISERoYKJs+0nGtaeM3rjDBVWKEsJhOsDD3mo75fUcvUU
         Mo35euniUyUys26yKh4E7IH50L8JieUEkIosyBA8c2XEl216Om6zZCaYIQ7EBm6sD2SB
         c0XXckg+SXuv7RZYlzNgR44sZtNV1s9io1TjvHnSXy5GkrO0yM8HeN0pC2I/i2AQtqap
         THNyW5LLz2I3QA2flxjSLW3wtW/vPk+Yrfk+sR0omqOX3UpHyaKuEhdI/XMdltQJxuGa
         eHqg==
X-Gm-Message-State: APjAAAV7zVBcMoALalvckqJzzY45NfpmRJiL2gVje67Z7MZLXXBu0CS/
        rn68AL0PHB9h0UiuJjcuzA==
X-Google-Smtp-Source: APXvYqzGdl3LOWdnYrdN3SHrblxgBCUvgxV6hMc2a8l49mT3oFhMzIqow6a25sDO9wSvXTpCi98GFQ==
X-Received: by 2002:a9d:7f92:: with SMTP id t18mr778557otp.323.1566944830570;
        Tue, 27 Aug 2019 15:27:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z9sm172631oid.39.2019.08.27.15.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 15:27:10 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:27:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/2] dt-bindings: usb: mtk-xhci: add an
 optional xhci_ck clock
Message-ID: <20190827222709.GA20468@bogus>
References: <1566542425-20082-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566542425-20082-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 14:40:24 +0800, Chunfeng Yun wrote:
> Add a new optional clock xhci_ck
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2 changes:
>   1. add the new clock at the end, suggested by Rob
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
