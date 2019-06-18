Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C973720663
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7n4C160"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfFRAhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 20:37:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35838 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 20:37:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so7303991oii.2;
        Mon, 17 Jun 2019 17:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Takjj4UXDH5g7gkdnJEF39H7z1yDSn328Wi1BxBDgk=;
        b=o7n4C160kNuzX2/5bOgd191XA4uZ4oiLKyXd3s3voEBnI7NwW6N/Qvoxbze1Dq4mjd
         qqB21Z5dWWwiuGpw8YyJR6E0xkZSEdrPpds31lN/PigSjhLH+OY9rAvXgxvNLFSTUaYc
         J/dSn8/Ol5M99oGIdPB8/0DO3PoqbCoq4x1cq1YhFLrv0QvW2bT+9vYaQ5fhY6aT+ylP
         VoSd4477xh22NFBxteLYvDVscT8dd4HyFiDXupShNOaLgsgao04h3BkSCyYF/314onve
         PtmQM+QWojP3uqVEtZDQW5w948Iz6hkh79ypX5zHLX6wVuqvJ0ch0JccgGmKQvAskbBJ
         n9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Takjj4UXDH5g7gkdnJEF39H7z1yDSn328Wi1BxBDgk=;
        b=OaPuSHr0I9GDhzicApXhDVMM0kekqvysYZzqIVYrRK/+TPqAoTXC7MNaYC+1OZwRr5
         JQy46WZc37dXKiH9rJisXacMuke4DZ+sVYMTNfCp+FGEjabNz8aGvoPuCr+9Txm+oiF2
         bPNxlMONyDmC9ZrFbw36ErlFNk7lnO/JRo10L77SfVBsDb+rT+mA9lJ4zvSjSdW8g5Do
         Y1HBbi9Uf3kkrRUXX2urgLG6O/MIocKVhyaef4uNh28QwMNHDyV+UDYlxvWUXxvX1wAy
         YznfHFQVJxZJjICH9YdDVlZDYf+9z5xf8rfontGalhA8ImfWcmN3TKYcwvNPwHr/jpPw
         c5pA==
X-Gm-Message-State: APjAAAUzujAH5NnTqode6u63PVViZHYOYCjlmvq7/jIX98ghnabejO6W
        99mSMOzuATlelZJ/eij60d2hSzH3MqSL0eHpoG/q+w==
X-Google-Smtp-Source: APXvYqwalpX2hav6iyql1PtTj+MHb8OCAx7by7N49NBs9MRMMe2y1LGdrFdg+LXaKfOjllbt+MdCL+p1jT6CyAlZe14=
X-Received: by 2002:aca:51ce:: with SMTP id f197mr312283oib.33.1560818271775;
 Mon, 17 Jun 2019 17:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560770687-23227-1-git-send-email-wanpengli@tencent.com>
 <1560770687-23227-2-git-send-email-wanpengli@tencent.com> <20190617114850.GC30983@xz-x1>
In-Reply-To: <20190617114850.GC30983@xz-x1>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 18 Jun 2019 08:38:27 +0800
Message-ID: <CANRm+CxytwzfgpkGqN9DJp09oMNovdpc=A=0-uNX6AO8TbsNHA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] KVM: LAPIC: Make lapic timer unpinned
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 19:48, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 17, 2019 at 07:24:43PM +0800, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Make lapic timer unpinned when timer is injected by posted-interrupt,
>
> It has nothing to do with PI, yet?
>
> And, how about mentioning 61abdbe0bc and telling that this could be
> another solution for that problem (but will be used in follow up
> patches)?
>
> > the emulated timer can be offload to the housekeeping cpus, kick after
> > setting the pending timer request as alternative to commit 61abdbe0bcc.

Yeah, the patch description needs to rework. Thank you.

Regards,
Wanpeng Li
