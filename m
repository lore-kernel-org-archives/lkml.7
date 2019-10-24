Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C49ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAE62166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPb0CPnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407567AbfJXP5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:57:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391173AbfJXP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571932641;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RYIycPZ7xwd/64WhlxXgAIdNrBNTMMCEk8QEeLMzlhE=;
        b=gPb0CPnZlY5ObaL+aSvvJWMffT/fNiA/CyX3F7DlysdLl6+6dfMXAcvEDEO2ic/McPYLYJ
        Wld6ijPwPnWnPBoPGMguQUL61Nz+6nvPPop+XaRn9fEeD+vAcjZ0oHiDdLH1w1ADaX1kOl
        M7CPs64ANDYI3ioyM79fzlkW0h9/YXQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-62KTNdSnPLqr8nMafcAv4w-1; Thu, 24 Oct 2019 11:57:11 -0400
Received: by mail-io1-f70.google.com with SMTP id r5so26385304iop.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=lVFoCFngLW9ciVYAq4RQbMPG6k9IMnqdRdRMrW8KJM4=;
        b=rFijuW5UYf6PaFBBlELsy6ZLNLZmVrgmeDmrcxdse08LKRam2MN/eDbtp+YGebYhvZ
         SGZTu4JJUhpH39EzVfDOXjF0uZG4Hsn2PaMqrnEV4uTWwxsmDvIEa2VXX7qVRoA+hI0U
         kuHxfdEgEwvzV1xxXVVqu5ThtwD+SnGnNA+sCqm9JdzGzvTGSlMdE/iKK6yJfIJHFfob
         g2hfnBwxaPa71+KhjmuS/dWwU3XHlgpHQ8Qj/QXVJ2k7sN1JEtuXSvHp3w63CUtmLVkX
         318GFQm/tKF0hghAD5HVacus5VK1rv/XBcNL0fiAdC2RaUIlj/DAJhHr5GYGETAogSaN
         dmjA==
X-Gm-Message-State: APjAAAWlLeIyzPqrkI8xEyIoxu5Ie+cwwi3JEga9B/e5QSXJ2DM3OBB9
        uuNiiW1D1XFqCzE2qLnF+uISdQKEmr87M/909V4cYrNm8obPrc3Dljf7HCZwLWeEANWItkyjAhk
        ZglB0ugMpdUOHjfPZiWxVRsh0
X-Received: by 2002:a05:6602:2254:: with SMTP id o20mr273088ioo.25.1571932630771;
        Thu, 24 Oct 2019 08:57:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKK/wDC8a1RTcR/5IybiL8/VSKAkuXsO2wJUmTxAvoCksSlrZObgPKaGMLq6lV4ivyfUTynQ==
X-Received: by 2002:a05:6602:2254:: with SMTP id o20mr273058ioo.25.1571932630437;
        Thu, 24 Oct 2019 08:57:10 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id u190sm10711104ilc.36.2019.10.24.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:57:09 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:57:08 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        ivan.lazeev@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191024155708.w3obpo3i6wz5b5er@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        ivan.lazeev@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191016182814.18350-1-ivan.lazeev@gmail.com>
 <20191021155735.GA7387@linux.intel.com>
 <20191023115151.GF21973@linux.intel.com>
 <20191023232035.ir7hmed4m3emovyx@cantor>
MIME-Version: 1.0
In-Reply-To: <20191023232035.ir7hmed4m3emovyx@cantor>
User-Agent: NeoMutt/20180716
X-MC-Unique: 62KTNdSnPLqr8nMafcAv4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 23 19, Jerry Snitselaar wrote:
>On Wed Oct 23 19, Jarkko Sakkinen wrote:
>>On Mon, Oct 21, 2019 at 06:57:35PM +0300, Jarkko Sakkinen wrote:
>>>Almost tested this today. Unfortunately the USB stick at hand was
>>>broken.  I'll retry tomorrow or Wed depending on which day I visit at
>>>the office and which day I WFH.
>>>
>>>At least the AMI BIOS had all the TPM stuff in it. The hardware I'll be
>>>using is Udoo Bolt V8 (thanks Jerry for pointing me out this device)
>>>with AMD Ryzen Embedded V1605B [1]
>>>
>>>Thanks for the patience with your patch.
>>>
>>>[1] https://en.wikichip.org/wiki/amd/ryzen_embedded/v1605b
>>
>>Jerry, are you confident to give this tested-by?
>>
>>I'm still in process of finding what I should put to .config in order
>>to get USB keyboard working with UDOO BOLT.
>>
>>/Jarkko
>
>I ran it through the tpm2 kselftests and it passed:
>
>TAP version 13
>1..2
># selftests: tpm2: test_smoke.sh
># test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
># test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
># test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
># test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
># test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
># test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
># test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
># test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
># test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
>#
># ----------------------------------------------------------------------
># Ran 9 tests in 12.305s
>#
># OK
>ok 1 selftests: tpm2: test_smoke.sh
># selftests: tpm2: test_space.sh
># test_flush_context (tpm2_tests.SpaceTest) ... ok
># test_get_handles (tpm2_tests.SpaceTest) ... ok
># test_invalid_cc (tpm2_tests.SpaceTest) ... ok
># test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
>#
># ----------------------------------------------------------------------
># Ran 4 tests in 11.355s
>#
># OK
>ok 2 selftests: tpm2: test_space.sh
>
>
>I also did some other testing of tpm2-tools commands, creating a
>trusted key and encrypted key, and running rngtest against /dev/random
>with the current hwrng being tpm-rng-0.
>
>I ran the selftests on an intel nuc as well:
>
>TAP version 13
>1..2
># selftests: tpm2: test_smoke.sh
># test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
># test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
># test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
># test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
># test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
># test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
># test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
># test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
># test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
># #=20
>----------------------------------------------------------------------
># Ran 9 tests in 29.620s
># # OK
>ok 1 selftests: tpm2: test_smoke.sh
># selftests: tpm2: test_space.sh
># test_flush_context (tpm2_tests.SpaceTest) ... ok
># test_get_handles (tpm2_tests.SpaceTest) ... ok
># test_invalid_cc (tpm2_tests.SpaceTest) ... ok
># test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
># #=20
>----------------------------------------------------------------------
># Ran 4 tests in 26.337s
># # OK
>ok 2 selftests: tpm2: test_space.sh
>
>
>So,
>
>Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>
>
>One thing I've noticed on the bolt and the nuc:
>
>[    0.808935] tpm_tis MSFT0101:00: IRQ index 0 not found
>
>I'm guessing this is Stefan's patches causing this?
>
>1ea32c83c699 | 2019-09-02 | tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before pro=
bing for interrupts (Stefan Berger)
>5b359c7c4372 | 2019-09-02 | tpm_tis_core: Turn on the TPM before probing I=
RQ's (Stefan Berger)
>
>I've never noticed tpm_tis messages before on a tpm_crb system, and double=
checked that I don't see it with 5.3.

I see there is a patch from Hans de Goede already dealing with this: "tpm: =
Switch to platform_get_irq_optional()".

