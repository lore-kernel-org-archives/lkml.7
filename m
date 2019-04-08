Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08113C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF78721841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TlfdBVgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfDHUtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:49:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53472 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDHUtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:49:23 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so1416372itf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fikndBnrEebyCh6F08UPUuck03CmAx6aho1AMBz6FQ=;
        b=TlfdBVgkzmiPhgSfwSEIl4s+l141o6TBSrxcquxlyClSoTSgZ/SkmUq399E5Oy+P/A
         boS2GKob3pomajHC1HXWO6TFmBBZvn0YfKfpphHhnNpeJWXKdaai+Xtu8Kn6UGBrn9Jn
         mRDxFwx43CFdwXNxfxi25TyAyspA9YwUNUnixbZkPO2czLOMwKPXjlhzrxPtODzH1HbL
         wy/Q357q4eCNk8YxBG77PWX8TpwwSTU0It0bo2munnIElPWLphlgdopShQnCZU1dHA8l
         NMilEMJ4sYgcfhgIxmGXozOLU1T21tatBMMJTPkU4EcTd6EZ9HjWITszHRbNMDgWIhjW
         VkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fikndBnrEebyCh6F08UPUuck03CmAx6aho1AMBz6FQ=;
        b=eaBT/B37u2CG5emFbrOWavaSymcPF5G8+qO+FMoba4aPsznzn2WZkgYYfQR701Piui
         XM7R+ujF1P06jN1ylggCqn25DkNI0dyYtUI2q4Fv4hxOU0Ps9zoTsmbVMwYeoAZ8wnwr
         kjPgt9OpvAUft/H9MB6laJACQP5MaxT+jQk8wWhP2ZSTf2VjTurNPPxZ3hq3guzvQh6B
         Wdl3GFv6oKX00vbVLxEK6y5wktFheLdLoMHWNFTop5AKyv6MzsxPTFQEX/HqzPjVyOz8
         flRIx2SbR7DQb6TzwuNg3umon2pfX8/CyRdOp9p961Ktk4C009o3rqgzlMHqdlD+LvqW
         xRnQ==
X-Gm-Message-State: APjAAAVc2hBc2o+oPwrMgNQIvwI5b+kYWoHhFkVitQGa4/Dk04wgTWt+
        00ygmupx1s+j4qpCIS/Zj3m2V8DnkVp0tSgKp6WflA==
X-Google-Smtp-Source: APXvYqxfnX5hu+73Yx18Cuo1eRLZ31HrnRCAaeQc91KzR+06giaq2wPEeYJfPp1B6RMZkR4bdVuaSUOCRrDKhIE4hXQ=
X-Received: by 2002:a02:9042:: with SMTP id y2mr22929336jaf.113.1554756563069;
 Mon, 08 Apr 2019 13:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190208150826.44EBC68DD2@newverein.lst.de> <20190208151011.0807668DD3@newverein.lst.de>
 <20190408152309.GJ6139@lakrids.cambridge.arm.com>
In-Reply-To: <20190408152309.GJ6139@lakrids.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 8 Apr 2019 22:49:13 +0200
Message-ID: <CAKv+Gu-DWL=gxw0gcjByrVOZsFSV1htoev5iiT++k=D3rf4WdA@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] arm64: replace -pg with CC_FLAGS_FTRACE in efi Makefiles
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 at 17:23, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 08, 2019 at 04:10:11PM +0100, Torsten Duwe wrote:
> >   In preparation for arm64 supporting ftrace built on other compiler
> >   options, let's have makefiles remove the $(CC_FLAGS_FTRACE)
> >   flags, whatever these may be, rather than assuming '-pg'.
> >   While at it, fix arm32 as well.
> >
> >   There should be no functional change as a result of this patch.
> >
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
>
> Ard, would you be happy if we were to take this via the arm64 tree?
>
> Assuming so, can we have your ack?
>

Sure

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
