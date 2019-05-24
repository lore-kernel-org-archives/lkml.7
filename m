Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEECC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43641205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMM7ilwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbfEXDDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:03:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34202 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbfEXDDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:03:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id u64so5988344oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 20:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/mticNGqlZT4FHVrZAivG939m0DEWwlRFOLuXxMIKc=;
        b=aMM7ilwXZ5jZQhsdIJHkTFnFk12H9TUIjfz/TTFCekyngUm/hGrnEakzz3Pf6djt4D
         DcaE0fCswN8n1CYD/dPWS49ayld8akpFyIHkG/OSg04RMOr1xHm4ggb00zKb1GsTlmhl
         DxR4xDmH0qbh673oo4ZxaoGCnfJTJdk0OGFX7nQvq0NzMBbPkZkwqD/aGTDdp3gGvhC9
         Ib+GzHRcelGy4AoffSX0+AaqaFPADhjBAGOwGg4k8uOgN7iZfEBOBCetKR/z+9Q81TjF
         Fr5hEWU7gsErRXDnpoMhNzBwL75aQbA9yjSu/f/9zaBs6Ku5lCJRvC1qntyTgJ8jL3av
         WX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/mticNGqlZT4FHVrZAivG939m0DEWwlRFOLuXxMIKc=;
        b=jwwVxPfkZb5gEP5548jvmY3Ln8vASyoiSRcelOL3MPEy6k7Pja6KnzxECH5uLSp4vO
         +yNuTV898jj3QtrhMICmh/YK7qxxM/UgJvsCFi7cAHwF8foXHRaOTeV6fbdUnwPslVnJ
         FjfyDpFED3OCjQEOoN8Sqrapnm/G9hDPsc5Z5C4mvTfWxsqOpQ8voJ3qUZ3IHFygMhAl
         POWk+tcYdIWGBSSQfagQx4rmrJ4+GMSiCxLfKy1IqehECdjWdzH/MfqG18rPNCByM/Oa
         zZMoNBa5MNa5uKtHvrg8KYX3Cmsw+uZ6FQpWvpyUtGU3hblAL7ewWXXx6Sd1x76FW9tK
         HhAA==
X-Gm-Message-State: APjAAAVrctK1I/FWS4ELgP3g5ZA5GuWyPLd58rKctfpWbkCHnSpyUpT5
        ULK8u14WZEhnMIyHaWJfVqLDANE/TiPb6xYd4Nw=
X-Google-Smtp-Source: APXvYqxPK8vbagl5ku5f4zn/OXi9FAw+sLQe1hcUrylW86bXhvq7dpjX4BoC9fSp2iLZkaZaqlbW2K9NCBXK2im4XEQ=
X-Received: by 2002:aca:72c5:: with SMTP id p188mr4633017oic.116.1558666989682;
 Thu, 23 May 2019 20:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190523053643.GA14465@kroah.com> <20190524023639.6773-1-gneukum1@gmail.com>
In-Reply-To: <20190524023639.6773-1-gneukum1@gmail.com>
From:   Geordan Neukum <gneukum1@gmail.com>
Date:   Fri, 24 May 2019 03:02:48 +0000
Message-ID: <CA+T6rvH0M2jy_FscF4RMseBKDpLMG8yukzzLjZuys_LY4SbOGA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: kpc2000: Add dependency on MFD_CORE to
 kconfig symbol 'KPC2000'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 2:38 AM Geordan Neukum <gneukum1@gmail.com> wrote:
> +       depends on MFD_CORE

In order for this to work in menuconfig, this either needs to be a
select or I need to
add a prompt to MFD_CORE. I don't have strong feelings either way, but all other
Kconfig options which are related to the MFD_CORE appear to do a straight
selection. Let me know what you think and I'll go that route.

Thanks,
Geordan
