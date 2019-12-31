Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B74D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXAD1iGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfLaBDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 20:03:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42189 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727806AbfLaBDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 20:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577754185;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=YEL59S0rEfaETJJxD2o4v2zyBJg6VbyRRupbe/gb39o=;
        b=EXAD1iGm4OOqGvDIErtjjh4PfHnPprTDRwkgXVtgbK4RexpXWvVc+o2zrxPsvXNfddghOw
        6TLP3uqp+w88TOPPBLDjTA5Ejb9cSPoJ7VZSpJeatU5KzPWnSFWL+JAUIQvCbU6MNeYFat
        mJQS05HAOdIUksdxkR1gZXQ0bZ3WT5o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-76QiPq1lOPGYu0ZV32n5hQ-1; Mon, 30 Dec 2019 20:03:02 -0500
X-MC-Unique: 76QiPq1lOPGYu0ZV32n5hQ-1
Received: by mail-pf1-f200.google.com with SMTP id i196so25489515pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 17:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YEL59S0rEfaETJJxD2o4v2zyBJg6VbyRRupbe/gb39o=;
        b=MyRXRrHDemFv99geQnE6PQT5tZUJuZ3HSKYMk/Gvp+FpkkmPZjMSXN4d7EB6vPEPx0
         WOoFtuA0/bYTM4Mojzun7U3HzJ+8VGvGq+OZHXsyddND6/z9lPjc9XUbJsBXMaJHVQ9l
         PwvUQPmvAou7gJaj+YcapgV5LIs05DjGmt1i2mnISFelpnWENKzbL397B8nkZnfBFm7X
         oPDctPo5dTFYMhPqyzxdCAIkUpkuk/y4iUbdCf2FwizShkUVPraPOMoOYe9eFBfpNZbe
         iHIoX7TfzVcnFj4mMS3Jj/WJPHAXPRl/w2QxbcYVNNEZMmF1eFIkO2WcctsftLuReo5E
         hxPQ==
X-Gm-Message-State: APjAAAWfcZ2LEJxY2vieXPdEosXp9bmFcoTpnfmn2H61AnmPtiQc05M4
        vPT1yYYmzGxwchLPRJcJjNMyg4uriqQ3i+qnSapUsRT09I7E/9+dp6pX0rrGTmCp56PLYO03gbu
        +AFVab2EdcHFCVClong8e766C
X-Received: by 2002:a17:90a:d804:: with SMTP id a4mr2786111pjv.11.1577754181412;
        Mon, 30 Dec 2019 17:03:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwK4Yqf5oL3Te81ljRHdMSyXxTSGUUsEblOWjDi2X4q996dVxQThs2vKjVE4pqL+Ar/f4RFQ==
X-Received: by 2002:a17:90a:d804:: with SMTP id a4mr2786074pjv.11.1577754181186;
        Mon, 30 Dec 2019 17:03:01 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id u7sm51013785pfh.128.2019.12.30.17.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 17:03:00 -0800 (PST)
Date:   Mon, 30 Dec 2019 18:02:56 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20191231010256.kymv4shwmx5jcmey@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1577122577157232@kroah.com>
 <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com>
 <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 31 19, Jarkko Sakkinen wrote:
>On Sun, 2019-12-29 at 23:41 -0800, Dan Williams wrote:
>> This looked like the wrong revert to me, and testing confirms that
>> this does not fix the problem.
>>
>> As I mentioned in the original report [1] the commit that bisect flagged was:
>>
>>     5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
>>
>> That commit moved tpm_chip_start() before irq probing. Commit
>> 21df4a8b6018 "tpm_tis: reserve chip for duration of tpm_tis_core_init"
>> does not appear to change anything in that regard.
>>
>> Perhaps this hardware has always had broken interrupts and needs to be
>> quirked off? I'm trying an experiment with tpm_tis_core.interrupts=0
>> workaround.
>>
>>
>> [1]: https://lore.kernel.org/linux-integrity/CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com/
>
>I think for short term, yes, it is better to revert the commits
>that make things more broken.
>
>for-linus-v5.5-rc5 branch contains three commits that exactly do
>this i.e. the reverts that Stefan sent and revert to Jerry's earlier
>commit.
>
>After that is out of the table it is easier to analyze how the code
>should be actually refactored. Like, I have no idea when I get
>local HW that can reproduce this and Jerry still seems to have the
>same issue. It'd be nice make the exactly right changes instead of
>reverts but situation is what it is.
>

The only other thought I had was moving the tpm_chip_start/stop
into tpm_tis_probe_irq_single around the tpm_tis_gen_interrupt call.
I don't know why doing the clkrun bit after setting the interrupt
register values would matter, but I'm not sure what else there is
that would be different than when that stuff was happening in
down in tpm_try_transmit. Without hardware to poke at it is hard
to get anywhere.

>Please check the branch and ACK/NAK if I can add tested-by's (and
>other tags).
>
>/Jarkko
>

