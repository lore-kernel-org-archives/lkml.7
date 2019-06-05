Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA0C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F44C20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAt2glob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfFEInV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:43:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41532 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFEInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:43:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so5192576pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nArXIV60d+VYSTjP25TqL0r5OPQUfdfeQ9wV987OiVo=;
        b=jAt2glob59zpg/piEgeo9LTYRsl/CaayO7C7wfjhbPvYScQMl45oyQPIrlgSb4LKFN
         uB6rTG6V2mGdGDUdwS0EaPd90EW2GiOVIIrCfis/CCl0lQLukg0nl2r/hLEre1f4N0gr
         5pCE/DSm+Lqq8bL+CQSl6ak6ibV+Kk2b5gjs+c0coCxbP6sS2Vew+x5LTiyqtRqmZv3p
         oxOviY4oLFOGlEM9xljT3hzkTVeBxfwCSOD9xcwfxMnKZk4kdIjJQswuLN2GObAYpjA4
         s7tvDXPzAePIjNYbwMTTvCYF0qN2ss2b3lFhtTqcWMkGbHkhg7FKYtjP1iZgQAV2KCPa
         Cq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nArXIV60d+VYSTjP25TqL0r5OPQUfdfeQ9wV987OiVo=;
        b=TVnlTMC/z7x3Yp1R2shmM+MHhdBH6k1d9vta4M2vVzLBF9o9eOpQrcK39IPoLq8aH8
         pgzv9rNR3OHxqYOguGXtKdaA2S3awxHka556ZKFZOvekzd/Nb9xL5/tfL2alwo0Urwes
         CSussKrKtdkN4D/0N+6dtGWgy3OIRASlpQ6dIEYV8ostMYaxVhe660GC8N/WkW9W9jOs
         9ZFRaRpIuou9izPzLv4GjQMU5YYhplkDiq7RaALHRNQuT428/zWdEgB3MrxKX41A9m+Z
         CWOmA56SMFOBxYsIyHf6Y6ZSAr8aICUkCRM/fn8QHYU9pUlxqo+p9+dCQ051z4vIoGQj
         SB1w==
X-Gm-Message-State: APjAAAXvyCTsSFSdTSyryee0aPd9YXpvfE3k1H9Od5jvczDMuNaZWyDM
        U+3eDFzScixMe+kUqGkgOAVLsvrOQIEWo0wIyUE=
X-Google-Smtp-Source: APXvYqwVkUT1PCQXZq3AwPelP4rt1tzMY1P1LcvQsvjtIjq/pLuPEAddIf+GoWC3unHIX7yoH6yq/Q3oFQRYfz9VfYg=
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr10724673pjb.30.1559724200329;
 Wed, 05 Jun 2019 01:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190602163541.8842-1-benniciemanuel78@gmail.com>
In-Reply-To: <20190602163541.8842-1-benniciemanuel78@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jun 2019 11:43:09 +0300
Message-ID: <CAHp75VdMQcZNgv9Tri7UY+wUOy4uUk4yMXYLaBQBBA88iysLFg@mail.gmail.com>
Subject: Re: [PATCH v2] pci: hotplug: ibmphp: Remove superfluous debug message
To:     benniciemanuel78@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joe Perches <joe@perches.com>, Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 7:35 PM Emanuel Bennici
<benniciemanuel78@gmail.com> wrote:
>
> The 'Exit' Debug message is superfluous ftrace can be used instead.
>

When reviewer gives you a comment in one entry, your job is to check
your entire series and address the same comment in other places.
There are many such unneeded debug messages.

-- 
With Best Regards,
Andy Shevchenko
