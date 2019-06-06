Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B520C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E930520874
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559840031;
	bh=D4UJP80FAdK9LRFAqEia+BMLNszARCWS/F17g9KPeEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xmroa3eEd8S84B+UtT/3hdrI4u82LfCruPGyZ6UCU4kY+uDgX6lxXlYLkDWZuxtP9
	 RZYVeleyJ5SUh+koCAEbwAdM6aa24ZxBJ0cN4wMObG8pZugKomtMF8M/CEfyfPcAoQ
	 h0w7OVkXbRSToTSp3xm4YJ8iKDSPjzoYbmjah97U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfFFQxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfFFQxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:53:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9ECA20693;
        Thu,  6 Jun 2019 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559840028;
        bh=D4UJP80FAdK9LRFAqEia+BMLNszARCWS/F17g9KPeEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ab//aI0UBRKWWFG1qVkLjglYjKyNYj9h76GAgyyb9BUQ/+jS1T3mbziDlTHoIgK80
         U/jIVlc9LXg53QiqnOPHH4RawJj1cXrlKBuifjOnuf2JYZj+tzR1960U+QkJg3NwZA
         QRxTgrZCw/fCie41FCmSmyJm8hY8ddQFcwDOKbkE=
Date:   Thu, 6 Jun 2019 18:53:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 237/276] scsi: lpfc: avoid uninitialized variable
 warning
Message-ID: <20190606165346.GB3249@kroah.com>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030539.944220603@linuxfoundation.org>
 <20190606125323.GC27432@amd>
 <20190606160042.GA54183@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606160042.GA54183@archlinux-epyc>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 09:00:42AM -0700, Nathan Chancellor wrote:
> On Thu, Jun 06, 2019 at 02:53:23PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > [ Upstream commit faf5a744f4f8d76e7c03912b5cd381ac8045f6ec ]
> > > 
> > > clang -Wuninitialized incorrectly sees a variable being used without
> > > initialization:
> > > 
> > > drivers/scsi/lpfc/lpfc_nvme.c:2102:37: error: variable 'localport' is uninitialized when used here
> > >       [-Werror,-Wuninitialized]
> > >                 lport = (struct lpfc_nvme_lport *)localport->private;
> > >                                                   ^~~~~~~~~
> > > drivers/scsi/lpfc/lpfc_nvme.c:2059:38: note: initialize the variable 'localport' to silence this warning
> > >         struct nvme_fc_local_port *localport;
> > >                                             ^
> > >                                              = NULL
> > > 1 error generated.
> > > 
> > > This is clearly in dead code, as the condition leading up to it is always
> > > false when CONFIG_NVME_FC is disabled, and the variable is always
> > > initialized when nvme_fc_register_localport() got called successfully.
> > > 
> > > Change the preprocessor conditional to the equivalent C construct, which
> > > makes the code more readable and gets rid of the warning.
> > 
> > Unfortunately, this missed "else" branch where the code was freeing
> > the memory with kfree(cstat)... so this introduces a memory leak.
> > 
> > Best regards,
> > 									Pavel
> 
> For the record, this is not a problem with the upstream commit (not
> saying you thought that or not, I just want to be clear).
> 
> Looks like commit 4c47efc140fa ("scsi: lpfc: Move SCSI and NVME Stats to
> hardware queue structures") "resolved" this by not making it an issue in
> the first place. I think the simpler fix is this.
> 
> Thanks for pointing it out!
> 
> diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
> index 099f70798fdd..645ffb5332b4 100644
> --- a/drivers/scsi/lpfc/lpfc_nvme.c
> +++ b/drivers/scsi/lpfc/lpfc_nvme.c
> @@ -2477,14 +2477,14 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
>         lpfc_nvme_template.max_sgl_segments = phba->cfg_nvme_seg_cnt + 1;
>         lpfc_nvme_template.max_hw_queues = phba->cfg_nvme_io_channel;
>  
> +       if (!IS_ENABLED(CONFIG_NVME_FC))
> +               return ret;
> +
>         cstat = kmalloc((sizeof(struct lpfc_nvme_ctrl_stat) *
>                         phba->cfg_nvme_io_channel), GFP_KERNEL);
>         if (!cstat)
>                 return -ENOMEM;
>  
> -       if (!IS_ENABLED(CONFIG_NVME_FC))
> -               return ret;
> -
>         /* localport is allocated from the stack, but the registration
>          * call allocates heap memory as well as the private area.
>          */
> 

Can you send this as a real patch that I can queue up?

thanks,

greg k-h
