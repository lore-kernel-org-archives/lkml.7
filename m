Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F74CC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0175620644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lr+O5/B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEHICj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:02:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34556 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEHICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:02:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so15570812wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lW7WPvS0BGszPgf22bfJoZtgKKh2N28a/QSwohBZbr8=;
        b=lr+O5/B0mr3yFBj3gucyu+7aRM6kkirSd0HWcJrx1iOguC0CdFSymKqv56EcXwGw0/
         Pm9EmV2CSSH3Fnv37oBNPGCTTOoo8NDkzbP4efMm+tcvdiSx66GzbeW2sfnyINs1wX5I
         PkhEDqhfVjl9VRv6lddMh+POF/EhIcDx21mQbcNiKZ7k6z8IAUrbRR1zDG69wSipQVM+
         r3tyClDm6HP9BGRSwBRb5EcvnNCxAelsaCC4kb/+t9QXIlBmYabC7n3bdTKMcwDKoaQO
         LD74S7jaGvjBkYVmZyuB/LimjmQLPaUIa1u6cvgqVWRvMBOB3WL9aP1fFUZqz9h57djj
         8THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lW7WPvS0BGszPgf22bfJoZtgKKh2N28a/QSwohBZbr8=;
        b=B+nc2Hu7zt5YPxvDH8HhRaaBSWIo4cIhFqyDTt3YPfCr8Be/fzHpkWycw4s2y2yKQ3
         0uxvu32xEKRwLQPs4YDBS9FBYvAZt3JM40RWN2hCF/07HjBj8WLJKpANy55Aqyy+E9pO
         79tcWBJ6EhwEIHBx/CtSSu0hkfUoOX+iy516jYgjiQ+rb1Jp3HhSxUkQ3yDJne7MSDnd
         0mCLZzKGXiy9Bo7k25Sqd+nSjxnAyp80PQJsmq8Uw4PWeehglZ9XXI+IcmFkvHn4/sco
         IhMVgi66QZUxoFsnh7oGEA9+x3E8AQO0gpIAo2gWPWTHJcBceiZuXKSDgJxoVFJEFaL5
         iJkQ==
X-Gm-Message-State: APjAAAXPv4DImfEoonGtoUYs1gEyqkqAo1PG6LA/8U5U55bHGVXrDLlM
        FQXqsXHgKFXWqqYhLDkf8D7HVw==
X-Google-Smtp-Source: APXvYqxTM7m8BRMjwLTWwpw8EixNZYqSmNK8dFtS5CxerzYfaEU5rADDWyznr8Pqz9IiBpzJA2BlFQ==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr569812wrn.156.1557302556362;
        Wed, 08 May 2019 01:02:36 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j190sm2658814wmb.19.2019.05.08.01.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:02:34 -0700 (PDT)
Date:   Wed, 8 May 2019 09:02:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org
Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Message-ID: <20190508080232.vzdyvmrqx2apfvlf@holly.lan>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190507174020.GH1747@sasha-vm>
 <CAFA6WYPk5Bm11RfaC72g_C8rnMQEPyp-MhtopmDM3Of31v1Z_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPk5Bm11RfaC72g_C8rnMQEPyp-MhtopmDM3Of31v1Z_w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 10:11:54AM +0530, Sumit Garg wrote:
> + TEE ML
> 
> Hi Sasha,
> 
> Firstly apologies for my comments here as I recently joined
> linux-integrity ML so I don't have other patches in my inbox. Also, it
> would be nice if you could cc TEE ML in future patches, so that people
> are aware of such interesting use-cases and may provide some feedback.

If this kind is desire exists then shouldn't it be captured in
MAINTAINERS?


Daniel.

> 
> On Tue, 7 May 2019 at 23:10, Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
> > >From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
> > >
> > >Changes since v2:
> > >
> > > - Drop the devicetree bindings patch (we don't add any new ones).
> > > - More code cleanups based on Jason Gunthorpe's review.
> > >
> > >Sasha Levin (2):
> > >  ftpm: firmware TPM running in TEE
> > >  ftpm: add documentation for ftpm driver
> >
> > Ping? Does anyone have any objections to this?
> >
> 
> From [PATCH v3 1/2] ftpm: firmware TPM running in TEE:
> 
> > +static const struct of_device_id of_ftpm_tee_ids[] = {
> > + { .compatible = "microsoft,ftpm" },
> > + { }
> > +};
> > +MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
> > +
> > +static struct platform_driver ftpm_tee_driver = {
> > + .driver = {
> > + .name = DRIVER_NAME,
> > + .of_match_table = of_match_ptr(of_ftpm_tee_ids),
> > + },
> > + .probe = ftpm_tee_probe,
> > + .remove = ftpm_tee_remove,
> > +};
> > +
> > +module_platform_driver(ftpm_tee_driver);
> 
> Here this fTPM driver (seems to communicate with OP-TEE based TA)
> should register on TEE bus [1] rather than platform bus as its actual
> dependency is on TEE driver rather than using deferred probe to meet
> its dependency. Have a look at OP-TEE based RNG driver here [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0fc1db9d105915021260eb241661b8e96f5c0f1a
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fe8b1cc6a03c46b3061e808256d39dcebd0d0f0
> 
> -Sumit
> 
> > --
> > Thanks,
> > Sasha
