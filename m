Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFE521900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="N5//jGST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCVStj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:49:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41697 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCVStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:49:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so2488287oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bI3YQ2UGTKs+MAcoBFqJxdwZKPIFUOvygyRC2OsSzCA=;
        b=N5//jGST86vYO340eYtI3EkCEzKT7yaEuHzY5+Kh5B7VJhGKQZ4aKXs1HDfK/9Ix5h
         ItPRUvuvEz9BWfASgO0emxKL4zXSy8oxYLRmVa5XPCr3WDgrEwo4c4J1tBIxQzudJMjt
         Degur5vzEwCS+T5z4mcKAcgf0BbI4d1JDWTB5LfIt8BFes3E7B4Z9pktgeJO6GE2vhx7
         5ygVZpcDN5oSJS8dQFNnzQQ5bfLhI8aCTcf83/iahdkt1fCs5ligA2mRZCaUugpP/SjO
         mGIo60JluCwEQxloMNcpZHIe2/8Dk4nDlxzJSPCKkkPdJgVzrOIcvW69mByO9FNLXpR2
         09IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bI3YQ2UGTKs+MAcoBFqJxdwZKPIFUOvygyRC2OsSzCA=;
        b=NjyRXLDiNjZsDNk3Y92HLcJKx0u69G6rJpNoUtb5zaPfWiI10dtxGFGQOttE4aRFEX
         DpAGas5vDLspvwr6xFUfa9qILApHK+pHpisyXZQ27fAtdiGyTAJewoy30NdMD6jS+Kou
         7LGkM9edoeBS+eC4Kv+C737iU0tlIs2IwlFRbnG25drt0plDEFLC0I9d9qxCnVbFck9C
         ixWPQIRFF/84W+dXzQlCNVAmWjce2mMWNX8mnyIYNpHDCft/tp6NC4vvKc6Vs+IPt8zB
         CucClfVf29eRX7pjEU55J8zm0hHr0A5k3w/Ss5lqkAwsZ/8dk0HoDKrYKKKa7AuJNDuk
         hi+g==
X-Gm-Message-State: APjAAAVubfTYMCZAeZ58a+Jvk71JaUJn0fZT4u5mR/IiYG49XeVoVx8+
        YbbGAwQRHypMZ6xMjJdkSyXRZAgV+oebXo/vNcQ0gg==
X-Google-Smtp-Source: APXvYqy4BJvYNZA7/ljIt/taH8vx1sPjx2JqEJOnCU54OBPk4JrQc65yT3qysc8ckBPzxLC48dIT/rgTYmGOgtvH+l8=
X-Received: by 2002:aca:aa57:: with SMTP id t84mr2975823oie.149.1553280578611;
 Fri, 22 Mar 2019 11:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190322180139.18856-1-roberto.sassu@huawei.com>
In-Reply-To: <20190322180139.18856-1-roberto.sassu@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Mar 2019 11:49:27 -0700
Message-ID: <CAPcyv4jU-TCyfJ5gxrEaZt1GDJ+b_FtYi9O8H=cqLbqOAaskuw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: defer execution of TPM-specific code until
 key instantiate
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, david.safford@ge.com,
        James Bottomley <jejb@linux.ibm.com>,
        Silviu Vlasceanu <silviu.vlasceanu@huawei.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:04 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Commit 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from
> tpm_default_chip()") changed the tpm_chip argument of every TPM function
> from NULL to a pointer that is retrieved at module initialization time.
>
> Unlike before this patch, the trusted module cannot be loaded if no TPM is
> available. Unfortunately, this causes a dependency problem because the
> encrypted key type requires the 'key_type_trusted' symbol when
> CONFIG_TRUSTED_KEYS is defined.
>
> This patch fixes the issue by deferring the execution of TPM-specific code
> until a new trusted key is instantiated: init_tpm(), to obtain a tpm_chip
> pointer; init_digests(), introduced by commit 0b6cf6b97b7e ("tpm: pass an
> array of tpm_extend_digest structures to tpm_pcr_extend()"), to get random
> bytes from the TPM to lock a PCR.
>
> Cc: stable@vger.kernel.org
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()")
> Reported-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks Robert!
