Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B9FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A50E22ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk2lwvoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfGXGzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:55:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45564 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGXGzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:55:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so45590472wre.12;
        Tue, 23 Jul 2019 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iMeNTsCiERl+P34fUTSUNSQriOGJih/vVFrylD6BeI=;
        b=fk2lwvozpFZQhIBd+22aYQwHfP0ddOk3rDZTodt7W2XLtZcbasVjL/eSI1ru8ghIJ1
         GBpn13Gqf1w/c8bkgJ56GrQTR6gsyDziHRCHP3cDUkQxBsbU3Bd9ZrBMg0owv0xRfUuE
         siiEsoXj/Awey9XsUzEvzn5SVEnOWDqWakDX78f/0Y/cEbdpl1znF7iWF/6N4ZZwrWNw
         hUvSFih3el+1CSVnGqKAH3Oi8byJ13eUDAsH9tdsAFyzuM5C0k2ZqDi+Ygl90+ZXvcsN
         Q2SAOY2o8O7+rgSWrXr/piH57mFLzvfggjE69vullExS7m4AdTjorSQ8a8iraFI7P6JH
         h5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iMeNTsCiERl+P34fUTSUNSQriOGJih/vVFrylD6BeI=;
        b=LATjSssiYkiYzXwNvXn+JIuTCks983sLkCtDv0dZDkI5wwLprU/15xpK+1jO2aP4eJ
         4S+RyORdcn4Rdqe0+7HZFZDwupX98tzmlTYzNPgjdmtRzNvfbtZ1r5L/KWrrF+5K3x1L
         6bAlZSt2eYQKkY6M/KWfLDu+TK9ZfHdd/sT054BkGgnaYxPiIbL822Y9mDljC2QSkZh9
         Z+e3iAAHdzXiRXufn5NeHcWv7YZep9caupQ2etEiS2xwTjcu8lFO02JfXtehFFY/s5tC
         Sjmpn9sBRyc6Gduv5P90ZRhRjZ+wOpAoiO7iRZe1R77b/2UzdLa+/cy8HmWTYxWz+Xsm
         bFAw==
X-Gm-Message-State: APjAAAU1KHIXPL8EFL4qKsxrsr8qbyQVq+9Mk/VSk3scBkHzhQhUjo5D
        OPI/sbqnsgwyupliykc8mfpP43KTPRT17xilTe0=
X-Google-Smtp-Source: APXvYqz4dhIt0idgKDMG+M+RinhFLThRORdt4BwIA6AYlWqxPwozbP8EWmcdiQMBzoZgaLOPnkooAPJC9t9UvPC06jc=
X-Received: by 2002:adf:c70e:: with SMTP id k14mr88734339wrg.201.1563951297367;
 Tue, 23 Jul 2019 23:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190723084104.12639-1-daniel.baluta@nxp.com> <20190723084104.12639-2-daniel.baluta@nxp.com>
 <a5d44d96-4d50-ee46-a6bf-3ce108b1994a@linux.intel.com>
In-Reply-To: <a5d44d96-4d50-ee46-a6bf-3ce108b1994a@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 24 Jul 2019 09:54:46 +0300
Message-ID: <CAEnQRZCuB2QKzz-08K0z+x+p0qCpqR_wDc=q2GChvJiw4E9hBA@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH v2 1/5] ASoC: SOF: imx: Add i.MX8 HW support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 6:18 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> > diff --git a/sound/soc/sof/imx/Makefile b/sound/soc/sof/imx/Makefile
> > new file mode 100644
> > index 000000000000..c69237971da5
> > --- /dev/null
> > +++ b/sound/soc/sof/imx/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +
> > +ccflags-y += -DDEBUG
>
> this should be removed or in a separate patch.

All right.

>
>
> > +struct imx8_priv {
> > +     struct device *dev;
> > +     struct snd_sof_dev *sdev;
> > +     struct imx_dsp_ipc *dsp_ipc;
> > +     struct imx_sc_ipc *sc_ipc;
>
> maybe a comment to explain what 'sc' stands for?

Sure.
>
> > +};
> > +
> > +static void imx8_get_windows(struct snd_sof_dev *sdev)
> > +{
> > +     struct sof_ipc_window_elem *elem;
> > +     u32 outbox_offset = 0;
> > +     u32 stream_offset = 0;
> > +     u32 inbox_offset = 0;
> > +     u32 outbox_size = 0;
> > +     u32 stream_size = 0;
> > +     u32 inbox_size = 0;
> > +     int i;
> > +
> > +     if (!sdev->info_window) {
> > +             dev_err(sdev->dev, "error: have no window info\n");
> > +             return;
> > +     }
> > +
> > +     for (i = 0; i < sdev->info_window->num_windows; i++) {
> > +             elem = &sdev->info_window->window[i];
> > +
> > +             switch (elem->type) {
> > +             case SOF_IPC_REGION_UPBOX:
> > +                     inbox_offset = elem->offset + MBOX_OFFSET;
> > +                     inbox_size = elem->size;
> > +                     snd_sof_debugfs_io_item(sdev,
> > +                                             sdev->bar[SOF_FW_BLK_TYPE_SRAM]
> > +                                             + inbox_offset,
> > +                                             elem->size, "inbox",
> > +                                             SOF_DEBUGFS_ACCESS_D0_ONLY);
> > +                     break;
> > +             case SOF_IPC_REGION_DOWNBOX:
> > +                     outbox_offset = elem->offset + MBOX_OFFSET;
> > +                     outbox_size = elem->size;
> > +                     snd_sof_debugfs_io_item(sdev,
> > +                                             sdev->bar[SOF_FW_BLK_TYPE_SRAM]
> > +                                             + outbox_offset,
> > +                                             elem->size, "outbox",
> > +                                             SOF_DEBUGFS_ACCESS_D0_ONLY);
> > +                     break;
> > +             case SOF_IPC_REGION_TRACE:
> > +                     snd_sof_debugfs_io_item(sdev,
> > +                                             sdev->bar[SOF_FW_BLK_TYPE_SRAM]
> > +                                             + elem->offset + MBOX_OFFSET,
> > +                                             elem->size, "etrace",
> > +                                             SOF_DEBUGFS_ACCESS_D0_ONLY);
> > +                     break;
> > +             case SOF_IPC_REGION_DEBUG:
> > +                     snd_sof_debugfs_io_item(sdev,
> > +                                             sdev->bar[SOF_FW_BLK_TYPE_SRAM]
> > +                                             + elem->offset + MBOX_OFFSET,
> > +                                             elem->size, "debug",
> > +                                             SOF_DEBUGFS_ACCESS_D0_ONLY);
> > +                     break;
> > +             case SOF_IPC_REGION_STREAM:
> > +                     stream_offset = elem->offset + MBOX_OFFSET;
> > +                     stream_size = elem->size;
> > +                     snd_sof_debugfs_io_item(sdev,
> > +                                             sdev->bar[SOF_FW_BLK_TYPE_SRAM]
> > +                                             + stream_offset,
> > +                                             elem->size, "stream",
> > +                                             SOF_DEBUGFS_ACCESS_D0_ONLY);
> > +                     break;
> > +             case SOF_IPC_REGION_REGS:
> > +                     snd_sof_debugfs_io_item(sdev,
> > +                                             sdev->bar[SOF_FW_BLK_TYPE_SRAM]
> > +                                             + elem->offset + MBOX_OFFSET,
> > +                                             elem->size, "regs",
> > +                                             SOF_DEBUGFS_ACCESS_D0_ONLY);
> > +                     break;
> > +             case SOF_IPC_REGION_EXCEPTION:
> > +                     sdev->dsp_oops_offset = elem->offset + MBOX_OFFSET;
> > +                     snd_sof_debugfs_io_item(sdev,
> > +                                             sdev->bar[SOF_FW_BLK_TYPE_SRAM]
> > +                                             + elem->offset + MBOX_OFFSET,
> > +                                             elem->size, "exception",
> > +                                             SOF_DEBUGFS_ACCESS_D0_ONLY);
> > +                     break;
> > +             default:
> > +                     dev_err(sdev->dev, "error: get illegal window info\n");
> > +                     return;
> > +             }
> > +     }
> > +
> > +     if (outbox_size == 0 || inbox_size == 0) {
> > +             dev_err(sdev->dev, "error: get illegal mailbox window\n");
> > +             return;
> > +     }
> > +
> > +     snd_sof_dsp_mailbox_init(sdev, inbox_offset, inbox_size,
> > +                              outbox_offset, outbox_size);
> > +     sdev->stream_box.offset = stream_offset;
> > +     sdev->stream_box.size = stream_size;
> > +
> > +     dev_dbg(sdev->dev, " mailbox upstream 0x%x - size 0x%x\n",
> > +             inbox_offset, inbox_size);
> > +     dev_dbg(sdev->dev, " mailbox downstream 0x%x - size 0x%x\n",
> > +             outbox_offset, outbox_size);
> > +     dev_dbg(sdev->dev, " stream region 0x%x - size 0x%x\n",
> > +             stream_offset, stream_size);
> > +}
>
> This looks 100% similar to Baytrail?

Yes!
>
> > +
> > +/*
> > + * IPC Firmware ready.
> > + */
> > +static int imx8_fw_ready(struct snd_sof_dev *sdev, u32 msg_id)
> > +{
> > +     struct sof_ipc_fw_ready *fw_ready = &sdev->fw_ready;
> > +     u32 offset;
> > +     int ret;
> > +
> > +     /* mailbox must be on 4k boundary */
> > +     offset = MBOX_OFFSET;
> > +
> > +     dev_dbg(sdev->dev, "ipc: DSP is ready 0x%8.8x offset 0x%x\n",
> > +             msg_id, offset);
> > +
> > +      /* no need to re-check version/ABI for subsequent boots */
> > +     if (!sdev->first_boot)
> > +             return 0;
> > +
> > +     /* copy data from the DSP FW ready offset */
> > +     sof_block_read(sdev, sdev->mailbox_bar, offset, fw_ready,
> > +                    sizeof(*fw_ready));
> > +     snd_sof_dsp_mailbox_init(sdev, fw_ready->dspbox_offset,
> > +                              fw_ready->dspbox_size,
> > +                              fw_ready->hostbox_offset,
> > +                              fw_ready->hostbox_size);
> > +
> > +     /* make sure ABI version is compatible */
> > +     ret = snd_sof_ipc_valid(sdev);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* now check for extended data */
> > +     snd_sof_fw_parse_ext_data(sdev, SOF_FW_BLK_TYPE_SRAM, MBOX_OFFSET +
> > +                               sizeof(struct sof_ipc_fw_ready));
> > +
> > +     imx8_get_windows(sdev);
> > +
> > +     return 0;
> > +}
>
> That code looks nearly similar to the baytrail one except for the last
> line, we should look into factoring this.

Yes, I got most of my inspiration from intel code.

>
> > +
> > +static void imx8_get_reply(struct snd_sof_dev *sdev)
> > +{
> > +     struct snd_sof_ipc_msg *msg = sdev->msg;
> > +     struct sof_ipc_reply reply;
> > +     unsigned long flags;
> > +     int ret = 0;
> > +
> > +     if (!msg) {
> > +             dev_warn(sdev->dev, "unexpected ipc interrupt\n");
> > +             return;
> > +     }
> > +
> > +     /* get reply */
> > +     sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
> > +
> > +     spin_lock_irqsave(&sdev->ipc_lock, flags);
> > +
> > +     if (reply.error < 0) {
> > +             memcpy(msg->reply_data, &reply, sizeof(reply));
> > +             ret = reply.error;
> > +     } else {
> > +             /* reply has correct size? */
> > +             if (reply.hdr.size != msg->reply_size) {
> > +                     dev_err(sdev->dev, "error: reply expected %zu got %u bytes\n",
> > +                             msg->reply_size, reply.hdr.size);
> > +                     ret = -EINVAL;
> > +             }
> > +
> > +             /* read the message */
> > +             if (msg->reply_size > 0)
> > +                     sof_mailbox_read(sdev, sdev->host_box.offset,
> > +                                      msg->reply_data, msg->reply_size);
> > +     }
> > +
> > +     msg->reply_error = ret;
> > +
> > +     spin_unlock_irqrestore(&sdev->ipc_lock, flags);
>
> I don't see a spin_lock/unlock for the get_reply in the Intel code, is
> this necessary?

Hmm, you are right. I think I've used an older version of the intel code
where there a lock.

>
> > +}
> > +
> > +void imx_dsp_handle_reply(struct imx_dsp_ipc *ipc)
> > +{
> > +     struct imx8_priv *priv = imx_dsp_get_data(ipc);
> > +
> > +     imx8_get_reply(priv->sdev);
> > +     snd_sof_ipc_reply(priv->sdev, 0);
> > +}
> > +
> > +void imx_dsp_handle_request(struct imx_dsp_ipc *ipc)
> > +{
> > +     struct imx8_priv *priv = imx_dsp_get_data(ipc);
> > +
> > +     snd_sof_ipc_msgs_rx(priv->sdev);
> > +}
> > +
> > +struct imx_dsp_ops dsp_ops = {
> > +     .handle_reply           = imx_dsp_handle_reply,
> > +     .handle_request         = imx_dsp_handle_request,
> > +};
> > +
> > +static int imx8_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
> > +{
> > +     struct imx8_priv *priv = (struct imx8_priv *)sdev->private;
> > +
> > +     sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
> > +                       msg->msg_size);
> > +     imx_dsp_ring_doorbell(priv->dsp_ipc, 0);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * DSP control.
> > + */
> > +static int imx8_run(struct snd_sof_dev *sdev)
> > +{
> > +     int ret;
> > +     struct imx8_priv *dsp_priv = (struct imx8_priv *)sdev->private;
> > +
> > +     ret = imx_sc_misc_set_control(dsp_priv->sc_ipc, IMX_SC_R_DSP,
> > +                                   IMX_SC_C_OFS_SEL, 1);
> > +     if (ret < 0) {
> > +             dev_err(sdev->dev, "Error system address offset source select\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = imx_sc_misc_set_control(dsp_priv->sc_ipc, IMX_SC_R_DSP,
> > +                                   IMX_SC_C_OFS_AUDIO, 0x80);
> > +     if (ret < 0) {
> > +             dev_err(sdev->dev, "Error system address offset of AUDIO\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = imx_sc_misc_set_control(dsp_priv->sc_ipc, IMX_SC_R_DSP,
> > +                                   IMX_SC_C_OFS_PERIPH, 0x5A);
> > +     if (ret < 0) {
> > +             dev_err(sdev->dev, "Error system address offset of PERIPH %d\n",
> > +                     ret);
> > +             return ret;
> > +     }
> > +
> > +     ret = imx_sc_misc_set_control(dsp_priv->sc_ipc, IMX_SC_R_DSP,
> > +                                   IMX_SC_C_OFS_IRQ, 0x51);
> > +     if (ret < 0) {
> > +             dev_err(sdev->dev, "Error system address offset of IRQ\n");
> > +             return ret;
> > +     }
> > +
> > +     imx_sc_pm_cpu_start(dsp_priv->sc_ipc, IMX_SC_R_DSP, true,
> > +                         RESET_VECTOR_VADDR);
> > +
> > +     return 0;
> > +}
> > +
> > +static int imx8_probe(struct snd_sof_dev *sdev)
> > +{
> > +     struct imx8_priv *priv;
> > +     int i;
> > +     struct platform_device *pdev =
> > +             container_of(sdev->dev, struct platform_device, dev);
> > +     struct platform_device *ipc_dev;
> > +     struct resource *mmio;
> > +     int num_domains = 0;
> > +     u32 base, size;
> > +     int ret = 0;
> > +     struct device_node *np = pdev->dev.of_node;
> > +     struct device_node *res_node;
> > +     struct resource res;
>
> nit-pick: can we reorder so that we have all counters last and a nice
> xmas-tree shape.
Ack.

>
> > +
> > +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     sdev->private = priv;
> > +     priv->dev = sdev->dev;
> > +     priv->sdev = sdev;
> > +
> > +     ret = imx_scu_get_handle(&priv->sc_ipc);
> > +     if (ret) {
> > +             dev_err(sdev->dev, "Cannot obtain SCU handle (err = %d)\n",
> > +                     ret);
> > +             return ret;
> > +     }
> > +
> > +     ipc_dev = platform_device_register_data(sdev->dev, "imx-dsp",
> > +                                             PLATFORM_DEVID_NONE,
> > +                                             pdev, sizeof(*pdev));
> > +     if (IS_ERR(ipc_dev)) {
> > +             dev_err(sdev->dev, "Failed to register platform device\n");
> > +             return PTR_ERR(ipc_dev);
> > +     }
> > +
> > +     priv->dsp_ipc = dev_get_drvdata(&ipc_dev->dev);
> > +     if (!priv->dsp_ipc)
> > +             return -EPROBE_DEFER;
> > +
> > +     imx_dsp_set_data(priv->dsp_ipc, priv);
> > +     priv->dsp_ipc->ops = &dsp_ops;
> > +
> > +     num_domains = of_count_phandle_with_args(np, "power-domains",
> > +                                              "#power-domain-cells");
> > +     for (i = 0; i < num_domains; i++) {
> > +             struct device *pd_dev;
> > +             struct device_link *link;
> > +
> > +             pd_dev = dev_pm_domain_attach_by_id(&pdev->dev, i);
> > +             if (IS_ERR(pd_dev))
> > +                     return PTR_ERR(pd_dev);
> > +
> > +             link = device_link_add(&pdev->dev, pd_dev,
> > +                                    DL_FLAG_STATELESS |
> > +                                    DL_FLAG_PM_RUNTIME |
> > +                                    DL_FLAG_RPM_ACTIVE);
> > +             if (IS_ERR(link))
> > +                     return PTR_ERR(link);
>
> Question: is the error flow final? Wondering if we release all the
> resources/memory/devices on errors?

Will check again. It seemed no need for resource freeing.

>
> Also are all the resources device-managed, I don't see a remove()?
Good catch for pm stuff. We mostly didn't care about remove because
drivers are always Y in our distribution.

Thanks Pierre for review, I will let some time for others to have a look and
send a new version.

thanks,
Daniel.
