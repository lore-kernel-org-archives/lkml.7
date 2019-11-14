Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FA5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F69206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ln3NbCfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNQ4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:56:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39289 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKNQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:56:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id 15so5579074qkh.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEt7mE3NlmcSAYBrfWxXnm5oc1z08XQBzX7blFZW3YM=;
        b=Ln3NbCfyyphUGctMBJPN1Evy417y1ng2dQdPseF+6NAmTNHhXfiLYSSYq8f06fkIpr
         MbyAqVa5yVDn1Cu9ukeg2CoNrPRQP9jzws0w8malWAqGe345/FP/lZpuk7iQUDYHchJY
         obluI9BCLAoJA5ics3DqOTe07uO7+JAxpLKiwmxZwLycwfNbH3AmvCw9ZBvyfjRX8OJX
         7eSKd3mbJRSBEUlhAzO3E2p4I+oa/lF6OFHqXrdXT279oiut1So/+fshDGXK+/P6L8QA
         wgWNz9l1LcJwow1YGMIYM9kqKI7o6rRlJ1nCUUiNWmTAYyKkfMdBCBxNfKJoLGQ4ZEKZ
         TgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEt7mE3NlmcSAYBrfWxXnm5oc1z08XQBzX7blFZW3YM=;
        b=ukLCXdR5r7TCtpGWx8XBqBNuNehgXwJ7s6shx9WCGd1WWTQLrnL/rnY1VsY7q/uVsf
         TEs70YSQCb8t9M7ahqDrkVIrZeokyP7Z8En+uvIoXGgkDSisHbFPQS9U1Mc57vWDcDUO
         4+3C9xAE2oJlxHhmN0pXS7Vm65kzBNVSfLmARgXyULUlUF7d9+kdDCwpEgUWld6FBuA0
         v1Z5FjQ+I6C85eovwD42vseE+Q+xtfnPHrJFRm/O6yS6U2ytpFEAqNy4MNFRh1Fo1hyw
         te0CzqyUVHgGJdpIHyAWBXB+myEIjcUP0qQPqr6jZEaYF0CXt6vRnj44mMgTLuofUYUU
         d5sQ==
X-Gm-Message-State: APjAAAVKJv/l56+GySF4uAF64qd6f9yTSSjeHyjgweQs9f58np+GgFiX
        yW51KV4/mZmnAJdofDPzv/ot9ZM1wGo=
X-Google-Smtp-Source: APXvYqxQE8WRBdBn+hiiaggtDJLmt7PKFZoGbqsJ3pDo6paBnbA6yB0zHjIFvPCFefq7Mjd0Dfp+ag==
X-Received: by 2002:a37:6189:: with SMTP id v131mr7847602qkb.489.1573750590124;
        Thu, 14 Nov 2019 08:56:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 27sm3554067qtu.71.2019.11.14.08.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 08:56:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVIQ1-00044H-Av; Thu, 14 Nov 2019 12:56:29 -0400
Date:   Thu, 14 Nov 2019 12:56:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191114165629.GC26068@ziepe.ca>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
 <20191114165357.GA11107@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114165357.GA11107@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 06:55:06PM +0200, Jarkko Sakkinen wrote:
> > Would it function with the timeout values set at the beginning of
> > tpm_tis_core_init (max values)?
> 
> tpm_get_timeouts() should be replaced with:
> 
> if (tpm_chip_start()) {
> 	dev_err(dev, "Could not get TPM timeouts and durations\n");
> 	rc = -ENODEV;
> 	goto out_err;
> }
> 
> tpm_stop_chip(chip);
> 
> tpm_get_timeouts() is called by tpm_auto_startup(). Also the function
> should be moved to tpm_chip.c and converted to a static function so
> that it won't be called from random cal sites like above.

Careful, the design here was to allow a driver to do only
get_timeouts, then additional setup work, then do auto_startup()

Forcing a driver to do auto_startup too early may not be good.

Jason
