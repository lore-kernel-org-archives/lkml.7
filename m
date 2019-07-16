Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985BDC76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7101621743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563317830;
	bh=3FziCkUhkic52Bz0GkIpF1K3lMHEHAHMOGGv+yHGAuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HMamwFbA7HNw818hBBIoSpnCpRs31LDbxK6OhNZK+S6Qkl2P1UktFsuUpqslTDrNq
	 7rsrN8wTqKOHpj8DaebS2oxaK9iet5ks4nK/A2xKvWp6OE5LVdLttoCgoO8oWOvLD+
	 uKuPoFMD/8PPbIZp69T6TxHdm+AZliHkAV/RmCv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbfGPW5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731273AbfGPW5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:57:09 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE99721842;
        Tue, 16 Jul 2019 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563317828;
        bh=3FziCkUhkic52Bz0GkIpF1K3lMHEHAHMOGGv+yHGAuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tHIuxFwbQhJ6bqRks348x26fjUooue674tNCmsDNaF7YctEzbVuTeO4vbdxLe5cLE
         wr2dq4jGaVUuCBnAoPYfd5xhW8mPFOUrjiBVZ3pH1dpKxA3QNaKy9G2tZvThaVsBDo
         xaqSPELdUJF49m3HgBXf5Is5Oh9fRrCtyJt9U1co=
Received: by mail-qk1-f180.google.com with SMTP id s22so15963969qkj.12;
        Tue, 16 Jul 2019 15:57:07 -0700 (PDT)
X-Gm-Message-State: APjAAAV31bEK6SvV0nr0QjaAf4DZdvldR/3Ek1uDcLKhpktjRpTSjGbQ
        Pv64Vx1F5EooBssnnA1EObH9bNPP7Zck9Qe1pA==
X-Google-Smtp-Source: APXvYqwIhgBe3UyiAiUUqKGCswul0dCV5zLkXb+CtviKLJPbKPZ2Qp20piCgEBRULt10Vr9A8Ukl3eOF7cL98pjlPQY=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr22553428qke.393.1563317827063;
 Tue, 16 Jul 2019 15:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com> <20190702004811.136450-3-saravanak@google.com>
 <CAL_JsqLdvDpKB=iV6x3eTr2F4zY0bxU-Wjb+JeMjj5rdnRc-OQ@mail.gmail.com>
 <CAGETcx_i9353aRFbJXNS78EvqwmU-2-xSBJ+ySZX1gjjHpz_cg@mail.gmail.com>
 <9e75b3dd-380b-c868-728f-46379e53bc11@gmail.com> <07812739-0e6b-6598-ac58-8e0ea74a3331@gmail.com>
 <CAGETcx8YCCGxgXnByenVUb+q8pHPPTjwAjK3L_+9mwoCe=9SbA@mail.gmail.com> <3e340ff1-e842-2521-4344-da62802d472f@gmail.com>
In-Reply-To: <3e340ff1-e842-2521-4344-da62802d472f@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Jul 2019 16:56:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLySLMLanBJvyWqFGhVzXrEaUP-3t9MDmpnAXhQA_7y=g@mail.gmail.com>
Message-ID: <CAL_JsqLySLMLanBJvyWqFGhVzXrEaUP-3t9MDmpnAXhQA_7y=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] of/platform: Add functional dependency link from
 DT bindings
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 7:05 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 7/15/19 11:40 AM, Saravana Kannan wrote:
> > Replying again because the previous email accidentally included HTML.
> >
> > Thanks for taking the time to reconsider the wording Frank. Your
> > intention was clear to me in the first email too.
> >
> > A kernel command line option can also completely disable this
> > functionality easily and cleanly. Can we pick that as an option? I've
> > an implementation of that in the v5 series I sent out last week.
>
> Yes, Rob suggested a command line option for debugging, and I am fine with
> that.  But even with that, I would like a lot of testing so that we have a
> chance of finding systems that have trouble with the changes and could
> potentially be fixed before impacting a large number of users.

Leaving it in -next for more than a cycle will not help. There's some
number of users who test linux-next. Then there's more that test -rc
kernels. Then there's more that test final releases and/or stable
kernels. Probably, the more stable the h/w, the more it tends to be
latter groups. (I don't get reports of breaking PowerMacs with the
changes sitting in linux-next.)

My main worry about this being off by default is it won't get tested.
I'm not sure there's enough interest to drive folks to turn it on and
test. Maybe it needs to be on until we see breakage.

Rob
