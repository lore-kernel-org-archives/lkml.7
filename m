Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E39C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE8F20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lJeUtQ+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCSVX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:23:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46207 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSVXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:23:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id c18so145071otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWQ3vhfwHXfkcaJP6o/4GK1QQqtD6Zxo1tjyMAbIy9o=;
        b=lJeUtQ+uwy3fSmM0iS35fhjhapm/C6bTPBslQomirVjFWzTl3/gk0yJ3gwEZuZnouK
         WK5k6+khlgIS3I3qoUzr7ggeUy4BooeZY9la5x2mkWhBRqYrGg69Spdok4gsQwslkcic
         eJ+QWg6YA1g709IAYJozlnk9iGGkqcWH2BfpmFKbgV3GgfuBYtyMy90hU8kDs86DxVvA
         Yx+/DbbvNMjPwoL8mdO000jiCzKl0vgMtvq7D+HE5E5kQVnYmrFRiCh4h/x2s8eCPTIS
         i/4vRlH+bY6QkaPPs52csZVrLjbDPopcQQqIcWXbiqMQ9Hiyr92bQVs9cltkPtQ9+iG3
         Mizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWQ3vhfwHXfkcaJP6o/4GK1QQqtD6Zxo1tjyMAbIy9o=;
        b=pcWsJxcqptyIj29qIW+UmI7/Lh4xlC1pIzP3rTh+iXBtrJCttLnpDjOFlbvAUNdEc2
         d296xhgzIlOEnrKoVw2+VYgGPMPQsf/8w3Oiy9IUPg+RBTvqh5YKRKc4c9p1r2FQjr5V
         jZTtdwTLhlzBJtC905TzfhBWoXdCgxsycx3qr0YE2wSDYudwVwPfp5RFGKV8xYv0dRzn
         y35unN1kHKIWFSMb8rrvmBmf2ntr25zn79R6dtLO6lNecHvd3a6sNK5PALvra8Tj2j+W
         u+E2c2vy08R0zy40nWm88e4rV0vuodXEBnJV2A9OO3+/6K5PC1/3RDu1W12BmiIQDmJg
         M5jQ==
X-Gm-Message-State: APjAAAUGaKVKe+vDsxKhzA/M7lq7uH6a5nlgdA6XayZnWTvtgEWa3HYJ
        SKheyxhD8/dpyIz7MwXtYYWyjGbH+5yMx/E7qLl+7w==
X-Google-Smtp-Source: APXvYqzrq49Z56YsAlcH5XYcXSWl3q2MG92JjDVxNUlugsQzb9jzdS7anEYOqTTJIN8g4016KZYEiLrZTd/3wWtKADM=
X-Received: by 2002:a05:6830:1c1:: with SMTP id r1mr3122166ota.229.1553030604327;
 Tue, 19 Mar 2019 14:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4ij2nHD7JumKNcNYB4gAGujWzCPkcpoi=XafmG3EP2b0g@mail.gmail.com> <1553029714.2932.43.camel@linux.ibm.com>
In-Reply-To: <1553029714.2932.43.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 14:23:13 -0700
Message-ID: <CAPcyv4jt-wbjR-eyeJ=hrcAF2jGBw11tdwL9=33+-CfxNNgLjg@mail.gmail.com>
Subject: Re: [PATCH 0/6] security/keys/encrypted: Break module dependency chain
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, ecryptfs@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 2:09 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Tue, 2019-03-19 at 14:01 -0700, Dan Williams wrote:
> > On Mon, Mar 18, 2019 at 11:18 PM Dan Williams <dan.j.williams@intel.c
> > om> wrote:
> > >
> > > With v5.1-rc1 all the nvdimm sub-system regression tests started
> > > failing because the libnvdimm module failed to load in the qemu-kvm
> > > test environment.  Critically that environment does not have a TPM.
> > > Commit 240730437deb "KEYS: trusted: explicitly use tpm_chip
> > > structure..." started to require a TPM to be present for the
> > > trusted.ko module to load where there was no requirement for that
> > > before.
> > >
> > > Rather than undo the "fail if no hardware" behavior James points
> > > out that the module dependencies can be broken by looking up the
> > > key-type by name. Remove the dependencies on the "key_type_trusted"
> > > and "key_type_encrypted" symbol exports, and clean up other
> > > boilerplate that supported those exports in different
> > > configurations.
> >
> > Any feedback? Was hoping to get at least patch1 in the queue for
> > v5.1-rc2 since this effectively disables the nvdimm driver on typical
> > configurations. Jarkko, would you be willing to merge it since the
> > regression came through your tree?
>
> The reason I sent out the RFC was to see if the people who actually
> wrote the code had any reasons they needed the current way of doing
> things preserving.
>
> I think your series looks fine except you need to export
> key_type_lookup (patch 2) before you use it (patch 1) to preserve
> bisectability of builds.

Good catch, I fumbled that around. I'll respin and let 0day chew on it
before sending out another version.
