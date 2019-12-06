Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED3EC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9FF24676
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7oCluiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLFXDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:03:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56852 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726374AbfLFXDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575673381;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6WTqIKjz3S325CCDp38W7Sg6rbkSpfGWJMYdV0cMT0=;
        b=K7oCluiIXRY/sk25EjRl4Lo6y5IX3Bz0285jxCljhmzTxEAvOAbSA2wGxG3PWa8G2DKyNR
        fFjuT0PKHXhqytXPLtkGU6GJjJb57hJi65UA9sC7eTHZIttmiTas8gXhxOp40xs8850rT9
        9j7tv2YAPQEB36P75cQR2xPTpqKXQwQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-h1sGsidiNpSA5ZjJSSNxPg-1; Fri, 06 Dec 2019 18:02:59 -0500
Received: by mail-pg1-f200.google.com with SMTP id o21so4615011pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9Ch5m35fVkEKG5wxtfGoZa8Wx0h7Ub5VYf9I4jeT7RE=;
        b=RHFWYTCQdE+u+m5UMGrzPUTApjDWZWTNb1HiUDP9IE3RG7qpMhC47uWosXNq/NaCbi
         /RdOf96Xmht/fVc0AWL+o2voWk7tEtU26q52Q9CPWtekkZ34vRBOIJ6XHmq8xCvMDTkf
         h4m8Pu/+ZRMR0DyZMp2DJzB7f1xhcip+xTsFkpvx+d7sGgPbFJUMy3j9r+OsOZUrBnTe
         BFxA2eSsdYbO/Pohwygq9Imr8hIN0qqM+VCJLuqkxZryE5jGeoDvG/yc+hnL0wZMvHaq
         zpQWRw9SkKk6uAGonZuDkLop1MMUUVNb6fp228FsnIxOAZoUmx367JSVv0495LDrliwR
         4ZjQ==
X-Gm-Message-State: APjAAAVj2zmrmvywAl+8JgWNd4nUo8guapKUkVIsofji8B3uyKfrdSC5
        EEEcTaDi36MMDUzlXfsoIBSQCGVW4PgLJJAKiJWHGiWraFH0I2GJtQK1LPmUsPl9FQZ5XU8gi24
        3szFMyCNnC5+q2E6qUhh6P2RA
X-Received: by 2002:a17:902:fe12:: with SMTP id g18mr17164259plj.20.1575673378486;
        Fri, 06 Dec 2019 15:02:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaH2k0aU5daJfRg60OkT59+hoEibc8Ok80QvecPXGnd9NYmO8bLlYzXX6tQ4naJPtMp1VAZQ==
X-Received: by 2002:a17:902:fe12:: with SMTP id g18mr17164215plj.20.1575673377994;
        Fri, 06 Dec 2019 15:02:57 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id m5sm4231286pjl.30.2019.12.06.15.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 15:02:57 -0800 (PST)
Date:   Fri, 6 Dec 2019 16:02:55 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.4
Message-ID: <20191206230255.mhinntfevp6vdlkj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
References: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
 <CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com>
 <20191127205800.GA14290@linux.intel.com>
 <20191127205912.GB14290@linux.intel.com>
 <20191128012055.f3a6gq7bjpvuierx@cantor>
 <20191129235322.GB21546@linux.intel.com>
 <20191130001253.rtovohtfbg25uifm@cantor>
 <20191206211834.GD9971@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191206211834.GD9971@linux.intel.com>
X-MC-Unique: h1sGsidiNpSA5ZjJSSNxPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 06 19, Jarkko Sakkinen wrote:
>On Fri, Nov 29, 2019 at 05:12:53PM -0700, Jerry Snitselaar wrote:
>> On Sat Nov 30 19, Jarkko Sakkinen wrote:
>> > On Wed, Nov 27, 2019 at 06:20:55PM -0700, Jerry Snitselaar wrote:
>> > > There also was that other issue reported on the list about
>> > > tpm_tis_core_init failing when calling tpm_get_timeouts due to the
>> > > power gating changes.
>> >
>> > Please add a (lore.ko) link for reference to this thread.
>> >
>> > /Jarkko
>> >
>>
>> https://lore.kernel.org/linux-integrity/a60dadce-3650-44ce-8785-2f737ab9=
b993@www.fastmail.com/
>
>tpm_chip_stop() probably causes the issue. That is why tpm2_probe()
>works and failure happens after that.
>
>tpm_chip_stop() should be called once at the end of the function.
>

The patch I posted that fixed the issue for him moved the
tpm_chip_start() from the irq probing section right below there to
before the tpm_get_timeouts call, but your idea is better.

Any thoughts on the irq issue? I need to go back and look at the older
commits again, but before Stefan's patch enabling the irq flag I'm not
sure the last time that testing code section in tpm_tis_send was
actually used. I think prior to that it always just went straight to
tpm_tis_send_main.

570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific") adds
the flag, and I can see where it disables and enables the flag in the
testing code in tpm_tis_send, but I don't see where it enables the
flag originally for it to ever get into the testing section of
tpm_tis_send. That means since this commit tpm_tis hasn't been using
interrupts, right?

Regards,
Jerry

>/Jarkko
>

