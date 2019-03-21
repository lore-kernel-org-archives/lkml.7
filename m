Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A136021916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki9RGjJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCUWoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:44:08 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39810 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCUWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:44:08 -0400
Received: by mail-ot1-f42.google.com with SMTP id f10so279535otb.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ufo9tkQtT9X/G/nbRpAYnlQuSFN9dNW1Mr3gsTT7VG4=;
        b=Ki9RGjJuMeoHpuX4xKKtTMBxTZL8D5VEmj8pK9y7gg+jvub5q2z1bcmWgn1D/eKc83
         SEMyOuRtGk303pgxckBcFOtxLhYjKWK8WKrthKlLjI1zpm1x74Xkqapf6spMVhyZNf7R
         ObjgrZaFbG8jb5Kb/TJJsDo12jEbhvHrUvIlDDbdpbtEtgp7RJS0J0HSkkGHJqeGtblK
         vlil9EEMtnXoHE5JRMQzkfFLf/OkqSBCGxNoH72osi90uN2NSoeUDE4V8MFc58KAd+yZ
         rF2zKDtbtEOmSaQb5om7/2tCIKPGmNGPKLR1kN6H59Atjfvf9cGAx8T2zhE/Um/rs8dv
         TO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ufo9tkQtT9X/G/nbRpAYnlQuSFN9dNW1Mr3gsTT7VG4=;
        b=SJK50GafPZYF8xfF7/cXG1i1In391MseuYabogi4mFBTUgqsZBrtLkhvplfCQ6SDJE
         fj+5jbkeMXwd1/3hwyzaABSrG2Mq8pNKHx62MbJXLQxIIlY8zy5yb17O8t1JAnubaTc2
         E5vAktn5Ci1CKmtQKh6hozvt9KoVqxmR8xAAHVUqT5ZTfXYReYJcy+oDMn8+8CKFZAe8
         86TM+OPcnMh9rbbiT4IXVVJJAD+GO0Q1fhC0Bv4UdfFchDtllPFdck6ujHYBcKX7tC2J
         5qosj1cxO52OYPbU56z1mumwdEtfUPNlRp2m89DlgdFjN5c0Ku2xLo0FvoEy+CEol3Yc
         xUbw==
X-Gm-Message-State: APjAAAUZ7rOqcGmVX8/mb5bQOPiIuT3pvBNQj+6q0WNIuvofvreGpEln
        S4GveuiIBOWf1wCEi2RlLY9iHdBxUjEkTGDGHMXevSkd
X-Google-Smtp-Source: APXvYqwpyuadGnhaz8VBI50TcyqI2tTvpQeTyzeZr2SnFv9EqcrfG185kIhHRe2dKZUD2rqDuemmqQrmeNqXDV3fpls=
X-Received: by 2002:a9d:7656:: with SMTP id o22mr4149965otl.216.1553208247000;
 Thu, 21 Mar 2019 15:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190313064557.GA14531@unicorn.suse.cz> <CADVatmMem3t-Lx42vU+-xN94FW5hbXjaBz3jgW6nkVouyWW-Qg@mail.gmail.com>
 <20190317180546.GA26013@unicorn.suse.cz> <CADVatmNVf+8fLsZjETx5nmYKmdQCg0Moqv5W3S0i4gtX9uMn=w@mail.gmail.com>
 <20190320211813.GE29968@unicorn.suse.cz>
In-Reply-To: <20190320211813.GE29968@unicorn.suse.cz>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 21 Mar 2019 22:43:30 +0000
Message-ID: <CADVatmNVM3a=L6McdCsr5xzCwZnW6N4r9Cf55gjQZjsGGosBDg@mail.gmail.com>
Subject: Re: regression (bisected): "modprobe parport_pc" hangs in current mainline
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michal,

On Wed, Mar 20, 2019 at 9:18 PM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Wed, Mar 20, 2019 at 09:30:59AM +0000, Sudip Mukherjee wrote:
> > Sorry, I didn't get the chance to look at it yet and have kept it
> > pending for this weekend. But just had a quick look and I was
> > wondering if the machine on which you are trying the modprobe has an
> > actual parallel port or the machine is not having any parallel port.
> > And also will you be able to send me a dmesg please.
>
> Attaching dmesg output from a virtual machine which doesn't seem to have
> a (virtual) parallel port. This part:
>
> [   63.962283] parport_pc 00:05: reported by Plug and Play ACPI
> [   63.962469] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> [   64.061723] ppdev: user-space parallel port driver
>
> was after I manually killed "/sbin/modprobe -q -- parport_lowlevel" which
> was started during boot.

Thanks for testing. I am unable to reproduce the problem in VM or in
machine, with or without parallel port. But from your logs it looks
like you have an alias set for "parport_lowlevel". When parport module
is being loaded if it does not find any port in its list, it will try
to load "parport_lowlevel" and that is where you are getting the
deadlock. "parport_lowlevel" is not a real module, but instead should
be an alias pointing to some real module. I tried by setting an alias
of parport_lowlevel" as parport_pc but still could not get the
problem.
Can you please check in your VM or machine what do you have the alias
as? It should be either in "/etc/modprobe.conf" or some conf file in
"/etc/modprobe.d" folder. And also, will you be able to test a debug
patch on your VM?

-- 
Regards
Sudip
