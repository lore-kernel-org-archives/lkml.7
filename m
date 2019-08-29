Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56089C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D33222CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567119464;
	bh=HMj/0K3T4WxYYdSnGgfjbtYT3a4AV/Y2JjszwuNPeQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tjgtp+QgOBCIf+eq1xmEdZQdwWWq55FCPNX4sHRtXiBccMucZCTMD8bxD646rxqwi
	 +VsRa2eijZ/q+NLCJ0/L/MBzUgBlui+WBIjs7f4giCPtYXrO2FH4/ZH6nemhlwX+4z
	 17cRhFnDJNRB4venblAwPSu+itHpGE948/lGJxuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfH2W5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:57:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40311 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfH2W5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:57:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id c34so5101785otb.7;
        Thu, 29 Aug 2019 15:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qIQzhm+bM9Ftsuy8oUZEYPRkQ9t9wEoQn7THpnhri8Y=;
        b=bNPpXumfxVrmVntPRRwOuQnod+zAq2pRVwH6LmYEdqVJbfsZ2Qb0N22SlZF2p85vxb
         PzKhRxn39FQM5APyqGclBeeeQOl+AftSQ6MfUhUfI/f8cbOzjq/ySNFipmPwSrGldLNH
         Q+Bhgbp1EeNXZ2xN9rO5x2Tl+se51/SzK37ZRdVxfScsMnzxdrDg1B3iO+PjtXdqzJTZ
         k95i+KfB/vJqjt8IOiwPRYxwiI2g/YZXHfEOcZAvRx+4P5/OZarFO5gEZjCKS0pUF8pv
         K1EZpcCbrk4bONFcz/x/q5DBkTJYmrZmu7C9oMcabxU57vchb2NFN4VI1OWV/LXZuS/D
         cNfQ==
X-Gm-Message-State: APjAAAVEPCkZiAaVJCpnNo6qKuZvwIxfo9Q5wTMeGCJ9wdp0Iast6cpI
        EF+73KWYHuBZjXU2rHX2mA==
X-Google-Smtp-Source: APXvYqz4jOe2RR0GNnJdoQrOU3ABZ9MenCTTl7aMTVaPlBmK0WM8Oe1IrLrRgDJTP+zY/ZBjh5q8Yw==
X-Received: by 2002:a9d:4912:: with SMTP id e18mr6698807otf.341.1567119461344;
        Thu, 29 Aug 2019 15:57:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q85sm1148716oic.52.2019.08.29.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:57:40 -0700 (PDT)
Date:   Thu, 29 Aug 2019 17:57:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandru M Stan <amstan@chromium.org>
Subject: Re: [PATCH] dt-bindings: Clarify interrupts-extended usage
Message-ID: <20190829225740.GA22740@bogus>
References: <20190827025511.22166-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827025511.22166-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 19:55:11 -0700, Stephen Boyd wrote:
> Reading the description about when to use interrupts-extended leads some
> developers to think that it shouldn't be used unless a device has
> interrupts from more than one interrupt controller. This isn't true. We
> should encourage devicetree writers to use this property in situations
> where it isn't the inherited interrupt-parent so that we have less
> properties in a DT node by virtue of not having to specify an
> interrupt-parent and an interrupts property.
> 
> Reported-by: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/interrupt-controller/interrupts.txt          | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Rob
