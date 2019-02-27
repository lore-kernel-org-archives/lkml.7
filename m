Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D66C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CB9218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfuxah9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfB0XwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:52:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54332 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfB0XwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:52:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so7579951wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 15:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4k8NHa+WUOOUzh4gh5kqn1y32OrJvTKQt77UZuSyark=;
        b=tfuxah9B26ZNjMPeEGA9hYz1tD4JIx3zClRLQnSGx2ANdXFWycTDCt/UtbC6aPxro6
         ppCpKC3gtVaRzHV1pwYrng2L2O4m4BQx8JmwRDmSH164gsxqY4T8bmH8QqUlPG7pS8kY
         Xi3dm3oZOw5eMMbmgUDWtTtdp2fnFi7de95PxmntwcJNuZmX7CQfm/1NA+eILCoc7C9U
         +C5kvJQPsRo0pWdU1zu1Aj95VIXivrwzkm9BiY94U6IfyBaV+WcnZhd7zrXIdJCl8YDJ
         1fInDMCAixD0Dgk8S/OOobgoP7FreLhFnnLUMQGjmSxE6rRVDxVy8rSLsImKmwYYJVg+
         r1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4k8NHa+WUOOUzh4gh5kqn1y32OrJvTKQt77UZuSyark=;
        b=QW/CDyjir/jQXRiSCvZwz2TQAX0NTnZE+lQbjlfahJeYkRRJhUH/PTw5MR/3pcA8kn
         JGJjJpV5H4254cOmn6JJ2aw5hYvsOggwcR10VjsC9FOvlqN87EMN+XzzRPFUYyspMfza
         4rQ/mdkIEoTzrBS6/A3N5dCNv54VnukkN82C/Osx327gIyLXRMXPBxoKS9VeYrdMBiY0
         cI8AWlatzE25J8SgZflxOrAGlUpZrIBp1yQksHaPEFU2nSFUVHIvwf/jUr5ol4WDxiWY
         hhV5tRcdKcbLkxGz9t6f0R72+19+nO3ZT3apcN/OKng4Ky1mEgOrqxElq8zJuOCiVNph
         4K4A==
X-Gm-Message-State: APjAAAUYQro6tm9FGqLnEF73abC2SBPJKCP1TSNqYe2JpiZp6Rxc7GZX
        hvqTQ3NDlnZe6N5Rk77aQ4oXLna+KnI8RJu8aRCNHGotFA==
X-Google-Smtp-Source: APXvYqzT53ii8DfHMpjBspyDPL6etWCpkcf/W3trmfRg3/ZNpAUVnoeEqif4+h5FLB1lMY6kHxESePzS5nUYrwc1IA0=
X-Received: by 2002:a1c:6409:: with SMTP id y9mr1064358wmb.68.1551311519213;
 Wed, 27 Feb 2019 15:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20190228080147.20df150f@canb.auug.org.au>
In-Reply-To: <20190228080147.20df150f@canb.auug.org.au>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 27 Feb 2019 17:51:46 -0600
Message-ID: <CAErSpo5-wi128AGyMsyvoyX0ObKon3Q4dU8FJEDTZAtxFHPk=w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 3:01 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Bjorn,
>
> Commit
>
>   a048671aa0c8 ("PCI: qcom: Don't deassert reset GPIO during probe")
>
> is missing a Signed-off-by from its committer.

Lorenzo, if you add your signed-off-by, I can rebuild this.  I think
it's on your pci/dwc branch.
