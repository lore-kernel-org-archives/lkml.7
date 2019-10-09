Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C72C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696002133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnainmCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJIG2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:28:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45070 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJIG2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:28:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so922870pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Le57krV/V2M5bV3ruPXTMG0AMTBpKunAb7kJzZ/0mTU=;
        b=lnainmCLAk/7lQrp3Adzja6aKxP/R/YDsPMKuNdNCdXdmStbxmfHQFbb5FALCPixkY
         7YXFkTl8otZ1PWyZOofORO8VXYk+NbZXKlER6frnkS80LjFYRtbSUZvVgukTq4kkQYVS
         hbh6qYpIKU/+HTRBRmfGOOGK2aMloZlMEIRamrgomTTmHPSg8f+hissWA9h0JNk5e4OQ
         dRUwkacOeIpMfzjcQ1xjw5Th4EB7BOgd91iiLHnGIoy2xUhQIzXk/C+WgtSAG2BN3k0K
         BR6x3g9s33M47SrcWZp3hFhMUinSTD1Q/Kz5nJHi/dUD3aXZQCC/DQiPb6Qm17roO5DO
         da+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Le57krV/V2M5bV3ruPXTMG0AMTBpKunAb7kJzZ/0mTU=;
        b=FOM4V7Mv3sRnxV4wjubUZPE7FYU7zSXw0ekZfSb4Nvpa5V3hKX28vO0M7m40cqAou8
         4MC3xnj5WPGUkmqVYiXSxr10wu6cGkK0vl2br6CeORCgLUYA2Ux/xvp21KAjAQvutJ8n
         MqTsMuOsPG/MvqGEj2bqezwTki0Vsq9hsmyQ01TtgNxwB2L2cd2zEXwueYmdidiu0uJT
         Q3TCvP48ftMnzSqhp6GMK2etueg8dUp9DkBPec+BI1bEMj1lrsprqIJBIIiuNMPttfFv
         fFO20mgulPjOeIKOG9KwePW3ff1Enw7JMcIo1bjgxZK6/ifrjXT14hRqjvC8h9Ph+OzQ
         H5gA==
X-Gm-Message-State: APjAAAVFhrBlsJWEf5GkEvViDEDLSIFPC8e0xAUb8gBtVtUFIQw+V5yC
        8FCH5j/jvO+rjF3aDUZhmoGz9UL9OIlOGGemLCQ=
X-Google-Smtp-Source: APXvYqz7MN7zzGCQlZmkXodNececiOgvYkeFqpNC5VqRvTLJiIoXLOWLDmxxEduUQXroXIBh0Mv6eV24GXgD3dCIDHg=
X-Received: by 2002:a17:90a:db4a:: with SMTP id u10mr2217076pjx.30.1570602526438;
 Tue, 08 Oct 2019 23:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191007184231.13256-1-ztuowen@gmail.com> <20191008151628.GA16384@42.do-not-panic.com>
 <20191008161245.GU32742@smile.fi.intel.com> <CAB=NE6V64g5WLMYFxkpC_wsnSbGG-5Nn9uFo1zpcqjP9NsRB+w@mail.gmail.com>
 <56c3808b29838ff37852e196184a7b995f5f1336.camel@gmail.com>
In-Reply-To: <56c3808b29838ff37852e196184a7b995f5f1336.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Oct 2019 09:28:34 +0300
Message-ID: <CAHp75VfLxoxXTBfM+q2xWDheAsAWNpSFKPv6UAVWxz-goCVPyQ@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
To:     GMAIL <ztuowen@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 12:09 AM GMAIL <ztuowen@gmail.com> wrote:
>
> I think that's a fair point. Sorry for not noticing it earlier.
>
> > On Tue, Oct 8, 2019, 6:12 PM Andy Shevchenko <
> > andriy.shevchenko@linux.intel.com> wrote:
> > > Maybe we can even split this to two patches?
>
> I assume splitting means one to add devm_ioremap_uc and one to use it
> for intel-lpss-pci.

Yes. And please, include Luis to Cc list.

-- 
With Best Regards,
Andy Shevchenko
