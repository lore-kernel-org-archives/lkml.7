Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7756B20873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVsyXeM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbfJDPgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:36:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38603 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389913AbfJDPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:36:05 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so14476947iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7wtWmNaBzWvHZFXd7ETJjhq/Ls8R+LbN1dmWdsPcLY8=;
        b=dVsyXeM+omMSii7CtpS0Du2za9NVA5njCkQUFjCWvClC5TIp4AfWCO4StgcM+JsVYO
         lj2RQdcQ7punxe1uv6ZBQBHk1CW5E+xCoVocUtDIquHCr9hdFneeQcAGmipReTC/pU6W
         lLTqG8QfMAqlPdFapGoA6BTIG5MKWJycO00e5pjiS0dRgDYsyZVFUKpcSWHcxE/9gUeL
         nbJhvaX0/XVgmENdcRDA5da1eh2dw/d7/0Pe5LIJuSAJOT+ASgS8ysIed0PwDZaS7eXJ
         Hcu0fqTZNPVsUVDDu9CbYJAXK88Sb5XS9WwhFXYh/MFJmJ8ytp/BiPWwDn+V1cuilSkV
         8NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7wtWmNaBzWvHZFXd7ETJjhq/Ls8R+LbN1dmWdsPcLY8=;
        b=ovbQr/pdqVcxj8s5M6nXhyhlsGYj3A4HUmP1uWjCCqBVPCieOVNc7XGMnxzB1yDp0H
         Kay2xNBX7M1WaKSw52v183XvuOGAH1x9v+eEvagNVfh0tVD6L13V4bBPsYroqyGVtzi7
         Hwn6oCKcQ2WLtb/WQhswlT6RfA0sEzvJrUwl/uSV7iBLe8lhzoSnUj93qrsksjG+ytGT
         BA/x6RvvDxZNbDP9qqTp/cmtvN0veYZGhPX7A+38WqcoGUjzF5CggTY3LOy1r2E1hekq
         8d2PmbVBessoZd6uuQ7KtQ78nmuzuSBdVdyVHdMOdCI0aDHKFrNtTKAB8MY2M8i/IAQH
         Lugg==
X-Gm-Message-State: APjAAAUJVN5S7xD2FOoZaJkNGY8NSnX4G4/P8Ni/j9Mh9WOyWhvGC1LL
        lS5bzd5f1xjN2o09nkcqLPU9OdT34aZWG2V0arY=
X-Google-Smtp-Source: APXvYqwyXYuqJXNQSyqexuyIk1RBvL29kVGFINewYpKfKOnPBcgWsjdT14kVqNJH+073EwFW0A+Dv6sYwrOooEet4mk=
X-Received: by 2002:a6b:c8cf:: with SMTP id y198mr9811572iof.179.1570203364443;
 Fri, 04 Oct 2019 08:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191003191354.GA4481@Serenity>
In-Reply-To: <20191003191354.GA4481@Serenity>
From:   Tyler Ramer <tyaramer@gmail.com>
Date:   Fri, 4 Oct 2019 11:36:42 -0400
Message-ID: <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a failure we had which represents the issue the patch is
intended to solve:

Aug 26 15:00:56 testhost kernel: nvme nvme4: async event result 00010300
Aug 26 15:01:27 testhost kernel: nvme nvme4: controller is down; will
reset: CSTS=0x3, PCI_STATUS=0x10
Aug 26 15:02:10 testhost kernel: nvme nvme4: Device not ready; aborting reset
Aug 26 15:02:10 testhost kernel: nvme nvme4: Removing after probe
failure status: -19

The CSTS warnings comes from nvme_timeout, and is printed by
nvme_warn_reset. A reset then occurs
Controller state should be NVME_CTRL_RESETTING

Now, in nvme_reset_work, controller is never marked "CONNECTING"  at:

     if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING))

because several lines above, we can determine that
nvme_pci_configure_admin_queues returns
a bad result, which triggers a goto out_unlock and prints "removing
after probe failure status: -19"

Because state is never changed to NVME_CTRL_CONNECTING or
NVME_CTRL_DELETING, the
logic added in https://github.com/torvalds/linux/commit/2036f7263d70e67d70a67899a468588cb7356bc9
should not apply. We can further validate that dev->ctrl.state ==
NVME_CTRL_RESETTING thanks to
the WARN_ON in nvme_reset_work.






On Thu, Oct 3, 2019 at 3:13 PM Tyler Ramer <tyaramer@gmail.com> wrote:
>
> Always shutdown the controller when nvme_remove_dead_controller is
> reached.
>
> It's possible for nvme_remove_dead_controller to be called as part of a
> failed reset, when there is a bad NVME_CSTS. The controller won't
> be comming back online, so we should shut it down rather than just
> disabling.
>
> Signed-off-by: Tyler Ramer <tyaramer@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c0808f9eb8ab..c3f5ba22c625 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2509,7 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>  {
>         nvme_get_ctrl(&dev->ctrl);
> -       nvme_dev_disable(dev, false);
> +       nvme_dev_disable(dev, true);
>         nvme_kill_queues(&dev->ctrl);
>         if (!queue_work(nvme_wq, &dev->remove_work))
>                 nvme_put_ctrl(&dev->ctrl);
> --
> 2.23.0
>
