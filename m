Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D91C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D231B21A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbmp5E0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfJBPbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:31:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48414 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727235AbfJBPba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570030289;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2WmFGxjjikT5Miosenuf0vEZuAWzLD/xn8HBAOrnNE=;
        b=bbmp5E0sYYcHpQz2cF3eDTL4JOYguMUFWCrd2xx8bobEK6AZBIwEsKzUFaNV7z9fC+LxAq
        x3xTlbFONjrqaeRkGOBw/jAwfD+UEjEA6tJvtg5YIWAECr3FkWTTggxHo+axRkGb7HvqvA
        eaJlmun97LH4f0kwluyqBRk5GpJF77Q=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-dRkTEF3UPym6DtvHXOORZA-1; Wed, 02 Oct 2019 11:31:26 -0400
Received: by mail-io1-f71.google.com with SMTP id e6so43705424iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3qwXQsR3lou+ROCRc4yzFy/Jy2vjM/kmf8Di06ZjAII=;
        b=WYKwJTguIfw2GdrGs3ZknsEi/i7mf3rBRBDT6wq6AsaxhX65QuNNbW3wuKC3RHThjO
         YZdDM1tFdG9oBrZ8zmLaoAG3ddXSjrGlsO62D8EAhPu9wzE0NgmWY3ktPzC3E3XJTO78
         bQpgC/4eXrqRMMqvOF3rNp+2KlBoh40zz8UQTWTmcpF+5x3sijAaSj5ydphQBCrlPLdL
         LlaPOYHT1TKWTcesGoR5631hKtBRfHOUPsWheoKgxJXzwjo+duJBpQSvFK29hZERywwz
         J1LBNyHFmX5sNn7d7c+9mQ3QQFAh0TPoKzlWqPCVxwtPv/lpSS8wYYrFVPQxDPrNVxqs
         kFYQ==
X-Gm-Message-State: APjAAAUWoTilzk93G1xwO4RAhjEvKhFIQFoz/J2kFFv4NBwxJbaYeDca
        6cbvYX5nxgutddF6C9Hk+mrt4C6MNhE8Ob1PsbxZW7YZm7/ifwMKqel4raE+sKGpiBWhnJtbC1s
        5UYuxXCX3HW3kVj4yVfsrlvME
X-Received: by 2002:a92:6507:: with SMTP id z7mr4198220ilb.191.1570030285581;
        Wed, 02 Oct 2019 08:31:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+A+4yeVQjgeYT4HlzAe6H/s5Sv36JwzxxIHXFwEfqwmULlLMujGvlChw2Hgybdyt37xLQvA==
X-Received: by 2002:a92:6507:: with SMTP id z7mr4198180ilb.191.1570030285293;
        Wed, 02 Oct 2019 08:31:25 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l82sm11873096ilh.23.2019.10.02.08.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:31:24 -0700 (PDT)
Date:   Wed, 2 Oct 2019 08:31:23 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-stabley@vger.kernel.org,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent future
 TPM operations
Message-ID: <20191002153123.wcguist4okoxckis@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-stabley@vger.kernel.org,
        Vadim Sukhomlinov <sukhomlinov@google.com>, stable@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191002131445.7793-1-jarkko.sakkinen@linux.intel.com>
 <20191002131445.7793-4-jarkko.sakkinen@linux.intel.com>
 <20191002135758.GA1738718@kroah.com>
 <20191002151751.GP17454@sasha-vm>
MIME-Version: 1.0
In-Reply-To: <20191002151751.GP17454@sasha-vm>
User-Agent: NeoMutt/20180716
X-MC-Unique: dRkTEF3UPym6DtvHXOORZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 02 19, Sasha Levin wrote:
>On Wed, Oct 02, 2019 at 03:57:58PM +0200, Greg KH wrote:
>>On Wed, Oct 02, 2019 at 04:14:44PM +0300, Jarkko Sakkinen wrote:
>>>From: Vadim Sukhomlinov <sukhomlinov@google.com>
>>>
>>>commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream
>>>
>>>TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
>>>future TPM operations. TPM 1.2 behavior was different, future TPM
>>>operations weren't disabled, causing rare issues. This patch ensures
>>>that future TPM operations are disabled.
>>>
>>>Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
>>>Cc: stable@vger.kernel.org
>>>Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
>>>[dianders: resolved merge conflicts with mainline]
>>>Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>---
>>> drivers/char/tpm/tpm-chip.c | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>>What kernel version(s) is this for?
>
>It would go to 4.19, we've recently reverted an incorrect backport of
>this patch.
>
>Jarkko, why is this patch 3/3? We haven't seen the first two on the
>mailing list, do we need anything besides this patch?
>
>--
>Thanks,
>Sasha

It looks like there was a problem mailing the earlier patchset, and patches=
 1 and 2
weren't cc'd to stable, but patch 3 was.

