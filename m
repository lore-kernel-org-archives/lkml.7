Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFF32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG6fkSgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF1R1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:27:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34446 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1R1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:27:04 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so14206997iot.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+U2gVHuaG0DVSq5b6nRpN6PYUhH5sGkmtGK3vlqF0no=;
        b=rG6fkSgEnU28dFl5tvTe0OYhgni9ymXBRnbhFDA280dPO8dL5yehTJw0wND4Aowd+D
         i51l5RorHBeqUXdT6YWGIJUHNvQMBVoKYxmgMue4v7MswL05eQUmWaijgFndc2WhbJfZ
         AgW94AKVWoSvksOPGdlyx73iQmCo6bpF94BxFv5D5w0n/1aMzY9+9ClHGRmPFN9fouqn
         hkk0S/DJod3PdvFVQJ0qWyNpOdBVhE3fKyeRMOHMJ480A+TIaPgcc3/4y1w99drS+oGL
         DrXikfBUg5zfO4ZlEUCurmsp3aIivGx8wrGZX5h669e6IdwA69X6ILLVq0g4KSO6n4Np
         KrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+U2gVHuaG0DVSq5b6nRpN6PYUhH5sGkmtGK3vlqF0no=;
        b=oHpWe5GPhG8Mx0i7qRNTNKMYX+YTs+XfN8G0zlGDPT/QnMAsxkneyNfvRbqgL/54T7
         uNRXd68LU4ZsEqvdhiKGsATdjPvGERjOsFFIoFvJ0Rtikuf66lFm0JpRG4a0Ux1mD+K7
         B5wrMrawAONhTtJ0aRjYnjSMCeRCvdm9GMxq4R1lsMZGDLDz1k7W1Y9lH4TbGIE90P9w
         mepMzJgCF+nukKns1xdzd33GTfMTmiW4PzRcVSNKsDqgh4DQfBTSzDdSEXwQcne/7WzI
         BmPed6ctvJ+baE745+E6ICvJwT2CLdNmtcnUrn+mAjS9yLp/un1/kW8vYg6f9pkBfJ20
         reTA==
X-Gm-Message-State: APjAAAVS1rNI9kOPPRHqN/usIyV6Dfw+Jhr+0fKfuKvmKqYT8LFAqprX
        t38j7AMxUS0AMC+UzUaUXkokZWIgpA2ml7EP9P0=
X-Google-Smtp-Source: APXvYqz/NJ6C1b17UyuzgifBeHM9CIvNWgXjeEEmX5QQDv15GV2L0o0m3AFNHfI1Inbht6zK2Nl4j41DG2NcYc6BgJk=
X-Received: by 2002:a02:1087:: with SMTP id 129mr13381904jay.131.1561742823398;
 Fri, 28 Jun 2019 10:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190628170046.3219-1-harshjain32@gmail.com>
In-Reply-To: <20190628170046.3219-1-harshjain32@gmail.com>
From:   harsh jain <harshjain32@gmail.com>
Date:   Fri, 28 Jun 2019 22:56:51 +0530
Message-ID: <CAKuL1XSOux9+ff1OQyT3Q5hY+CZ1a_s+zDLUh7cgzCv_E92HhQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] staging:kpc2000:Fix integer as null pointer warning
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, harsh jain <harshjain32@gmail.com>,
        harshjain.prof@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:31 PM Harsh Jain <harshjain32@gmail.com> wrote:
>
> From: root <harshjain32@gmail.com>
Again sent with wrong user. Please ignore this series. Will send the
updated one.
>
> It fixes sparse warning in kpc2000 driver.
>
> Harsh Jain (2):
>   staging:kpc2000:Fix symbol not declared warning
>   staging:kpc2000:Fix integer as null pointer warning
>
>  drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>
