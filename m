Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054A4C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 23:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B557720818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 23:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TtbGAGWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEOX1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 19:27:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34037 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEOXZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:25:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id l17so1726466otq.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klWe1X2kwGWTqHnD0kZUJYyAWHWMIBILlhfu7UeUVVU=;
        b=TtbGAGWdg/sFEvxvKLNEZ3rTz7M7jfaRfe9gkKZaWkcRY6wmWibUhniy4j6lMmowes
         k4ZkROyySNl28Ly0EaCwYr/DoQLXncEJMz04K6R1TSilBAWE5LGJc8AsxZS1firED+jR
         BGlWjEZACXditdDy5plTGSvMT+HiPDAmujo8v6hFs0xeAFhq+qeHMCfFJGGYgYIYdys+
         KIVydwcyDbANs8aIX5IB35f+4IB3uZkBBggGc1aP2h+WC9lrQPgXB2T0LN9LXo4EGDI6
         2il7zKY5TwInDXv+g52o6VMtQVQNFZ/ggEmKBDPef5GIGedriiglj5vbuzLNqEdHC7+0
         IcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klWe1X2kwGWTqHnD0kZUJYyAWHWMIBILlhfu7UeUVVU=;
        b=G/p3YiLn+1DfMZsxtPPgEz/niAnsdJPnLTtExwcSFC7WxlA7raL1ybGLZb1pF2BxIE
         oVZKcEcFHbYSZ9/35cEoVlLpVwdgdRbqg0Pr+e1/QFVS+H2EmEbykE70W5w3MAKWrpcg
         6M7BhXM2VdUjPlVlHRvxa8kALGKOpED74PC0dwgmmc/7d3ZjRDHQ0M7nno1/ykW0ah08
         Orsx2vcoD+P4aOaVYzVkTu81Bf+6QTMRvxrNQ4rYdtQfmF7zErK2qVVgZDswY4up9WkN
         rh9gSrK8cGeQACZz3aDn5Dt8C8uZPR01ji4Y5ee24UN4U5oiqXnLodSUi6Xyoo5qb6Uv
         U7vA==
X-Gm-Message-State: APjAAAVn4kp7RZQF+Jhr5R4pF+2ngwUH4YPM68hV1zwjaUKloAKHVQep
        HJ4rU3pzN1siqzle2oZ5Kn7PCE2kitGDzJti0CkZTQ==
X-Google-Smtp-Source: APXvYqyM5sfKqWWuJ6NZ12KG98/fUsZHMvQd7yZZtlA/U/scHiv81oFh4P8+Ypn6b9fGKLScDh5q4DWj5y6qwTHenr4=
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr11455354otg.116.1557962728184;
 Wed, 15 May 2019 16:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190514150735.39625-1-cai@lca.pw>
In-Reply-To: <20190514150735.39625-1-cai@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 May 2019 16:25:16 -0700
Message-ID: <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 8:08 AM Qian Cai <cai@lca.pw> wrote:
>
> Several places (dimm_devs.c, core.c etc) include label.h but only
> label.c uses NSINDEX_SIGNATURE, so move its definition to label.c
> instead.
> In file included from drivers/nvdimm/dimm_devs.c:23:
> drivers/nvdimm/label.h:41:19: warning: 'NSINDEX_SIGNATURE' defined but
> not used [-Wunused-const-variable=]
>
> The commit d9b83c756953 ("libnvdimm, btt: rework error clearing") left
> an unused variable.
> drivers/nvdimm/btt.c: In function 'btt_read_pg':
> drivers/nvdimm/btt.c:1272:8: warning: variable 'rc' set but not used
> [-Wunused-but-set-variable]
>
> Last, some places abuse "/**" which is only reserved for the kernel-doc.
> drivers/nvdimm/bus.c:648: warning: cannot understand function prototype:
> 'struct attribute_group nd_device_attribute_group = '
> drivers/nvdimm/bus.c:677: warning: cannot understand function prototype:
> 'struct attribute_group nd_numa_attribute_group = '

Can you include the compiler where these errors start appearing, since
I don't see these warnings with gcc-8.3.1

>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/nvdimm/btt.c   | 6 ++----
>  drivers/nvdimm/bus.c   | 4 ++--
>  drivers/nvdimm/label.c | 2 ++
>  drivers/nvdimm/label.h | 2 --
>  4 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 4671776f5623..9f02a99cfac0 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1269,11 +1269,9 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
>
>                 ret = btt_data_read(arena, page, off, postmap, cur_len);
>                 if (ret) {
> -                       int rc;
> -
>                         /* Media error - set the e_flag */
> -                       rc = btt_map_write(arena, premap, postmap, 0, 1,
> -                               NVDIMM_IO_ATOMIC);
> +                       btt_map_write(arena, premap, postmap, 0, 1,
> +                                     NVDIMM_IO_ATOMIC);
>                         goto out_rtt;

This doesn't look correct to me, shouldn't we at least be logging that
the bad-block failed to be persistently tracked?

>                 }
>
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 7ff684159f29..2eb6a6cfe9e4 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -642,7 +642,7 @@ static struct attribute *nd_device_attributes[] = {
>         NULL,
>  };
>
> -/**
> +/*
>   * nd_device_attribute_group - generic attributes for all devices on an nd bus
>   */
>  struct attribute_group nd_device_attribute_group = {
> @@ -671,7 +671,7 @@ static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
>         return a->mode;
>  }
>
> -/**
> +/*
>   * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
>   */

Lets just fix this to be a valid kernel-doc format for a struct.

@@ -672,7 +672,7 @@ static umode_t nd_numa_attr_visible(struct kobject
*kobj, struct attribute *a,
 }

 /**
- * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
+ * struct nd_numa_attribute_group - NUMA attributes for all devices
on an nd bus
  */
 struct attribute_group nd_numa_attribute_group = {
        .attrs = nd_numa_attributes,

>  struct attribute_group nd_numa_attribute_group = {
> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
> index f3d753d3169c..02a51b7775e1 100644
> --- a/drivers/nvdimm/label.c
> +++ b/drivers/nvdimm/label.c
> @@ -25,6 +25,8 @@ static guid_t nvdimm_btt2_guid;
>  static guid_t nvdimm_pfn_guid;
>  static guid_t nvdimm_dax_guid;
>
> +static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
> +

Looks good to me.

>  static u32 best_seq(u32 a, u32 b)
>  {
>         a &= NSINDEX_SEQ_MASK;
> diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
> index e9a2ad3c2150..4bb7add39580 100644
> --- a/drivers/nvdimm/label.h
> +++ b/drivers/nvdimm/label.h
> @@ -38,8 +38,6 @@ enum {
>         ND_NSINDEX_INIT = 0x1,
>  };
>
> -static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
> -
>  /**
>   * struct nd_namespace_index - label set superblock
>   * @sig: NAMESPACE_INDEX\0
> --
> 2.20.1 (Apple Git-117)
>
