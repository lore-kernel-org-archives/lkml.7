Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD743C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868DD23428
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O3LIh1Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfH3Mng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:43:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38360 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfH3Mng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:43:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id b2so3936938qtq.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3ZitNgFXrdayf4EBPMRNk2dQMSxsOg5aQdjNQBrLxV0=;
        b=O3LIh1VnGlkPOZRjsHo4nMuWtoEGAiQRYYoD6NNlNcGuu0FBYUlVYR6rh1cRtKftVu
         bT0oSnDd+W+W9nEf4LCrq0Z6XgY6fv2097uMGoIARrHecLnNcbEfoTF5tNdkG4mKMTyh
         d3qBjBhPbET10i0VH4df7MtHrExDfBIk8ELqFSBsx0Vgzq4SH/+xhTaobO1jGFgWOlxO
         2HPbu/l6Z6CCz+aMERDdMW3DXnp3MNiwVFPSdQoKWx4kiExb8Yu0RA7iLKFMKMcofpvT
         J253asUJtCWT6ATk/krqzemDRS4bnNEU3czn+uiR1hCHPsDh0ouB8YywBj2f4MR7mKkW
         grBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3ZitNgFXrdayf4EBPMRNk2dQMSxsOg5aQdjNQBrLxV0=;
        b=jirltCO4Rz6r+daFZ9zA3HEOl2axF0PRmcY7+iVCPqP/byBnowOIRZM2Sj3wovoeAD
         Ccfig2s/Vtw8qjKVDrMPudCWY8nG6Wjj+hb5AGR5wIcgH2WFbudNCrF0yUskTSF8r8uL
         Wk5wp91h7CmkrJysGgrECZaUYAlCHA2EFkLuS4UU9dbowVRSOdw2E1I3XPn4KsCZkP/u
         wajfIa7dmymLZUygyn0Psn06Rtam/sw4K/LBr5TneKHi25B2rqbagARFDKznOTmJAC41
         6iXIhe0TQvonVwoBPc9qlrkhk8ZBBE5EF5UIrqug55mVUvFczsyQNXr19YSmUoHNHVgf
         dljg==
X-Gm-Message-State: APjAAAUtRq1OUI4OAlnYZKHMpnpwQ3JMX2PmMFh8hLdyUbv7dZbHeFVe
        agyIw9o3JAQW3TvslMa7bHaySg==
X-Google-Smtp-Source: APXvYqxr7U5iMINGzaLcpnUhV5vvDu+v79cBheEV2BWbod9IlB4d2dpJ4rUyizeWdQ0pkITl4LBVqA==
X-Received: by 2002:ac8:478b:: with SMTP id k11mr15016996qtq.323.1567169015108;
        Fri, 30 Aug 2019 05:43:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id d134sm2141239qkg.133.2019.08.30.05.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 05:43:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i3gFa-0003Cg-4Q; Fri, 30 Aug 2019 09:43:34 -0300
Date:   Fri, 30 Aug 2019 09:43:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
Message-ID: <20190830124334.GA10004@ziepe.ca>
References: <20190830095639.4562-1-kkamagui@gmail.com>
 <20190830095639.4562-3-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830095639.4562-3-kkamagui@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 06:56:39PM +0900, Seunghun Han wrote:
> I got an AMD system which had a Ryzen Threadripper 1950X and MSI
> mainboard, and I had a problem with AMD's fTPM. My machine showed an error
> message below, and the fTPM didn't work because of it.
> 
> [  5.732084] tpm_crb MSFT0101:00: can't request region for resource
>              [mem 0x79b4f000-0x79b4ffff]
> [  5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> 
> When I saw the iomem, I found two fTPM regions were in the ACPI NVS area. 
> The regions are below.
> 
> 79a39000-79b6afff : ACPI Non-volatile Storage
>   79b4b000-79b4bfff : MSFT0101:00
>   79b4f000-79b4ffff : MSFT0101:00
> 
> After analyzing this issue, I found that crb_map_io() function called
> devm_ioremap_resource() and it failed. The ACPI NVS didn't allow the TPM
> CRB driver to assign a resource in it because a busy bit was set to
> the ACPI NVS area.
> 
> To support AMD's fTPM, I added a function to check intersects between
> the TPM region and ACPI NVS before it mapped the region. If some
> intersects are detected, the function just calls devm_ioremap() for
> a workaround. If there is no intersect, it calls devm_ioremap_resource().
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

This still seems to result in two drivers controlling the same
memory. Does this create bugs and races during resume?

Jason
