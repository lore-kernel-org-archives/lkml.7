Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C5C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8BC214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RJvMZ0xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfFYIfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:35:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39897 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfFYIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:35:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so12001203lfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk5hrs4C1tt/nglJSF3HRfZ1Bert/xei53XsDQtZv3U=;
        b=RJvMZ0xf0FFZturrGj3s8PD+dfTywtJeBO4V1p/DJyCQhQluUkFNKj08X91XvfwrJz
         LYTzGaCoqmE8kPTb/FJMJhMTMPB1Q1j0T7j9lwCyYuGYBX6KfVSuZC9k7UjZhIQ4YUzf
         Zzpe29mDXFXQjNGSPoelt2iWqCLm6UpMYgdCeoFj15fxzCaDsX4lsBug5NKZmS8x4lkF
         /oFtdAD2gyPlgBWu5ETHYX3IVyBg/2IUZcgY9dDvxlY6Id8TKd7JvCTqHbHu5GQ7xIZI
         ShCMiXk0NN3dKb4x2CHymD/nE+NsnXo1uivxDiLAMY9dab4IM1SrDQP0F95S2Z2zhQSr
         gKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk5hrs4C1tt/nglJSF3HRfZ1Bert/xei53XsDQtZv3U=;
        b=YBqjfUa5mV4N1WRIOpXM3ETWB21dv/FagqHm+R40SlALoUA4wKwz+JclvYmpEtjrAF
         Y4+88JjqDjSZAIJUDxgyO+FfKephrNZHXhf1JAb7KXhOFPl23CVzH0gxHauWQO3co7wH
         yoYRGb+g9PnuiIkRJ/6LFMk1Axr1wnk3kkJKgSZ7K+41//TZBN1XT7CiOIuW1flwcrJ8
         ew1N2HEHQAweI3APSedYuibdtiJ+nge54EFn1PstSfwqLjMiUCSMInxvKi6qf2v7QJ1a
         xWud28ftbZQ60mzizM9MwA6qGXd0MsCwbSHhwP+agW1bag+3jYa1hTYdl0S6iiBUbTT6
         XFzA==
X-Gm-Message-State: APjAAAXcuPwtUi7SIjbzoVDgkNLroWIRfUbzNVCjlXmseQnKZWLnqL8Q
        48pOic01gyBsTgTtGLhMBE+ohdQKk0drMzK/wOC71Q==
X-Google-Smtp-Source: APXvYqzjF2ta5Anb3SRj80V5eALP3RJBskJMY6xQfTjbjhnPfmrbwahJYk02lH0NXADJ1BXJc7sI0CSzU2xDanIpddo=
X-Received: by 2002:ac2:446b:: with SMTP id y11mr73052242lfl.158.1561451732515;
 Tue, 25 Jun 2019 01:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <1561375453-3135-1-git-send-email-yash.shah@sifive.com> <alpine.DEB.2.21.9999.1906241421550.22820@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906241421550.22820@viisi.sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 25 Jun 2019 14:04:56 +0530
Message-ID: <CAJ2_jOFaS4ZU4m8sE0SFM0sL32Q8fUbg9jbRoEKHU1U2Zqp3YQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: Re-organize SPI DT nodes
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
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

Ok, I will send another patch which will cover the other I/O devices
as well.  Please ignore this patch.

- Yash

>
>
> - Paul
