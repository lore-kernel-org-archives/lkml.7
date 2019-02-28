Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D84BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BE22184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EhzMZZr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfB1HyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:54:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37238 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfB1HyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:54:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id w66so15769287oia.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 23:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oge1v0CI7B6i3pkVqnC/QfefhOu5L2twbcqoTGVhkCQ=;
        b=EhzMZZr+sRfu5A8F4nCspWxurM7GYsUuit+M4eikNppiCN/FWZEg/OF2ZVRFUMf7Sm
         wzzbepq/XbXWubVw6VHXPdLE74Z4AEiqKZ5KsekOmYyYUUFPVlsqLgNJtZWjvI6/n7YU
         Xsh+BicS3fJnhOH8z8dWI20m0CauIc70eq0w0NUbdKeOIzovGSA546Ig//TY6MXLpOTX
         jr613YEjvSXUnJAG3sOsYnRvyj0B5T6Xj0V6A8SM12RY5MsMLvrUETkZmJ9bPdxaIsqS
         aVStzMCiTkjyVcpqYeAhNZEbo1VkW3Td7LQvioIiHqE8HHUN4U77ohdlQo8PWQttszpD
         1+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oge1v0CI7B6i3pkVqnC/QfefhOu5L2twbcqoTGVhkCQ=;
        b=P09SsAzjA+ldot6L5pUNOJ0q2t5lzzt2WannrkXT2clxc9dS6gdgLlvtihqAXgS2yf
         mvcNmGmyz2bPFTzlEulBtfxzGzTh9oOjz5ziFgqzVkGYnBK5Hi33v7HAkuV4xrrtNIFZ
         Nw94izi1W4HG9ACF1Zk6II2ESlFurGlTWcXPFyGpXInaSDLFRBYAB3X/8B27DM6IvcxX
         D3ML03LS+8UF1Y1HqZtXcKu5R8l8Va9GYxGbx+d5Kw5Qq82yHFj73+olomyZIuwortdj
         /86QQEnCx3Ji5/ETOJIl1jXBnOd2oHdNNl1NWMdXIWTVFhbUnUmjt9QEC7C+OIqEhSLV
         Z2og==
X-Gm-Message-State: AHQUAuYdvvDioFGcZFc+ZVBxw03MetEXYHYIox5N5g4Okm9ke/AdwQEA
        4Ogx8bHScjhBMDjlD7CuTnGEGiBYu43jPF1igAswpA==
X-Google-Smtp-Source: AHgI3IbkiPdsFeFzguag0b4I3zroh+QeHRG2uCIfc+UreYswnZM9YP/qszsvAyNGZLPR65RdvNitqZGb90bHbB/ahMU=
X-Received: by 2002:aca:4a10:: with SMTP id x16mr2100135oia.73.1551340443762;
 Wed, 27 Feb 2019 23:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20190225185727.BCBD768C@viggo.jf.intel.com>
In-Reply-To: <20190225185727.BCBD768C@viggo.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Feb 2019 23:53:52 -0800
Message-ID: <CAPcyv4g8ACK6ZOmDWVVhCAwcoaxRZdXQDt_8D6Omckuop8DapQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] [v5] Allow persistent memory to be used like normal RAM
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Stephen and Juergen ]

On Mon, Feb 25, 2019 at 11:02 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> This is a relatively small delta from v4.  The review comments seem
> to be settling down, so it seems like we should start thinking about
> how this might get merged.  Are there any objections to taking it in
> via the nvdimm tree?
>
> Dan Williams, our intrepid nvdimm maintainer has said he would
> appreciate acks on these from relevant folks before merging them.
> Reviews/acks on any in the series would be welcome, but the last
> two especially are lacking any non-Intel acks:
>
>         mm/resource: let walk_system_ram_range() search child resources
>         dax: "Hotplug" persistent memory for use like normal RAM

I've gone ahead and added this to the libnvdimm-for-next branch for
wider exposure. Acks of course still welcome.

Stephen, this collides with commit 357b4da50a62 "x86: respect memory
size limiting via mem= parameter" in current -next. Here's my
resolution for reference, basically just add the max_mem_size
statement to Dave's rework. Holler if this causes any other problems.

diff --cc mm/memory_hotplug.c
index a9d5787044e1,b37f3a5c4833..c4f59ac21014
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@@ -102,28 -99,21 +102,24 @@@ u64 max_mem_size = U64_MAX
  /* add this memory to iomem resource */
  static struct resource *register_memory_resource(u64 start, u64 size)
  {
-       struct resource *res, *conflict;
+       struct resource *res;
+       unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+       char *resource_name = "System RAM";

 +      if (start + size > max_mem_size)
 +              return ERR_PTR(-E2BIG);
 +
-       res = kzalloc(sizeof(struct resource), GFP_KERNEL);
-       if (!res)
-               return ERR_PTR(-ENOMEM);
-
-       res->name = "System RAM";
-       res->start = start;
-       res->end = start + size - 1;
-       res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-       conflict =  request_resource_conflict(&iomem_resource, res);
-       if (conflict) {
-               if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
-                       pr_debug("Device unaddressable memory block "
-                                "memory hotplug at %#010llx !\n",
-                                (unsigned long long)start);
-               }
-               pr_debug("System RAM resource %pR cannot be added\n", res);
-               kfree(res);
+       /*
+        * Request ownership of the new memory range.  This might be
+        * a child of an existing resource that was present but
+        * not marked as busy.
+        */
+       res = __request_region(&iomem_resource, start, size,
+                              resource_name, flags);
+
+       if (!res) {
+               pr_debug("Unable to reserve System RAM region:
%016llx->%016llx\n",
+                               start, start + size);
                return ERR_PTR(-EEXIST);
        }
        return res;
