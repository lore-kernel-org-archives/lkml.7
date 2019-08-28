Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7553AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493B323404
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566981957;
	bh=SYNMMq01znmSNj5G0W+PjKmwx9zN78KMh0tsuO4IhcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NsaqQNjueUrXKqB4l0U14RjLagebP6mN6ZAlHoAY/rSwiqaSMF652d8JUsAFvdi++
	 nmWd1mGPjnVQ5jiK/rW06w82y2y77H1JxLTT2VsjeTjabMteAKnB5errMQSt7WlfOP
	 CGuPshaBIIv5NuXC+1SCOfXlTz+lngQumBg98470=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1Ip4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:45:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35245 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH1Ip4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:45:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id 100so2011748otn.2;
        Wed, 28 Aug 2019 01:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jCxOMA9aKz6SC3UYzcS/O/Ome5CiEdeSa8P16zSjLyw=;
        b=mtVHIfLz2MYDqKv0z90pu/NAxxsgLVfBebaj1h8GhPpQgKlrIlsg8u8mUkghB++9fI
         oLpjzcJRRMJoVtnSGMP/RPDDBfgNOvBeFjshTz5xysC07a4jM+ar64+qL296DyRNRixz
         VZ/jstryf8mbnGy6rTiR95G4PylRZmca3c8dC9Mp8cqs3xg7Yf9gXSgX5j7xINpRPe0G
         rrmHviLz1RW/VgsOVOExvP/CZcdMgFChLEkLlxTSC1/uQ4giWB3cDCMfKAWPkGTHP8xa
         eyGP7GwdjfLiBYfTa/tRkcI/bSUj8wAGAxkjb9/6tBks6NzWM7Wf9NW2Qu+GHMz16yMa
         1hhw==
X-Gm-Message-State: APjAAAUeU1eWcnyuWHx4caEqL9izF/CcxyzK13zSVq2qdwv24nYzyRkN
        HoNKcGSDkK1TaZzZe8av1ufPhVukX0zYYIctdlI=
X-Google-Smtp-Source: APXvYqwC2lZkwr9YxZ3bcwcAf22d6yK/9b2s9wjSflhVJcF8c3Hu86klsU+hStpBZP/K4omckicJLzQ8jSi7GQLdnp8=
X-Received: by 2002:a05:6830:154:: with SMTP id j20mr2381058otp.266.1566981954882;
 Wed, 28 Aug 2019 01:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <1564643196-7797-1-git-send-email-wanpengli@tencent.com>
 <7b1e3025-f513-7068-32ac-4830d67b65ac@intel.com> <c3fe182f-627f-88ad-cb4d-a4189202b438@redhat.com>
 <20190803202058.GA9316@amt.cnet> <CANRm+CwtHBOVWFcn+6Z3Ds7dEcNL2JP+b6hLRS=oeUW98A24MQ@mail.gmail.com>
 <20190826204045.GA24697@amt.cnet> <CANRm+Cx0+V67Ek7FhSs61ZqZL3MgV88Wdy17Q6UA369RH7=dgQ@mail.gmail.com>
 <CANRm+CxqYMzgvxYyhZLmEzYd6SLTyHdRzKVaSiHO-4SV+OwZUQ@mail.gmail.com>
In-Reply-To: <CANRm+CxqYMzgvxYyhZLmEzYd6SLTyHdRzKVaSiHO-4SV+OwZUQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Aug 2019 10:45:44 +0200
Message-ID: <CAJZ5v0iQc0-WzqeyAh-6m5O-BLraRMj+Z7sqvRgGwh2u2Hp7cg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle-haltpoll: Enable kvm guest polling when dedicated
 physical CPUs are available
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:34 AM Wanpeng Li <kernellwp@gmail.com> wrote:
>
> On Tue, 27 Aug 2019 at 08:43, Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > Cc Michael S. Tsirkin,
> > On Tue, 27 Aug 2019 at 04:42, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >
> > > On Tue, Aug 13, 2019 at 08:55:29AM +0800, Wanpeng Li wrote:
> > > > On Sun, 4 Aug 2019 at 04:21, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > > > >
> > > > > On Thu, Aug 01, 2019 at 06:54:49PM +0200, Paolo Bonzini wrote:
> > > > > > On 01/08/19 18:51, Rafael J. Wysocki wrote:
> > > > > > > On 8/1/2019 9:06 AM, Wanpeng Li wrote:
> > > > > > >> From: Wanpeng Li <wanpengli@tencent.com>
> > > > > > >>
> > > > > > >> The downside of guest side polling is that polling is performed even
> > > > > > >> with other runnable tasks in the host. However, even if poll in kvm
> > > > > > >> can aware whether or not other runnable tasks in the same pCPU, it
> > > > > > >> can still incur extra overhead in over-subscribe scenario. Now we can
> > > > > > >> just enable guest polling when dedicated pCPUs are available.
> > > > > > >>
> > > > > > >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > > > >> Cc: Radim Krčmář <rkrcmar@redhat.com>
> > > > > > >> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > > > > > >> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > > > > > >
> > > > > > > Paolo, Marcelo, any comments?
> > > > > >
> > > > > > Yes, it's a good idea.
> > > > > >
> > > > > > Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Hi Marcelo,
>
> If you don't have more concern, I guess Rafael can apply this patch
> now since the merge window is not too far.

I will likely queue it up later today and it will go to linux-next
early next week.

Thanks!
