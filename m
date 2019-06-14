Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1403C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785452133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcjQ3DXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFNFnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:43:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33728 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNFnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:43:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so854575lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 22:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVIR1GkNWFjgCo6n/lJ9j+Zokzf1PhIsv8AWYg66O4c=;
        b=OcjQ3DXZXxZGUJfGsHVs16bdUSPIXCoPO6rd+Em3canK5qP0jdrlME/SkH1ZpiBa5e
         6En68VCQ0h1bHVeaZ5dk7+uUmItuqcCKFVMh6qwufvSmXVZlBM4Q5L/ajY8cwPIgqCd8
         RmBSdwPO2hJg6BicZwSWWVw4/Nwxc8co02DUZy/HIqDQm6OZk7yAmI8/Mugy3BMvyLd4
         rS8Zi6WkKqstpFv7VA+TvY/Y3t7DkznCLtOsQ/c8oQjJFc1V7MXNQuwP/UZoDaOcUoUg
         tukyJ7OWFISkcvvz45rrVwlIrJUEHau2u1L45fQPLkh57gu28RkmLzFxen4iEOzcVMRH
         YCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVIR1GkNWFjgCo6n/lJ9j+Zokzf1PhIsv8AWYg66O4c=;
        b=drrX7tdSR69ybBP1b+Vzq47UlPIy8Jhsi2fkdgPvMrhqG6Tyegjla4a64hEVJ/bHHj
         K/rY4uzTo7/0KWZUZZDWW38azMzxL+TONYE3VZ0QPmu5/AJC9R01Cs6gnGbVHeghvlQl
         8t84iyMrcXnU14TY9l/S4zU1ebOZ69FeJm/i9t8CUheXTcslTO23FXxCnJ7akiX0/HHu
         +GHYlyOde6r5xvVKKsgU7/W1xZwpKocOuAylqJXYC64J8ohSYfWVnLCHjlHX5Yz+ed1c
         YcE/XCGz/MSvvR4tVZVPbDVqZ1cLdOY3FHocThP7COYhBY+0yrjcRfWXi8AnP5C8GlVh
         rLUA==
X-Gm-Message-State: APjAAAVoeGxNKmMB1MKXPqzsv3SvbAImT3R77SdSSutDjWszeB/u8vSa
        FBoTZj0OR1EHXHwl2uHIkT4H5oknHKbV/pLBI33rfA==
X-Google-Smtp-Source: APXvYqxj5PpnHtG+YRTVNxCmORSFhlhBSVXH7J3GGA/xbCqCGA6/OMvH04SkOMSY5qASjDsZtJWfbvmI5TkJT9aHrNw=
X-Received: by 2002:ac2:5094:: with SMTP id f20mr48938479lfm.186.1560491029117;
 Thu, 13 Jun 2019 22:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-5-git-send-email-sumit.garg@linaro.org> <20190613153202.GF18488@linux.intel.com>
In-Reply-To: <20190613153202.GF18488@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Jun 2019 11:13:38 +0530
Message-ID: <CAFA6WYOe19cOSNUdWvwg-FaXeU5_cev=OpsFYJp020bUrxWxow@mail.gmail.com>
Subject: Re: [RFC 4/7] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 at 21:02, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 04:00:30PM +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key.
> >
> > Refer to Documentation/tee.txt for detailed information about TEE.
> >
> > Approach taken in this patch acts as an alternative to a TPM device in case
> > platform doesn't possess one.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> How does this interact with the trusted module? Why there is no update
> to security/keys/trusted-encrypted.txt?
>

You already found documentation patch [1].

> Somehow the existing trusted module needs to be re-architected to work
> with either. Otherwise, this will turn out to be a mess.
>

See my reply on this patch [1].

[1] [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys

-Sumit

> /Jarkko
