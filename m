Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4A4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1F521848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CipekAbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394011AbfHWPPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:15:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44671 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733257AbfHWPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:15:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so9029964ote.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yF6s2o6Obyqe3Vdpv/vEsuzAp6r9764Exr+eDaZHvIs=;
        b=CipekAbZFv7AtHaeNXijgoaKhu1e4Ki+U+C5UwmSTDk1R0S6hDs4Rz2vU5i7aJx+Xm
         CNIekhclzjzyj/jl3B4i8OIxJ6LkL0vwtijn9gG6PL9FFIjKLREyHpLX0dOnwbR0Y3Yz
         IJxMIxvhHrwSWKUrN2lkWRoeMoZa+8njEAvaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yF6s2o6Obyqe3Vdpv/vEsuzAp6r9764Exr+eDaZHvIs=;
        b=MABjrsGqHR/TmkMuhpDmYKj39HuYDoxjkpnrApW8ZTtaRUblsuhyelZmDXaolwi/Ua
         mjMUlmBt7CjH5oDY8cR9twHU7L79HZ0wp2nsxgh9Qk4lHHmL/KTHSdS/AjnxDMZK718A
         lh6oEwadWAFVA4WAewzNNLh4DMnMU0HnJJlT18byQXPr/pMfQHAgoWJofOBBP4oq3xZe
         EzIqstfle9xk/n/T651dlc908N7qKbOANzW6CXDJPXOCsgoFC8X0ZJdNfvaIWRQqbLkJ
         0/RrTWXRF7Sue0LCPxuYKOZXgW36znbBGzh5YIx0RFr2cY2oHK95pWHL/8nRuIhWxGow
         MYbA==
X-Gm-Message-State: APjAAAVuiOb1lCDhZYELEiKp2aOBcFPhi2qOwwfnYYxyyySYJcZohVUZ
        aYicXJvsC1+LGrwfwWJ1tQtOf72p8+J0006jTEKy/g==
X-Google-Smtp-Source: APXvYqxYJ5Sv6xRYyBhZ/VIa63V8CWwoKAMb/ZibSDLDyqK3dCvDo5SGQy04IWZyYut8+xZ5L8t6GMt0vJE1pUvmUsA=
X-Received: by 2002:a9d:7087:: with SMTP id l7mr4788315otj.281.1566573349104;
 Fri, 23 Aug 2019 08:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-4-daniel.vetter@ffwll.ch> <20190820202440.GH11147@phenom.ffwll.local>
 <20190822161428.c9e4479207386d34745ea111@linux-foundation.org>
 <CAKMK7uGw_7uD=wH3bcR9xXSxAcAuYTLOZt3ue4TEvst1D0KzLQ@mail.gmail.com>
 <20190823121234.GB12968@ziepe.ca> <CAKMK7uHzSkd2j4MvSMoHhCaSE0BT0zMo9osF4FUBYwNZrVfYDA@mail.gmail.com>
 <20190823140615.GJ2369@hirez.programming.kicks-ass.net>
In-Reply-To: <20190823140615.GJ2369@hirez.programming.kicks-ass.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 23 Aug 2019 17:15:37 +0200
Message-ID: <CAKMK7uFM0JLqJ7y9F8ybvYx+o4+2S+guaV-MaBQyyik3F0vNiQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] kernel.h: Add non_block_start/end()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 4:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Aug 23, 2019 at 03:42:47PM +0200, Daniel Vetter wrote:
> > I'm assuming the lockdep one will land, so not going to resend that.
>
> I was assuming you'd wake the might_lock_nested() along with the i915
> user through the i915/drm tree. If want me to take some or all of that,
> lemme know.

might_lock_nested() is a different patch series, that one will indeed
go in through the drm/i915 tree, thx for the ack there. What I meant
here is some mmu notifier lockdep map in this series that Jason said
he's going to pick up into hmm.git. I'm doing about 3 or 4 different
lockdep annotations series in parallel right now :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
