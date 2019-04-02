Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5855DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B5420883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554212030;
	bh=AlIQL+QQwTF2a7ewomx0uODQ0IiKBqz7M7AXoj0J1+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z7DV3/tzfr/BI2hPcPgy9Xj3+DiL03mj9SOYhwAGTv3DFsCAWeAWosmoC29w1CSK3
	 R+YoAvQWpjfiq0DG2nAECPLvY1hgxX04gRvGfH8F31UPRNy+RZneqHAhggSgG2/U3n
	 N2/e2x9Ml9nlXFxl5Q0NS/4fdTdzBqjH+tjApYfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfDBNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:33:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45566 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfDBNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:33:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so11962939otk.12;
        Tue, 02 Apr 2019 06:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6aeOC7SVpLFSszfhznLaB+QdrlYI8qSl4PkyhTfLSWk=;
        b=U7tCaBRXImTi4qHyTp+ZfQl9Ucm9itgC/FIVWEh9nvvmAT6xKc9dS5tamRgHBdQjSe
         2EHHVOBQSCAfRRvRCW9mThtalGnjVlszVXDNSloHqAgFeDHhzVsX7aOtwcS+0NkBoqC0
         rMx5vz+ySkGheS8CdRLOFN1uRu0Tfn+JR74+FOGafcE0V304Te+6dhC7wFK+vs6CY8Oc
         P64N5qAh2qGCah9mKECCQTEMhEelhW3u4goUft5HZhY12JjpCdY7aKyPG9ndaAxBR2gV
         UmfAchBPZ9Llni4xxwds/a94qUwxUrV9pf14Q1nfaD4R2YOefwJi4Xk78K0OnUT0A/6R
         Ga3w==
X-Gm-Message-State: APjAAAVHCxsIRzAKopURXikGz8JLM+uMiVdQSSj/07vRIVpHCC7I8As6
        egun5PUektNv0O//eB+4Jv8=
X-Google-Smtp-Source: APXvYqyMODiVtiUjWPM8wy2WziqDPFcq4joIL8D/VENLCrfphz7t0EaOzLy/niFw6UaAL9sQqy42TA==
X-Received: by 2002:a9d:7e91:: with SMTP id m17mr23004271otp.78.1554212027489;
        Tue, 02 Apr 2019 06:33:47 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id u11sm5532165otb.66.2019.04.02.06.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 06:33:46 -0700 (PDT)
Date:   Tue, 2 Apr 2019 06:33:46 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, atull@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 01/17] fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register
 address.
Message-ID: <20190402133346.GA14777@archbook>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-2-git-send-email-hao.wu@intel.com>
 <20190401195447.GA1910@archbook>
 <20190402043845.GA24012@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402043845.GA24012@hao-dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wu,

On Tue, Apr 02, 2019 at 12:38:45PM +0800, Wu Hao wrote:
> On Mon, Apr 01, 2019 at 12:54:47PM -0700, Moritz Fischer wrote:
> > Hi Wu,
> > 
> > On Mon, Mar 25, 2019 at 11:07:28AM +0800, Wu Hao wrote:
> > > FME_PR_INTFC_ID is used as compat_id for fpga manager and region,
> > > but high 64 bits and low 64 bits of the compat_id are swapped by
> > > mistake. This patch fixes this problem by fixing register address.
> > > 
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> > > ---
> > >  drivers/fpga/dfl-fme-mgr.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> > > index 76f3770..b3f7eee 100644
> > > --- a/drivers/fpga/dfl-fme-mgr.c
> > > +++ b/drivers/fpga/dfl-fme-mgr.c
> > > @@ -30,8 +30,8 @@
> > >  #define FME_PR_STS		0x10
> > >  #define FME_PR_DATA		0x18
> > >  #define FME_PR_ERR		0x20
> > > -#define FME_PR_INTFC_ID_H	0xA8
> > > -#define FME_PR_INTFC_ID_L	0xB0
> > > +#define FME_PR_INTFC_ID_L	0xA8
> > > +#define FME_PR_INTFC_ID_H	0xB0
> > 
> > Does this handle endianess correct?
> 
> Hi Moritz,
> 
> This is just a bug fixing for wrong offsets given to these 2 registers
> according to spec. I think this is not endianess related, and per my
> understanding we don't need more code on endianess handling as that
> should be done inside the readq function already. :)
> 
> Thanks
> Hao

Thanks for clarifying,

Moritz
