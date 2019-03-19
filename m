Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6515213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XMD3wPAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCSVB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:01:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35766 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfCSVB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:01:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id j132so83741oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pio8TBO/QxsrXniSoOcMA/CnPnxy0r3ewdeSRItQSw0=;
        b=XMD3wPAA6RKkVosjWQwrcVhBSXF4CQRZ8WKqSVJ9/VfCAf3dqaP2ng/aEHufoysWhB
         YrexdPQzS+tQ3FrO/+rUCd5AZNQDZMAEV9VCpW5RIY7jbMmiRf6wunCroGrodqHcKoLl
         dZEtk2EtuOMEaazpk7jMIqI9UgbzCpDk41SXpYKx2kvo9R2W7t9TJ98S5lzHdblY3bNK
         Bx0Yt+LEGL6ANZbbr+/LqdPqFFXSTjcvaWBnq6CH5+w62cW2L94/Qaqhk6WrRGKMLQxN
         +NDzy6J0jJVqFrWy6rx8GiNCUBZFkt0MucGFSGF3AvCS9NPYSWlUClVIKKU8kQ2DRDsV
         yKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pio8TBO/QxsrXniSoOcMA/CnPnxy0r3ewdeSRItQSw0=;
        b=a0H9YuGnPp25y7a3cI2WM2f91EKpce+vTU1QKxv6paFcGKvLmD3s6J0Qp0maOi7djV
         ggOfhEYM/Q+SC3VWm4/9AveuEwAiPD9k590XI002uues5WI3Hfmruc7t3fL+m8f2T0kR
         tJpnF2TBeb8/G2bameHB9Qakvd/rqBWGmVH6V52kWZEyjp0DzyXyrK8RtF3hQlK/kbf+
         GgKKK0L32tBcJ8NRV0U69uHQxjDkR7FvReMbpgAW/sGABDAZ/Mn4HX/3aFppCt0n/70A
         MwcngbIypu8q80fZJAH/snBUyl9aKBTj12/BxAqaPFCwDtCzkGG9imGX8RYXEupKpK4O
         THhQ==
X-Gm-Message-State: APjAAAV3jCIjHstWlZOmgYosBb9GMuSuK78ktiN/N5+uSkEv5QrIYxyL
        oKLmsPUwjChhgdaYz9li787bGQvpyDBhtminWMJ32A==
X-Google-Smtp-Source: APXvYqyHNtGGZSB7SlpOJuqDZtzl6bzk0eKQD3cO5l9cq0xQo47Tfb8PX+RvbbwXDPfbDMpqweT+G/hCWCzFon2Me5E=
X-Received: by 2002:aca:aa57:: with SMTP id t84mr2883959oie.149.1553029315376;
 Tue, 19 Mar 2019 14:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 14:01:44 -0700
Message-ID: <CAPcyv4ij2nHD7JumKNcNYB4gAGujWzCPkcpoi=XafmG3EP2b0g@mail.gmail.com>
Subject: Re: [PATCH 0/6] security/keys/encrypted: Break module dependency chain
To:     keyrings@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
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

On Mon, Mar 18, 2019 at 11:18 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> With v5.1-rc1 all the nvdimm sub-system regression tests started failing
> because the libnvdimm module failed to load in the qemu-kvm test
> environment.  Critically that environment does not have a TPM. Commit
> 240730437deb "KEYS: trusted: explicitly use tpm_chip structure..."
> started to require a TPM to be present for the trusted.ko module to load
> where there was no requirement for that before.
>
> Rather than undo the "fail if no hardware" behavior James points out
> that the module dependencies can be broken by looking up the key-type by
> name. Remove the dependencies on the "key_type_trusted" and
> "key_type_encrypted" symbol exports, and clean up other boilerplate that
> supported those exports in different configurations.

Any feedback? Was hoping to get at least patch1 in the queue for
v5.1-rc2 since this effectively disables the nvdimm driver on typical
configurations. Jarkko, would you be willing to merge it since the
regression came through your tree?

> Dan Williams (6):
>       security/keys/encrypted: Allow operation without trusted.ko
>       security/keys/encrypted: Clean up request_trusted_key()
>       libnvdimm/security: Drop direct dependency on key_type_encrypted
>       security/keys/ecryptfs: Drop direct dependency on key_type_encrypted
>       security/integrity/evm: Drop direct dependency on key_type_encrypted
>       security/keys/encrypted: Drop export of key_type_encrypted
>
>
>  drivers/nvdimm/security.c                        |   11 ++++-
>  fs/ecryptfs/ecryptfs_kernel.h                    |   22 -----------
>  fs/ecryptfs/keystore.c                           |   12 ++++++
>  include/keys/encrypted-type.h                    |    2 -
>  include/linux/key.h                              |    1
>  security/integrity/evm/evm_crypto.c              |    9 ++++
>  security/keys/encrypted-keys/Makefile            |    3 -
>  security/keys/encrypted-keys/encrypted.c         |   35 ++++++++++++++++-
>  security/keys/encrypted-keys/encrypted.h         |   12 ------
>  security/keys/encrypted-keys/masterkey_trusted.c |   46 ----------------------
>  security/keys/internal.h                         |    2 -
>  security/keys/key.c                              |    1
>  12 files changed, 65 insertions(+), 91 deletions(-)
>  delete mode 100644 security/keys/encrypted-keys/masterkey_trusted.c
