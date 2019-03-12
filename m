Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EBA206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552408774;
	bh=CqXWuWpNs+h6BJSaO51k8J/NJKen9UakOO47VfM8+1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZdEPJ/wDS6HJmbvgsCJ79tnBHBsAv7tsRawatFgdVo2HffGp56MMf7ZzlFunsGybB
	 o368aDq9Ytoybd6Bvz28sH4Dxd80W6S53PXX59jCn5mhMNAq22mJcVY7xpAHl1bm3R
	 vYXRujzQrwVNIgH5hcaWgLMBT/TcKaojPYBw+G0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCLQjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:39:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45880 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLQjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:39:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id t82so2591248oie.12;
        Tue, 12 Mar 2019 09:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M7xF05yE85z4mfam/PqBmB77ngvRVE0X32ViJl3jP4I=;
        b=S0hIGuLzElw59g/1ccwVVA+Y65xUWYSjKERj7oJlutO7y3cSJiaptknL3XgLOsttbN
         dN2ixCoTJhKLFo3ysS+WYQDr9HAjVccqay3EYFipKe/FkVVOi3J11YZKYPNFQgNPnZxe
         DgCP6nL9aL4qGcAaUi/SCPkND6iUXasQkLpj5sibiaHiM0Hbwt9VshfWhGCZCyEujq2H
         wee3neO/D4RCIUS6lVYoury604jv/mZHZ2QetAkInAIYY1uaglJ5SFtNXljVq5iH88ag
         B0Tr5vS8n51L4otNMVK8PJPLU0e0IVZfL1TguUF93kF5LWaia6kx68Mi8KV2h5DmRlPN
         0oyA==
X-Gm-Message-State: APjAAAV5MoCxX/Cb9nF/VjSYWcgLJICSPiQw+SQO9TOqB1/wykXwpRhF
        88UkqD/7/iC6X2H62U+wAw==
X-Google-Smtp-Source: APXvYqzBiiI21E03qQ4mTRm1aCtHeS6vjXq9jykO04AX7HeLVHDAuYoV4Yj31lr1nD3O4cc2QAyDpw==
X-Received: by 2002:aca:3887:: with SMTP id f129mr2342719oia.139.1552408771691;
        Tue, 12 Mar 2019 09:39:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 97sm3743928otc.25.2019.03.12.09.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:39:31 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:39:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        arnd@arndb.de, davem@davemloft.net, gregkh@linuxfoundation.org,
        johan@kernel.org, khilman@baylibre.com, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, songqiang1304521@gmail.com, treding@nvidia.com,
        techsupport@maxbotix.com
Subject: Re: [PATCH v2 2/4] dt-bindings: maxbotix,i2cxl: Add MaxBotix i2c
 ultrasonic rangers
Message-ID: <20190312163930.GA30288@bogus>
References: <20190301134225.susjgtck4iktkbeg@arbad>
 <20190302182639.48e73885@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302182639.48e73885@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 06:26:39PM +0000, Jonathan Cameron wrote:
> On Fri, 1 Mar 2019 14:42:27 +0100
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
> > Add doc for dt binding maxbotix,i2cxl. This binding is for MaxBotix
> > I2CXL-MaxSonar ultrasonic rangers which share a common i2c interface.
> 
> I'm a bit confused on the naming. Certainly the binding should have
> separate entries for each supported part, rather than a group one
> for their i2cxl naming.  Having said that they do have a wide
> range of parts with only the one datasheet.
> 
> Rob, what do you think?  Go with this i2cxl naming
> or list the individual supported parts?

Looks like the difference is mainly just the range. Is that something 
s/w needs to know about?

> 
> mb1202, mb1212, mb1222, mb1232, mb1242, mb7040, 
> mb7137?

OTOH, that's not really too many.

Rob
