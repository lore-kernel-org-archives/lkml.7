Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BA6C3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 04:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C53217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 04:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIbJwD7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgADEdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 23:33:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58949 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgADEdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 23:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578112387;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=EH4HIVfE1g94Oc74sF5uvgjnl7asPTcL1vJBmw2UA5M=;
        b=YIbJwD7mcBsX6d4qY4gt9+Rr/38b8YT1eeOgcgjti5d3IfuZE+w2YYgJuw/qvH+J2P0WpL
        kWfEvN6aUpLKFA/FLzzK9bOdcBeS+l6V7vmmcw0zBzR1D/gfPfwz7VE/h+FMe8zVHjjLQD
        pSr9MSzeLeJPCKHlSFYggodMrs0Grc0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-3mc9jl6dOTOJjEWrhtMAeg-1; Fri, 03 Jan 2020 23:33:03 -0500
X-MC-Unique: 3mc9jl6dOTOJjEWrhtMAeg-1
Received: by mail-yb1-f199.google.com with SMTP id k190so2187789yba.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 20:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EH4HIVfE1g94Oc74sF5uvgjnl7asPTcL1vJBmw2UA5M=;
        b=YXYApPle7KruHey41dSVKc+LlS433fTq4dOLSic9BrHk1j4CFMT95Hds5ViThp528e
         q8PnXO640F7iArHdPeCJg2Ib3DvPqWGcrLtok6od0qTiRhHzpBr59BZRrBctVYW2yv70
         ssLdhHPGXRJ2qXH8M8z+Mwf1IDuzZI6fEuzL6eaB+I5Zr1NhBskk6S5JztZctewLAHzr
         s6c+yyDci3UbaJ5jmx9UenQ8ghdietGc5NaNfqGWs0erDe9OvRNH24tk9L+H6c9M8t6b
         sF5c+Uz8J4F//S/IXeSsu6G5rwFvXeDe/kI9RDVueg2abtG0gxcC8ouD/sD33zXAnSCh
         egtw==
X-Gm-Message-State: APjAAAX+93zmUfBxQs5ImYDJUV+J9xSd908PUk3pzM7izwZnurpNkp/b
        Sf6+bJe/inb8C1IbArCrdjUNZTeeohI7k+tIp08V2+D9xMivSloiTFe1fPMffRz7dHkhUFxCmEk
        YWtiQU/phHFurH4/z5pVhWRQB
X-Received: by 2002:a81:2f04:: with SMTP id v4mr64921588ywv.341.1578112382616;
        Fri, 03 Jan 2020 20:33:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYrucKBjExCaCtPyxX/ykitdGBb5WIYegTI6Se0XwSbgJhV2yWefwN68nViIpFEk+rJGnJmA==
X-Received: by 2002:a81:2f04:: with SMTP id v4mr64921565ywv.341.1578112382327;
        Fri, 03 Jan 2020 20:33:02 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z12sm24661864ywl.27.2020.01.03.20.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 20:33:01 -0800 (PST)
Date:   Fri, 3 Jan 2020 21:32:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH for-linus-v5.5-rc6 0/3] TPM changes for v5.5-rc6
Message-ID: <20200104043259.krg7uo6q7owg4fka@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20200103232935.11314-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200103232935.11314-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jan 04 20, Jarkko Sakkinen wrote:
>There has been a bunch of reports (one from kernel bugzilla linked)
>reporting that when this commit is applied it causes on some machines
>boot freezes.
>
>Unfortunately hardware where this commit causes a failure is not widely
>available (only one I'm aware is Lenovo T490), which means we cannot
>predict yet how long it will take to properly fix tpm_tis interrupt
>probing.
>
>Thus, the least worst short term action is to revert the code to the
>state before this commit. In long term we need fix the tpm_tis probing
>code to work on machines that Stefan's code was supposed to fix.
>
>Link: https://bugzilla.kernel.org/show_bug.cgi?id=205935
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>
>Jarkko Sakkinen (1):
>  tpm: Revert "tpm_tis: reserve chip for duration of tpm_tis_core_init"
>
>Stefan Berger (2):
>  tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for
>    interrupts"
>  tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's"
>
> drivers/char/tpm/tpm_tis_core.c | 34 +++++++++++++++------------------
> 1 file changed, 15 insertions(+), 19 deletions(-)
>
>-- 
>2.20.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

