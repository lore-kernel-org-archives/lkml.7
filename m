Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4015EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99452082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554309019;
	bh=yaYCFUpD3wkB+sZzvu9Uq0b0BCZ5s40TjdM0TynNnk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s+Y+hiFO83NDDCODUMA8GcgKn4BY5jvta2Ti7xbqR90yInDNmXMKpNMnrr3zouIf2
	 iLLSIG2A1mVzE+jB+X70FOuXchxY8uzh/dBgdyhFd0M0oUFQ+7TDuGPernji3hD+FY
	 nZDqLRbtwjfE1IlnYEcQyS5uuPjZI0Mre20q6/wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDCQaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCQaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:30:17 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B711F2082C;
        Wed,  3 Apr 2019 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554309017;
        bh=yaYCFUpD3wkB+sZzvu9Uq0b0BCZ5s40TjdM0TynNnk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VXskTnCPMXoU+uWMk+0Q5dsqRAsI7V4xAb73kRheW8pNYSUYTx8Av6wyIPiwBIDtf
         wTXoJvIBPNnI22bSM1tj2L6jEnvUA8sn3QhQMSizXLsIJu0wZwYfEHnVWzpckzBFog
         uHCvbuOCH0hT/c32OWqNljrdR7z8tv8hj3iCNZqY=
Received: by mail-ed1-f52.google.com with SMTP id d26so15473191ede.10;
        Wed, 03 Apr 2019 09:30:16 -0700 (PDT)
X-Gm-Message-State: APjAAAU3RudIzQbGsBENwpYPlmBz9Y4v+tgYahdwo/2BbYBIuuOUeQE1
        8R2P2Mt3yZLXSYUDe2UhAFikvTrf9D6xCMki/bw=
X-Google-Smtp-Source: APXvYqwhiREeh0pLqBKWEwpPzQoBW1B9dCCGoOD5eMnChUkSCSz2MQRkTehHan8XMSoSk7RLCYOjND2uFxq3EkUtu0k=
X-Received: by 2002:a17:906:25ce:: with SMTP id n14mr404280ejb.115.1554309015230;
 Wed, 03 Apr 2019 09:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com> <20190403142022.GB5752@archbook>
In-Reply-To: <20190403142022.GB5752@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 3 Apr 2019 11:29:39 -0500
X-Gmail-Original-Message-ID: <CANk1AXQAr-B8ShU4=Zs_aq3_iyQoZTfEhnLpnr9xiWHrKyZiow@mail.gmail.com>
Message-ID: <CANk1AXQAr-B8ShU4=Zs_aq3_iyQoZTfEhnLpnr9xiWHrKyZiow@mail.gmail.com>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Richard Gong <richard.gong@linux.intel.com>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:20 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Richard,
>
> On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
> > From: Richard Gong <richard.gong@intel.com>
> >
> > Add a log for user to know FPGA configuration is successful
> >
> > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > ---
> >  drivers/fpga/fpga-mgr.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index c386681..559e046 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
> >       }
> >       mgr->state = FPGA_MGR_STATE_OPERATING;
> >
> > +     dev_info(&mgr->dev, "Successfully programming FPGA\n");
>
> That info is available in FPGA manager's sysfs status entry, if at all
> I'd make this a dev_dbg().
>
> From my end I don't see how we need this really.

I'm ok with adding a message.  It's not adding lots of messages, just
one line for an event that will only happen for people who care about
the event (not too many FPGA users but if someone is using FPGA, they
will care about this.)

Alan


>
> Thanks,
> Moritz
