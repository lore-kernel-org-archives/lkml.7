Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18583C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40B824679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="aewkQnNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfLTHM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:12:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33847 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfLTHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:12:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so8367767wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 23:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=I2m7FEoEgsHjv2bLMPPs6pK2dGPZu4nGzDA5vSdYg2g=;
        b=aewkQnNnv53dP93qLGgJshlGAMUAoExZYBjsVGTZKP3swyysCcVeWAoQK1MODPAqWO
         BH53JDDE0Vde5lV9G8gtPQmual1laQg5+txVUMKiUqvsAgtSDM0k6xrhhAD+NWpRLecc
         miAJyaBSOvGqk3WNsk4AXF5DAUfUvrI7ezFLDEpnermkNfDgH92qIJ+t7GhIAATdcj9s
         OcibV53NmKFy5pLKPkXIYAS1f5w43RPGhNATVtk98rZJVvYKDFhzZSN23StvGv9fcJc+
         AxGYHoD5cJONLccWUTAXfl4zGyRK/MTXN01egZjsnycA0ZC/oa6WyW6rl8jPkB+kSkc2
         xkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=I2m7FEoEgsHjv2bLMPPs6pK2dGPZu4nGzDA5vSdYg2g=;
        b=fY9UVjHyT2YjHThF0wzNtXYn29nVvFkAnprzhcY1IqrBGt0ByAf2vGp9jqYqDIZopG
         5v5hlVOqCC6QEIxZ/2T5aUjF6+lSP9BdWfZ/J+PKEamuiicLsNSYLb4ICUBtk9FnhC+Q
         PGTpVI70tIKMQ4HXDiP27n0q0136JSC1PQFJ+gNOlXjsbO2HFa5f/4UGdvtPgAYpprqa
         SBKGf9/tbBF8TT3SdJA+P29hb2gqXCgaY6Q6OaURb/7feIDDrN7U6qZQTQwACLh1nhf3
         giQbqyfVGA68/oU38fvKuqJMy4oW3eHyscDjA9nkdZGSo2G133Aq4MNM51ppkQZrOvji
         mN6A==
X-Gm-Message-State: APjAAAXH5Z9247dWaeLCazCMHsQXCbi/tQppXI/hvP/OpiethA8txHKz
        ESdNx3dDBz0A8AgEoDV5v3GrXg==
X-Google-Smtp-Source: APXvYqwzANwQbkdywUdCxVE2iwgboUXMP8N0dc0HdOPN/yCnvAV54g1qiVetuF6mZDjwYzh67zoPOQ==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr13483479wrx.153.1576825946247;
        Thu, 19 Dec 2019 23:12:26 -0800 (PST)
Received: from rudolphp (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id x6sm8530461wmi.44.2019.12.19.23.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 23:12:24 -0800 (PST)
Message-ID: <9158a0d87f6493977455179202cd86165437f5f6.camel@9elements.com>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
From:   patrick.rudolph@9elements.com
To:     Julius Werner <jwerner@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Date:   Fri, 20 Dec 2019 08:12:22 +0100
In-Reply-To: <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com>
         <20191128125100.14291-2-patrick.rudolph@9elements.com>
         <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-09 at 22:54 -0800, Julius Werner wrote:
> > +static int cbmem_probe(struct coreboot_device *cdev)
> > +{
> > +       struct device *dev = &cdev->dev;
> > +       struct cb_priv *priv;
> > +       int err;
> > +
> > +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv-
> > >entry));
> > +
> > +       priv->remap = memremap(priv->entry.address,
> > +                              priv->entry.entry_size,
> > MEMREMAP_WB);
> 
> We've just been discussing some problems with CBMEM areas and memory
> mapping types in Chrome OS. CBMEM is not guaranteed to be page-
> aligned
> (at least not the "small" entries), but the kernel can only assign
> memory attributes for a page at a time (and refuses to map the same
> area twice with two different memory types, for good reason). So if
> CBMEM entries sharing a page are mapped as writeback by one driver
> but
> uncached by the other, things break.
> 
> There are some CBMEM entries that need to be mapped uncached (e.g.
> the
> ACPI UCSI table, which isn't even handled by anything using this
> CBMEM
> code) and others for which it would make more sense (e.g. the memory
> console, where firmware may add more lines at runtime), but I don't
> think there are any regions that really *need* to be writeback. None
> of the stuff accessing these areas should access them often enough
> that caching matters, and I think it's generally more common to map
> firmware memory areas as uncached anyway. So how about we standardize
> on mapping it all uncached to avoid any attribute clashes? (That
> would
> mean changing the existing VPD and memconsole drivers to use
> ioremap(), too.)

I wasn't aware that CBMEM is used for DMA as there's no such concept in
coreboot yet. For me it looks like the UCSI is regular DRAM mapped as
WB accessed by the ACPI interpreter.
I'll prepare a new patch-set using ioremap in all drivers that access
CBMEM.

