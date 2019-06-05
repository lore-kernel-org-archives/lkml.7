Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D51BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF6C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfFEMaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:30:03 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:37278 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfFEMaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:30:02 -0400
Received: by mail-qk1-f173.google.com with SMTP id d15so4976855qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 05:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIAzEohJtJriwCbIUZZo9vfkYvFr6mQlgHKp93Bv63s=;
        b=EULbMMoNo6CgIbs2ODD03WPIhQXeszKHLtRfZ2CEVeoNh3/3co7Fj4stFuXzgrEsmo
         FuDyujoJXqftQgC/l7aFBNfsRyYNTkMCCu5w3fnaKDf7FEuwMpf9v80GQueRG3unZAoe
         kGjjXV6iGLT7+Wos7tkxHScauVizMWQPliVIe3ym4EQBmhVzG90Q9TSdSCX66UiIboPu
         v9Z5CB+2AUN5R2MmHyVN1J2Tc1k5DC+aHfVuP4RMVt4OesJOH6ovNMSTyDFCLTHDCRRd
         +lpQa5pwVzXKGpP/AD2EST4yiFeLRG9wJk7q4PEIR9y1cuqHW/o/sKPiMU3or9iCSn08
         nyog==
X-Gm-Message-State: APjAAAU5GmYaqk2t/nmZaX75Z3U7UDVBcJx3eG0OhEDuNdhacbv/YdYj
        gNX5nCmPpw6DSF+pu0VX0310us39YkYKcqO33cRcaw==
X-Google-Smtp-Source: APXvYqy7DvU2elWDBI9zmbpUy+hrtmlt3IP/EIen41Bl/ne7+i+zpOGvpgNyeoG+k91FO+A9HM667ql0wEDHAYo+dQw=
X-Received: by 2002:a05:620a:12db:: with SMTP id e27mr21336923qkl.352.1559737801799;
 Wed, 05 Jun 2019 05:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm> <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com> <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com> <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
 <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com> <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
 <CAO-hwJKRRpsShw6B-YLmsEnjQ+iYtz+VmZK+VSRcDmiBwnS+oA@mail.gmail.com>
 <e431dafc-0fb4-4be3-ac29-dcf125929090@redhat.com> <CAO-hwJ+5UYJMnuCS0UL4g45Xc181LraAzc-CMuYB2rcqKGe_Sw@mail.gmail.com>
 <4548d196-b75f-c4d0-8f3c-3e734b9a758c@redhat.com> <c05929f4-00b6-e098-cd69-cd6539ccd3f1@redhat.com>
 <CAO-hwJJWWRf8cCLCB3JdfFGCGPnp9ar9HC_QAg7crJ0y+pA-hg@mail.gmail.com> <nycvar.YFH.7.76.1906042307260.27227@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1906042307260.27227@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 5 Jun 2019 14:29:49 +0200
Message-ID: <CAO-hwJ+iRYS5+5XiCCG+RJQRCzAaUcxF-xxX-K-H1j+snVpoBw@mail.gmail.com>
Subject: Re: hid-related 5.2-rc1 boot hang
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 11:08 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 4 Jun 2019, Benjamin Tissoires wrote:
>
> > > Which should fix this. It is quite simple and safe, so if we get testing
> > > feedback relatively soon, we could go with the fix instead of dropping the
> > > product-id, your call.
> >
> > I should receive the M280 tomorrow, hopefully with the C52F. If the
> > receiver is correct and the tests are successful, I'd prefer to take
> > this one over the revert :)
>
> Agreed at this release phase. And if it doesn't work, immediate revert for
> now and proper fix for 5.3-rc1.
>

Mouse received, patch tested, patch validated.

Honestly, before fully reviewing the patch, I thought it would be more
5.3 material, but after a thorough review, there is nothing scary in
it and we can safely push it on top of the 5.2 branch.

I'm about to send the other mentioned reverts and push everything in 5.2-fixes

Cheers,
Benjamin
