Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134A9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C0620828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TqKrbziv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfH1UEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:04:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37758 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfH1UEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:04:13 -0400
Received: by mail-io1-f65.google.com with SMTP id q12so2119453iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzkV411pf7zjofW+GZBpfOIv838Cue5Dz3c2i54W3Hs=;
        b=TqKrbzivXqLx4S72W9/Dc/16SjCBEh3vmOYxQ3T+8TpNAQOkEilxhkcInM8KKq9hjh
         vMLEOnxrv2stuvKcwnG75VkLLYAyHfF6ce0Qy6iyvDw+Zwn+C9vrD6OvIQ7MqyRBhpgM
         BUId+T7rzLQhHnxLOs08kABS35fqei4e1vddRKPYY87walLPB3nws1UMO1NFJXexc3jy
         H3W56C9ljLZ9ervxhBEAHBs+RAX5TSb+05DMUHpqe3u8a9F3NJxunHsomOi6Ee3CzYmi
         OnZzkGQznIAJ32b8g0HEoWPT6HCtV7eO4uvSAc7s4F7HMR/W6+4j+m0axWOP8xwMFeS0
         ynUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzkV411pf7zjofW+GZBpfOIv838Cue5Dz3c2i54W3Hs=;
        b=FHEv3A4GNNWxaWApxtZqT+st7Td/W7W6puNozSVbRfI5kp+C6wrDkry/yZAB3S46dL
         xZpmdsy1MTfTvKIDP7lTKNhlKTWsjCXaTh7TXU6kRvhSMVxoos/r5dc1/KYSHK4mDC/Y
         Xm3VVBitImCPlQ2O2fbcl1RhErg0VFlreVvixOAgmphKwmmcvW+FSLX+VCRq6CG47xJO
         Cgjs3ZcAglMlSbrhrpHJYP6r+vIEEHNQGjOZUHhMDd1Km27RQVwKYZkG1b5TXFdpbrxX
         y1YLZ8MZEaPmfLD2YlBAiIbi+T6meAJpqMNVZ1wizQ7dyc14odHTDgo/wf2h5eBhtjYH
         H4pA==
X-Gm-Message-State: APjAAAWsIh+EBVFMfJsn3pw+5iesiTLQkBTjM+8YGlT6j0PQTLuohJnp
        HX9OZNydsxjZdT8zBY5kBuD8yxTda+U06Zq1X/h31A==
X-Google-Smtp-Source: APXvYqw5epOw/NZMbEmhKAtRFqcMNSUdTV5t85vDn9nrUKWf3BAFpFG1pFBMN53uSE8ck6quuNpyfiHE0Ok4ffFdY8Q=
X-Received: by 2002:a5e:8e0d:: with SMTP id a13mr6685498ion.28.1567022652649;
 Wed, 28 Aug 2019 13:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190826193638.6638-1-echron@arista.com> <1566909632.5576.14.camel@lca.pw>
 <CAM3twVQEMGWMQEC0dduri0JWt3gH6F2YsSqOmk55VQz+CZDVKg@mail.gmail.com>
 <79FC3DA1-47F0-4FFC-A92B-9A7EBCE3F15F@lca.pw> <CAM3twVSdxJaEpmWXu2m_F1MxFMB58C6=LWWCDYNn5yT3Ns+0sQ@mail.gmail.com>
 <2A1D8FFC-9E9E-4D86-9A0E-28F8263CC508@lca.pw> <CAM3twVR5TVuuZSLM2qRJYnkCEKVZmA3XDNREaB+wdKH2Ne9vVA@mail.gmail.com>
 <20190828070845.GC7386@dhcp22.suse.cz> <2e816b05-7b5b-4bc0-8d38-8415daea920d@i-love.sakura.ne.jp>
In-Reply-To: <2e816b05-7b5b-4bc0-8d38-8415daea920d@i-love.sakura.ne.jp>
From:   Edward Chron <echron@arista.com>
Date:   Wed, 28 Aug 2019 13:04:00 -0700
Message-ID: <CAM3twVRbhGL8pj0oa9NOu4pO2FWx3tTu928pW0g5CiE-K-meYw@mail.gmail.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional information
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 3:12 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/08/28 16:08, Michal Hocko wrote:
> > On Tue 27-08-19 19:47:22, Edward Chron wrote:
> >> For production systems installing and updating EBPF scripts may someday
> >> be very common, but I wonder how data center managers feel about it now?
> >> Developers are very excited about it and it is a very powerful tool but can I
> >> get permission to add or replace an existing EBPF on production systems?
> >
> > I am not sure I understand. There must be somebody trusted to take care
> > of systems, right?
> >
>
> Speak of my cases, those who take care of their systems are not developers.
> And they afraid changing code that runs in kernel mode. They unlikely give
> permission to install SystemTap/eBPF scripts. As a result, in many cases,
> the root cause cannot be identified.

+1. Exactly. The only thing we could think of Tetsuo is if Linux OOM Reporting
uses a an eBPF script then systems have to load them to get any kind of
meaningful report. Frankly, if using eBPF is the route to go than essentially
the whole OOM reporting should go there. We can adjust as we need and
have precedent for wanting to load the script. That's the best we could come
up with.

>
> Moreover, we are talking about OOM situations, where we can't expect userspace
> processes to work properly. We need to dump information we want, without
> counting on userspace processes, before sending SIGKILL.

+1. We've tried and as you point out and for best results the kernel
has to provide
 the state.

Again a full system dump would be wonderful, but taking a full dump for
every OOM event on production systems? I am not nearly a good enough salesman
to sell that one. So we need an alternate mechanism.

If we can't agree on some sort of extensible, configurable approach then put
the standard OOM Report in eBPF and make it mandatory to load it so we can
justify having to do that. Linux should load it automatically.
We'll just make a few changes and additions as needed.

Sounds like a plan that we could live with.
Would be interested if this works for others as well.
