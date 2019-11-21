Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02B220721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4o9WuaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfKUDTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33142 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKUDTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id m193so1929150oig.0;
        Wed, 20 Nov 2019 19:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ORuQkvInRIZpmE3bKVpI577gbWuSzgmOBOgmNTdknE=;
        b=P4o9WuaQGPkn72hAS23FYaUvGDs2HqOkLQPuZhgGJBw5NzUjoRtyNWJe2qoK+CHlm/
         kJ1AjTDQmCVY5aWWqh5AFMkLV7OscF0zZnsbJsAHdT9zqDnyOziA5naO2zxRsfMJbPc4
         7PcetyfcZd3yoHl+lE7c16JHdfGdVE2FelFmWcnD1KzMwMxPUWqa9GUjON/e54Ad3fGG
         FuEVSo0WXKhQY5pkMY0v/9emKh433pZ4eAePOH29gQriO1gXAdE5lxbSAVdxXqlaMDuW
         gePpSHMsgXUplcD8pwgipd3UQA8n62UrXwJDpM6f+iVvX1LVcQ1BArsSIqGe0VB9b7sH
         EzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ORuQkvInRIZpmE3bKVpI577gbWuSzgmOBOgmNTdknE=;
        b=ONZ8jkyLx9WL4+xAH8eq0RipxssCPCgX/iieaDWwVoTvBRxUqXNzwowL1nk+IcoB+o
         vscwIDliJzWgtyWw1WXiCr1abLxqlpkU327FdfREeTvJ7JR1wTcGfrUrwUzi+MHcacy0
         CsPmXVDpggVe6gu2dkVEdaFOWXkVUsWMmS422lHwPMI8WVCuWu/qWhMe6U8xBXshjpiG
         iE1QFzCBIp03Ho7NlfFwWPAtrcMAO2el+k+GOOWhSSqw195qxrk3VPU7Ymh5PYNrmekI
         Ss1JsvL9v+hJQYa2yK1gZLFoK2tFM0vD+HTty7X/XsevVc0AZrs6e25k6PfCLFDp8qb9
         LTZA==
X-Gm-Message-State: APjAAAWZSlD8rxzyjDVUuL/qlo1kmeBHqxg92SJHBXEBvt2QjaFlCYr2
        2S17iGVBBqxgfh1ACKM7TpKKoJSEvJZ/eR1OWVU=
X-Google-Smtp-Source: APXvYqxlQpe4WhwDOVBsqXPX8cfFqoMxDXH2hLXgNMl8urqU1qZk9ZGvrud2ITkmCkT1iNi9mii8uOzCBaqiHfq9S34=
X-Received: by 2002:aca:ebd4:: with SMTP id j203mr5586225oih.141.1574306358796;
 Wed, 20 Nov 2019 19:19:18 -0800 (PST)
MIME-Version: 1.0
References: <1574145389-12149-1-git-send-email-wanpengli@tencent.com>
 <87r224gjyt.fsf@vitty.brq.redhat.com> <CANRm+CzcWDvRA0+iaQZ6hd2HGRKyZpRnurghQXdagDCffKaSPg@mail.gmail.com>
 <87lfscgigk.fsf@vitty.brq.redhat.com> <f13b9873-5187-1558-2599-453041beed4a@redhat.com>
In-Reply-To: <f13b9873-5187-1558-2599-453041beed4a@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 21 Nov 2019 11:19:10 +0800
Message-ID: <CANRm+CxDOaBWuysZ-Q-3OvWegDkL0iyq-DXNjbeTZ6uSk5PG7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: VMX: FIXED+PHYSICAL mode single target IPI fastpath
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 at 01:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/11/19 13:26, Vitaly Kuznetsov wrote:
> > What about ' << 4', don't we still need it? :-) And better APIC_ICR
> > instead of 0x300...
> >
> > Personally, I'd write something like
> >
> > if (index > APIC_BASE_MSR && (index - APIC_BASE_MSR) == APIC_ICR >> 4)
> >
> > and let compiler optimize this, I bet it's going to be equally good.
>
> Or "index == APIC_BASE_MSR + (APIC_ICR >> 4)".

It is done in v3 and v4. Please have a look. :)

    Wanpeng
