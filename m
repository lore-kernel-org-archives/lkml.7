Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD3C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083BC2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554843950;
	bh=xnpa7ujTpqe8MwJmLJse6j4GVSpXEGQ+bN23OWVBL04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UU3NbFUOmMKYwNjsI+CNungqr9ie4BZL1/gHmYfhpBsdjAE5+uDqV/YvNJYXiK51V
	 5gj+pQJY95FTPxvxWJR9ahrTHQOZdOlOUMoLHb+dzCQ5qcI53j3ggkjtF53CX9h5Aq
	 CVhIn9+jPPB0UHTgZmImo2txPECCMIA1OVCyetfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDIVFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfDIVFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:05:48 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5CA2082A;
        Tue,  9 Apr 2019 21:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554843947;
        bh=xnpa7ujTpqe8MwJmLJse6j4GVSpXEGQ+bN23OWVBL04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PvkwfNVEbwSqg9TTt1ePcOY1xhzVWyFRh/KNzFlCFf5WsbLL9Nk1nQKBr7ZXrplw+
         mmFyYfFW+fPqyoN27p274r8vK7f2I5b06aFXlQ8D12WCAG/pgi9UUNPxMXvaibbFjk
         y4EKwq3s5uMH8TNLcXAMw+Gj6kUu9/neA7hoJdc0=
Received: by mail-ed1-f50.google.com with SMTP id s39so105588edb.2;
        Tue, 09 Apr 2019 14:05:46 -0700 (PDT)
X-Gm-Message-State: APjAAAVNH9YPEu+h6Cs3DZzZrp4Y/78+thur55NDcZXN5I4aaO81/+Tp
        fsMOmHTDF58XYejxh651SZxb21140PY7a5tmyUQ=
X-Google-Smtp-Source: APXvYqymhMNELio6LR5G11T4S+8eVv8lYMACka0cW2NKNWtrJaNQSZoydvX1eblpHnD/OEsz+e88wu9o4PHACgGkkOI=
X-Received: by 2002:a50:b5c3:: with SMTP id a61mr18787964ede.31.1554843945534;
 Tue, 09 Apr 2019 14:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-14-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-14-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 9 Apr 2019 16:05:09 -0500
X-Gmail-Original-Message-ID: <CANk1AXQvsUYHmyZ7XF2LD+eNQ2FV33HageL0Mgbt7-9YVaagdw@mail.gmail.com>
Message-ID: <CANk1AXQvsUYHmyZ7XF2LD+eNQ2FV33HageL0Mgbt7-9YVaagdw@mail.gmail.com>
Subject: Re: [PATCH 13/17] fpga: dfl: fme: add capability sysfs interfaces
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:24 PM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Looks good...

>
> This patch adds 3 read-only sysfs interfaces for FPGA Management Engine
> (FME) block for capabilities including cache_size, fabric_version and
> socket_id.
>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan

> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-fme | 23 ++++++++++++
>  drivers/fpga/dfl-fme-main.c                      | 48 ++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index 8fa4feb..b8327e9 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -21,3 +21,26 @@ Contact:     Wu Hao <hao.wu@intel.com>
>  Description:   Read-only. It returns Bitstream (static FPGA region) meta
>                 data, which includes the synthesis date, seed and other
>                 information of this static FPGA region.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/cache_size
> +Date:          March 2019
> +KernelVersion:  5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. It returns cache size of this FPGA device.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/fabric_version
> +Date:          March 2019
> +KernelVersion:  5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. It returns fabric version of this FPGA device.
> +               Userspace applications need this information to select
> +               best data channels per different fabric design.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/socket_id
> +Date:          March 2019
> +KernelVersion:  5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. It returns socket_id to indicate which socket
> +               this FPGA belongs to, only valid for integrated solution.
> +               User only needs this information, in case standard numa node
> +               can't provide correct information.
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 38c6342..8339ee8 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -75,10 +75,58 @@ static ssize_t bitstream_metadata_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(bitstream_metadata);
>
> +static ssize_t cache_size_show(struct device *dev,
> +                              struct device_attribute *attr, char *buf)
> +{
> +       void __iomem *base;
> +       u64 v;
> +
> +       base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +
> +       v = readq(base + FME_HDR_CAP);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> +                        (unsigned int)FIELD_GET(FME_CAP_CACHE_SIZE, v));
> +}
> +static DEVICE_ATTR_RO(cache_size);
> +
> +static ssize_t fabric_version_show(struct device *dev,
> +                                  struct device_attribute *attr, char *buf)
> +{
> +       void __iomem *base;
> +       u64 v;
> +
> +       base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +
> +       v = readq(base + FME_HDR_CAP);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> +                        (unsigned int)FIELD_GET(FME_CAP_FABRIC_VERID, v));
> +}
> +static DEVICE_ATTR_RO(fabric_version);
> +
> +static ssize_t socket_id_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       void __iomem *base;
> +       u64 v;
> +
> +       base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +
> +       v = readq(base + FME_HDR_CAP);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> +                        (unsigned int)FIELD_GET(FME_CAP_SOCKET_ID, v));
> +}
> +static DEVICE_ATTR_RO(socket_id);
> +
>  static const struct attribute *fme_hdr_attrs[] = {
>         &dev_attr_ports_num.attr,
>         &dev_attr_bitstream_id.attr,
>         &dev_attr_bitstream_metadata.attr,
> +       &dev_attr_cache_size.attr,
> +       &dev_attr_fabric_version.attr,
> +       &dev_attr_socket_id.attr,
>         NULL,
>  };
>
> --
> 2.7.4
>
