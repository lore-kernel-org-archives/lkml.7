Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87339C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E0421881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWifykzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGCGpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:45:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42610 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfGCGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:45:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so1109937lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptGTicjFq+J0eTU/VpcxUsmOsp/qaZSNFW8K0GR+TOs=;
        b=kWifykzpZN5anpXIiQ4YGdylV33AXUn4GyrE0mtZQ50+vZthGp8hOmYzwGAaFUTju/
         5DmP+TbKSdayBm2W4adywOLUqzuZv2ldPWrpFcUc4oUr3uWIG3tC+oZTIkunY+1HI1Hl
         I1LQvdxcJEK8TZC4EfOOfwVqjWewrJJyUAnEEkVRYxoLxXdcpyXqjkmtbEey0c/oLSF2
         jKAMFREDiyC4VRZyQ953d3IohkmgbTG+O9rdLN0dQ9j0FdaOld5pnEPn7H244FRBQqSG
         L+PpuwWTK0rCWmAI9TRp9eK8EdXAcfnU0FIvWnEFru9hwMQ/DxDvqRt1Ut4VJOFn6hnC
         hJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptGTicjFq+J0eTU/VpcxUsmOsp/qaZSNFW8K0GR+TOs=;
        b=cLoE0HKO9me1l70eZYdju+v5x6V9mRIW4zRXRIDHG0uwY0njqWJfbP/ZqvbFa79lGX
         AZTIdyikTe8WYD+G7z0KoLlpM7GprzIE/56j/Hkd0Mz6+LMWkh7L6RdnNjVZeizmJpVC
         QTc/X5AUG/XlYbbAQpSHnBK/WbA7agUkEiuZ4uO/NhxHw15Sp2444rmeQ3yr1t9k/sbL
         QROdC00hpsoel+mbVvWQu8ivtdjUkZDUzO4TS3PBki/HvaxOtuVlqCQCqLGNIPbVm37v
         gIfDHjbxK8Ut3pyldxy9pUbbdoyAxir/0Ym5w4scL3+I9iPw3MHlEq9F6c2Fna48vW2G
         XUWQ==
X-Gm-Message-State: APjAAAUcKe5mvjCUYqsyr6ETLgKXZfwfmgdHjS81vjHasfi2g8W2gdf7
        dnFkHZ8QDzuSiASzkSZQysBFz8q1dHw1Af6Go/wNrw==
X-Google-Smtp-Source: APXvYqzHLP5x6CDVK5N1nXarqor8EAB7jH3AjLWnOHwZsb5xNHK5SYSF45C/ETdsoHYS4PNC/AJ0+jRqGmYO2T35c80=
X-Received: by 2002:a2e:2e18:: with SMTP id u24mr13211024lju.204.1562136332739;
 Tue, 02 Jul 2019 23:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-7-saravanak@google.com>
In-Reply-To: <20190703011020.151615-7-saravanak@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Jul 2019 08:45:21 +0200
Message-ID: <CAKfTPtCJFaEfvu3Dnp9WSxQEwSfY=VS+xsoQ+4P+vg7_WL0BAQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] interconnect: Add OPP table support for interconnects
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>, kernel-team@android.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 at 03:10, Saravana Kannan <saravanak@google.com> wrote:
>
> Interconnect paths can have different performance points. Now that OPP
> framework supports bandwidth OPP tables, add OPP table support for
> interconnects.
>
> Devices can use the interconnect-opp-table DT property to specify OPP
> tables for interconnect paths. And the driver can obtain the OPP table for
> an interconnect path by calling icc_get_opp_table().

The opp table of a path must come from the aggregation of OPP tables
of the interconnect providers. So such kind of OPP table should be at
provider level but not at path level.

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/interconnect/core.c  | 27 ++++++++++++++++++++++++++-
>  include/linux/interconnect.h |  7 +++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 871eb4bc4efc..881bac80bc1e 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -47,6 +47,7 @@ struct icc_req {
>   */
>  struct icc_path {
>         size_t num_nodes;
> +       struct opp_table *opp_table;
>         struct icc_req reqs[];
>  };
>
> @@ -313,7 +314,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  {
>         struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>         struct icc_node *src_node, *dst_node;
> -       struct device_node *np = NULL;
> +       struct device_node *np = NULL, *opp_node;
>         struct of_phandle_args src_args, dst_args;
>         int idx = 0;
>         int ret;
> @@ -381,10 +382,34 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>                 dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>         mutex_unlock(&icc_lock);
>
> +       opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);
> +       if (opp_node) {
> +               path->opp_table = dev_pm_opp_of_find_table_from_node(opp_node);
> +               of_node_put(opp_node);
> +       }
> +
> +
>         return path;
>  }
>  EXPORT_SYMBOL_GPL(of_icc_get);
>
> +/**
> + * icc_get_opp_table() - Get the OPP table that corresponds to a path
> + * @path: reference to the path returned by icc_get()
> + *
> + * This function will return the OPP table that corresponds to a path handle.
> + * If the interconnect API is disabled, NULL is returned and the consumer
> + * drivers will still build. Drivers are free to handle this specifically, but
> + * they don't have to.
> + *
> + * Return: opp_table pointer on success. NULL is returned when the API is
> + * disabled or the OPP table is missing.
> + */
> +struct opp_table *icc_get_opp_table(struct icc_path *path)
> +{
> +       return path->opp_table;
> +}
> +
>  /**
>   * icc_set_bw() - set bandwidth constraints on an interconnect path
>   * @path: reference to the path returned by icc_get()
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index dc25864755ba..0c0bc55f0e89 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -9,6 +9,7 @@
>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
> +#include <linux/pm_opp.h>
>
>  /* macros for converting to icc units */
>  #define Bps_to_icc(x)  ((x) / 1000)
> @@ -28,6 +29,7 @@ struct device;
>  struct icc_path *icc_get(struct device *dev, const int src_id,
>                          const int dst_id);
>  struct icc_path *of_icc_get(struct device *dev, const char *name);
> +struct opp_table *icc_get_opp_table(struct icc_path *path);
>  void icc_put(struct icc_path *path);
>  int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>
> @@ -49,6 +51,11 @@ static inline void icc_put(struct icc_path *path)
>  {
>  }
>
> +static inline struct opp_table *icc_get_opp_table(struct icc_path *path)
> +{
> +       return NULL;
> +}
> +
>  static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  {
>         return 0;
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
