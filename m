Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F9BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF29217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+squ87/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbfEXJIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:08:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42498 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389475AbfEXJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:08:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id w9so6492794oic.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fB4Mx1+ciujWx737rFsuAYwMzrj1DN17Thp/F78Hnjc=;
        b=d+squ87/oI0uVVahDHP6UGzMXCXMhgPZZcDo3lVXzeXUKSHBkQhc7gqWzihqo9vOQy
         CdgX6zR6DifJEB+vf61aGhD4gh3pjN/pnahyKTvjQWfAdRzfOTpjHqbQQG/bkMktFaVp
         oWdn/FYmS4jPv8RbWG9Betj4zgRTJFRn2F9hb8Wbn0tjO5TauhiOmLa/pn7sCcvh8+Tq
         TctxiuJGuhmN+OnrJMgEv+EMTx6LdVEBzpYwedKNLMLLhNtznxp7PAlxH/NTLuN4Hwep
         sBLq4Ew6yYq1c0EyYNmvCukIEtsgg+E/rtyVPuSFE2csK8qrl20iJk7W3VyNwXv7P5ca
         hzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fB4Mx1+ciujWx737rFsuAYwMzrj1DN17Thp/F78Hnjc=;
        b=udYZIKVv5rHMCxSFeuOP7sJR1H1WiziMnqzu+PbX7Sh98ZB9/yUW5r2BmDWeNx9FG7
         fMCz7N1FQ/UnfulUSwPD289yQn75zgwdjSBvdulLIraNLzPndhQzWtI2uMKzRP4lOmSb
         hL309NG0JDDmvIujR4jszasEvrMcs1S9qeONl3IWamQ30KSEHv/R+TxhLg6wPoWoTkh/
         kff/fccRdEvByExG/o3aFk7jhEUPCVJhmsFsMlhj7m7wPxUWbpH3BanuCyAskuhp/kjr
         Q/a6lUavhwzaaWtjh/uRkbTYw8NwWrju56rIS0SbcvUog3MjL4uHzX+b/xHZHQwaFsxy
         0Ikw==
X-Gm-Message-State: APjAAAWygGWLtHTmfs/fnNkX12SY4TymF6B75kkZOrHXZ0XxKO9Wdkcs
        ULWo+lgH9Tff6rUAD9Qjt9Fwf5297IzP6aUZrf42PA==
X-Google-Smtp-Source: APXvYqxHbexWzTRLmkrsg+gXqQ60yiLxWfsxk2OkwvXCv6kRjRelFNf+AkPIWYQAJhahxwNOdWMgxZbeYGVl2JUIWH8=
X-Received: by 2002:aca:5785:: with SMTP id l127mr5290268oib.48.1558688899862;
 Fri, 24 May 2019 02:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190520190533.GA28160@Red> <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red> <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com> <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
 <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
In-Reply-To: <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 24 May 2019 10:08:09 +0100
Message-ID: <CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
Subject: Re: [Qemu-devel] Running linux on qemu omap
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 at 19:36, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Cheetah works with serial console. I tried with console on display,
> and it seems to boot up, and the frame buffer window gets correctly
> sized but for some reason it just stays blank.

As a general question, when you're doing these tests are you
using a kernel image that is known to work on real hardware?
One problem we have with some of these older QEMU platforms
is that it turns out that QEMU is only tested with the kernel,
and the kernel support for the platform is only tested with
QEMU, and so you get equal and opposite bugs in QEMU and the
kernel that cancel each other out and don't get noticed...

(On the QEMU side these platforms are all basically orphaned:
if somebody submits patches to fix bugs we'll review them,
but they're unlikely to get a great deal of attention otherwise.
They're also quite near the top of the "maybe we'll just
deprecate and then delete these" list, since we have not
historically had any working guest images to test against.
If there's a real userbase that wants them to continue to
exist that's a different matter, of course.)

thanks
- PMM
