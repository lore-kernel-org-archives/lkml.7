Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F752086A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9hGflyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfK1AON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:14:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34107 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727033AbfK1AOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574900051;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bI3FgBWOF7wCQIIRv2T8Vht0Y2ID7iTwByZG4uRF2TY=;
        b=C9hGflyA8dPTSRY8yNzI/haK/B942652U+THL98mFvtyOM1jdpQuovldgOTnahoOdOibjL
        B/313YeumbOihO15FZscZTBK6Vs+bQN2Twx9oxup8LyjHGt422SVyNqUNXYhAJKp9cxw6B
        /OY573Hs0HbDXAap2QbxvO3X83OUhJs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-sos3zqb7M2Kx4d_36oqY3Q-1; Wed, 27 Nov 2019 19:14:08 -0500
Received: by mail-pj1-f69.google.com with SMTP id w8so11924003pjh.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 16:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=81TflNEkIggalSb9xJoZHH5dIwhWptMNuIwNrPhaU8E=;
        b=c4TDepQP5HutdKoOTs6aKT3tmXEdvUmCK8QtUZOqZCr8UJ6WY5v+hXT2J/pkzKao3Y
         gpc5ezguwM3g+7qSvRS6sQHsgx0NWhws7mjlJ85zaPFa/GLlzNlccK+n0fZWBuwiz5La
         aMtqOnQxSDUjfNnOnVEtGNSADlpKh/D7ocBUeKr9dJUiReLJhQi/CxIrQV0Ub/fxRm7c
         gjvFu+QtL34cQwHj0olxfphIJNlJeLcXALv0ZR3OjcaC+bfTbIEaM2T7i4gDn2nlx0eJ
         8b/nsRD+6CiOAjUFOE5Cymb3+Somzuxf5zuZhgzou0bPM086quigBKZSYWhu1bYFbMUM
         nEZA==
X-Gm-Message-State: APjAAAX9V9lC/NfxlnQ1NWCB8vp0QOr4bWC+7HbJGW+PaWl/ne7F8juu
        3AzluoDfQ1Li8pIdGabq52L8DcO+6+vZG2MnPEwoAPec96h8C7pkO06UN3pMxX74YIPG//Mlkef
        cggSgI9l4Yh7SFko9uZI4keYP
X-Received: by 2002:a62:16d3:: with SMTP id 202mr6980029pfw.118.1574900047372;
        Wed, 27 Nov 2019 16:14:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJc+VcxwW5kWr8ouolCeyP8fu1uzQijQ/p273FgvMFRNGogDQLIK+RwXvnf+WFq5+P1kvN6w==
X-Received: by 2002:a62:16d3:: with SMTP id 202mr6980008pfw.118.1574900047098;
        Wed, 27 Nov 2019 16:14:07 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id b1sm7823320pfi.74.2019.11.27.16.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 16:14:06 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:14:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
Message-ID: <20191128001404.3y4wh4hbhqpzxmfx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com>
 <20191114164426.GC9528@linux.intel.com>
 <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
 <20191121184949.yvw2gwzlkhjzko64@cantor>
 <20191127211109.GF14290@linux.intel.com>
 <CAPcyv4gO2T4xcZjYSYJ8-0kDPRnVYWhX_df5E94Cjyksx6WFbg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gO2T4xcZjYSYJ8-0kDPRnVYWhX_df5E94Cjyksx6WFbg@mail.gmail.com>
X-MC-Unique: sos3zqb7M2Kx4d_36oqY3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Nov 27 19, Dan Williams wrote:
>[ add Jerry ]
>
>On Wed, Nov 27, 2019 at 1:11 PM Jarkko Sakkinen
><jarkko.sakkinen@linux.intel.com> wrote:
>>
>> On Thu, Nov 21, 2019 at 11:49:49AM -0700, Jerry Snitselaar wrote:
>> > On Sat Nov 16 19, Stefan Berger wrote:
>> > > On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
>> > > > On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
>> > > > > On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
>> > > > > > From: Stefan Berger <stefanb@linux.ibm.com>
>> > > > > >
>> > > > > > Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
>> > > > > > tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
>> > > > > > This move handles error conditions better that may arise if an=
ything
>> > > > > > before fails in tpm_tis_probe_irq_single.
>> > > > > >
>> > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> > > > > > Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> > > > > What about just changing the condition?
>> > > > Also cannot take this since it is not a bug (no fixes tag).
>> > >
>> > > I'll repost but will wait until Jerry has tested it on that machine.
>> > >
>> > >    Stefan
>> > >
>> > >
>> > > >
>> > > > /Jarkko
>> > >
>> > >
>> >
>> > It appears they still have the problem. I'm still waiting on logistics
>> > to send me a system to debug.
>>
>> Which hardware is guaranteed to ignite this? I can try to get test hw
>> for this from somewhere. Kind of looking into this blinded ATM. Dan?
>
>Jerry had mentioned that this was also occurring on T490s. Otherwise
>I'll ping you offline about the system I saw this on internally.
>

I've been trying for about 3 weeks now to get one of the laptops from
logistics here, but unfortunately they have been silent. Pinged one
of their email addresses today to see if they could respond to the
ticket, so hopefully next week I will have something.

