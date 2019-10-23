Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4F2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6620679
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zbx2mTJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436983AbfJWXUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 19:20:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28986 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404151AbfJWXUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571872843;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1gIIOpWX0kmuV8pGcMJNBdk7solK8ew7ygNzM9f9h4=;
        b=Zbx2mTJJqiw4pXrX/loA3rFztCpr9FnFrkH9dBKHsAsRepze+bznbIFb5QPz79xJOi17ZH
        wN8SQypRf+Ex/U7zvrfcx523dq0hekoazxy41acxxDlAGhbVYXhJhw6KqUNxTm/x555oCa
        qT6k+wWvG5q41B/AkRX7ootL6kyCvYM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-54iux7AAMXSNSy404YY4Qg-1; Wed, 23 Oct 2019 19:20:42 -0400
Received: by mail-il1-f199.google.com with SMTP id s17so13994022ili.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 16:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BNl9Uy1RmdYWPElsAHF3OHYdNrnKgMqhpn5Eaj07V2k=;
        b=YqEOam8Ip0QeLDFVTiXYtDk6/wiTtFygav7ycye3NhFRY6bxQe/qBV3r8qFCyy88o4
         wKIW1ZH3YHpgqKiUGksdNCm9yqTMaEFAf1a9gJz8+V8SQJeLqeuz94ihHOBK9Kv615pG
         bZ392tLlEFOhCzxVGlcAVkKKThmLFXw/gWVykcdeztHl0gBc0bo9MTKed+22m9S9F5Y/
         t/2wwto8N1b1B/v/CypdQYUK5P48EjVJIn/FKnBxY0OJpY5eqi86s06/ZmABK9nZ2gUO
         cBVlgUBGCS+4GPvpWBD6LfHyDgwyOB7FTx+oHDhRgFtA4xbxitKW+dR3+m9xd+jhNnwj
         0IcQ==
X-Gm-Message-State: APjAAAU5ywLOP8KiWsGVLCdLAw5mRbs36xSqkkethv8e+7JVnFk2nCz3
        olunC/rtrh1hHBxcyV3fkKc0CJuEwz7RM+jVyqtEqmPG9cdn9x1jM00HH3yLLvaQOHaivk6A6Zt
        a23BpSKBfX7MfOcK5jLCj50MR
X-Received: by 2002:a6b:ab03:: with SMTP id u3mr553332ioe.158.1571872841765;
        Wed, 23 Oct 2019 16:20:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyF7qrGiVvCscTOw+aNfXxqYquTIiaVJdbtw612TTKl3QtQMeOf7yuOTCKu3ac4j7p0IUWriw==
X-Received: by 2002:a6b:ab03:: with SMTP id u3mr553307ioe.158.1571872841493;
        Wed, 23 Oct 2019 16:20:41 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id u124sm7731617ioe.63.2019.10.23.16.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:20:40 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:20:35 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     ivan.lazeev@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191023232035.ir7hmed4m3emovyx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        ivan.lazeev@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191016182814.18350-1-ivan.lazeev@gmail.com>
 <20191021155735.GA7387@linux.intel.com>
 <20191023115151.GF21973@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191023115151.GF21973@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: 54iux7AAMXSNSy404YY4Qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 23 19, Jarkko Sakkinen wrote:
>On Mon, Oct 21, 2019 at 06:57:35PM +0300, Jarkko Sakkinen wrote:
>> Almost tested this today. Unfortunately the USB stick at hand was
>> broken.  I'll retry tomorrow or Wed depending on which day I visit at
>> the office and which day I WFH.
>>
>> At least the AMI BIOS had all the TPM stuff in it. The hardware I'll be
>> using is Udoo Bolt V8 (thanks Jerry for pointing me out this device)
>> with AMD Ryzen Embedded V1605B [1]
>>
>> Thanks for the patience with your patch.
>>
>> [1] https://en.wikichip.org/wiki/amd/ryzen_embedded/v1605b
>
>Jerry, are you confident to give this tested-by?
>
>I'm still in process of finding what I should put to .config in order
>to get USB keyboard working with UDOO BOLT.
>
>/Jarkko

I ran it through the tpm2 kselftests and it passed:

TAP version 13
1..2
# selftests: tpm2: test_smoke.sh
# test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
# test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
# test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
# test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
# test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
# test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
# test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
#
# ----------------------------------------------------------------------
# Ran 9 tests in 12.305s
#
# OK
ok 1 selftests: tpm2: test_smoke.sh
# selftests: tpm2: test_space.sh
# test_flush_context (tpm2_tests.SpaceTest) ... ok
# test_get_handles (tpm2_tests.SpaceTest) ... ok
# test_invalid_cc (tpm2_tests.SpaceTest) ... ok
# test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
#
# ----------------------------------------------------------------------
# Ran 4 tests in 11.355s
#
# OK
ok 2 selftests: tpm2: test_space.sh


I also did some other testing of tpm2-tools commands, creating a
trusted key and encrypted key, and running rngtest against /dev/random
with the current hwrng being tpm-rng-0.

I ran the selftests on an intel nuc as well:

TAP version 13
1..2
# selftests: tpm2: test_smoke.sh
# test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
# test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
# test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
# test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
# test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
# test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
# test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
#=20
# ----------------------------------------------------------------------
# Ran 9 tests in 29.620s
#=20
# OK
ok 1 selftests: tpm2: test_smoke.sh
# selftests: tpm2: test_space.sh
# test_flush_context (tpm2_tests.SpaceTest) ... ok
# test_get_handles (tpm2_tests.SpaceTest) ... ok
# test_invalid_cc (tpm2_tests.SpaceTest) ... ok
# test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
#=20
# ----------------------------------------------------------------------
# Ran 4 tests in 26.337s
#=20
# OK
ok 2 selftests: tpm2: test_space.sh


So,

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>



One thing I've noticed on the bolt and the nuc:

[    0.808935] tpm_tis MSFT0101:00: IRQ index 0 not found

I'm guessing this is Stefan's patches causing this?

1ea32c83c699 | 2019-09-02 | tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before prob=
ing for interrupts (Stefan Berger)
5b359c7c4372 | 2019-09-02 | tpm_tis_core: Turn on the TPM before probing IR=
Q's (Stefan Berger)

I've never noticed tpm_tis messages before on a tpm_crb system, and doublec=
hecked that I don't see it with 5.3.

