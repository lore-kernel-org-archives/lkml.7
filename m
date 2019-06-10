Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6358C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863D520863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcJdLTor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbfFJFs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 01:48:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42880 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387464AbfFJFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 01:48:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so7763752wrl.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 22:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UqTMfvdUN4l4dmfUrLpLCLxSB+Co9swJe7W/3oUlri0=;
        b=tcJdLTorzCf4nvzqeoyQF2XfPfTYL490JDW0DOUImon5g5L3pLvtatzry6AKu3ahJw
         zM9dC1SF0n2o3vxGe/b9rpXN3ZdXKACyvUcegPGCc3TPpYVUk6SZ+Mv/wJOSUb3F9ZQ1
         VzJFUDXsDX+i4wAujIYBm2L09Q1IyNHrXgacLWKslptpyzU1jyZGwvBeZ48HxhZy/0jG
         gJo7dINUS1p3HVnTu+DvaZx7jc4z6RBcFA7GWbgEcH5V21D7pG/VeVTAaD1jGRfGlhnw
         cV179tidSdxtnzxNCzFnWwibq35ErWEeGSHqsAaR80//LhCE1zygrHaFYRJKdKVNA2ou
         swlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UqTMfvdUN4l4dmfUrLpLCLxSB+Co9swJe7W/3oUlri0=;
        b=i4CP970YxMZ260aPqMRLtjPoeIxk9PpWUpZPLD2KjwB4WXohhivISuymEf8O/LUOif
         ISg8i/CQM5Sd4so22n6ETwERV5qB4+LsofWX9ApqJNuyUxToBSUymaU9Wx1JvqItKo05
         664jygULr/9FNzj0+jDeCMmOGQ5lHhEaCGcH1sYNS/oCVveqLYv3BvUXX4BI9QsFXvQ4
         CxsTOuvr+gJZmERW4ZHnGavQsgIzSJDWZO4iyQkVoXdUH984mSnbfh8eXDwArsNP9FBv
         g7JllF7MdQreTcCaS3CS7Ll9SFmpBULNJGcSk1lFnjs+pwhEesj4EyeZsu5s/ukMUeK9
         pW3w==
X-Gm-Message-State: APjAAAWWmjTs24slT3X6laX4hPvQK17OSJf6F0bu2/r9HTqySJVN/3/q
        2N00cpz18tzCYJ+Bd/ph9AehiQ==
X-Google-Smtp-Source: APXvYqwsrG8dkGOUshS3cNu9PxOmmzcafSURYr1r2F+1zsSm5ObYfNFi3/TpWb7kqnrdPh7vZpSZtw==
X-Received: by 2002:adf:db4c:: with SMTP id f12mr20398326wrj.276.1560145704642;
        Sun, 09 Jun 2019 22:48:24 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id d10sm9750323wrp.74.2019.06.09.22.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 22:48:24 -0700 (PDT)
Date:   Mon, 10 Jun 2019 06:48:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: Re: [PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Message-ID: <20190610054822.GE4797@dell>
References: <20190516043218.8222-1-j-keerthy@ti.com>
 <20190516043218.8222-4-j-keerthy@ti.com>
 <20190522153528.GG8582@sirena.org.uk>
 <1712197d-7d43-38a8-efde-11b99537eae9@ti.com>
 <20190528132755.GK2456@sirena.org.uk>
 <e68d9939-a56a-b3c5-7f6d-e5783e16a6de@ti.com>
 <20190608195159.GA5316@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190608195159.GA5316@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Jun 2019, Mark Brown wrote:

> On Sat, Jun 08, 2019 at 09:26:31AM +0530, keerthy wrote:
> 
> > mfd patches are on linux-next already. Hope you can pull this one now that
> > dependencies are met.
> 
> Someone will need to send me a copy of the patch, if I acked it I was
> expecting it to go in with the MFD changes.

There is/was no need for that.  Patches are built-time orthogonal.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
