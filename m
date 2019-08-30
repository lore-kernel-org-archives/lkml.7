Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819CCC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4BC21897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GXget5Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfH3Oiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:38:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42837 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfH3Oiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:38:55 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so12457068iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jgvuX3mMmDJc/ezKItSFjRT6UTB3DxucqcXRUOj/zcI=;
        b=GXget5QqWcoVV20hrVl8z/734YXraq2fUD3DzCUj4gl3uabBS3UFzNf0ba0+YCbay7
         vog1JwlLXNOx8mQxUYV/a6YYm26t8RUPUGzw0MK0LVwAOcTOOB21n0qyBcqS0UjvNlOC
         kQgMcdNGGedkmoMSRrFZGpqfeWpLuSSe3EF8GyZyi/wEJCPDdTvPpw17Wht04TveC1LX
         qHFRlVmfR9Oic2M2iuBThZOXT14BchHEbKos5E0eQUDBc1ZjuuEjPVy+8VloXQnBs3p8
         dvN5ignrb8HBn2yxAA7tN9/746wKC7bfpUsRVbEfGj8+U3HevUHZ+FMJhQl6rzi+eMRR
         bNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jgvuX3mMmDJc/ezKItSFjRT6UTB3DxucqcXRUOj/zcI=;
        b=QBChnFSxpd2ob7MCx1Urt8v/P40IcBmgGvXWEnmmP8WNj7WpxppSGXVHiJN5lHKTuG
         MkGB948+QJTJT25U7bE2Xtk4pfZ+VtqjD1GSmw8KOSbLm07IGSVPYKFpbgqpfvufCWEG
         5qfGX6yxUm8FCFQom6VTsrvHG9ftIQ38Y822yq8pJU7UFvmeVj1uYJtOykwxiFd8+Rea
         hIjvR8ho1c5kiSmcscmmjPCyQAiLzbwR5xCoj1yUCKwdsd52K/l3PJD7bgw/8eNPIzOV
         lcnCubcAgmECjvoL77cMgsCizNYTo/mi8vul/L5HbUOaPp0N+KiWo+kELq6tv2/WjH/L
         k2ww==
X-Gm-Message-State: APjAAAX+Zixg95B/ybo7s/0NWWLo48OBbxmtzlyt3QUTdAzoEEHJtU3r
        yQnzSfngk+zpzCsAAIKOTgPkOw==
X-Google-Smtp-Source: APXvYqwqV4sqIOnC5JkzIybJh2aOhL5g7B/SiCPWu7FObtesW0RDKSiaWPbQGgAkjnQniKe/QwNt5w==
X-Received: by 2002:a5d:9282:: with SMTP id s2mr4066iom.283.1567175934280;
        Fri, 30 Aug 2019 07:38:54 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id z9sm8093916ior.79.2019.08.30.07.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 07:38:53 -0700 (PDT)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i3i3A-00005B-SD; Fri, 30 Aug 2019 11:38:52 -0300
Date:   Fri, 30 Aug 2019 11:38:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
Message-ID: <20190830143852.GA302@ziepe.ca>
References: <20190830095639.4562-1-kkamagui@gmail.com>
 <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca>
 <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:54:59PM +0900, Seunghun Han wrote:

> When I tested this patch in my machine, it seemed that ACPI NVS was
> saved after TPM CRB driver sent "TPM2_Shutdown(STATE)" to the fTPM
> while suspending. Then, ACPI NVS was restored while resuming.
> After resuming, PCRs didn't change and TPM2 tools such as
> tpm2_pcrlist, tpm2_extend, tpm2_getrandoms worked well.
> So, according to my test result, it seems that the patch doesn't
> create bugs and race during resume.

I have a feeling that is shear luck of link time ordering and not guarenteed??	

Jason
