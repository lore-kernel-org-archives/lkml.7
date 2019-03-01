Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25C220840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXfJkBEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbfCASSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:18:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41186 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfCASSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:18:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so11780571pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 10:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h35YKF5L8EDqOduZgWsX8HZ+XsvcGNyCabMpxhGQ+sM=;
        b=AXfJkBEKOABr91YOp8FtleDRjJsoIITi0LpW4niIUJn1iMk9qWes0KpPnaexoZH8xs
         nILFkpONSMEzWSinIRmuJZO92lXRogB+I9NTmH0lkd3bPm0Um5yJdsHGfM28D3jo0IxO
         NIkN6m0BKkoRe9bFWD8tt7vxekNkRCIGrCTLAZT4232WBh2ihF6yxpcYNzyuqExILnCA
         zZ3a7xZKpNfz72feMbsDBowM3JAb3BvUIbeHWK3wUBqWNKNXn+fVkBdR/egNO0LMU78D
         lkwC1gOvrpd+skIFKMKo1ezzLToDsBJgF8dEchjplfumKzLb1UYmRZKzTKWU4ezdqp4T
         vhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h35YKF5L8EDqOduZgWsX8HZ+XsvcGNyCabMpxhGQ+sM=;
        b=VbvJoi7J4E60FxwEXJTnz8ufY9HHiUIalzlA5zw8lpjsf50iHnmwLgqZBgRK2J8TNT
         v3uQ72UITS3VRf/6X2DLsh1kD47IGSI5aDzdDDK8hC5Triyg8uWMeuv6ErP/6IAg/IXb
         B9ao9shIsGdQUySs4KencMuDFYGQLl2DOyCO30IWmW1WRrWyJmxj7wAiiHuhOOenc3Cv
         z+EpeoxjeQZovWtqAbe+R21Gc9paNcNpPzIMu8P5HmaD8k8YdbB7asuikOT9WeuNA2X4
         1fBrXz3ZfTBCIc+8BVnZkxbHPHOXUPHC6xC44xjqLwUtr5Eki30pkppSQhxl8vaVAdvk
         r1RA==
X-Gm-Message-State: APjAAAVhFIUEBBnLPSpQGJleXsbtR0pCUh+M2xkeMK0XRZl2TG8eepiH
        FRPzj1eKeINkgG/oe4CUbC97hFPSNCkzRN0S6ORfYA==
X-Google-Smtp-Source: APXvYqxdY52ou9sQe3bQSQ44lb8A7JywnYfnOuTRYlS+/9lxKf/eAq8f2v9vopXgAchaK4ulrFKcb2v4zSaRdFfPXeE=
X-Received: by 2002:a63:5506:: with SMTP id j6mr6128864pgb.202.1551464323548;
 Fri, 01 Mar 2019 10:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20190228115256.5446-1-louis@kragniz.eu> <20190228122417.9318-1-louis@kragniz.eu>
 <15c6689389503a82394bccb9204650bf20a7a6d3.camel@perches.com>
 <CACJJ=pzfSMgJbt5zKzgN-AcugkYRuGhbB88tsTX7k+-qPnS0jA@mail.gmail.com>
 <1450785b937f4a2b5f98c8548986b162684a719b.camel@perches.com>
 <CACJJ=pz50c3oovHbKkjDDF=pabAj_9RtKGWvtpwx4nO+E_EtJg@mail.gmail.com> <3f515cdb5cb6f77acb5cd8029bacd0be782eed64.camel@perches.com>
In-Reply-To: <3f515cdb5cb6f77acb5cd8029bacd0be782eed64.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 1 Mar 2019 10:18:32 -0800
Message-ID: <CAKwvOdnzArsYOdMc=NC=LQym3CDZG+bvMz0AAbYgo5Le6+aJdw@mail.gmail.com>
Subject: Re: [PATCH] wusb: Remove unnecessary static function ckhdid_printf
To:     Joe Perches <joe@perches.com>
Cc:     Jon Flatley <jflat@chromium.org>, Louis Taylor <louis@kragniz.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 8:38 PM Joe Perches <joe@perches.com> wrote:
>
> This static inline is unnecessary and can be removed
> by using the vsprintf %ph extension.
>
> This reduces overall object size by more than 2K.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Deserves a reported by tag from (https://lkml.org/lkml/2019/2/28/1138)
Reported-by: Louis Taylor <louis@kragniz.eu>

> ---
>  drivers/usb/wusbcore/cbaf.c       | 15 ++++-----------
>  drivers/usb/wusbcore/dev-sysfs.c  |  5 ++---
>  drivers/usb/wusbcore/devconnect.c |  2 +-
>  drivers/usb/wusbcore/wusbhc.c     |  6 +-----
>  include/linux/usb/wusb.h          | 16 ----------------
>  5 files changed, 8 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/usb/wusbcore/cbaf.c b/drivers/usb/wusbcore/cbaf.c
> index 222228c5c1e1..af77064c7456 100644
> --- a/drivers/usb/wusbcore/cbaf.c
> +++ b/drivers/usb/wusbcore/cbaf.c
> @@ -302,10 +302,8 @@ static ssize_t cbaf_wusb_chid_show(struct device *dev,
>  {
>         struct usb_interface *iface = to_usb_interface(dev);
>         struct cbaf *cbaf = usb_get_intfdata(iface);
> -       char pr_chid[WUSB_CKHDID_STRSIZE];
>
> -       ckhdid_printf(pr_chid, sizeof(pr_chid), &cbaf->chid);
> -       return scnprintf(buf, PAGE_SIZE, "%s\n", pr_chid);
> +       return sprintf(buf, "%16ph\n", cbaf->chid.data);
>  }
>
>  static ssize_t cbaf_wusb_chid_store(struct device *dev,
> @@ -415,10 +413,8 @@ static ssize_t cbaf_wusb_cdid_show(struct device *dev,
>  {
>         struct usb_interface *iface = to_usb_interface(dev);
>         struct cbaf *cbaf = usb_get_intfdata(iface);
> -       char pr_cdid[WUSB_CKHDID_STRSIZE];
>
> -       ckhdid_printf(pr_cdid, sizeof(pr_cdid), &cbaf->cdid);
> -       return scnprintf(buf, PAGE_SIZE, "%s\n", pr_cdid);
> +       return sprintf(buf, "%16ph\n", cbaf->cdid.data);
>  }

Great simplification overall.  If you wanted to push further,
cbaf_wusb_c{h|d}id_show() are basically (almost) the same function
now.  They probably could share more code.  Everything else looks
good, thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  static ssize_t cbaf_wusb_cdid_store(struct device *dev,
> @@ -503,7 +499,6 @@ static int cbaf_cc_upload(struct cbaf *cbaf)
>         int result;
>         struct device *dev = &cbaf->usb_iface->dev;
>         struct wusb_cbaf_cc_data *ccd;
> -       char pr_cdid[WUSB_CKHDID_STRSIZE];
>
>         ccd =  cbaf->buffer;
>         *ccd = cbaf_cc_data_defaults;
> @@ -513,10 +508,8 @@ static int cbaf_cc_upload(struct cbaf *cbaf)
>         ccd->BandGroups = cpu_to_le16(cbaf->host_band_groups);
>
>         dev_dbg(dev, "Trying to upload CC:\n");
> -       ckhdid_printf(pr_cdid, sizeof(pr_cdid), &ccd->CHID);
> -       dev_dbg(dev, "  CHID       %s\n", pr_cdid);
> -       ckhdid_printf(pr_cdid, sizeof(pr_cdid), &ccd->CDID);
> -       dev_dbg(dev, "  CDID       %s\n", pr_cdid);
> +       dev_dbg(dev, "  CHID       %16ph\n", ccd->CHID.data);
> +       dev_dbg(dev, "  CDID       %16ph\n", ccd->CDID.data);
>         dev_dbg(dev, "  Bandgroups 0x%04x\n", cbaf->host_band_groups);
>
>         result = usb_control_msg(
> diff --git a/drivers/usb/wusbcore/dev-sysfs.c b/drivers/usb/wusbcore/dev-sysfs.c
> index 85a1acf3a729..67b0a4c412b2 100644
> --- a/drivers/usb/wusbcore/dev-sysfs.c
> +++ b/drivers/usb/wusbcore/dev-sysfs.c
> @@ -50,10 +50,9 @@ static ssize_t wusb_cdid_show(struct device *dev,
>         wusb_dev = wusb_dev_get_by_usb_dev(to_usb_device(dev));
>         if (wusb_dev == NULL)
>                 return -ENODEV;
> -       result = ckhdid_printf(buf, PAGE_SIZE, &wusb_dev->cdid);
> -       strcat(buf, "\n");
> +       result = sprintf(buf, "%16ph\n", wusb_dev->cdid.data);
>         wusb_dev_put(wusb_dev);
> -       return result + 1;
> +       return result;
>  }
>  static DEVICE_ATTR_RO(wusb_cdid);
>
> diff --git a/drivers/usb/wusbcore/devconnect.c b/drivers/usb/wusbcore/devconnect.c
> index fcb06aef2675..a93837d57d53 100644
> --- a/drivers/usb/wusbcore/devconnect.c
> +++ b/drivers/usb/wusbcore/devconnect.c
> @@ -532,7 +532,7 @@ static void wusbhc_handle_dn_connect(struct wusbhc *wusbhc,
>         }
>
>         dnc = container_of(dn_hdr, struct wusb_dn_connect, hdr);
> -       ckhdid_printf(pr_cdid, sizeof(pr_cdid), &dnc->CDID);
> +       sprintf(pr_cdid, "%16ph", dnc->CDID.data);
>         dev_info(dev, "DN CONNECT: device %s @ %x (%s) wants to %s\n",
>                  pr_cdid,
>                  wusb_dn_connect_prev_dev_addr(dnc),
> diff --git a/drivers/usb/wusbcore/wusbhc.c b/drivers/usb/wusbcore/wusbhc.c
> index e5ba6140c1ba..d0b404d258e8 100644
> --- a/drivers/usb/wusbcore/wusbhc.c
> +++ b/drivers/usb/wusbcore/wusbhc.c
> @@ -80,17 +80,13 @@ static ssize_t wusb_chid_show(struct device *dev,
>  {
>         struct wusbhc *wusbhc = usbhc_dev_to_wusbhc(dev);
>         const struct wusb_ckhdid *chid;
> -       ssize_t result = 0;
>
>         if (wusbhc->wuie_host_info != NULL)
>                 chid = &wusbhc->wuie_host_info->CHID;
>         else
>                 chid = &wusb_ckhdid_zero;
>
> -       result += ckhdid_printf(buf, PAGE_SIZE, chid);
> -       result += sprintf(buf + result, "\n");
> -
> -       return result;
> +       return sprintf(buf, "%16ph\n", chid->data);
>  }
>
>  /*
> diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
> index 9e4a3213f2c2..65adee629106 100644
> --- a/include/linux/usb/wusb.h
> +++ b/include/linux/usb/wusb.h
> @@ -236,22 +236,6 @@ enum {
>         WUSB_TRUST_TIMEOUT_MS = 4000,   /* [WUSB] section 4.15.1 */
>  };
>
> -static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
> -                                  const struct wusb_ckhdid *ckhdid)
> -{
> -       return scnprintf(pr_ckhdid, size,
> -                        "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
> -                        "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
> -                        ckhdid->data[0],  ckhdid->data[1],
> -                        ckhdid->data[2],  ckhdid->data[3],
> -                        ckhdid->data[4],  ckhdid->data[5],
> -                        ckhdid->data[6],  ckhdid->data[7],
> -                        ckhdid->data[8],  ckhdid->data[9],
> -                        ckhdid->data[10], ckhdid->data[11],
> -                        ckhdid->data[12], ckhdid->data[13],
> -                        ckhdid->data[14], ckhdid->data[15]);
> -}
> -
>  /*
>   * WUSB Crypto stuff (WUSB1.0[6])
>   */
>
>


-- 
Thanks,
~Nick Desaulniers
