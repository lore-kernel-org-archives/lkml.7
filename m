Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DF5C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227E1214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2dCAgfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbfHHOMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:12:07 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34482 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390098AbfHHOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:12:07 -0400
Received: by mail-ua1-f66.google.com with SMTP id c4so9644612uad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNVZgrjZAoC1yeVxZddqbJGZYNnHMsHA3+Hp07xldq0=;
        b=U2dCAgfBv1ightu3KHjqo2GKg/cQiEULplV60BxGmuGUlnybV+X5qzQUdY6zWlVITq
         5qBX/5wWKwqO50qy9jj4+hMUAr/lfCs4dhN/4rkiu15xsmJaVHphvoLaIa0FGdBtNWHd
         hrzoA6QVIfJa7SuIWIw1+b3vtB40SgbW38CTunEdCfb0XRbmEXl0FrQtxKntt5N5XNzt
         UkbSwiy6WSTp0z5NjPkU7CizrKEXsLkQC86s8VgOrSLXQKyFqM3jMEOhhQnaWforefCY
         u83npG1wOnOSlR05wu5yo2UxL51t5pDpXAefK7Y+RjPOZ3A/lUUXu3WRQ7o4JNpxZ2Do
         rhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNVZgrjZAoC1yeVxZddqbJGZYNnHMsHA3+Hp07xldq0=;
        b=IDJ/P4M/mWicaCDCUlothf441szVCpIWPuMhJGaCD9/bTNHVdnPtOy6HxfsP1gz9Ql
         rkb+67E2OFIr27BRXIFbwgNN+Lx6oFXWBsQXxXnAlWqBe6pGGfvACsBnqtmD6NMPvOR3
         rDaY+2BjHp8RGkMNhMbs8JK5FaGV+nS53fXYM87RPxGS/oxUHJu2kFb8uS84FLhMso/4
         Opvtq/2SaqAmNxWSGmeqrTQpSJEsWjMW1a9Oq1y9Zn5SyXTDcq4Sub1tzHIGF7QjTSjq
         3BvA26Rb0fKNj4BYtFn18oDRHvCy4BDDxAsAtPdE0mCIU9qxPFkGKZxP23TCHctzA89W
         HOpQ==
X-Gm-Message-State: APjAAAVHYW/gd3cbQBLMJaF6qfw5Jbs7CCpiNIq4uJ6Peig3DIgce3CO
        wAuzOkraS0RL+LX1nH+1T4vUvt/9f95W8Evr6/MlxQ==
X-Google-Smtp-Source: APXvYqy/6AuAvMUiSSaCu01fEZsnLNa7Zc91nfxm3bQk3kVfMnPmTFon//I1cPYbP/UrxBAWx2+NYIPPDBzyTwURjyA=
X-Received: by 2002:ab0:20cc:: with SMTP id z12mr7849404ual.32.1565273525864;
 Thu, 08 Aug 2019 07:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190808122422.28521-1-ttayar@habana.ai>
In-Reply-To: <20190808122422.28521-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 8 Aug 2019 17:11:39 +0300
Message-ID: <CAFCwf12V3bFELqUfHDiuby++w9waeX=3u9_oxeQm8wEpnCPpWA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Expose devices after initialization is done
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 3:25 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> The char devices are currently exposed to user before the device and
> driver initialization are done.
> This patch moves the cdev and device adding to the system to the end of
> the initialization sequence, while keeping the creation of the
> structures at the beginning to allow the usage of dev_*().
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/device.c     | 163 ++++++++++++++++++---------
>  drivers/misc/habanalabs/habanalabs.h |   2 +
>  2 files changed, 111 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index efde1fe7d286..9a5926888b99 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -151,50 +151,94 @@ static const struct file_operations hl_ctrl_ops = {
>         .compat_ioctl = hl_ioctl_control
>  };
>
> +static void device_release_func(struct device *dev)
> +{
> +       kfree(dev);
> +}
> +
>  /*
> - * device_setup_cdev - setup cdev and device for habanalabs device
> + * device_init_cdev - Initialize cdev and device for habanalabs device
>   *
>   * @hdev: pointer to habanalabs device structure
>   * @hclass: pointer to the class object of the device
>   * @minor: minor number of the specific device
>   * @fpos: file operations to install for this device
>   * @name: name of the device as it will appear in the filesystem
> - * @cdev: pointer to the char device object that will be created
> - * @dev: pointer to the device object that will be created
> + * @cdev: pointer to the char device object that will be initialized
> + * @dev: pointer to the device object that will be initialized
>   *
> - * Create a cdev and a Linux device for habanalabs's device. Need to be
> - * called at the end of the habanalabs device initialization process,
> - * because this function exposes the device to the user
> + * Initialize a cdev and a Linux device for habanalabs's device.
>   */
> -static int device_setup_cdev(struct hl_device *hdev, struct class *hclass,
> +static int device_init_cdev(struct hl_device *hdev, struct class *hclass,
>                                 int minor, const struct file_operations *fops,
>                                 char *name, struct cdev *cdev,
>                                 struct device **dev)
>  {
> -       int err, devno = MKDEV(hdev->major, minor);
> -
>         cdev_init(cdev, fops);
>         cdev->owner = THIS_MODULE;
> -       err = cdev_add(cdev, devno, 1);
> -       if (err) {
> -               pr_err("Failed to add char device %s\n", name);
> -               return err;
> +
> +       *dev = kzalloc(sizeof(**dev), GFP_KERNEL);
> +       if (!*dev)
> +               return -ENOMEM;
> +
> +       device_initialize(*dev);
> +       (*dev)->devt = MKDEV(hdev->major, minor);
> +       (*dev)->class = hclass;
> +       (*dev)->release = device_release_func;
> +       dev_set_drvdata(*dev, hdev);
> +       dev_set_name(*dev, "%s", name);
> +
> +       return 0;
> +}
> +
> +static int device_cdev_sysfs_add(struct hl_device *hdev)
> +{
> +       int rc;
> +
> +       rc = cdev_device_add(&hdev->cdev, hdev->dev);
> +       if (rc) {
> +               dev_err(hdev->dev,
> +                       "failed to add a char device to the system\n");
> +               return rc;
>         }
>
> -       *dev = device_create(hclass, NULL, devno, NULL, "%s", name);
> -       if (IS_ERR(*dev)) {
> -               pr_err("Failed to create device %s\n", name);
> -               err = PTR_ERR(*dev);
> -               goto err_device_create;
> +       rc = cdev_device_add(&hdev->cdev_ctrl, hdev->dev_ctrl);
> +       if (rc) {
> +               dev_err(hdev->dev,
> +                       "failed to add a control char device to the system\n");
> +               goto delete_cdev_device;
>         }
>
> -       dev_set_drvdata(*dev, hdev);
> +       /* hl_sysfs_init() must be done after adding the device to the system */
> +       rc = hl_sysfs_init(hdev);
> +       if (rc) {
> +               dev_err(hdev->dev, "failed to initialize sysfs\n");
> +               goto delete_ctrl_cdev_device;
> +       }
> +
> +       hdev->cdev_sysfs_created = true;
>
>         return 0;
>
> -err_device_create:
> -       cdev_del(cdev);
> -       return err;
> +delete_ctrl_cdev_device:
> +       cdev_device_del(&hdev->cdev_ctrl, hdev->dev_ctrl);
> +delete_cdev_device:
> +       cdev_device_del(&hdev->cdev, hdev->dev);
> +       return rc;
> +}
> +
> +static void device_cdev_sysfs_del(struct hl_device *hdev)
> +{
> +       /* device_release() won't be called so must free devices explicitly */
> +       if (!hdev->cdev_sysfs_created) {
> +               kfree(hdev->dev_ctrl);
> +               kfree(hdev->dev);
> +               return;
> +       }
> +
> +       hl_sysfs_fini(hdev);
> +       cdev_device_del(&hdev->cdev_ctrl, hdev->dev_ctrl);
> +       cdev_device_del(&hdev->cdev, hdev->dev);
>  }
>
>  /*
> @@ -898,13 +942,16 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>  {
>         int i, rc, cq_ready_cnt;
>         char *name;
> +       bool add_cdev_sysfs_on_err = false;
>
>         name = kasprintf(GFP_KERNEL, "hl%d", hdev->id / 2);
> -       if (!name)
> -               return -ENOMEM;
> +       if (!name) {
> +               rc = -ENOMEM;
> +               goto out_disabled;
> +       }
>
> -       /* Create device */
> -       rc = device_setup_cdev(hdev, hclass, hdev->id, &hl_ops, name,
> +       /* Initialize cdev and device structures */
> +       rc = device_init_cdev(hdev, hclass, hdev->id, &hl_ops, name,
>                                 &hdev->cdev, &hdev->dev);
>
>         kfree(name);
> @@ -915,22 +962,22 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>         name = kasprintf(GFP_KERNEL, "hl_controlD%d", hdev->id / 2);
>         if (!name) {
>                 rc = -ENOMEM;
> -               goto release_device;
> +               goto free_dev;
>         }
>
> -       /* Create control device */
> -       rc = device_setup_cdev(hdev, hclass, hdev->id_control, &hl_ctrl_ops,
> +       /* Initialize cdev and device structures for control device */
> +       rc = device_init_cdev(hdev, hclass, hdev->id_control, &hl_ctrl_ops,
>                                 name, &hdev->cdev_ctrl, &hdev->dev_ctrl);
>
>         kfree(name);
>
>         if (rc)
> -               goto release_device;
> +               goto free_dev;
>
>         /* Initialize ASIC function pointers and perform early init */
>         rc = device_early_init(hdev);
>         if (rc)
> -               goto release_control_device;
> +               goto free_dev_ctrl;
>
>         /*
>          * Start calling ASIC initialization. First S/W then H/W and finally
> @@ -1016,12 +1063,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>                 goto release_ctx;
>         }
>
> -       rc = hl_sysfs_init(hdev);
> -       if (rc) {
> -               dev_err(hdev->dev, "failed to initialize sysfs\n");
> -               goto free_cb_pool;
> -       }
> -
>         hl_debugfs_add_device(hdev);
>
>         if (hdev->asic_funcs->get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
> @@ -1030,6 +1071,12 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>                 hdev->asic_funcs->hw_fini(hdev, true);
>         }
>
> +       /*
> +        * From this point, in case of an error, add char devices and create
> +        * sysfs nodes as part of the error flow, to allow debugging.
> +        */
> +       add_cdev_sysfs_on_err = true;
> +
>         rc = hdev->asic_funcs->hw_init(hdev);
>         if (rc) {
>                 dev_err(hdev->dev, "failed to initialize the H/W\n");
> @@ -1066,9 +1113,24 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>         }
>
>         /*
> -        * hl_hwmon_init must be called after device_late_init, because only
> +        * Expose devices and sysfs nodes to user.
> +        * From here there is no need to add char devices and create sysfs nodes
> +        * in case of an error.
> +        */
> +       add_cdev_sysfs_on_err = false;
> +       rc = device_cdev_sysfs_add(hdev);
> +       if (rc) {
> +               dev_err(hdev->dev,
> +                       "Failed to add char devices and sysfs nodes\n");
> +               rc = 0;
> +               goto out_disabled;
> +       }
> +
> +       /*
> +        * hl_hwmon_init() must be called after device_late_init(), because only
>          * there we get the information from the device about which
> -        * hwmon-related sensors the device supports
> +        * hwmon-related sensors the device supports.
> +        * Furthermore, it must be done after adding the device to the system.
>          */
>         rc = hl_hwmon_init(hdev);
>         if (rc) {
> @@ -1084,8 +1146,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>
>         return 0;
>
> -free_cb_pool:
> -       hl_cb_pool_fini(hdev);
>  release_ctx:
>         if (hl_ctx_put(hdev->kernel_ctx) != 1)
>                 dev_err(hdev->dev,
> @@ -1106,14 +1166,14 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>         hdev->asic_funcs->sw_fini(hdev);
>  early_fini:
>         device_early_fini(hdev);
> -release_control_device:
> -       device_destroy(hclass, hdev->dev_ctrl->devt);
> -       cdev_del(&hdev->cdev_ctrl);
> -release_device:
> -       device_destroy(hclass, hdev->dev->devt);
> -       cdev_del(&hdev->cdev);
> +free_dev_ctrl:
> +       kfree(hdev->dev_ctrl);
> +free_dev:
> +       kfree(hdev->dev);
>  out_disabled:
>         hdev->disabled = true;
> +       if (add_cdev_sysfs_on_err)
> +               device_cdev_sysfs_add(hdev);
>         if (hdev->pdev)
>                 dev_err(&hdev->pdev->dev,
>                         "Failed to initialize hl%d. Device is NOT usable !\n",
> @@ -1179,8 +1239,6 @@ void hl_device_fini(struct hl_device *hdev)
>
>         hl_debugfs_remove_device(hdev);
>
> -       hl_sysfs_fini(hdev);
> -
>         /*
>          * Halt the engines and disable interrupts so we won't get any more
>          * completions from H/W and we won't have any accesses from the
> @@ -1223,11 +1281,8 @@ void hl_device_fini(struct hl_device *hdev)
>
>         device_early_fini(hdev);
>
> -       /* Hide device from user */
> -       device_destroy(hdev->dev_ctrl->class, hdev->dev_ctrl->devt);
> -       cdev_del(&hdev->cdev_ctrl);
> -       device_destroy(hdev->dev->class, hdev->dev->devt);
> -       cdev_del(&hdev->cdev);
> +       /* Hide devices and sysfs nodes from user */
> +       device_cdev_sysfs_del(hdev);
>
>         pr_info("removed device successfully\n");
>  }
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index aaaa29d98901..1bb181285589 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -1216,6 +1216,7 @@ struct hl_device_reset_work {
>   * @dma_mask: the dma mask that was set for this device
>   * @in_debug: is device under debug. This, together with fpriv_list, enforces
>   *            that only a single user is configuring the debug infrastructure.
> + * @cdev_sysfs_created: were char devices and sysfs nodes created.
>   */
>  struct hl_device {
>         struct pci_dev                  *pdev;
> @@ -1291,6 +1292,7 @@ struct hl_device {
>         u8                              device_cpu_disabled;
>         u8                              dma_mask;
>         u8                              in_debug;
> +       u8                              cdev_sysfs_created;
>
>         /* Parameters for bring-up */
>         u8                              mmu_enable;
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
