Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED3C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6074F2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="k1icy9J+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgAHSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:00:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36663 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgAHSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:00:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so3348761edp.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 10:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIJ0Kicl6j4bwXIU5AzbCNCUfZFKVKAfMopkDEnB5BY=;
        b=k1icy9J+CME6Q3G9G6W6/Wv1Th4TizSEtmEO2uqDn9/R2gnG7nTvQmcSUcyeHKx2Ac
         yAEmz18kLhG+P+c7VgJ6jc+I3/8OBYKPwV9OP6COSgjbIAAlPOXTNAfxz+Uaf7a9VJmv
         KojoOW3+tXzg/ogcCuK6wOSJLJvkNGAEOihfGv3uPgnHkLvuVmyZSUrnSQ8dRrU1eqz1
         cBsJlNdEhUKxsfziEmjwcL6E6MdqoEVqj68ZvsiX6UgHLIMaIOiglQPN5EknHspqLo5v
         SnTPTnUG0niEvIsg0Y//qMlhQ2dHa11PKPesbSSgAmwib6yaPg11UY72yqqevSn6TJzH
         4FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIJ0Kicl6j4bwXIU5AzbCNCUfZFKVKAfMopkDEnB5BY=;
        b=iT0dQlGIJNNw76iD6l8YBsrlOoN4U2joGUiNxM5oJNYcM3E158cM6NsiQmFaPNj2ET
         Qc3ANSb2c7cEYZGiNXCSPypy0pXyFCdI/4HKjIeKPKVyqN+Tvx45mf2Z6H8uZPh99xxk
         ATRp22h1uajClxpGQ/IMe7218Yl9lWK35xJwNNgQ841jtx9Bg2e3nysP2aEkhNpuKppy
         nnz1wNg2tnsQETDy1b0gJx7fhlN4ox7OwW95aRIyXv0MonCoVN9slsjTQHK8XOOsIK2R
         jqvUug/4dF2bHKxB5LbYhpAoQgjY6/IZnyGag681xnps8Ho2cqJX7ha3nSzBxRb9Sm99
         7Geg==
X-Gm-Message-State: APjAAAWOOhbfMKFAeK1v2XZt7piXgI4WUInBZmBsZz5cD34gIsRfRW3X
        63+Wp3y18arx6tWnc372fkScp6vrPdiCLVInzrARmg==
X-Google-Smtp-Source: APXvYqxFiszEz1ruqvN1JxacvGk2YwwdHvkB9/n82UcGb5OJEZoTXm7+hnEEp5cKFmWsqXK5/IDqdumJ8FpMF8USO5g=
X-Received: by 2002:a50:cbc3:: with SMTP id l3mr6877488edi.258.1578506402641;
 Wed, 08 Jan 2020 10:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20200102211357.8042-1-pasha.tatashin@soleen.com>
 <20200102211357.8042-2-pasha.tatashin@soleen.com> <alpine.DEB.2.21.2001060918470.732@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2001060918470.732@sstabellini-ThinkPad-T480s>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 8 Jan 2020 12:59:51 -0500
Message-ID: <CA+CK2bAbMqusWhGmPg32zZ2gaZ3KPS_6LTDPh3rdi1ohO_yQqw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] arm/arm64/xen: hypercall.h add includes guards
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Julien Grall <julien@xen.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 12:19 PM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> On Thu, 2 Jan 2020, Pavel Tatashin wrote:
> > The arm and arm64 versions of hypercall.h are missing the include
> > guards. This is needed because C inlines for privcmd_call are going to
> > be added to the files.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Julien Grall <julien@xen.org>
>
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>


Thank you,
Pasha
