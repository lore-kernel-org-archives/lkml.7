Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA75C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA330206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553793064;
	bh=qfTK6Cz6DUF/wNOyd0AeQ6hCoCEJx4ssNMIZW03UqU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KQN6O1q50pCvg9SxldOgi7ByIUXWKssS1FAAqV4XVjw46Agi+6mAgsYCJjrs4OZ7X
	 8q/TGMK6RT/oe38dKxH36+oYLHTcA5U26fCqJY5LSHo+Rj+8D7yWOGtp+2pqFawF9u
	 2GS1zcTcGpgnUy2zDb3Em6rCPic5pJDFjnL8UT80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfC1RLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:11:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40880 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1RLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:11:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id 3so16372529oir.7;
        Thu, 28 Mar 2019 10:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2PifHClGCLanaNSQPBR78NEYXuqNhnO5B4xpO9+kUE=;
        b=cJhEWC0YbaBaxFxjhqG2nu28C8yZdcE5IEoW4gQkdqbnY9fWOX/NMw0Q8vr4iZSn7S
         9yYK5pUtNwANgohfLUCDUwrv/v3D0rt0ppO3zgupk1HdfPDje26fOHCwhSkZ2X7CPyk4
         98rtXbXasoCis05rtnyCEbooRxJKQSZRrIYQ7HwdoFJRHJw1+aWPfnyYN/HhB/7Skeaq
         cTzciRa0bSxaGNhMag8TK/AMaAAd3WQOUegFUxoaJEDI4GZYsjY9zE0nc+V4l0kBlm7i
         i6iyNxi2W/XZPPDbrD9SdGtiDWV6DaEvW+Rbe7+6pAiR1aIhQojwWWI6EsgvC2NZPvZ+
         a+uQ==
X-Gm-Message-State: APjAAAWXs9PXhn1fT7TyJlJBgvK30sZ6LsZDe1bRkQVRr9FAHtNRxTK5
        ua9bvjJ5qNWcTCkJ081EEEajZuE7Qg==
X-Google-Smtp-Source: APXvYqzaAShYBNGi0XBqbIXzYRJQCUlYMyZGg041PIsxQv0F/+S70GPnS1B9fPZ6zFoc7iFWy46zfw==
X-Received: by 2002:aca:d409:: with SMTP id l9mr808282oig.98.1553793062428;
        Thu, 28 Mar 2019 10:11:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a16sm2582918otl.4.2019.03.28.10.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:11:01 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:11:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com, Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v4 01/12] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
Message-ID: <20190328171101.GA25451@bogus>
References: <20190316035342.77998-1-chenyu56@huawei.com>
 <20190316035342.77998-2-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316035342.77998-2-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 11:53:31 +0800, Yu Chen wrote:
> This patch adds binding documentation for supporting the hi3660 usb
> phy on boards like the HiKey960.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v1:
> * Fix some format error as suggested by Rob.
> v2:
> * Change hi3660 usb PHY to hi3660 USB PHY
> v3:
> * Make device node a subnode of usb3_otg_bc register.
> v4:
> * Remove "hisilicon,usb3-otg-bc-syscon" property
> ---
> ---
>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt    | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
