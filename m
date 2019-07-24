Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F66C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C56A21926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563987954;
	bh=6bX8EN05db+8hyAQYIxci6Aj9r0UtVgc7Pk4BalATGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QlJ7HeDq+25LIgxvNd1Qf3fFHwM4c4beM8j7EHdru2Jma26eYtJmFThq0BhpCLt9S
	 anrrCB6LnapCMr0/dr+mVAnByDCTENO2FdttzXIpd4jrmq0Y+nVCT8HQ/2JKp41gaW
	 hzmWshN+nvBG188H0lz35PxaaFSb6YbKJxoO8UpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfGXRFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:05:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39228 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGXRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:05:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so21532286pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3y5e0V75FF7ktuv1k1viWq4wpzJ+tVc25TApnmBOyk=;
        b=tfuUS9ElY8p6yJW21Y+33oa4Sao2uiMU3ey8r4o7AbMftXOLQEC2BzCztnMrvY37mY
         oAT9YWswX3G55yOF+XqyZHKUl+iHi0AZ/0xVyKdbxFy+8hapsflunsDzppRZxl+2er54
         irbLJHgo68WaplQx7tgP6uMow9QN5KDGcdK0jwLbSvWfo6ED2VQOXIlk3jDLblGPTWMW
         fmcKn050BR/9yTv1W5dAfKMNRpAnQ86tqKhDFSnOYSfPReNuKz6QYF4Bizi0Ub/lPkQh
         qmzFSzeKp2YLJz5C4jng0Gd66o9p8AVxY59/+foYnvwBu+qm6Y+BHF1erZrIkXMqbKdp
         AzMg==
X-Gm-Message-State: APjAAAWh1EfCMJCmfe/pkO3iJLjWs2Z7r4iBA1ZMAca7Qw+O6uDjSNfK
        s9JyknTR1DeEnHrn4nxDYQDPuQ==
X-Google-Smtp-Source: APXvYqz4lgZWEtny44DcSM+tpFZea85qcbpNheLf0Pg6yQpKe3AxN03jJDTZN/mShvNNwOoBz63n+Q==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr88637834pjb.30.1563987951930;
        Wed, 24 Jul 2019 10:05:51 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id b30sm70895221pfr.117.2019.07.24.10.05.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 10:05:50 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:05:49 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, richard.gong@linux.intel.com,
        agust@denx.de, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] fpga: altera-cvp: Preparation for V2 parts.
Message-ID: <20190724170549.GA26502@archbox>
References: <1563317287-18834-1-git-send-email-thor.thayer@linux.intel.com>
 <1563317287-18834-3-git-send-email-thor.thayer@linux.intel.com>
 <20190722005938.GB2583@archbook>
 <6e54c0ee-b8ec-4f95-cf81-70aacc82c72e@linux.intel.com>
 <20190724145704.GB24455@archbox>
 <b52ea6f3-a547-ebce-88f5-6256501a7e99@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52ea6f3-a547-ebce-88f5-6256501a7e99@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thor,

On Wed, Jul 24, 2019 at 11:59:12AM -0500, Thor Thayer wrote:
> Hi Moritz,
> 
> On 7/24/19 9:57 AM, Moritz Fischer wrote:
> > On Tue, Jul 23, 2019 at 09:40:51AM -0500, Thor Thayer wrote:
> > > Hi Moritz,
> > > 
> > > On 7/21/19 7:59 PM, Moritz Fischer wrote:
> > > > Thor,
> > > > 
> > > > On Tue, Jul 16, 2019 at 05:48:06PM -0500, thor.thayer@linux.intel.com wrote:
> > > > > From: Thor Thayer <thor.thayer@linux.intel.com>
> > > > > 
> > > > > In preparation for adding newer V2 parts that use a FIFO,
> > > > > reorganize altera_cvp_chk_error() and change the write
> > > > > function to block based.
> > > > > V2 parts have a block size matching the FIFO while older
> > > > > V1 parts write a 32 bit word at a time.
> > > > > 
> > > > > Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> > > > > ---
> > > > > v2 Remove inline function declaration
> > > > >      Reverse Christmas Tree format for local variables
> > > > > ---
> > > > >    drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++-----------------
> > > > >    1 file changed, 46 insertions(+), 26 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > > > > index b78c90580071..37419d6b9915 100644
> > > > > --- a/drivers/fpga/altera-cvp.c
> > > > > +++ b/drivers/fpga/altera-cvp.c
> > > > > @@ -140,6 +140,41 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
> > > > >    	return -ETIMEDOUT;
> > > > >    }
> > > > > +static int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
> > > > > +{
> > > > > +	struct altera_cvp_conf *conf = mgr->priv;
> > > > > +	u32 val;
> > > > > +
> > > > > +	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
> > > > > +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> > > > Same as in the other email, why can we ignore return values here. I
> > > > think the original code probably did that already.
> > > 
> > > Yes, I actually didn't make any changes to this function. You can see I
> > > moved it from below since it is used in the following function.
> > > 
> > > I'm not checking the return code from any of the read/write functions since
> > > the original driver didn't. Would you prefer I check and issue a warning?
> > 
> > Not sure a warning would change much here. We should probably look at
> > why it was ok in the first place.
> 
> A quick grep of the drivers directory shows that an overwhelming majority of
> pci_read_config_dword() and pci_write_config_dword() calls do not check the
> return code.

Yeah I came to the same conclusion after looking around the codebase.

> 
> For robustness, I agree with you that checking and returning the return code
> in this error checking function is important. I will return the error code
> if the read fails.

Ok.

> 
> It shouldn't be necessary to change the rest of the code though unless you
> feel strongly about updating the existing codebase.

Yeah not in this patchset. We'll look at it separately.

Cheers,
Moritz
