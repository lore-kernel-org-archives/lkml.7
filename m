Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFEBC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7360B2158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmPqSNsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfK1BIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:08:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbfK1BIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574903311;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lxh3+1e+t0p/N8JdhBbJ4iy/gsFRZKU/W7b/lbYo44=;
        b=XmPqSNsfhR1L9EZzKwNPMwUeVgS0Jb90KgrcVCys3tT6rg639bcVI6NlJh2tN+nXOgs32B
        o/V9dyzocpTO3a/GHNfpECXimRUgkmyEpSo0nZjEzT7AJsmiWp3i35RG4puxhPRUsoK9aW
        rUspKix4DlxT1UjI5tl4u8eg2uWMCGY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-CH1QW6XoOtuqcLlvWag6XA-1; Wed, 27 Nov 2019 20:08:30 -0500
Received: by mail-pg1-f199.google.com with SMTP id l13so1064030pgt.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 17:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4lxh3+1e+t0p/N8JdhBbJ4iy/gsFRZKU/W7b/lbYo44=;
        b=r4nXh8EwB3bpwKBGb0aIBv/wunuTRQ6MhSp1lSu6/uf7e7U1roh62kEdAR+WfdjSr7
         0/b1Fi5FPvfzrhXxerl9UkaOcaQC5ueTZsEGZR8wkqClBqUCevIzhhJaCJZGD68BLCsz
         dBrycSkkrhOGurkaRFHDQjppYiqmA6hniioJtkC6Cfrbt//fQkpBL3uLMt/EwcjqV5eQ
         nBjmHUo/7vE3vVuBT0lhBqZ72Q5kUYSpxJTs2WAVwM7hhJloWJRY1Y9mDfRrMwu8dqok
         VAdUPpPFJ3oXZQvRwHIf+jCFyisj4RH/EXWUsqgy9C//Whp7Dr0b4FIblhVJh3tDEB3L
         Yekg==
X-Gm-Message-State: APjAAAVsagXET5tJt7WXD+eyWzKJg7k/N7wCxyENMsz7yKAGROU803Vk
        MRtXSsSGil42GYMQlUxhbpiD3/v+jiwrnTi20x2Nm4K2I+B8cBwhpOnBB06/865mQCaKwrQlsEN
        xfmd+P7mrJdrlWW4d3JEcoBFk
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr7074831plp.334.1574903308944;
        Wed, 27 Nov 2019 17:08:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcvc25Epzzx5nB68vlU5JUnkFeScMae9w13LQmZvEajOi11t7slcGmn/Ggj/jfoNtwCuq/zQ==
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr7074796plp.334.1574903308548;
        Wed, 27 Nov 2019 17:08:28 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id h5sm1676517pfk.30.2019.11.27.17.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 17:08:27 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:08:26 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Add tpm_version_major sysfs file
Message-ID: <20191128010826.w4ixlix3s3ovta3m@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <20191030225843.23366-1-jsnitsel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191030225843.23366-1-jsnitsel@redhat.com>
X-MC-Unique: CH1QW6XoOtuqcLlvWag6XA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 30 19, Jerry Snitselaar wrote:
>Easily determining what TCG version a tpm device implements
>has been a pain point for userspace for a long time, so
>add a sysfs file to report the TCG major version of a tpm device.
>
>Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
>describing the new file.
>
>Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Cc: Mimi Zohar <zohar@linux.ibm.com>
>Cc: Peter Huewe <peterhuewe@gmx.de>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: linux-integrity@vger.kernel.org
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---
>v4: - Change file name to tpm_version_major
>    - Actually display just the major version.
>    - change structs to tpm1_* & tpm2_*
>      instead of tpm12_* tpm20_*.
>v3: - Change file name to version_major.
>v2: - Fix TCG usage in commit message.
>    - Add entry to sysfs-class-tpm in Documentation/ABI/stable
>
> Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
> drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
> 2 files changed, 38 insertions(+), 7 deletions(-)
>

Anyone else have feedback?

