Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBD3CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7220D205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ecUT7YuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfJUQby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:31:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52363 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfJUQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:31:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so14083989wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3IkhyqN1C3DeqmpvyeKao62eu0Id9wyxWa4NyKMwjSY=;
        b=ecUT7YuSAH7EqAHwjxoJ7bXyebXggXNBwTBOODxudm9W3L4rkeeF2Tup1Rjgq9+0nX
         1ig00rspZrWlFuh9g6eK7Iu3wfnnlYbTq5Ri8hsPUTViIT9wIE6HafPFwHR/TllGcxDR
         /9VvDHFweGt+uOWhUbn9oGA4OsW6S59AVRWtMrVsp2JVl6obVs2Z+ocmObYsTyrsJFVq
         HXrxI67X+xn7XSZiGSVIxnN9jAi3rsKEqKhd4FTequn80r2arymkCrxSqoB1GN+QqgJp
         iAqbQbKupwGVXNS8Z0tNTPAej0KM6EndGKI+mdUmCApAZb6zvxHZ5V2QC4OygoowVtSt
         9kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3IkhyqN1C3DeqmpvyeKao62eu0Id9wyxWa4NyKMwjSY=;
        b=e0GeNCig+7iFA+JBRb5AdP1LtzZNfuVln0BLBNvf0DmsNY7cL1XynM82XStJ/VH8AO
         NP6HBIHQdsV8ceenHmJVh50r5WErWyEATxY/1PTvrc6Pd4q8slAY6BwYt5hsXXugLBfv
         DW6siQfHmp/kL/cnzTG+38h/4RtgGx03wWdSGgkLkzikJrq1riUXZvdKxVGRkZ7K8MaC
         58Le0+auM4YVxznmHMWp91GSRzpB+LVi9WRqc/GSgHLrt2rJipt0r4tTu9Bnsq/fou63
         pQkli/KjYyjL++KDSlDXQWZ61BSPznDgDSiBPz9FLgXnx40dozqyGnlTU8WE3yJVhCpT
         cqSA==
X-Gm-Message-State: APjAAAWscuq0tysFMeIAygWHP1rTpXqZO8jVyuXQs4tSRj+Km2VilrP6
        gpKsKOT2wQyK+tIrc15rzpIlew==
X-Google-Smtp-Source: APXvYqzPOa4k0MGzDnxIlfae62AIVxgrRFLh8OdQdSIsPDPBjcYwh/TC0W5XSEVF4sDYB4ISkgFdIQ==
X-Received: by 2002:a7b:cf28:: with SMTP id m8mr20552680wmg.63.1571675512031;
        Mon, 21 Oct 2019 09:31:52 -0700 (PDT)
Received: from netronome.com ([83.137.2.245])
        by smtp.gmail.com with ESMTPSA id z9sm16104645wrl.35.2019.10.21.09.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 09:31:51 -0700 (PDT)
Date:   Mon, 21 Oct 2019 18:31:40 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, tiwei.bie@intel.com, jason.zeng@intel.com,
        zhiyuan.lv@intel.com
Subject: Re: [RFC 1/2] vhost: IFC VF hardware operation layer
Message-ID: <20191021163139.GC4486@netronome.com>
References: <20191016011041.3441-1-lingshan.zhu@intel.com>
 <20191016011041.3441-2-lingshan.zhu@intel.com>
 <20191016095347.5sb43knc7eq44ivo@netronome.com>
 <075be045-3a02-e7d8-672f-4a207c410ee8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075be045-3a02-e7d8-672f-4a207c410ee8@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:55:33PM +0800, Zhu, Lingshan wrote:
> 
> On 10/16/2019 5:53 PM, Simon Horman wrote:
> > Hi Zhu,
> > 
> > thanks for your patch.
> > 
> > On Wed, Oct 16, 2019 at 09:10:40AM +0800, Zhu Lingshan wrote:

...

> > > +static void ifcvf_read_dev_config(struct ifcvf_hw *hw, u64 offset,
> > > +		       void *dst, int length)
> > > +{
> > > +	int i;
> > > +	u8 *p;
> > > +	u8 old_gen, new_gen;
> > > +
> > > +	do {
> > > +		old_gen = ioread8(&hw->common_cfg->config_generation);
> > > +
> > > +		p = dst;
> > > +		for (i = 0; i < length; i++)
> > > +			*p++ = ioread8((u8 *)hw->dev_cfg + offset + i);
> > > +
> > > +		new_gen = ioread8(&hw->common_cfg->config_generation);
> > > +	} while (old_gen != new_gen);
> > Would it be wise to limit the number of iterations of the loop above?
> Thanks but I don't quite get it. This is used to make sure the function
> would get the latest config.

I am worried about the possibility that it will loop forever.
Could that happen?

...

> > > +static void io_write64_twopart(u64 val, u32 *lo, u32 *hi)
> > > +{
> > > +	iowrite32(val & ((1ULL << 32) - 1), lo);
> > > +	iowrite32(val >> 32, hi);
> > > +}
> > I see this macro is also in virtio_pci_modern.c
> > 
> > Assuming lo and hi aren't guaranteed to be sequential
> > and thus iowrite64_hi_lo() cannot be used perhaps
> > it would be good to add a common helper somewhere.
> Thanks, I will try after this IFC patchwork, I will cc you.

Thanks.

...
