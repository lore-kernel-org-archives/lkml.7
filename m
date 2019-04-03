Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C75FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D703920830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554310066;
	bh=lRdeevj5cZlijkozufjDpEWXzomyGATg5+JX/JeHLmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MZK99bdtO7jwRSNYDjo4F3vNE16n0LiOgORT0Cb3brAF0J6xktySU9uZ4qS8eQIV+
	 Cgm6hBDchjSJxjHjpPGq/TB2mOVldBh7LdkoiH1QmG9TefFJCGYVcp0wJ0W35MUSKI
	 3iIqknYWpy3zTlEVVBWz56O/XrgPRcHC4D5XG5XU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDCQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:47:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47065 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDCQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:47:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id s24so16003952otk.13;
        Wed, 03 Apr 2019 09:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K8u+qJVWk3puiAbwA2MiT4s2T0KxTnWEgSl/MPXNyZQ=;
        b=CvalVmyRjCG0dXYLDL5v8Bpo6N1MoqVLwOuKk0O8JLPzuHZtZghSqHcTy+X713fa86
         dPep6HIcKrBMN004c2U8SFkoj31SYTKuN5WtvMfTuN/Jl8CwOv1uanNUPJ3eJ7O+VZsV
         p/JJw9wYIDcb8JvxGGtbvcInJIvGUIBcFWbNuW2qROiQUs4agAEWBYyviGFjaS1aC2gf
         I9V5jqjG2UDahm6wuoeaUpTszt6kOgngHJzAgrIb7LmrPHJAqOA6qsb7HMouWsgzXHYg
         MYqXpfoFYAZQBS1NyhrPZzNCIOGsF95vfFP791fRZ/So/yQSgpUbMli7YTp0Fm7SuMlR
         opow==
X-Gm-Message-State: APjAAAVXJXCrtP3qLRyFUtI6w6N2ii+75neSyOgivS39ZaYpnvWXR2+E
        l+IoOfNkvnJDzVHt3BKW9j4=
X-Google-Smtp-Source: APXvYqyYlOwdEWSnwg4utpLgiUxjDTjABGAmPzsoc4M+19vqe5cstnb5RP9t9skItJMKB640NF9kLA==
X-Received: by 2002:a05:6830:1654:: with SMTP id h20mr382165otr.149.1554310063637;
        Wed, 03 Apr 2019 09:47:43 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id k25sm6905368otj.72.2019.04.03.09.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:47:43 -0700 (PDT)
Date:   Wed, 3 Apr 2019 09:47:42 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, atull@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
Message-ID: <20190403164742.GC5752@archbook>
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook>
 <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Wed, Apr 03, 2019 at 11:43:26AM -0500, Richard Gong wrote:
> Hi Moritz,
> 
> 
> On 4/3/19 9:20 AM, Moritz Fischer wrote:
> > Hi Richard,
> > 
> > On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
> > > From: Richard Gong <richard.gong@intel.com>
> > > 
> > > Add a log for user to know FPGA configuration is successful
> > > 
> > > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > > ---
> > >   drivers/fpga/fpga-mgr.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > > index c386681..559e046 100644
> > > --- a/drivers/fpga/fpga-mgr.c
> > > +++ b/drivers/fpga/fpga-mgr.c
> > > @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
> > >   	}
> > >   	mgr->state = FPGA_MGR_STATE_OPERATING;
> > > +	dev_info(&mgr->dev, "Successfully programming FPGA\n");
> > 
> > That info is available in FPGA manager's sysfs status entry, if at all
> > I'd make this a dev_dbg().
> > 
> >  From my end I don't see how we need this really.
> 
> We got requests from the field and they want to see a log to get know if
> FPGA configuration is successfully completed. They don't want use any
> additional command to get status.
> 
> This log is useful for the user who performs FPGA configuration.
> 
> I think we need use dev_info, since dev_dbg is not enabled by fault for most
> build.

Well basically it boils down to:

$ dmesg | grep "Sucessfully"

vs

$ cat /sys/class/fpga.../status 

Personally not in favor of extra messages, but if we do it we should
change the message to "Sucessfully programmed FPGA".

I think making it a dbg message is a good trade-off ...

Moritz
