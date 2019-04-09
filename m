Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1215320833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2BVTu8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDIJWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:22:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35511 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfDIJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:22:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so9055578plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=YC1feqKlZEVMS4YoQTZ4Ne8qnxJnVw8mIrsaa5cJO1s=;
        b=Q2BVTu8v8RaHnw+RJ33EBqlCDvyN95SyH3iRtjS8e4OLg8n5Gpk4pe1wrDeAE21o2o
         w1HJZyQlewnGhXF/s0SRjvE79c2HsbEncGinhM/CWLG2GCcSRZu0K3vecOBS0pcoFriP
         iewULm1VV6OVRzQBTtbJVPPdjenUYGAsmhQuBquy89RT/16LgWcT0S+8QCvTz41qeTjD
         Zfas6U/5vUymoXmWz3kWZIsghciz3iiIeq42iXMEh9+Kyb/iwL1rjDHOodhWyKyYPrc0
         QMB09SN6ovwiYYbZhQ1gVGoqq9XlVYHuZ2Dn/WkEo5ca3CNrZfOGcjwqxCI+G9+hGfyF
         59ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=YC1feqKlZEVMS4YoQTZ4Ne8qnxJnVw8mIrsaa5cJO1s=;
        b=Fkas76JNK4paii3FjOQbuNTJGBBlSmQoTlXlPDysSKqNV+NTegPZsZRS5DsGS8bLvX
         YctWzdKUCrSnbtMVFpiI0uF5CCOJjTPmmIhR9+imvMoPFtvBXOW4XYDTzyXCEvFtYtxq
         IsaEHG87mjufduHeAPJ2tSJfnci8SvYQOiB5lQUgFwXcaakmZpbG7ekAcTQu3r7NaTYG
         GcpYp+f1ctkzF2DP/PBElzEopulTBxyfq39SZjHiAlRNof8HmQ809Y4Gi/1py1jfTxzd
         1vQ44cTTgGMuG3rIZBfOodavY3D8DxAHW65Zxo56d0+cHTazbJWMd4hHzVamerBMiGaH
         eYmw==
X-Gm-Message-State: APjAAAWLg3bQB1geM+ILzYTO9Y7O9XhKrCSGggaORbvCEFR/7HrHPMn3
        Jn3/dEsrCrBU2DgZDFp3bA4=
X-Google-Smtp-Source: APXvYqw6HVklM7gvOhRdGBZMNKTtPCqzE49p+QBftb7VgZ2pwtboNH00CRR6e+uxB7qHHTTEJS8klQ==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr14996001plb.190.1554801721726;
        Tue, 09 Apr 2019 02:22:01 -0700 (PDT)
Received: from localhost ([58.84.79.14])
        by smtp.gmail.com with ESMTPSA id b19sm21883248pgb.51.2019.04.09.02.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 02:22:01 -0700 (PDT)
Date:   Tue, 09 Apr 2019 19:21:54 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/4] Allow CPU0 to be nohz full
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20190404120704.18479-1-npiggin@gmail.com>
        <alpine.DEB.2.21.1904041635190.1685@nanos.tec.linutronix.de>
        <1554393113.wbjxx9ccdx.astroid@bobo.none>
        <alpine.DEB.2.21.1904051952160.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904051952160.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554800737.v126tflazd.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner's on April 6, 2019 3:54 am:
> On Fri, 5 Apr 2019, Nicholas Piggin wrote:
>> Thomas Gleixner's on April 5, 2019 12:36 am:
>> > On Thu, 4 Apr 2019, Nicholas Piggin wrote:
>> >=20
>> >> I've been looking at ways to fix suspend breakage with CPU0 as a
>> >> nohz CPU. I started looking at various things like allowing CPU0
>> >> to take over do_timer again temporarily or allowing nohz full
>> >> to be stopped at runtime (that is quite a significant change for
>> >> little real benefit). The problem then was having the housekeeping
>> >> CPU go offline.
>> >>=20
>> >> So I decided to try just allowing the freeze to occur on non-zero
>> >> CPU. This seems to be a lot simpler to get working, but I guess
>> >> some archs won't be able to deal with this? Would it be okay to
>> >> make it opt-in per arch?
>> >=20
>> > It needs to be opt in. x86 will fall on its nose with that.
>>=20
>> Okay I can add that.
>>=20
>> > Now the real interesting question is WHY do we need that at all?
>>=20
>> Why full nohz for CPU0? Basically this is how their job system was
>> written and used, testing nohz full was a change that came much later=20
>> as an optimisation.
>>=20
>> I don't think there is a fundamental reason an equivalent system
>> could not be made that uses a different CPU for housekeeping, but I
>> was assured the change would be quite difficult for them.
>>=20
>> If we can support it, it seems nice if you can take a particular
>> configuration and just apply nohz_full to your application processors
>> without any other changes.
>=20
> This wants an explanation in the patches.

Okay.

> And patch 4 has in the changelog:
>=20
>    nohz_full has been successful at significantly reducing jitter for a
>    large supercomputer customer, but their job control system requires CP=
U0
>    to be for housekeeping.
>=20
> which just makes me dazed and confused :)
>=20
> Other than some coherent explanation and making it opt in, I don't think
> there is a fundamental issue with that.

I will try to make the changelogs less jibberish then :)

Thanks,
Nick

=
