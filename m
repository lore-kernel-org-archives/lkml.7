Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17BCC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4CE21670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6+PYlkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfEAOhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:37:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39288 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEAOhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:37:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id o39so3654860ota.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeNawWVBAySPb9PDlZKwYFSNGyoNGUr1GIrZtBOZHwE=;
        b=W6+PYlkMPJHz0yB1KJTSgTz43TMM4saV68HGbJbXDY0sKCSjZpKqfbag63PHUxXT4j
         y9jjjepBKDyN8HH89wXIlTQJ4dgAciZbAEhiu/ycDGsHIV0RDTVktQHwX7pRqto/HIA1
         EWhQEfwJdAxKsw97tKEsEI2kIxlSYmfcNtJdYRSVCei6bcyI2zaGbYpyCWKOgZwq+uHA
         KlGFNTVAxTlrKCfZxElihlpCAiTe6ihDbdyZf3kjmuMoFEDLmG1+PYsn1BnSji3tY3VL
         ugcW1al6YyHyrBKe6Wuj7Ojb1gv66lNKfkKvSxLGJpeA0w8chmBDiJRcvnU0C7HXaDAH
         9ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeNawWVBAySPb9PDlZKwYFSNGyoNGUr1GIrZtBOZHwE=;
        b=oPj03rKcnG2YxU+p5e6pbMDiO94P9SPFm5ieDPMb/f9n9b8eWmcAsY2+nwQPsqnYrm
         779a3bTNnnchzm2U3BGd1hMr8kiAq3uEtcQcR1WuuB1qSILU8w61xwEseuI9xiXHw1bi
         MlfLjGR2AF3rGBCnxmYzolL+qL+aVa53b/BY3XoobsnkNcldwbsoPZ+0X9O+AHm+OkwU
         4MU842m1ofSFbFqOjj6+o0l3ae7C+yhJGEq1Xit7RmT3ynbAYiTghnaGg6qYhHM2+PFh
         mHHOuuT3lbHKTPUi17SP0oyNXXWwi7Q+Fb739fdt8o4rUxH9K/+E6/znMUSwWDuAr48l
         ZooA==
X-Gm-Message-State: APjAAAVG5thaZOzrKtD1oCajvOEE2++sNeHlTRR5/hfKvk2QOXPIPTPq
        kqgWcN2IsmfAmfO9WvzQQP+ggSk0+5bzx4ZVs20=
X-Google-Smtp-Source: APXvYqxUPcBihXr+kVa92SD3B7QipRcrz8gjMtl76VPv4sjk/YqbN4YdwpCOihv0kXUK0oSdzfMFoibXinHK/tOaEsE=
X-Received: by 2002:a9d:7319:: with SMTP id e25mr2089734otk.279.1556721456085;
 Wed, 01 May 2019 07:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190501143543.7586-1-TheSven73@gmail.com>
In-Reply-To: <20190501143543.7586-1-TheSven73@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 1 May 2019 10:37:25 -0400
Message-ID: <CAGngYiUSmDw8PH0Qy25Pk7dW0-tKdkZbLmBDdp-tTMJdsZTXww@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybus-s: fix wait_for_completion_timeout
 return handling
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 10:35 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Reviewed-by: Sven Van Asbroeck <TheSven73@googlemail.com>

Ouch, this isn't right. I'll re-send the patch. Sorry.
