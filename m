Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035ACC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AB9206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571082603;
	bh=tLt8EpyqkoFKQItTHvuBnwOZ0YJdYNZeVBbKFjB28zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FHb+0k5uh++h15+wozlxJnGBMtkvwE3sKADawVjtdwz5+xVJdhkld7b3KaZ65oYbX
	 5NnM+t/OeBvZ9TWoxSFE97PidfAOs2fHbtEwKJdOMSrxrQRjMk/vjVc8DSi0vZXyit
	 7/38vpLXGwmIyx9KbmfUMLKCLI75q7dw08AHLfTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfJNTuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:50:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44534 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfJNTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:50:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id w6so14712201oie.11;
        Mon, 14 Oct 2019 12:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NxhCCxPZ2FpXlTCWZLPNlVYro5ejAF3sMPqwp32yhUc=;
        b=btv/iedE1rCUiL+e7RFcXH/DGQCrkYZdcWsxG7XnmANNmx0WF1sFioozo2HJRn1rok
         EX9yXki6w1I2s4vrW/U6AQC45o/BergFspE1fE5rV7yj63PdbaBYXYHogzD21liUWo9E
         H+GhIfEWdTwyq/F/kfza1lsrScaY6OGemWJZG9ZTISzkXY5OOl7RBW5frKgJnzsoUfiu
         5Uy0Ssxi238kRehJVJP4heV3wDos/HrVjCgWin6C5UNB+S9s96TAiQwTArCdgtQIJhIC
         1WqDU30A0WrEKO/k2u4uAIfLg9pJDUw8VrVg8SHEPs+6YPOLge85S6nxe3iZKHXbf5mj
         vYVA==
X-Gm-Message-State: APjAAAXRG3YFiXzD94GEMKxA9r6KhWtSWJtNhclwcyyYMj7CqiOBaZa1
        xS8XxHI1lqjiSwnRmp2RRw==
X-Google-Smtp-Source: APXvYqz8cLeQnVPXfJbn0yMhk9Ft8PU/gotpH8mO+4vzmJUPaFtR7C1fUMAwi6LrI3V2N7Rln4VRXw==
X-Received: by 2002:aca:370b:: with SMTP id e11mr25053138oia.96.1571082601381;
        Mon, 14 Oct 2019 12:50:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f205sm5792922oib.11.2019.10.14.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 12:50:00 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:50:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: add binding for Rockchip OTP
 controller
Message-ID: <20191014195000.GA17233@bogus>
References: <20190925184957.14338-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925184957.14338-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 20:49:56 +0200, Heiko Stuebner wrote:
> Newer Rockchip SoCs use a different IP for accessing special one-
> time-programmable memory, so add a binding for these controllers.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/nvmem/rockchip-otp.txt           | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
