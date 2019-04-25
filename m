Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA04C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E2B2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9nSvzUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfDYPUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:20:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46994 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:20:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so9023491pll.13;
        Thu, 25 Apr 2019 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yoGmyiBWeZnSsqkaBcEqMFAHcCmUDlyEJTGPecR9P2k=;
        b=h9nSvzUU1D22znVNFQ1LSGhY/0zTExAwrch/8IAqB2qOf32x85XkppW9Qkg8apnTLx
         U31SxfBskuD4jasmcIot/IIyg9VB9JzfcVi/0Ek8ofJ2n0RE/RGVrcRMdRu+1hLUMcry
         BSwLTfgRv9LZcYh2Ptpzeg5Eq7Y91dIZxyWOgWOSPs4a175JAS+jYOyYie3BZqWehcGQ
         Cjowx9sJzpwok5JaMrlbTeb0mEY34SZ4cuEC0NnSSc4naB8eFtosl07D1xt6hhH17Ls5
         jAqBNuY9EwsRHZy5pfApE03f1201K1ED/uINpnqrp0Bi4IRO+XqDAjsKqIO/4yuw7gGF
         K6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yoGmyiBWeZnSsqkaBcEqMFAHcCmUDlyEJTGPecR9P2k=;
        b=qNdnxr/np0FEU+4B4ha20flUf3UceXgfoh1wpFen5fvgdz1AqrWxx6nk472R9ClX0W
         9h32c1wMMkCRF3ScHrRiSscUtOK13gekC2/0KvNR+i3Pa2UP5jgg8VrbEDfzT81xZa5R
         dHDfi0ZhE/+VRluhYZqKVilfnuAuHU2osgdNjInEKog34nzjy9fjvG0BuZw3I92OGOmg
         Wdq8wDOqrc1Vq2kcJ3xiiM13aerTM9ITvzccyWn+lOdIW4ovgKlEUUoXaHQOiXRr/Uri
         DsrOZuZdfme3jnij9K39d9FVpMXweRSLee5xpoceSspFXQfUJaU2mKLCyXfjGgze21uz
         g+HA==
X-Gm-Message-State: APjAAAUAgVPEqqQuBUBq+e7t8YHOpcDBGkYZy+CG5P/AHrr17I3cR+sR
        iVCcPlxkXCMqeREuouaXXTx/6urz
X-Google-Smtp-Source: APXvYqwiI2NpjrX77r+6N7Cj/eYgSoQZlyoYY9SaicaEwRGqAwKcL+aCStyywLLg2owA0vEn3apKfQ==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr40074978ple.62.1556205645128;
        Thu, 25 Apr 2019 08:20:45 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v15sm30955894pff.105.2019.04.25.08.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 08:20:44 -0700 (PDT)
Date:   Thu, 25 Apr 2019 23:20:35 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v5 00/23] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190425152034.u4q6wjhm3yfhbnzp@mail.google.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
 <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:44:14AM +0200, Rafael J. Wysocki wrote:
> .On Wed, Apr 24, 2019 at 7:54 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Hi All,
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> > reST format in this serias.
> >
> > The hieararchy of ACPI docs are based on Corbet's suggestion:
> > https://lkml.org/lkml/2019/4/3/1047
> > I did some adjustment according to the content and finally they are placed as:
> > Documentation/firmware-guide/acpi/
> 
> I'd like to queue up this series, but it is missing a patch to create
> Documentation/firmware-guide/acpi/index.rst.
> 
> Care to provide one?
oops, the first patch is missed. Let me add it next.

-- 
Cheers,
Changbin Du
