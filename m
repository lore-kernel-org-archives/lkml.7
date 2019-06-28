Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C67BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEBC208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nAdwaoFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfF1Lrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:47:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39553 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1Lrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:47:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so4487653qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnrNJm+YPQ9P/zBeIY5Q0s4HopjViLSRE1ga8Evn3gQ=;
        b=nAdwaoFQWMK/thL2OEH/rLDCYdBnzoQTtEM6UcrKBEmJQKF6ko515Bi6qtrIdXDt15
         ixrnyV55XUQ08KxuoymqWCYvAquA66hzFuvBfNRqZUrp4+6Yn8YXtiAOaHTcEAIP6I29
         0kgKXVjJNGQvg7lzEJnk75HtFdgoa1aD+8i7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnrNJm+YPQ9P/zBeIY5Q0s4HopjViLSRE1ga8Evn3gQ=;
        b=kORhqa7iypev6oQxRt7inhqcN/6zLG0i2WmvQVpo3XR7Pz18HULZicBZosb82yaLsi
         zDkK3/kpWANCjyI/gxuRRDDLbxvXHBpGsDtwVy3IiuVr6ppI1W0dEi2Sk0NHf8GWhzjp
         PauRQ3qCxMPMUTxYoYJZ3LjRlevij/k/UFCyFwn3sBU2C2YTKBiKoL5ve996xtsSnEn9
         zKnarxX8o7LBw+Hj6epFZWy5S+GL6Cc8O5/yBYmKLizEEmbr863d5DxrnkSQWJh3Qy9c
         ylxBYOiZ4ucGKYXgmCWsMA4eMYLuG6furx8ga1J/9Z0NpKxUx7wvm2oR06c9SDay3vy9
         omhw==
X-Gm-Message-State: APjAAAWSQdc+0wAnZin3/UKSIcyjODcWFJI3GiL8K89xzjtxH/rj3o1q
        UT0wn39w+0BDGIFeJbHmWYDB7/EW3yDfVi29Ea8BPQ==
X-Google-Smtp-Source: APXvYqzQhSBa4VdeP8zdX3MfsDpwnzjGB/9TwQnwrCUPanMsHkJGMPExpgescOhQ+3g3ljoWtSM2K9PaHPvV17b7bgA=
X-Received: by 2002:a37:9e4b:: with SMTP id h72mr8236923qke.297.1561722466499;
 Fri, 28 Jun 2019 04:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190612043258.166048-1-hsinyi@chromium.org> <20190612043258.166048-4-hsinyi@chromium.org>
 <20190628094251.GC36437@lakrids.cambridge.arm.com>
In-Reply-To: <20190628094251.GC36437@lakrids.cambridge.arm.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 28 Jun 2019 19:47:20 +0800
Message-ID: <CAJMQK-iRKkOS9q-qGVj-3o6BVMeANrBoF_4MWQ1g-=4_6HRdbw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: kexec_file: add rng-seed support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 5:42 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jun 12, 2019 at 12:33:02PM +0800, Hsin-Yi Wang wrote:
> > Adding "rng-seed" to dtb. It's fine to add this property if original
> > fdt doesn't contain it. Since original seed will be wiped after
> > read, so use a default size 128 bytes here.
>
> Why is 128 bytes the default value?
More than 64 bytes should be enough.
>
> I didn't see an update to Documentation/devicetree/bindings/chosen.txt,
> so it's not clear to me precisely what we expect.
>
Rob suggested to update in a newer dt-schema documentation at
https://github.com/devicetree-org/dt-schema.
A pull request has been sent but perhaps it would continue if kernel
patches are accepted.
>
> For 128 bytes, it would be better to use a buffer on the stack. That
> avoids the possibility of the allocation failing.
>
Okay, I'll update this.
>
> If the RNG wasn't initialised, we'd carry on with a warning. Why do we
> follow a different policy here?
>
For failure case, I think kernel can still be boot since this is not a
very fatal case, just same as the seed wasn't provided by bootloader
at first boot. So I'll also let fdt_setprop() failed case carry on
with warning.

Thanks
