Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DB3C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D89921872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyRbd50G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLURm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:17:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40177 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbfKLURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573589860;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qm8sRANNmzEPm6nlw2BezXJvLm5FulYqmCTuQv0ocvM=;
        b=VyRbd50Ga4ZOL7lmh8eZqa5toCAbmNaV4TIiZ/AGoE0ymtIEt+SqlBqNJHnrmLZIwOYpB2
        7wEqbPCj6IOAaOb5P7zFb8zIxmrOeyutV6HY+FN3THPSRhfNnQTONmroHTazVGZh1CUPM/
        hlYC/vosIi1NTTGzmRFBsw5LpT4ckUY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-kSUp9x2ZPDCS8QmuqBcZGQ-1; Tue, 12 Nov 2019 15:17:39 -0500
Received: by mail-yb1-f198.google.com with SMTP id p4so15240099ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Ue+RmWRiIYpJZ808L9pilsgFcrEW5+LqZcaMFFe1nnY=;
        b=UF7njQj0rbaUNw9F0n4hVpfV3aCMGHQ0YH/MpTeAGT4VZrVDYED8fCI069B1StwVdX
         xFLUrNiIWyCihFiNuC2qw/9dpMQIhdjfNxkgKLwgHoTNs5j6mPp+DIB1OVfWroAv4Ycy
         MfgV2/Jw3p9bNmtjH5y66l2rjzNTD/eajcUa7Z0XvhgzTT6mqV9S0RND0DXFTCb43mn1
         n7+HDw0fX57zB1JKEYs3eKnYCHyZ/brgw0OLnK+a/BErpjtRZMXmLX+QJr/8PE1cbS12
         iho3P2D/DTyJQC54/v3Cwb64MVvso0PjeBV6uGS0RCrtdqrJFzB2eF12B5S97Fe1rl7v
         93bQ==
X-Gm-Message-State: APjAAAV9dpU3xjJisrTcdAzC9rDdq79aI1zc8BvkE7BAVDiXZkrCn8Rq
        o0GoNiMStMVAWCgPVQP8LwmWt5ZF1gnaPnBKxfutNpC4lvzBxCIBby0UcoWOmWBNFrM0q5jF4XI
        KV3iWwM/KWSINEiEzH1e/Fy5N
X-Received: by 2002:a0d:ed03:: with SMTP id w3mr20747370ywe.359.1573589858337;
        Tue, 12 Nov 2019 12:17:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYp2kqGLoqObRY4Is6v+pkaruIb7c8mpH86ZaIHND5kbcPDCzu5Wor8G+hmiSRQuTmt3fZoQ==
X-Received: by 2002:a0d:ed03:: with SMTP id w3mr20747359ywe.359.1573589858076;
        Tue, 12 Nov 2019 12:17:38 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q127sm13598290ywc.43.2019.11.12.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 12:17:37 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:17:34 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191112201734.sury5nd3cptkckgb@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <20191112200703.GB11213@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191112200703.GB11213@linux.intel.com>
X-MC-Unique: kSUp9x2ZPDCS8QmuqBcZGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 12 19, Jarkko Sakkinen wrote:
>On Mon, Nov 11, 2019 at 08:36:37PM -0700, Jerry Snitselaar wrote:
>> Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ
>> before probing for interrupts").  Doesn't tpm_tis_send set this flag,
>> and setting it here in tpm_tis_core_init short circuits what
>> tpm_tis_send was doing before? There is a bug report of an interrupt
>> storm from a tpm on a t490s laptop with the Fedora 31 kernel (5.3),
>> and I'm wondering if this change could cause that. Before they got the
>> warning about interrupts not working, and using polling instead.
>
>Looks like it. Stefan?
>
>/Jarkko
>

Stefan is right about the condition check at the beginning of tpm_tis_send.

=09if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
=09=09return tpm_tis_send_main(chip, buf, len);

Before his change it would've gone straight to calling
tpm_tis_send_main instead of jumping down and doing the irq test, due
to the flag not being set. With his change it should now skip this
tpm_tis_send_main call when tpm_tis_gen_interrupt is called, and then
after that time through tpm_tis_send priv->irq_tested will be set, and
the flag should be set as to whether or not irqs were working.

I should hopefully have access to a t490s in a few days so I can look at it=
,
and try to figure out what is happening.

