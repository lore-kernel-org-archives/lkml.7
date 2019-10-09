Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F43ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B4621835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QI/ialJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJIJNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:13:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50935 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730579AbfJIJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570612418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=cZvwRNK0EK2nVjw8oRG2qh7gftxLlqc06mSiL5eetn4=;
        b=QI/ialJNeAhazVCnlfbxJy1tX0U0fhYfKrvlm0fQlzaYW6mPMJlseivGXi9fVDSOtkHTN/
        hbRMR4QFwNJnN9TpegPKbfmaX6/1Tw/g4/KwtLczIc3kkUBkUHfeQYWI55Ttk+BcaLEvo3
        qWc98XwEkefijzOJCwCYbm0hlXRNmNw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-gn01pkWMO2GLKaumcRs8bA-1; Wed, 09 Oct 2019 05:13:29 -0400
Received: by mail-wr1-f69.google.com with SMTP id c17so795621wro.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kg2KEa3btbJJz7gSq4olohGQOCWfoKGhQXiDkLfxFuQ=;
        b=DwYy2NQtN/D6TvfSbVO4hPRUImiJLsoxe/eI3R8bY4hSry+C28GSNocu8/MpUAfZjX
         /+Lwi5AaCmSPRx+Oq/eZK6oBiBMaUd0BLlM2eTEV5QUajjYDKS0y4JZXUi56VYNIf0ko
         yhUwduHdQRAg7rU4K5i3ftcqSFoO5halIld7CZAcF+uuX4v53LcrmrhP6JPYsQkkMMY+
         eT8vpQKcZVt59haDILSmPxOx72ERlGt7pmRqq1z+UiV+2Q6j0vG0ZMKuUy7Tri6mRPe7
         0m4/k+aN91LodndnEfkXeY2QEnnXcn1tjimxk3hO2tuXFbtrEodjE4ZxfvMLHu9L51wA
         Ihhg==
X-Gm-Message-State: APjAAAUO9JKnyaeviSBFyIokqcd+aV9jzvN7S08gzxr+io418GeODmue
        PosyjkZAag0coTcIBmMjXkE+MyAE2cz/WZCqSWML1ag61SUanXIDZIr5CgKkJRfe3aFuSbzBmd7
        t+M2z1Vd5f6fSznIQGvSs5ZIw
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr1874124wml.31.1570612408501;
        Wed, 09 Oct 2019 02:13:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLOYwIk6SUEWDWI7Ogctb8DPrp2tNv5YirX6y3gAP4cOVc6ZTZZ4OcRelLJPbF+BRnisnwJw==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr1874100wml.31.1570612408241;
        Wed, 09 Oct 2019 02:13:28 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id z22sm1311808wmf.2.2019.10.09.02.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:13:27 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/6] psci: Add hvc call service for ptp_kvm.
To:     "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        "Justin He (Arm Technology China)" <Justin.He@arm.com>,
        nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190918080716.64242-1-jianyong.wu@arm.com>
 <20190918080716.64242-5-jianyong.wu@arm.com>
 <83ed7fac-277f-a31e-af37-8ec134f39d26@redhat.com>
 <HE1PR0801MB1676F57B317AE85E3B934B32F48E0@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <629538ea-13fb-e666-8df6-8ad23f114755@redhat.com>
 <HE1PR0801MB167639E2F025998058A77F86F4890@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <ef6ab8bd-41ad-88f8-9cfd-dc749ca65310@redhat.com>
 <a1b554b8-4417-5305-3419-fe71a8c50842@kernel.org>
 <56a5b885-62c8-c4ef-e2f8-e945c0eb700e@redhat.com>
 <HE1PR0801MB1676115C248E6DF09F9DD5A6F4950@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <1cc145ca-1af2-d46f-d530-0ae434005f0b@redhat.com>
 <HE1PR0801MB1676B1AD68544561403C3196F4950@HE1PR0801MB1676.eurprd08.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6b8b59b2-a07e-7e33-588c-1da7658e3f1e@redhat.com>
Date:   Wed, 9 Oct 2019 11:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0801MB1676B1AD68544561403C3196F4950@HE1PR0801MB1676.eurprd08.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: gn01pkWMO2GLKaumcRs8bA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 10:18, Jianyong Wu (Arm Technology China) wrote:
> Hi Paolo,
>=20
>> -----Original Message-----
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Sent: Wednesday, October 9, 2019 2:36 PM
>> To: Jianyong Wu (Arm Technology China) <Jianyong.Wu@arm.com>; Marc
>> Zyngier <maz@kernel.org>; netdev@vger.kernel.org; yangbo.lu@nxp.com;
>> john.stultz@linaro.org; tglx@linutronix.de; sean.j.christopherson@intel.=
com;
>> richardcochran@gmail.com; Mark Rutland <Mark.Rutland@arm.com>; Will
>> Deacon <Will.Deacon@arm.com>; Suzuki Poulose
>> <Suzuki.Poulose@arm.com>
>> Cc: linux-kernel@vger.kernel.org; kvm@vger.kernel.org; Steve Capper
>> <Steve.Capper@arm.com>; Kaly Xin (Arm Technology China)
>> <Kaly.Xin@arm.com>; Justin He (Arm Technology China)
>> <Justin.He@arm.com>; nd <nd@arm.com>; linux-arm-
>> kernel@lists.infradead.org
>> Subject: Re: [RFC PATCH v3 4/6] psci: Add hvc call service for ptp_kvm.
>>
>> On 09/10/19 07:21, Jianyong Wu (Arm Technology China) wrote:
>>> As ptp_kvm clock has fixed to arm arch system counter in patch set v4,
>>> we need check if the current clocksource is system counter when return
>>> clock cycle in host, so a helper needed to return the current
>>> clocksource. Could I add this helper in next patch set?
>>
>> You don't need a helper.  You need to return the ARM arch counter
>> clocksource in the struct system_counterval_t that you return.
>> get_device_system_crosststamp will then check that the clocksource
>> matches the active one.
>
> We must ensure both of the host and guest using the same clocksource.
> get_device_system_crosststamp will check the clocksource of guest and we =
also need check
> the clocksource in host, and struct type can't be transferred from host t=
o guest using arm hypercall.
> now we lack of a mechanism to check the current clocksource. I think this=
 will be useful if we add one.

Got it---yes, I think adding a struct clocksource to struct
system_time_snapshot would make sense.  Then the hypercall can just use
ktime_get_snapshot and fail if the clocksource is not the ARM arch counter.

John (Stultz), does that sound good to you?  The context is that
Jianyong would like to add a hypercall that returns a (cycles,
nanoseconds) pair to the guest.  On x86 we're relying on the vclock_mode
field that is already there for the vDSO, but being able to just use
ktime_get_snapshot would be much nicer.

Paolo

