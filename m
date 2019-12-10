Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABB7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2CD207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZW+RiShQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLJMLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:11:40 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45232 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:11:40 -0500
Received: by mail-qt1-f172.google.com with SMTP id p5so2520555qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 04:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=1Yz8O3f/m1g7LWK6aF/bLTiQzm0F53jsud4P5YMuk1A=;
        b=ZW+RiShQX8qoAcQ2tPP4n3ru4Eev41rBDxV8QxBHs6VQiE8GYWm1u90R+2UN0yoEL9
         iZkFuKQIZeUW9dwHzurwsY5NjXE9/6oHV8OTMl1MuKXSlwlz0OHZuTpys9N/C2wKfhr7
         7I3LFh2KdYpSpeRoqbd+xH2r3r9GJJSGc6yQHis+UnwCy0NFypHbimHWgGlPS9hzZRzK
         KWztt8rgqVwAg/KwOvAxIwPiygC1QLwd3szH745bfRcrpnq3sZ4NKDO/PoN1k+tghxgv
         D2p3+aw6ys70uTETeCSKsSuMQWp6mjgjzibm4ks3AGuMdL1ylitmy2uu1KfvkbTx8lM6
         +sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=1Yz8O3f/m1g7LWK6aF/bLTiQzm0F53jsud4P5YMuk1A=;
        b=ndYVQ0ltdYtuCR1P4b5/lClweqZSTk5k++UUVijKqj3BzxW06x9rK9bzBKM6NAo+45
         HvZkTp5+HZ/gIej8EhaZLnb3uhTTLG8m6IoKP6B7kYm0c8jcuDVrIPwpuGc7cjNyrZjl
         K6hwgvOqgI9Uep08JNb+O9CbPU89QnDn1x6beB+UOHS+8dnAR54vU47jys0cXRqQMlfy
         pYoR0f0RVNrNhk/AbWU/kebkl1kpLErb91RXo1PcOzu7jf+8hDrG5vsLsot3u81wuYYD
         4gxAVDC+27MNXBLZXPP9Ae+HAB1qZrFbmdimLJ2OMZcXfejcBOa3701OOnk4xlL7oC+M
         pvNQ==
X-Gm-Message-State: APjAAAXqrOcr9fZGAn7BwdH5zSO3J2I9dkKRDdPdtm8ohHn6Cqcrtklt
        dTIQuWSJLXI9YWkbeuvGogpRAA==
X-Google-Smtp-Source: APXvYqxhprn+07lXzoth5hrt7MSdT29jgRXMxQRlPrpU8KZLPvUa28w4zWd5BfAzW6ao0Lb34KT9Yw==
X-Received: by 2002:ac8:5418:: with SMTP id b24mr30100834qtq.226.1575979898839;
        Tue, 10 Dec 2019 04:11:38 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w21sm1081193qth.17.2019.12.10.04.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 04:11:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/resctrl: fix an imbalance in domain_remove_cpu
Date:   Tue, 10 Dec 2019 07:11:37 -0500
Message-Id: <A6F550BE-D7F6-4FE1-8FED-85AA69835FFB@lca.pw>
References: <CADjb_WRmyE3rRN2sLAh9ZOqAg0E3WeCkj9SwSM9dorvx4TGC2A@mail.gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Tony Luck <tony.luck@intel.com>, tj@kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CADjb_WRmyE3rRN2sLAh9ZOqAg0E3WeCkj9SwSM9dorvx4TGC2A@mail.gmail.com>
To:     Ryan Chen <yu.chen.surf@gmail.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 10, 2019, at 2:44 AM, Ryan Chen <yu.chen.surf@gmail.com> wrote:
>=20
> Could you elaborate a little more on the failure symptom?
> If I understand correctly, the error you described was  due to
> r->mon_capable set to false while is_mbm_enabled() returns true?

Yes.

> Which means on this platform rdt_mon_features is non zero?

No idea. I did add some debug code that indicated resctrl_online_cpu() found=
 3 resources in for_each_capable_rdt_resource(r). Only the first one set r->=
mon_capable.

> And in get_rdt_mon_resources() it will invoke rdt_get_mon_l3_config(),
> however the only possible failure to do not set r->mon_capable is that it
> failed in dom_data_init() due to kcalloc() failure?  Then the logic in

Very likely. Should be easy to confirm.

> get_rdt_resources() is that it will ignore the return error if rdt allocat=
e
> feature is supported on this platform?  If

Yes.

> this is the case, the r->mon_capable
> is not an indicator for whether the overflow thread has been created, righ=
t?

I am not sure about that.

> Can we simply remove the check of r->mon_capable in domain_add_cpu() and
> invoke  domain_setup_mon_state() directly?

That should work too, but it is so perfect align with the r->alloc_capable c=
heck above, so I am not sure it is a good idea to break it.

> Humm, it looks like there are two places within this function
> invoked cancel_delayed_work(&d->mbm_over),
> why not adding the check for both of them?

Because I am not sure about the second one.  It was never executed due to =E2=
=80=9Ccpu !=3D d->mbm_work_cpu=E2=80=9C even after offlining all CPUs except=
 cpu 0 and never cause anything wrong yet, so I could not test it yet, but I=
 can see why it might need a similar check too if d->mbm_work_cpu is non-zer=
o and could trigger the same imbalance.=
