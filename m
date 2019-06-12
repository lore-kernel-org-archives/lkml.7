Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4570DC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8BA21019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pc3Q4WLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfFLOdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:33:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33898 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbfFLOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:33:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so17210811wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5tpURbYw8ulSj4zNIAnwRv+mqsPvaMs89zHgCbwUorE=;
        b=pc3Q4WLwtyH/QqKBdbPVUglaSmeArsffZq21ZXYXzU0DRnR35+sY3tdGWBuagK0cZI
         wtd9n32LtCybJZK7GO1zh3tHmEwZHbWLSXmR2OOndJ9BVl9Gf5gPTc8tuRnaESo4WFrl
         lJlwyoVwN+S3JZ2O69BZoIUYNXBtDaFza1rrCroi5ISfOyaJRSe83xxkFeXAZUAsn0wE
         v89G7hLfRq6vxIPrlUc39q8Jq1j8+rYvCGITvtOAt5G8RjwVJkfvFbPAgYOEfCJQMODw
         mCcpaR4WPIwz31PgpOt3n3lOPHHz/aUkTS5liQDjdAbSnFydljdrrcrQ4SCJOqpB+exu
         08mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5tpURbYw8ulSj4zNIAnwRv+mqsPvaMs89zHgCbwUorE=;
        b=kr+gYuyQqkCUh8nTsxTrxyWvrLAQseQQlDqY/ocselEbY9JzifRgxvWC+RxjwBUbJn
         QuyqdnIa7SGPMBQ45dTt8GFSxaZRMcy1HFMEp8wFadukPy1YXpMsO4HsGiy2lRts1Muw
         RsUJDaAUjcYr6pBLRYgWMQYip70iYe4ozDcRUCbYUKItG1CNkceT0UI18xTMUa5buA0U
         h/ddvfFXn/juDZoaep1zsQG8F5vMzw2A6t4rD2rsvgn8VyPOedzamJu6Caf4b+NfIr2e
         dyL+yEZLj2YPbLnOgyFPM93r3/xHM/S0dSvcKpQPJIXe5NqCnjU26R3vv6wZ1qL09qUq
         eA2A==
X-Gm-Message-State: APjAAAWjjSf6PfZcPr82xwfWYJE1+yjvcrE5TcgxJb3nccVRlWibA1Io
        FbgVyHV53haJ1rPx41qlfGrtIg==
X-Google-Smtp-Source: APXvYqy3YGHWLFgs7/wW/TUEjrur0gU36dxTuCSlAFVwP2jci8YFavbg0zMWnihd20zFriRbKLVnCA==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr31381985wrl.134.1560350032633;
        Wed, 12 Jun 2019 07:33:52 -0700 (PDT)
Received: from dell ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id w67sm264912wma.24.2019.06.12.07.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 07:33:51 -0700 (PDT)
Date:   Wed, 12 Jun 2019 15:33:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: Re: [PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Message-ID: <20190612143350.GB4660@dell>
References: <20190516043218.8222-1-j-keerthy@ti.com>
 <20190516043218.8222-4-j-keerthy@ti.com>
 <20190522153528.GG8582@sirena.org.uk>
 <1712197d-7d43-38a8-efde-11b99537eae9@ti.com>
 <20190528132755.GK2456@sirena.org.uk>
 <e68d9939-a56a-b3c5-7f6d-e5783e16a6de@ti.com>
 <20190608195159.GA5316@sirena.org.uk>
 <20190610054822.GE4797@dell>
 <c58ef6cd-893e-c20f-f437-e0343aa83fea@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c58ef6cd-893e-c20f-f437-e0343aa83fea@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019, Keerthy wrote:

> 
> 
> On 10/06/19 11:18 AM, Lee Jones wrote:
> > On Sat, 08 Jun 2019, Mark Brown wrote:
> > 
> > > On Sat, Jun 08, 2019 at 09:26:31AM +0530, keerthy wrote:
> > > 
> > > > mfd patches are on linux-next already. Hope you can pull this one now that
> > > > dependencies are met.
> > > 
> > > Someone will need to send me a copy of the patch, if I acked it I was
> > > expecting it to go in with the MFD changes.
> > 
> > There is/was no need for that.  Patches are built-time orthogonal.
> 
> Sorry i am still not clear. Should i resend this patch?

Yes.  It sounds like Mark no longer has the patch to apply.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
