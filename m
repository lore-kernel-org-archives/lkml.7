Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE62FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E388021D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571323653;
	bh=bY/VafwpVthFD/FxhIEMVzABCKxfcnbJ1BrKllziJc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BAI19H2/rbbteQHqGjCLsrBc4/e/gwmEQQv53XD/XyZGv+09gDjk1WA1s1kZ8DdXv
	 toxAOkgJubBCiFLAOMfSR8GEIMNLRXGyQZ4yTW4XmMsqc91QVbK/C7RF9T6YvyMh6P
	 dWm4gVXY8ohn4kdQCz2VfYW2h84X1IpMt3MFvR30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502978AbfJQOrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:47:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41581 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502912AbfJQOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:47:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id g13so2099227otp.8;
        Thu, 17 Oct 2019 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z80ioQYPpNmtk8h1xfkOdNkYcIk//+vGn82l24tC3Ec=;
        b=ayFVzTCztGpLtHspAthIPiMYYdPoNhmCaXJgQ+lV9/WwBkYzWFUJVF0zu1pjx7BMJX
         nEhEcRbq4j85JmRtBKWx+3vAt54mCp7lfZdLBn8nBQoJSkslmZBS4sjpvsco0moLHWsS
         /D79Dt/zK9hTR6unTy9yPmyes47Q6a3HNP1loaUEPRMKNXJoteJ+DNGJ9vV2BKxA/kfZ
         acO+lAm++1UshfO54ZsCnsy5A1C04iZH9IoCY1NvmrClYdxAo5o+aEHeFfN2PF9Atp5l
         VPEf18TAOwSuU+yzNZrClJ6cYwRAGE7xuNYgYkp0TdL+ZY64kEwAaR5bsOB1fDIPGRjF
         lQbQ==
X-Gm-Message-State: APjAAAUzLXPU+TIwYEAz8v9ClPNKQ9lCSxPfreSYlInq/Bic9J27aSn6
        SxrM+bTroocV1j9Pko77Yw==
X-Google-Smtp-Source: APXvYqxedbXcwY+kWj3j3VwNg1snNtfWuxZ2dsQ49jnmZZAQU7CyljXQg+V0/vcDbf7GjJYWKlOB0Q==
X-Received: by 2002:a9d:6858:: with SMTP id c24mr3254047oto.124.1571323649229;
        Thu, 17 Oct 2019 07:47:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm636635otb.65.2019.10.17.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:47:28 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:47:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC][PATCH v3 08/11] dt-bindings: usb: generic: Add
 role-switch-default-host binding
Message-ID: <20191017144727.GA27542@bogus>
References: <20191016033340.1288-1-john.stultz@linaro.org>
 <20191016033340.1288-9-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016033340.1288-9-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 03:33:37 +0000, John Stultz wrote:
> Add binding to configure the default role the controller
> assumes is host mode when the usb role is USB_ROLE_NONE.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/generic.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
