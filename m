Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94058C43141
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C0720803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zn6/mtS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfLCTlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:41:45 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:39431 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfLCTlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:41:45 -0500
Received: by mail-io1-f46.google.com with SMTP id c16so5130776ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBemf5DffbM9H45GJNpf6XQTgytqS7SHwtWxDozwP2k=;
        b=Zn6/mtS46CfYNTBvL+G3gsuGdj1yDZoKrME2Cm0wMQCY5fjcoWvefbN1CLMGjmOJA1
         9WC2PCtFU8/4Vfd86+YWCUQIvD9IOjXz34uyx/oizThOidMc1Rr0u0foU+ENh1eWzRRd
         6l8ow8Ls2e3YVJifDJ0mtA6n/3ev0jFO8JJ+Tetw55fE3BZW/65tDfu58DYHWpL900Hb
         z5JrdoFih7F7WjFZ6OB4c0Tm/Qbd8PQ3GaRoIQa9kfq1Db5dV1NprGktZwf6GGHsNcmE
         YGHLmKd1Je58e3wvoMtiPxTd4xKzZD57TXT4CL0ZVrlbTrU3JZaYltoYxGOJIFmjwp54
         a48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBemf5DffbM9H45GJNpf6XQTgytqS7SHwtWxDozwP2k=;
        b=Gwdqz1TlpRUQ5Qd47+g0Fn9cAyTnEdjsOcdW2yW1e914PpzURohKVznA90aRVFG3AD
         Tx4ta4RmeFsUHaquyh746Rrh7dg0ycuTDXVYt6OCiT03Fz2UgRnBtkH+uAMSL6iKvz1s
         BGlXJ3jB6L/D8QF/BmrMSTq4xZmRdzaHs4Ebz6XJmJtdZpZ0gcQvWxXyRVeiuPTHb5qm
         Dg7wNBlUwyntS0VpXIYTstAP8QIgkAatQ+xAs3IUvKM3mhN9hsjbkASBxJRI6MC+0MwG
         wSHJyJYCzQUynFN0TQ0AB3oUeJlyTe97h5DdB54WEqp6zecLPNFpG3uEtCcSw2IpmS1t
         OP9A==
X-Gm-Message-State: APjAAAVSHHh6iOrVEAia4uFRBNMY9nByMVi0hfi0ZZgrsKkRIabo7WT8
        QzYE1dgzdfH3yh9yKWkw520iGAiLQH12JR9fBFXnsQ==
X-Google-Smtp-Source: APXvYqwxkVJgS3InUv5/LmPbRiof3P9j+j9W7/spqafHaIbJnIhprxg1ULJPZZFP78UueZBNHl/exmw8VSDIniSdL/k=
X-Received: by 2002:a5d:9913:: with SMTP id x19mr3905793iol.46.1575402104183;
 Tue, 03 Dec 2019 11:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com> <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
In-Reply-To: <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 3 Dec 2019 11:41:32 -0800
Message-ID: <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        X86 ML <x86@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 7:30 AM Andy Lutomirski <luto@amacapital.net> wrote:

> Would a similar patch apply to non-EFI boot?  That is, in a BIOS boot,
> is busmastering on when the kernel is loaded?

It's only relevant where firmware configures the IOMMU but then
removes that configuration before handing control to the OS. I'm not
aware of that happening anywhere other than EFI.
