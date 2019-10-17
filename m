Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38799C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C14D20820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T00cp7pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437988AbfJQHbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:31:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36649 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfJQHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:31:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so507675wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8OEfVQbrvR0wmfK2+kxKZvqgQERq/GULj0cPgfTphk4=;
        b=T00cp7pMvFvno4cXfCiVwYpqGiV0JJBYnQZt+ziJEYucsSUJPndzZb00evjNLP9/Ot
         yQNHtxVVZrVZEHR9fe/9koTnuauXhwj0QATHUqETYDvkxucZKLnK6vUrF7ygFHZG/j2z
         0zwpedtcaTcezRT85ahJEsdw1GYnCPVjtn6vKvKUXq5/9rwv5gJo3iT4ESioraPB7EV4
         FdNaOp93VJXHBTh+CDcOtUbJjpHEgd2Z9kGtOKe9Qd5iVVdFiJP7jgocJp9onN8V0lP6
         Y060ztZWjRYrNTtJFZw6H1/04NXZkcFPb+YO5N11I331Uy+20BHZC2zP229dcIuFMWZZ
         6vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8OEfVQbrvR0wmfK2+kxKZvqgQERq/GULj0cPgfTphk4=;
        b=M2cSek0ZvDxnge2XJFqDAFK+i8V53jqy42I/o3XO6uXj7xP8ZGjNFkJfpNh2fsr4bd
         XvnI0d/CuGs7u9Bbgq+mxcU0VFNHnucaaq9u6yvQJT++Y4Qpr0yH//qBp8C6OaYMTS3u
         PhoMHhS3YuwqbEORqwMRzZaFdEXTDnGVoYaZZeqZ4+fI7vN7iuY8YNbO/d8Ac+vjt6OE
         9JUoa1K6nEOPSvM9gqc2HMGKIjMYjmAzj+HPZzM7pQ6vfYXtWXuGMWbB/uBwGm0kxZjo
         2skYxNGQ3TBUOPMHkZ1RBHdjX9NDKwOaMpjXyYqW/yR2JxhW6cEuie37Pvb8LDTwWPGD
         N88Q==
X-Gm-Message-State: APjAAAUzoQYxe/LBFc7Y8lH7MP3cvRhqijxiC8IIK/MjZVUCQunImRB/
        xtJ919O2OwPBkn5zcTr/ClHkag==
X-Google-Smtp-Source: APXvYqx0CVBeGKj+ANau+LA0DSzLjhV41Uq6n59ElB8MNaWs2uVBueoHrhpXdeGcdFR/pG5+lOApGw==
X-Received: by 2002:a5d:4010:: with SMTP id n16mr1647855wrp.152.1571297478278;
        Thu, 17 Oct 2019 00:31:18 -0700 (PDT)
Received: from dell ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id 26sm1327674wmf.20.2019.10.17.00.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 00:31:17 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:31:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tuowen Zhao <ztuowen@gmail.com>, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        mcgrof@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v5 0/4] Fix MTRR bug for intel-lpss-pci
Message-ID: <20191017073116.GM4365@dell>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
 <20191017071409.GC32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017071409.GC32742@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Andy Shevchenko wrote:

> On Wed, Oct 16, 2019 at 03:06:25PM -0600, Tuowen Zhao wrote:
> > Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> > in MTRR. This will cause the system to hang during boot. If possible,
> > this bug could be corrected with a firmware update.
> > 
> > Previous version: https://lkml.org/lkml/2019/10/14/575
> > 
> > Changes from previous version:
> > 
> >  * implement ioremap_uc for sparc64
> >  * split docs changes to not CC stable (doc location moved since 5.3)
> > 
> 
> It forgot to explicitly mention through which tree is supposed to go.
> I think it's MFD one, correct?

To be fair, that's not really up to the submitter to decide.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
