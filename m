Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC47C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9292084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573594012;
	bh=raaEbLqNarzWJ6JB1vuCRjGkJaRlQDaUk7sgNF1cNgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xx87XCohAQPY6CpM67D3Ml/PKLMsEDYsyflbrox1ItGbAaVRZdgzE8T+ob+o1/0zD
	 bhHf3Y5nAjyoO4T7yVEPKm5t55FLuU4FRywEvHrBVLSjOltsiywLbUw7ETEcO6bZQy
	 Ny5HItm//yUYHt89rJO05r54Yh/1xz5DHEgCU1io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKLV0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:26:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40031 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLV0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:26:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so75320ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2kd7wElWMgzfhzil86lKOxClkhSX76vUlbnZXhNRBU=;
        b=GM8FaRiPEkdHS56FwdTLO7a5FOcLD2iJt2i7xIxdVDSTlqk5b3yhck5CRqTDoa7b4S
         mV9X20uS0gEUhdpGbx6MmjERR/XvnvHOT3oxhuDv5WC1p6fYAn9dWLCm/Uf2PH2onKq8
         uarbTWRJRqNL0DHM7NiJvYKUEDyyKfd1Fd1dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2kd7wElWMgzfhzil86lKOxClkhSX76vUlbnZXhNRBU=;
        b=BdqBWdhjrMZ9AG1ildabNeRHN+19nVzd07zeNAofcztJPriuiT7E12gmtUYG63ZVVq
         gXTpviZaVijaH7/6gpCQW8vV8O/vx3ha27xHezxQqt9amoiCIutbqBoBkEHSWQVpU88K
         pgJau9alHvPMDMfgOCZh2wx0hudz3am4ZD2gZ264LY7BSNNC2gnEqXHbeJY3bh/g7fNf
         WBFGoF6ePeCOwndWVP1Nlit972AwgydnmcMBTJqA+vD2g0TdEPIkHyOkVJITXvmZTPm0
         RZF0AMG2lKm9L33hoUa8ZynnuLWtbyBNWmrva6GEBee7zR8KrFOuJtViBJTqRqWzwe9e
         w+BA==
X-Gm-Message-State: APjAAAXGtYA0nr66vlCPHC/XFfEs1AVCuq3pBxhxLQH9+mNTjwiLkX2E
        vb1lFWXhGRkdq1uZ95qlSk2pKZO+e0g=
X-Google-Smtp-Source: APXvYqyIlWA+++3akP0I3ujU089DaKA+jyK1RfGB5tkKy9WAe+n2IVTVetRPKC0kapSH9/w+LQJvOQ==
X-Received: by 2002:a2e:5c46:: with SMTP id q67mr21063729ljb.42.1573594007903;
        Tue, 12 Nov 2019 13:26:47 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y72sm5218560lfa.94.2019.11.12.13.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 13:26:47 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id d22so69673lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:26:46 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr21939869lji.1.1573594006740;
 Tue, 12 Nov 2019 13:26:46 -0800 (PST)
MIME-Version: 1.0
References: <1573593036-23271-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573593036-23271-1-git-send-email-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 13:26:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibywR7ySaBD=H9Q0cc1d86+Z1Sg3OWUsDjUvj21dZAKQ@mail.gmail.com>
Message-ID: <CAHk-=wibywR7ySaBD=H9Q0cc1d86+Z1Sg3OWUsDjUvj21dZAKQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM patches for Linux 5.4-rc8
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 1:10 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> It's not a particularly hard conflict, but I'm including anyway a
> resolution at the end of this email.

Hmm. My resolution has a slightly different conflict diff, that shows
another earlier part (that git ended up sorting out itself - maybe you
edited it out for that reason).

I think I did the right conflict resolution, but the difference in
diffs makes me just slightly nervous. Mind checking it?

               Linus
