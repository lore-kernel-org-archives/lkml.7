Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E58CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B03D222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pgtBz1yN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394641AbfJRQQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:16:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35045 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJRQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:16:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id z6so5448438otb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yvne9gR5NX8diVvQ4owtsBgM2mX2Xb63EAQlH8HuKk=;
        b=pgtBz1yNdYHNJjI2qaamNbVambOK9yJQgeULnvuFlYsPJ9Rjw1N2d9H+8UMr9eWj3b
         9liGZz4th/SqPt1msrv5ZhJ9X9azJiH5HNasIcgScD598JWlRWnzuFGS5AXysqgA6HLk
         gwKe5zRem+TLue5OOjkQh/IQhuxj1AIg1HfVEcb//hOpoKtgw5H/2dP9kiqZLYOx1QBF
         SrL6WQzrY22NyTxaL8lcVppjuosDDGcqNgrGBBEmn5Oh8WYlAZ4hC7itFji5GF+ZbDMS
         QAID4k1OHaUbZNUNfqTZiKItV2l49Gld9cwb/kfcjD69FsTkXtRptAEHg/UKD/mgPmFj
         rfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yvne9gR5NX8diVvQ4owtsBgM2mX2Xb63EAQlH8HuKk=;
        b=YuOp+mSbJy95rA5a5vfifXfZ+MmiBot11yWz2207eqgQIRs7BSK1cORfv5rvwUjcJ3
         vyl9TY887yIM/wWPgNDYvZvdlmYLbmpIu2q5yUTZvCru/ZW9IGizEb1meulwMdQQOQ5D
         tCh/STYYxkQvMab7Z4jnujhBAttgeSoTtSXmCxAVypYWe/vahsI7ybLWPPW0xuoGMfkt
         V00cnOLKRfvC3hRjBcIkgX7rkQbhahSi7RyTrEjbsB5VRZtSVrAuu9Egqcewuwq6CFHn
         Z2UOo9JaNCC3zbCjFuqagXYnZxq+XcsMmDwnQFRz0SKM8yxN0hI1AFoWp+s4YDv599fg
         2XMQ==
X-Gm-Message-State: APjAAAVV5EPxIfdSnNVafOsWp8TZObKHOchYRkLk3P4YRAkQc/wPCaTg
        ZAWkR8zELjLSw0KyrqRAbUGvOz64o+ckiotkYc1atw==
X-Google-Smtp-Source: APXvYqyblv3J/xJHeQdDv4C30Sjo0Fd3shSE2mry0JpF/Y+67xf+0kg0irQ3y+5bIupfWe2BJ5cEte7rGplRl+cUL8w=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr8454155otn.363.1571415404227;
 Fri, 18 Oct 2019 09:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018123534.GA6549@mwanda>
In-Reply-To: <20191018123534.GA6549@mwanda>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Oct 2019 09:16:33 -0700
Message-ID: <CAPcyv4jm7kiayfHnBcm7mNW2NeJ81LeUVphMYG0Tq50is-tQ0A@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: unlock on error in scrub_show()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We change the locking in this function and forgot to update this error
> path so we are accidentally still holding the "dev->lockdep_mutex".
>
> Fixes: 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good to me, thanks Dan.
