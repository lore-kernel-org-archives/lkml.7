Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04921C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C334E2467A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 00:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hnJNaWKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfLHAZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 19:25:16 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41700 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLHAZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 19:25:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id g15so9882574qka.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 16:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LA4N4ibkBTMQWH6ww1/KUYSWbMZArPv7/lp2zOrDSu8=;
        b=hnJNaWKWfpk8rdHHlMhuWvvi23XJ/BjtwmmQm2Ds4RC64Uww6p1pUNvMoTI4R8ek9i
         vPKf+/8PJBi/enFvBuT+z3IVCCET4zGZvGEroAcrg4bWv/WNeEK8HBGq5I0dwNnMge1F
         y0B3YhkFqim13Wcy11ZxonJYkOtjzW5eIn/r7WAYPH/8TjkIxley7spZlwoq6S7C9uKm
         iOyAL250ltcjyqxciCMhlHoiAlqcKAA1hEoRzfaDlEgHAFkmJlXf3JSWWz6OuQsY03SU
         p7UJiqyCLkSOOZbM0Iuxiy0ABj4OY88yNdXoomGVIGE9IrUu+q5HN9lHkxDC9WuEcFXp
         P8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LA4N4ibkBTMQWH6ww1/KUYSWbMZArPv7/lp2zOrDSu8=;
        b=Ky4GwbQ5bCs+NN75DvQBIlMQERByAQeaEldhZgP4TWewjicfbdecr1AhVT2pkbfXv7
         rIdvLy5AvfSOJ0DV2jTiBrCPhIQ2YPpX06SZzrRjmMfeOQ1eRZm3TidIeynk4wdQjvEG
         X3d/iLwwtsLmmk8zwzJcU8WC5MtFTHWLzFzVDEmvNfxl3DGmgV7sOh1mTgh2viarbsL3
         C3woa9Pbblb8HdO1TJuqzMQReIhjm+YWJii2gz6hYQaUG5Pwp78An0xxP2MmTeoKmqct
         i49K/Gt9UGK3GBB3SXVvAIK7SJjUg5770BiTC1IAJSiBayMpnygHcirL7ovQHFmSf6eX
         egXA==
X-Gm-Message-State: APjAAAXt750LXjEltfm4LQbUdpBhH9BVhqS73q4cmo+xfxyPpMSaXkBw
        3XwoynKefU0VmNowyqrFmMFKyQ==
X-Google-Smtp-Source: APXvYqxNo8O7Ua5bKHiMIz9HWbpTC75H8jOLck7W0znKlSgbuBXgp2dYwdO4bkOKMiaHzJba8rS4yA==
X-Received: by 2002:a37:4b4f:: with SMTP id y76mr21189522qka.46.1575764714648;
        Sat, 07 Dec 2019 16:25:14 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n19sm7380105qkn.52.2019.12.07.16.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 16:25:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] timer: fix a debugobjects warning in del_timer()
Date:   Sat, 7 Dec 2019 19:25:12 -0500
Message-Id: <B476DCDF-9860-4600-AEF8-0C9AB9794138@lca.pw>
References: <20191207075828.2347-1-cai@lca.pw>
Cc:     sboyd@kernel.org, vikas.shivappa@linux.intel.com,
        tony.luck@intel.com, tj@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20191207075828.2347-1-cai@lca.pw>
To:     tglx@linutronix.de, john.stultz@linaro.org
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 7, 2019, at 2:58 AM, Qian Cai <cai@lca.pw> wrote:
>=20
> Since the commit e33026831bdb ("x86/intel_rdt/mbm: Handle counter
> overflow"), it will generate a debugobjects warning while offlining
> CPUs.
>=20
> ODEBUG: assert_init not available (active state 0) object type:
> timer_list hint: 0x0
> WARNING: CPU: 143 PID: 789 at lib/debugobjects.c:484
> debug_print_object+0xfe/0x140
> Hardware name: HP Synergy 680 Gen9/Synergy 680 Gen9 Compute Module, BIOS
> I40 05/23/2018
> RIP: 0010:debug_print_object+0xfe/0x140
> Call Trace:
> debug_object_assert_init+0x1f5/0x240
> del_timer+0x6f/0xf0
> try_to_grab_pending+0x42/0x3c0
> cancel_delayed_work+0x7d/0x150
> resctrl_offline_cpu+0x3c0/0x520
> cpuhp_invoke_callback+0x197/0x1120
> cpuhp_thread_fun+0x252/0x2f0
> smpboot_thread_fn+0x255/0x440
> kthread+0x1e6/0x210
> ret_from_fork+0x3a/0x50
>=20
> This is because in domain_remove_cpu() when "cpu =3D=3D d->mbm_work_cpu", i=
t
> calls cancel_delayed_work(&d->mbm_over) to deactivate the timer, and
> then mbm_setup_overflow_handler() calls schedule_delayed_work_on() with
> 0 delay which does not activiate the timer in __queue_delayed_work().
>=20
> Later, when the last CPU in the same L3 cache goes offline, it calls
> cancel_delayed_work(&d->mbm_over) again in domain_remove_cpu() and
> trigger the warning because the timer is still inactive.
>=20
> Since del_timer() could be called on both active and inactive timers,
> debug_assert_init() should be called only when there is an active timer.
>=20
> Signed-off-by: Qian Cai <cai@lca.pw>

Self-NACK this and I=E2=80=99ll post a more correct patch.=
