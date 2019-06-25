Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A01C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B1020659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 03:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="YutOJx/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfFYDbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 23:31:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56071 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfFYDbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 23:31:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so1226956wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hreneRMdosQHoew3G/ulwzqPUoN3bk6y0Mh9gFGiOHc=;
        b=YutOJx/yNHxHBs7eip+GCzWGxLqBKS6HyqZOc89ENz9rJ34KjLkKIpDBw4RWPnmHLa
         MgchNwF70fF15hKZ24AWHDw+jN7rsCA9L13wkYtqXguEBXH072x8pEdHIijavPAOQufT
         ULwurfHUvacfjYlhENKW0MRK/d7rmWJ8yu0OcsDgVV91KEtrztuDNtXClNYJMgLaBzjI
         tEDhtW2KUAkF61HI2Etk6L3uJMrm7rBqP7pglkCVqUtohmQL0WgIPACLQTdzadflJn8N
         stPVpKOCO7djrBVvPtAQGvlSeYrSfjepK5GDBspXz4SOq5mnCipmYi9j4vRInCQRf0gk
         ZlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hreneRMdosQHoew3G/ulwzqPUoN3bk6y0Mh9gFGiOHc=;
        b=ScDVo59pF41u7/0TpvQTyX70lr9vCmMD7WiNBR7Gl0IaCOZ3ng2DRfvQfaJPGjQG80
         GXxXq87WGsYu/nNeod1jSHFZESsll3nBr3JnpLCXgPGdJYCU+Jsm6xcrHi97jD/nQHdu
         ECty3SgeUAGUcbbL1IYb/dLnnj2Yk0pykmhCG0R+/qfZwb193CH0EjFDHAFRw8mPkRFO
         YxVpG+7MOIXZLTxWdT5+SIkDrgBWxZV7qvpmW+O5+iZ1QwD9LqD2PYW4/32QhaMYAk74
         BZ+W4zwhuCWXfyeMT0h/i0l3OzLCy5LrfOAKXjFuQ3USVdt/XEBCLl/KFKWeqm627OX6
         ftlA==
X-Gm-Message-State: APjAAAVxlfoW5eMzCSPWNIfxfnIXr7A7mtmNdlBDzjAnbUPvTuMmTICb
        bzkeK5BF+FX1aEl3nVNYm8FsUq2cAsZoIEQmvPZKTA==
X-Google-Smtp-Source: APXvYqwcYlRtlu/HQuSek8ocdSv5LWy+5p/nWI6LivltsiY0CBh5f2cBsro42LBCqwPhF/BJ5ow4BED0pcLfkh3uKF8=
X-Received: by 2002:a1c:740f:: with SMTP id p15mr17990557wmc.103.1561433506287;
 Mon, 24 Jun 2019 20:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <1561375453-3135-1-git-send-email-yash.shah@sifive.com> <alpine.DEB.2.21.9999.1906241421550.22820@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906241421550.22820@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 25 Jun 2019 09:01:33 +0530
Message-ID: <CAAhSdy0Z_uGMYqC+6yRPFzEBDGi+SHkrvhe2+1ZMt9heHhJ0=g@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: Re-organize SPI DT nodes
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Yash Shah <yash.shah@sifive.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, sachin.ghadi@sifive.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 2:53 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Mon, 24 Jun 2019, Yash Shah wrote:
>
> > As per the General convention, define only device DT node in SOC DTSi
> > file with status = "disabled" and enable device in Board DTS file with
> > status = "okay"
> >
> > Reported-by: Anup Patel <anup@brainfault.org>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
>
> This is a good start, but should also cover the other I/O devices in the
> chip DT file.  The mandatory internal devices, like the PRCI and PLIC, can
> stay the way they are.

Yes, this convention only applies to SoC devices with external connections
so PRCI, PLIC, and CLINT DT nodes are not required to follow this.

Eventually, this convention helps when we have multiple boards of same
SOC and each board having different set of peripherals connections.

Regards,
Anup
