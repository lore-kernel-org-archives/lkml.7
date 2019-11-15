Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3FCC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407322073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTRt8W8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKOVNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:13:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35323 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfKOVNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:13:00 -0500
Received: by mail-io1-f68.google.com with SMTP id x21so11975611ior.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 13:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8qRRdDVOJ2xu8KBi98E5RGZhtFOj+R45HMgOd4adps=;
        b=YTRt8W8RB+3JupukO1+edrrdO58VVKh3lYLrAE7eOWwNB4S199kLz8esoZpXiyzd61
         /caciTK/qGbwnphEaxbyTjUREegWs/rU+oOA3brfEbLDzsubl9cNsjbEM1h1YUykwwAh
         wTh9cxduLi20z2vlNj60xAF+zaWrEJ6v6hlVQPz+hvf6AH/QnN7YDttpJ0Wuk5NKhNfG
         NX8MkhsDSKMH87PKdI4ZdKtayia3H+8mqxL7Nbvm86+VMKX5bAro8LfU93KVHmN0M6GW
         gJ1fefJJ036dBLC3jcsrsLsCGtq0k38ANf2eY8A2t+mJas0WT75Eg7AH4LlS4eJ7iZbB
         t9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8qRRdDVOJ2xu8KBi98E5RGZhtFOj+R45HMgOd4adps=;
        b=Ik7/KFMNedkYm9BphHlo5VWXc0wFmNTCqsxE+yetxINInigOWWCTXFEgiaNDN+gVJj
         D1UOW7/+iEYexGSsZBewoQsq58POk75qF07MejRasdzJ+xzSuB74i2hrRi918OBQM0ad
         IudZsbaZVTspc/zPkYr4nIG9PZPAQ2seVOSM+OEJx1y6GV++0B8guB6ixoq3KkNjWJg/
         vTCs4Lvj4SeeTSFvMCYbmKF0rX/Qy+8Kc+gI2KS2DQLrbL1MR2uuBcKEbqOZLhC+dGSg
         pnWetTrDD2+HGHK9uxnuMuIASMLuXw0YM8pP54jXWO5Im3a+5mVIEl7s4vnTbjh8gzBd
         gaYg==
X-Gm-Message-State: APjAAAXgPdXykZbUL4UF5VhcSydbXRYX9kj7hLf7lp35brV8PIK93pu6
        BVCryNZD54oDoS7Hsq9b0/Qs37OqijMg9EMHmLQMKg==
X-Google-Smtp-Source: APXvYqySs2aNa6G3NRenBPFAfh2NsFHJFR8XK/T1zmoQ50FTrAJ3p44tWqAG8IvANXb7LyjFscytg1rxz+n6lLYwcqM=
X-Received: by 2002:a5e:9608:: with SMTP id a8mr2594936ioq.58.1573852379871;
 Fri, 15 Nov 2019 13:12:59 -0800 (PST)
MIME-Version: 1.0
References: <1573680543-39086-1-git-send-email-loic.pallardy@st.com>
 <20191114181909.GA21402@xps15> <27c9d23478cf410481285182f9e42172@SFHDAG7NODE2.st.com>
In-Reply-To: <27c9d23478cf410481285182f9e42172@SFHDAG7NODE2.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 15 Nov 2019 14:12:49 -0700
Message-ID: <CANLsYkyahM0nfvb8B__TP_yNe1eNywpqf7tuBJGdmYBt4iS8aQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] remoteproc: add support for co-processor loaded
 and booted before kernel
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 08:27, Loic PALLARDY <loic.pallardy@st.com> wrote:
>
> Hi Mathieu,
>
> > -----Original Message-----
> > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Sent: jeudi 14 novembre 2019 19:19
> > To: Loic PALLARDY <loic.pallardy@st.com>
> > Cc: bjorn.andersson@linaro.org; ohad@wizery.com; linux-
> > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> > POULIQUEN <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org;
> > Fabien DESSENNE <fabien.dessenne@st.com>; s-anna@ti.com
> > Subject: Re: [PATCH v3 1/1] remoteproc: add support for co-processor
> > loaded and booted before kernel
> >
> > Hi Loic,
> >
> > On Wed, Nov 13, 2019 at 10:29:03PM +0100, Loic Pallardy wrote:
> > > Remote processor could boot independently or be loaded/started before
> > > Linux kernel by bootloader or any firmware.
> > > This patch introduces a new property in rproc core, named skip_fw_load,
> > > to be able to allocate resources and sub-devices like vdev and to
> > > synchronize with current state without loading firmware from file system.
> > > It is platform driver responsibility to implement the right firmware
> > > load ops according to HW specificities.
> > >
> > > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > >
> > > ---
> > > Change from v2:
> > > - rename property into skip_fw_load
> > > - update rproc_boot and rproc_fw_boot description
> > > - update commit message
> > > Change from v1:
> > > - Keep bool in struct rproc
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 51
> > +++++++++++++++++++++++++++---------
> > >  include/linux/remoteproc.h           |  2 ++
> > >  2 files changed, 40 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > > index 3c5fbbbfb0f1..585cdca8b241 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -1360,7 +1360,7 @@ static int rproc_start(struct rproc *rproc, const
> > struct firmware *fw)
> > >  }
> > >
> > >  /*
> > > - * take a firmware and boot a remote processor with it.
> > > + * Handle resources defined in resource table and start a remote
> > processor.
> > >   */
> > >  static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
> > >  {
> > > @@ -1372,7 +1372,11 @@ static int rproc_fw_boot(struct rproc *rproc,
> > const struct firmware *fw)
> > >     if (ret)
> > >             return ret;
> > >
> > > -   dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> > > +   if (fw)
> > > +           dev_info(dev, "Booting fw image %s, size %zd\n", name,
> > > +                    fw->size);
> > > +   else
> > > +           dev_info(dev, "Synchronizing with preloaded co-
> > processor\n");
> >
> > Here we assume that if @fw is NULL then the image is already loaded.  The
> > first
> > question that comes to mind is if that means the ELF image has already been
> > copied to the coprocessor's boot address.  If that is the case it would be nice
> > to make it explicit with a comment in the code.
>
> Yes, but will be better to test "skip_fw_load" properties to change display info message.

I am good with the different dev_info() based on the value of @fw.

> Anyway, agree to mention that if @fw is NULL that means fw considered as already loaded.

If you have to do a respin then a clear explanation would be
appreciated, especially since this is core code.  If you don't go for
a 4th iteration then leave it as is.

> >
> > Following the earlier comments made on the thread for this serie, I
> > understand
> > the rproc_ops fed to the core should provision for @fw being NULL.  In
> > this case though st_rproc_ops[1] reference a number of core operations that
> > aren't tailored to handled a NULL @fw parameter.
>
> True, some patches will follow
>
> >
> > I am pretty sure you're well aware of this and you have more patches to go
> > with
> > this one or said patches have already been published and I'm looking at the
> > wrong tree. If that is the case would you mind making those patches public or
> > pointing me to a repository somewhere?
>
> Please have a look here [1].
> The properties is named preloaded instead of skip_fw_load, but that's the same.

I saw rproc::early_boot but the end result is indeed the same.

> Impacted ops are working differently according to preloaded status.
>
> When skip_fw_load is true, no ELF image is used. Platform driver is in charge of providing resource table location somewhere in memory.
> Somewhere is platform dependent.

Thanks for letting me in on the bigger picture - things are much
clearer now and I see where you're going.  How the resource table is
handled in stm32_rproc_elf_load_rsc_table() also answers my questions
in that area.

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>
> Regards,
> Loic
> [1] https://github.com/STMicroelectronics/linux/blob/v4.19-stm32mp/drivers/remoteproc/stm32_rproc.c
>
> >
> > I have other concerns about the specifics shared between the application
> > and co
> > processors using the ELF image but I'll wait for your reply to the above before
> > addressing those.
> >
> > Regards,
> > Mathieu
> >
> > [1]. https://elixir.bootlin.com/linux/v5.4-
> > rc7/source/drivers/remoteproc/stm32_rproc.c#L470
> >
> > >
> > >     /*
> > >      * if enabling an IOMMU isn't relevant for this rproc, this is
> > > @@ -1719,16 +1723,22 @@ static void rproc_crash_handler_work(struct
> > work_struct *work)
> > >   * rproc_boot() - boot a remote processor
> > >   * @rproc: handle of a remote processor
> > >   *
> > > - * Boot a remote processor (i.e. load its firmware, power it on, ...).
> > > + * Boot a remote processor (i.e. load its firmware, power it on, ...) from
> > > + * different contexts:
> > > + * - power off
> > > + * - preloaded firmware
> > > + * - started before kernel execution
> > > + * The different operations are selected thanks to properties defined by
> > > + * platform driver.
> > >   *
> > > - * If the remote processor is already powered on, this function
> > immediately
> > > - * returns (successfully).
> > > + * If the remote processor is already powered on at rproc level, this
> > function
> > > + * immediately returns (successfully).
> > >   *
> > >   * Returns 0 on success, and an appropriate error value otherwise.
> > >   */
> > >  int rproc_boot(struct rproc *rproc)
> > >  {
> > > -   const struct firmware *firmware_p;
> > > +   const struct firmware *firmware_p = NULL;
> > >     struct device *dev;
> > >     int ret;
> > >
> > > @@ -1759,11 +1769,17 @@ int rproc_boot(struct rproc *rproc)
> > >
> > >     dev_info(dev, "powering up %s\n", rproc->name);
> > >
> > > -   /* load firmware */
> > > -   ret = request_firmware(&firmware_p, rproc->firmware, dev);
> > > -   if (ret < 0) {
> > > -           dev_err(dev, "request_firmware failed: %d\n", ret);
> > > -           goto downref_rproc;
> > > +   if (!rproc->skip_fw_load) {
> > > +           /* load firmware */
> > > +           ret = request_firmware(&firmware_p, rproc->firmware,
> > dev);
> > > +           if (ret < 0) {
> > > +                   dev_err(dev, "request_firmware failed: %d\n", ret);
> > > +                   goto downref_rproc;
> > > +           }
> > > +   } else {
> > > +           /* set firmware name to null as unknown */
> > > +           kfree(rproc->firmware);
> > > +           rproc->firmware = NULL;
> > >     }
> > >
> > >     ret = rproc_fw_boot(rproc, firmware_p);
> > > @@ -1917,8 +1933,17 @@ int rproc_add(struct rproc *rproc)
> > >     /* create debugfs entries */
> > >     rproc_create_debug_dir(rproc);
> > >
> > > -   /* if rproc is marked always-on, request it to boot */
> > > -   if (rproc->auto_boot) {
> > > +   if (rproc->skip_fw_load) {
> > > +           /*
> > > +            * If rproc is marked already booted, no need to wait
> > > +            * for firmware.
> > > +            * Just handle associated resources and start sub devices
> > > +            */
> > > +           ret = rproc_boot(rproc);
> > > +           if (ret < 0)
> > > +                   return ret;
> > > +   } else if (rproc->auto_boot) {
> > > +           /* if rproc is marked always-on, request it to boot */
> > >             ret = rproc_trigger_auto_boot(rproc);
> > >             if (ret < 0)
> > >                     return ret;
> > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > > index 16ad66683ad0..4fd5bedab4fa 100644
> > > --- a/include/linux/remoteproc.h
> > > +++ b/include/linux/remoteproc.h
> > > @@ -479,6 +479,7 @@ struct rproc_dump_segment {
> > >   * @table_sz: size of @cached_table
> > >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> > >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > > + * @skip_fw_load: remote processor has been preloaded before start
> > sequence
> > >   * @dump_segments: list of segments in the firmware
> > >   * @nb_vdev: number of vdev currently handled by rproc
> > >   */
> > > @@ -512,6 +513,7 @@ struct rproc {
> > >     size_t table_sz;
> > >     bool has_iommu;
> > >     bool auto_boot;
> > > +   bool skip_fw_load;
> > >     struct list_head dump_segments;
> > >     int nb_vdev;
> > >  };
> > > --
> > > 2.7.4
> > >
