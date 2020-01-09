Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EED620721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJli3nwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAIVtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:49:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725840AbgAIVtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578606580;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=jP05U3J7xQbdMnr/CfhHt9vwscvvHAPq8Wq8LG9LWJo=;
        b=cJli3nwIelwtP2ROy2tWCb6nkcaM3VxABEPLiSLB77KZ6WE+kOlIu/QKIERvZPQwzD45m1
        2RlaPRyv2uYpiBQQl9/5YvFYZ0blUMjwMIUcNCiwbwXn5w+HJrTPCFfbW4B4ofXMVOCBNC
        TM+XI2sknYSVP6RB5H7tPar2OEYwkro=
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-aDWv_3-LNVujmJDZlyFuUg-1; Thu, 09 Jan 2020 16:49:38 -0500
X-MC-Unique: aDWv_3-LNVujmJDZlyFuUg-1
Received: by mail-yw1-f69.google.com with SMTP id l12so5859385ywk.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jP05U3J7xQbdMnr/CfhHt9vwscvvHAPq8Wq8LG9LWJo=;
        b=sDEf8r11fHeFuAhNxK5CD12VVCLZe7s1RAMrK5J6kQwH2rDX24H3agDtXtktL/99Ak
         XIUpekSxuXaLT5HXDwUkknpn8UL7umjKFfc3ZyLHHvTi+db9fgZWldnm1W6BuKDHQrBV
         E8iYVQVpTPTVgCjOx6KtnFKpsXW1qPF+MAcjLjRb7LdQCN3VA9xmCm3Mjc9wivgjxpc6
         g7Jxy887akysBCgDbK58ZJfKuWpLJnm0xJXWZiuoSMPiOl3ZR4RIRqCIh+PH9syxw/zA
         6JogTO8w+TKzeAipAhFbxcaK5dX9JQHVAmkryUVevQ6xqz7SCX73dHWrchb9+MXXWbmB
         yomQ==
X-Gm-Message-State: APjAAAXEYDYfNcuGRb/w33Pe0GVFVDFmBBLSMO/4F/ba2B1Q1RG91Wbn
        YAOKd1Q+03TpNIxc66JLGg3wptdawo8JIDF2U1uGkDp3eg6NvekPfEmR3W6PcLa1WoDOTMVZBEL
        9JakYTEaJb0kbiFBEvS6OaWNj
X-Received: by 2002:a81:1b88:: with SMTP id b130mr161021ywb.514.1578606578366;
        Thu, 09 Jan 2020 13:49:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8ikvQAKqAc60KdU2r0EKeN5NCJJ0/miKwf9hOWHgJ5YdaDBB4+0SwW+TvMSACfP3kocICBg==
X-Received: by 2002:a81:1b88:: with SMTP id b130mr161003ywb.514.1578606578052;
        Thu, 09 Jan 2020 13:49:38 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id r66sm47795ywh.57.2020.01.09.13.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:49:37 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:49:35 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Add tpm_version_major sysfs file
Message-ID: <20200109214935.ud7p7uwjimilxvi7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
References: <20191030225843.23366-1-jsnitsel@redhat.com>
 <20191128010826.w4ixlix3s3ovta3m@cantor>
 <20191129235131.GA21546@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191129235131.GA21546@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Nov 30 19, Jarkko Sakkinen wrote:
>On Wed, Nov 27, 2019 at 06:08:26PM -0700, Jerry Snitselaar wrote:
>> On Wed Oct 30 19, Jerry Snitselaar wrote:
>> > Easily determining what TCG version a tpm device implements
>> > has been a pain point for userspace for a long time, so
>> > add a sysfs file to report the TCG major version of a tpm device.
>> >
>> > Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
>> > describing the new file.
>> >
>> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > Cc: Mimi Zohar <zohar@linux.ibm.com>
>> > Cc: Peter Huewe <peterhuewe@gmx.de>
>> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> > Cc: linux-integrity@vger.kernel.org
>> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> > ---
>> > v4: - Change file name to tpm_version_major
>> >    - Actually display just the major version.
>> >    - change structs to tpm1_* & tpm2_*
>> >      instead of tpm12_* tpm20_*.
>> > v3: - Change file name to version_major.
>> > v2: - Fix TCG usage in commit message.
>> >    - Add entry to sysfs-class-tpm in Documentation/ABI/stable
>> >
>> > Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
>> > drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
>> > 2 files changed, 38 insertions(+), 7 deletions(-)
>> >
>>
>> Anyone else have feedback?
>
>I can apply this after the issues on hand have been sorted out.
>
>/Jarkko
>

Hi Jarkko,

Will this get queued up for 5.6?

Regards,
Jerry


