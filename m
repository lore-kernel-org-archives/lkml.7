Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E9DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506A2206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNUFdEtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfHMMQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:16:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37353 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHMMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:16:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id 129so4598697pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HVlLJiIzjaXDxFFkRwCgsS9CVo3aI/KKzGwIYcEyzZU=;
        b=XNUFdEtT15n7SWbDoymnDWB6S1FHl3jTRMDvFq1tpn+deX4cDMtdSaifhruzfd5utA
         Zm6EOCAz2i2aXTj/LvosazkuB1chumYOVHkJVyOztRrzdHDgtxXKQsag4uSefxubT8x+
         x8F9fAzkGkBc7u9QgBuN/hq7bzEW/tmUINBC0DuoIUPEe455xY7RjQ2NFB3+cTbPFKny
         eYCN6EhLj+4oY6s+oDAWKtGbhZo4r+HhznjjdW37EgA0ODTPkQnXJkWn5QB6sCpwgMb9
         3jfjohhGwfSx4Y7y23bjrgF8Dgs8wqn4QCUrhRRoUK+AqAEGBXjikFMhsCwTCF9uuNa7
         1VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HVlLJiIzjaXDxFFkRwCgsS9CVo3aI/KKzGwIYcEyzZU=;
        b=YDHbMTSBjTQ02wHrJFizGFiIn5HnaeQLMUDpAaftiQSkPhrTKl6ZMUPPfNqqUVHbEA
         PVXpr+hNwzq7uNcJgm3qD7CxJozVuW4mF9q5+YkQgMcR3r+k8j9Q5LlEt0RqU5xXf84q
         HUteMUgUs9yIbC1hD8iQhsPfWfKE19QuLWenvHcNo9rIh66HqmtirtMB/olerpzPMQz5
         GKq8FMIWqGmInvk0pNlEzXO/hgGs29Xlu7MevL/hlWzLmNtKxu6SySaD8FRHFMGfONXK
         78o4nmjzKQg5/n275hnyaW5VnMtUPjI/KJD9UbRzvZHORyBIVsDThJ5ub6GMtKlq3jdF
         madQ==
X-Gm-Message-State: APjAAAXc1pfd6OhPsypzSrCw6rel9rSRbRum4QPraWxLBYPhKYDEzVOp
        HEOw9jC1TxAupB0iUxGu1Oih
X-Google-Smtp-Source: APXvYqyqBDGNMo4tLSC5P2L0ZMq6zP+MdPBF4+rrYMx7vSuFUW2VLy1NayISlC8n8x8eROfvPHOiTw==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr1936580pjb.68.1565698569207;
        Tue, 13 Aug 2019 05:16:09 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:649c:6ce0:9d44:669c:5d6c:bc5f])
        by smtp.gmail.com with ESMTPSA id o24sm200027991pfp.135.2019.08.13.05.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 05:16:08 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:46:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com
Subject: Re: [PATCH v2 1/3] dt-bindings: media: i2c: Add IMX290 CMOS sensor
 binding
Message-ID: <20190813121601.GB29378@Mani-XPS-13-9360>
References: <20190806130938.19916-1-manivannan.sadhasivam@linaro.org>
 <20190806130938.19916-2-manivannan.sadhasivam@linaro.org>
 <20190813115427.GC2527@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813115427.GC2527@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 02:54:27PM +0300, Sakari Ailus wrote:
> On Tue, Aug 06, 2019 at 06:39:36PM +0530, Manivannan Sadhasivam wrote:
> ...
> > +Required Properties:
> > +- compatible: Should be "sony,imx290"
> > +- reg: I2C bus address of the device
> > +- clocks: Reference to the xclk clock.
> > +- clock-names: Should be "xclk".
> > +- clock-frequency: Frequency of the xclk clock.
> > +- vdddo-supply: Sensor digital IO regulator.
> > +- vdda-supply: Sensor analog regulator.
> > +- vddd-supply: Sensor digital core regulator.
> 
> Could you also add the link-frequencies property, please?
> 

Sure, will do.

Thanks,
Mani

> -- 
> Sakari Ailus
