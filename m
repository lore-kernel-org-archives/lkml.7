Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BE8C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008AA214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hK+orHdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKLRcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:32:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42920 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:32:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so12284766pgt.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TuW6QL1ARg9HMedopE4tjT3r+/KkNCYJcn2YjqAUMdE=;
        b=hK+orHdvYQ3w6pL1zhBSee/zUrMB5OpQdFZ5BrSbkllVmhO1CZzhsAF9djt+8f0FX6
         AivYxlLSuEiUtoVCOOEB5V5eq6QllPFvhFHFp4q/P1ep+BbpZp468UsVOfyKKa6dqf3P
         wVST+6RPswVxGVqtXjqzYyoyzE6fvwV4WU79V5Ii4t4tfqkCSb7s3n89usvqBW9UKmdX
         l6tKa+RNYH+PlyeAMoNWNPyOnHx1631Bu8WlnYEOqhGvYQ2uHgIEpWZuDbWR/2Pex2Qp
         /16KdzBjsVyHiSnd57NBO0EqmltIYtqalrL20EIGvev+XwHIvnrj5pwa1htLzpWMznKf
         ptJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TuW6QL1ARg9HMedopE4tjT3r+/KkNCYJcn2YjqAUMdE=;
        b=FtHkRqZKTE6DZkrQ+h8tmW0YECv9lfupR+Kn9nGfrphJnu280zR407DY1gq8vNzcw/
         DQ1CMGIFsXVUtzCGjcANjZFB17nXyG/GXm1myQM/e6jzTwDVjw6W32W/OvSWiF3kzSIN
         RmOD2OOJm25KierLHN+zixrpdiVXmUmOy/jWGnDF74LgqeFLoXqeV+KjQu9DlV6BmLG+
         KugZm448soCl5EGqyBJaLaeHRJ+38xNCi3ugVyP0LTxB/o1QEQvRN8zy81PEvrpNsUHg
         FNxKe+aZjWqhs6oSCiXDvuUFn4jo9am6qHxB+DUmuMWqDjPuhNjAReTtiJ7zElKjKMwp
         Rb8Q==
X-Gm-Message-State: APjAAAWWAPcy9imnuUnsZqajw4e3H0TIWGB+Jp+6Ygg/Lgipu4OgiVfb
        IS478mYTZS3JtjRUBKEF8f1q3w==
X-Google-Smtp-Source: APXvYqyXOwW0r07tTSk+45/adpdCEe9iNWBodcJOr3IhmLurS+g4gWuAmtntTOGgcqWb9jt/ic4XDw==
X-Received: by 2002:a63:de0b:: with SMTP id f11mr30255249pgg.8.1573579964653;
        Tue, 12 Nov 2019 09:32:44 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r20sm28133840pgo.74.2019.11.12.09.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 09:32:44 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:32:41 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: Re: [PATCH v2 1/1] remoteproc: add support for co-processor booted
 before kernel
Message-ID: <20191112173241.GG3797@yoga>
References: <1572864570-10131-1-git-send-email-loic.pallardy@st.com>
 <20191109012027.GC5662@tuxbook-pro>
 <9879473e5b91499eb3d6ddd11584af16@SFHDAG7NODE2.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9879473e5b91499eb3d6ddd11584af16@SFHDAG7NODE2.st.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Nov 00:40 PST 2019, Loic PALLARDY wrote:

> Hi Bjorn,
> 
> Thanks for your review.
> 
> > -----Original Message-----
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Sent: samedi 9 novembre 2019 02:20
> > To: Loic PALLARDY <loic.pallardy@st.com>
> > Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> > benjamin.gaignard@linaro.org; Fabien DESSENNE
> > <fabien.dessenne@st.com>; s-anna@ti.com
> > Subject: Re: [PATCH v2 1/1] remoteproc: add support for co-processor
> > booted before kernel
> > 
> > On Mon 04 Nov 02:49 PST 2019, Loic Pallardy wrote:
> > 
> > > Remote processor could boot independently or be started before Linux
> > > kernel by bootloader or any firmware.
> > > This patch introduces a new property in rproc core, named preloaded,
> > > to be able to allocate resources and sub-devices like vdev and to
> > > synchronize with current state without loading firmware from file system.
> > > It is platform driver responsibility to implement the right firmware
> > > load ops according to HW specificities.
> > >
> > 
> > Is it just preloaded or already started?
> At the beginning, this properties was indeed to support an already
> started coprocessor, but discussing with Suman few months ago, we
> detected some cases for which firmware may be loaded before kernel
> start (firmware located in embedded flash or loaded by bootloaders) or
> may be loaded by a dedicated driver interface before rproc framework
> be called.
> As rproc framework is mainly responsible for firmware loading and
> resource allocation, I named this property preloaded to cover as much
> as possible all cases.

Cool, then I like this patch :)

> > 
> > > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > >
> > > ---
> > > Change from v1:
> > > - Keep bool in struct rproc
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 37
> > +++++++++++++++++++++++++++---------
> > >  include/linux/remoteproc.h           |  2 ++
> > >  2 files changed, 30 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > > index 3c5fbbbfb0f1..7eaf0f949afa 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -1372,7 +1372,11 @@ static int rproc_fw_boot(struct rproc *rproc,
> > const struct firmware *fw)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> > > +	if (fw)
> > > +		dev_info(dev, "Booting fw image %s, size %zd\n", name,
> > > +			 fw->size);
> > > +	else
> > > +		dev_info(dev, "Synchronizing with preloaded co-
> > processor\n");
> > >
> > >  	/*
> > >  	 * if enabling an IOMMU isn't relevant for this rproc, this is
> > > @@ -1728,7 +1732,7 @@ static void rproc_crash_handler_work(struct
> > work_struct *work)
> > >   */
> > >  int rproc_boot(struct rproc *rproc)
> > >  {
> > > -	const struct firmware *firmware_p;
> > > +	const struct firmware *firmware_p = NULL;
> > >  	struct device *dev;
> > >  	int ret;
> > >
> > > @@ -1759,11 +1763,17 @@ int rproc_boot(struct rproc *rproc)
> > >
> > >  	dev_info(dev, "powering up %s\n", rproc->name);
> > >
> > > -	/* load firmware */
> > > -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> > > -	if (ret < 0) {
> > > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > > -		goto downref_rproc;
> > > +	if (!rproc->preloaded) {
> > > +		/* load firmware */
> > > +		ret = request_firmware(&firmware_p, rproc->firmware,
> > dev);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "request_firmware failed: %d\n", ret);
> > > +			goto downref_rproc;
> > > +		}
> > > +	} else {
> > > +		/* set firmware name to null as unknown */
> > > +		kfree(rproc->firmware);
> > > +		rproc->firmware = NULL;
> > 
> > What happens when the remoteproc crashes? What happens if I stop it and
> > try to start it again?
> Exactly, it should be stopped, then firmware should be provided and
> coprocessor restarted thanks to sysfs interface
> 

But in both these cases you rely on the firmware being persistent in
some memory - be it some protected portion of RAM or some ROM?

I.e. with this patch, and not setting "firmware" the remote is expected
to just boot again on the same firmware.

> > 
> > >  	}
> > >
> > >  	ret = rproc_fw_boot(rproc, firmware_p);
> > > @@ -1917,8 +1927,17 @@ int rproc_add(struct rproc *rproc)
> > >  	/* create debugfs entries */
> > >  	rproc_create_debug_dir(rproc);
> > >
> > > -	/* if rproc is marked always-on, request it to boot */
> > > -	if (rproc->auto_boot) {
> > > +	if (rproc->preloaded) {
> > > +		/*
> > > +		 * If rproc is marked already booted, no need to wait
> > > +		 * for firmware.
> > > +		 * Just handle associated resources and start sub devices
> > > +		 */
> > > +		ret = rproc_boot(rproc);
> > 
> > This will trickle down to your remoteproc driver's start() callback. If
> > you really mean that "preloaded" means "already started", then I presume
> > you're having some logic in your start() to turn it into a nop?
> Yes it is the responsibility of the driver to know in which state coprocessor is.
> Depending on the use case, driver could:
> - do nothing if coprocessor already running
> - boot coprocessor, if only firmware was preloaded
> - reboot coprocessor to restart its execution on the preloaded firmware
> 

I'm slightly worried about the cases of finding an already booted
coprocessor, as this often means that we have to make assumptions about
clock states etc.

But with the focus of supporting persistent firmware, I like this.

> > 
> > > +		if (ret < 0)
> > > +			return ret;
> > > +	} else if (rproc->auto_boot) {
> > > +		/* if rproc is marked always-on, request it to boot */
> > >  		ret = rproc_trigger_auto_boot(rproc);
> > >  		if (ret < 0)
> > >  			return ret;
> > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > > index 16ad66683ad0..b68fbd576a77 100644
> > > --- a/include/linux/remoteproc.h
> > > +++ b/include/linux/remoteproc.h
> > > @@ -479,6 +479,7 @@ struct rproc_dump_segment {
> > >   * @table_sz: size of @cached_table
> > >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> > >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > > + * @preloaded: remote processor has been preloaded before start
> > sequence
> > 
> > I think this should be "skip_firmware_load", or if you really mean that
> > the bootloader started the remote process perhaps this should be
> > "@fw_booted: remote processor was booted by firmware" (or something
> > similar).
> I'm fine with "skip_firmware_load" or "skip_fw_load" to have a shorter name.
> I'll also add "preload" in patch title.
> 

skip_fw_load sounds good.

Thanks,
Bjorn

> Regards,
> Loic
> 
> > 
> > Regards,
> > Bjorn
> > 
> > >   * @dump_segments: list of segments in the firmware
> > >   * @nb_vdev: number of vdev currently handled by rproc
> > >   */
> > > @@ -512,6 +513,7 @@ struct rproc {
> > >  	size_t table_sz;
> > >  	bool has_iommu;
> > >  	bool auto_boot;
> > > +	bool preloaded;
> > >  	struct list_head dump_segments;
> > >  	int nb_vdev;
> > >  };
> > > --
> > > 2.7.4
> > >
