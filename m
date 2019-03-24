Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453D5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF4920989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553462207;
	bh=GBmR9fmpp+O0Ypc2SFn4CXzytAFmr+0PXSj4Y68h3x0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TluiADL22P6HiQxh8bS6XxvsCzCM5sj1DFrGDzaxdY8alLBuXwotDfGGC8UgshJo9
	 8U6XlCC2+GH0kfJfUNxiw5G/mqbkgM/84h8ZLoufHduKyItboz/JEVSogUpbuKG13K
	 s8Y+3bl/cPbTwkKR+QqMb9RXD07YHl5dNWaKgr9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfCXVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXVQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:16:45 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E5AA2147C;
        Sun, 24 Mar 2019 21:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553462204;
        bh=GBmR9fmpp+O0Ypc2SFn4CXzytAFmr+0PXSj4Y68h3x0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HQxHbU8vuMnDsHRFu/GBRs+Q5cTx8uSe9faXWinxPtHhScILAvk4eU9I4O/J98SmN
         lNVz/RYy9rEDX8sYzMoPBSJCshvfJkH24ebdekmvKUTzoMR+/tMZioD2Bf0HJEmDfP
         MdOSEIuRmCPXag34mZqtIV2Udl6ek8+AnuJItxM0=
Received: by mail-qt1-f171.google.com with SMTP id y36so8181893qtb.3;
        Sun, 24 Mar 2019 14:16:44 -0700 (PDT)
X-Gm-Message-State: APjAAAULc5dSmQ1XFkKpTlZwDAV1P6JyUUM/HiVOEYaaauzgIGjEkPx0
        KRpwIMDsvwGohCgUnrzAOB/Tf0NYZloLvSmeZw==
X-Google-Smtp-Source: APXvYqxUGl7AdfmV+gdN14yJICBGL+E2EuCdqCELwzFCS8tlQj1SRldU5+ITBtf38aAH1AdFMETqnofojz+lGcqZAOQ=
X-Received: by 2002:ac8:30bc:: with SMTP id v57mr17619209qta.26.1553462203824;
 Sun, 24 Mar 2019 14:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190320234806.19748-1-atish.patra@wdc.com> <20190320234806.19748-3-atish.patra@wdc.com>
In-Reply-To: <20190320234806.19748-3-atish.patra@wdc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 24 Mar 2019 16:16:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCJOioe63oAJVS_=jBuwxTtE79xBnOzqscV4yY_6WfOA@mail.gmail.com>
Message-ID: <CAL_JsqJCJOioe63oAJVS_=jBuwxTtE79xBnOzqscV4yY_6WfOA@mail.gmail.com>
Subject: Re: [RFT/RFC PATCH v3 2/5] dt-binding: cpu-topology: Move cpu-map to
 a common binding.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 6:48 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> cpu-map binding can be used to described cpu topology for both
> RISC-V & ARM. It makes more sense to move the binding to document
> to a common place.
>
> The relevant discussion can be found here.
> https://lkml.org/lkml/2018/11/6/19
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../topology.txt => cpu/cpu-topology.txt}     | 82 +++++++++++++++----
>  1 file changed, 66 insertions(+), 16 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)

Reviewed-by: Rob Herring <robh@kernel.org>
