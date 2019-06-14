Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DE1C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C774720850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2taeimw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfFNFNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:13:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41091 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfFNFNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:13:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id s21so992608lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEcwvzDbZgh36sf0IDCKh8szy53wV/GjfhuFB+x9+B0=;
        b=s2taeimw3XvFPIL11YwD/5Yw5TcIPVUvT8+tgj8+2Zyh6SVTrHyyk/EJ/JCRhF//fw
         A+2S86fznNpPTwxq6Z0Bo5GwbrLr1ETUBE+fCUiWfHDy1ry0/FU40X1JPxwHJSHuXyNs
         cBnVNupPUiBNNCRN3y+IPUsKOnnTSZktQaPAjCRCitcR6kesm+/CYpQuV2lCmEz7xVus
         44bJ1huXCH/7TA4XaXN41ZX5NREeKaKbP5Kc0dvkrvA+KzT3qyTQbm4k5yQVfqsl5URy
         v4i22cjKfuvWrpRAt8la5w1JBjqVB2nGrhkF+DHEv6AlOQgyvmJ3+axF4XxaBBvqGaIR
         4wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEcwvzDbZgh36sf0IDCKh8szy53wV/GjfhuFB+x9+B0=;
        b=uG0ip1MK0j/pLVsAYBqmfObQahijE5nw3UnbT8HgTHQWuFUybBl/7ojgt9ygqWbfv9
         PhuWChgIp31nfKc2mhlsne8bbIUdCNg6snGoJK4/UqhG4SGbFg6R1TXu2XengiWxRKlf
         wvSrE5994qg3P5f83YNVrqftoHP9asSLscOb3iWwX5t6G1rNb7clM3BEChRDc43QqX8w
         muUKe2DJGwMZfHNgwSpT+DqGmmjPkYr1hw5iUkXVf+QWyBb5S92HaYJKn+YOhorILZwV
         2bVGqfNO7E1z1G/jeYD1abUxJGxA+pFvyF2C/r9Q/LeiZ0kC0QzhZC7PMKYB+6MhFb4v
         pXGg==
X-Gm-Message-State: APjAAAWtbbGbrqAS8iwlzKPxu2G5og7WqYZBrsyb7fmbP03XvTPOmY9K
        PTMCmMGMX8qlqiyxgoROinUnqLJEpLjjjwsyG56ygw==
X-Google-Smtp-Source: APXvYqyMLEhKd1WWY+BA07+pXv1UfARrC4yw3pAYgqbxqGyINCZlSFS8u3RnkH7fTLodB4y6NuAlY19vyYH/44JgWfg=
X-Received: by 2002:a2e:85d4:: with SMTP id h20mr14940805ljj.142.1560489215802;
 Thu, 13 Jun 2019 22:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-3-git-send-email-sumit.garg@linaro.org> <20190613152003.GE18488@linux.intel.com>
In-Reply-To: <20190613152003.GE18488@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Jun 2019 10:43:24 +0530
Message-ID: <CAFA6WYOqMaLDBZSY5GYUc=p2GqtpujLfHo4OjqX83q-0aGD1bw@mail.gmail.com>
Subject: Re: [RFC 2/7] tee: enable support to register kernel memory
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

On Thu, 13 Jun 2019 at 20:50, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 04:00:28PM +0530, Sumit Garg wrote:
> > Enable support to register kernel memory reference with TEE. This change
> > will allow TEE bus drivers to register memory references.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Thanks.

-Sumit

> /Jarkko
