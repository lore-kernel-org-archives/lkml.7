Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6785AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E922067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HcnG05wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKLTiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:38:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45594 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:38:03 -0500
Received: by mail-oi1-f195.google.com with SMTP id 14so9941671oir.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WimPYMY4ElLHUFFKax8XxzUf794g+9qy+ZcVmaVuAcA=;
        b=HcnG05wnGXWAD3tJYg/lrbE1+BP8mZbcyUXiEhT/4H5cmFBXdm3LKznNrl7E06/RvD
         nrMvD1V15i3JWo6K7vp/VRjIrRS2nSyFSCYI8nPTTeGkVucNiA6+ctSfIUzcIIvV6fb6
         sDT8iHpdk7lXBXkPvyp7/GCIWbwBhDpNpfKVOvgcyOGje8Q4Yd0VyT7rd8EfPfmXIBp3
         ULNNC9ad1rTHxaWTGUMdDaaqTftk8ZZxHfUFcU2bpQpTuDHusLrARE7GHzz5nhrUAKYH
         C9yvDnR9ztR92XmKIaUbf3aKBrmVWX0DszAGA3L+zGW44LVsKSfSImwMdxaj4baUPBHh
         uYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WimPYMY4ElLHUFFKax8XxzUf794g+9qy+ZcVmaVuAcA=;
        b=TVXBO0fBBL1FwONbJHISEhW5AWpPP5UNjQDka11GUNlXo/XNlEtx8o1fi+Xc/jUjZj
         GaHmeH/9Gw0aUBHiamr4eLVx9vQdHa5JAHVip4RCA0TTCx58o6hgOmfl338LBqXGP0NO
         yfS4vGTY7J3IpB71Aw7KUlOZ9jz1cbIIi3m09AezFkSA73RaHVKbzxnUniqGtzOMWYtV
         AyoOgQDZ1kswXh5tyRSy1GGGSFRw3Zu3NU1aT8xdtH1URwMFnGuZERe6YBnjCDydiLWP
         z2kM5rkrAeYgbasw02EsKHEUB0aLuMmHcVHUayTZlR4/gJsQ1uNajh8hSvIJ4rzw49K6
         CuQg==
X-Gm-Message-State: APjAAAUzWBqizodyHhfC6SVoXf0St7iLzjJn8osX30D7W+MxTN3OW1fw
        Cx2bWl90U7+oF8UNJMLNz52PGvy4ws4cXh+oO/kadA==
X-Google-Smtp-Source: APXvYqy4nVx5cqhvzWgLCkvoCxBoiErI2cm44tEsrTAKJ9s0rE6buD5AjAFCNien8s0flORShIZ0P4Y/eJ81VIPpwYo=
X-Received: by 2002:aca:ad52:: with SMTP id w79mr550653oie.149.1573587482869;
 Tue, 12 Nov 2019 11:38:02 -0800 (PST)
MIME-Version: 1.0
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <8736ettj60.fsf@linux.ibm.com>
In-Reply-To: <8736ettj60.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Nov 2019 11:37:51 -0800
Message-ID: <CAPcyv4iKE6x2uD0NUjivO8KFXQxcX_kWBysShXBf_p8PfFiMXA@mail.gmail.com>
Subject: Re: [PATCH 00/16] Memory Hierarchy: Enable target node lookups for
 reserved memory
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 3:43 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Yes, this patch series looks like a pile of boring libnvdimm cleanups,
> > but buried at the end are some small gems that testing with libnvdimm
> > uncovered. These gems will prove more valuable over time for Memory
> > Hierarchy management as more platforms, via the ACPI HMAT and EFI
> > Specific Purpose Memory, publish reserved or "soft-reserved" ranges to
> > Linux. Linux system administrators will expect to be able to interact
> > with those ranges with a unique numa node number when/if that memory is
> > onlined via the dax_kmem driver [1].
> >
> > One configuration that currently fails to properly convey the target
> > node for the resulting memory hotplug operation is persistent memory
> > defined by the memmap=nn!ss parameter. For example, today if node1 is a
> > memory only node, and all the memory from node1 is specified to
> > memmap=nn!ss and subsequently onlined, it will end up being onlined as
> > node0 memory. As it stands, memory_add_physaddr_to_nid() can only
> > identify online nodes and since node1 in this example has no online cpus
> > / memory the target node is initialized node0.
> >
> > The fix is to preserve rather than discard the numa_meminfo entries that
> > are relevant for reserved memory ranges, and to uplevel the node
> > distance helper for determining the "local" (closest) node relative to
> > an initiator node.
> >
> > The first 12 patches are cleanups to make sure that all nvdimm devices
> > and their children properly export a numa_node attribute. The switch to
> > a device-type is less code and less error prone as a result.
>
>
> Will this still allow leaf driver to have platform specific attribute
> exposed via sysfs? Or do we want to still keep them in nvdimm core and
> control the visibility via is_visible() callback?

The leaf driver can still have platform specific attributes, see:

    acpi_nfit_attribute_groups
    acpi_nfit_dimm_attribute_groups
    acpi_nfit_region_attribute_groups

...that still exist after this conversion. This conversion simply
arranges for those to passed in without making the leaf driver also be
responsible for specifying the core attributes.
