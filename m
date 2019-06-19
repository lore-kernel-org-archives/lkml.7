Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44F7C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 22:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AA72085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 22:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6WWNTDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfFSWsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 18:48:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36116 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfFSWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 18:48:36 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so36776ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YKJaoMjaF4vCZqPi8dwckcEgHtOWdNYvU090tpibj0w=;
        b=d6WWNTDf8BwpcDeLK3CHrloIi8s3+6D20pkxtkx0tfHOzYzHxUI6l1c1+/LNMs30sM
         BMoSj2tz2++N/8yJG1frilcp+5jbpEvCMOhUNiSdjIaB9yxbr+UO33vHSgypay0UfOhi
         Akil9xVSqel1xTCQ4z11nvl3JpSCjY2nZZtKPRabomxyQWdVOczgB+u+evqwqvTekzlT
         7CcmYKsjG5BewmhtbtVRS1jKryf4TZHc8v0FmbPQ9rAXmEuK8zjbvTCi+lB6n2kUt45z
         0I6TQbCHrUNoR5C3o5YvtxgW4P36jHKWnGvCb01DQFWtUWUI/YyQyNWXVuYoliIbAWgw
         8zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YKJaoMjaF4vCZqPi8dwckcEgHtOWdNYvU090tpibj0w=;
        b=AJOFSLECmaGH+EKaZlfGOlk/z+/ONphuaJrt4JvQk8h6zIj4oZpcIBgbj84p3dt9h3
         BMZvPZjcSGX4+00qUyA54zAkVDTPPNPxGvNS3s2w54Bq77Aa8vlZ9bx32B0QnnVKpbP6
         6q4iQlREPYwsSuVmswlo1dYJ/F6MlxMVMtBm5332Ry3fmmOiliKiDYUl1/iMn7RrZguK
         RZrFKYWofBvpA0WabEcVQ85diHyloRzdch1ez6ve22zPsOD1vGqehtrp5J2VynrYa1D/
         FUBhi/HiiTXTFCGj30XIKKybmshoKHrf5mjGBybiO6+yTMj5Jo4orPEo1YQYgia/Ma3x
         yIXQ==
X-Gm-Message-State: APjAAAV1jC4/dSSDhWVoqqeVG9LA2sNlc25eO/Wb/dZyQOxCzI8OPSj8
        IRy/KMwWcKOGhMO5w3ssN7oqrxI5cOsld0An72bhkg==
X-Google-Smtp-Source: APXvYqw4FrufMrwsWG20g5Vc8KSbXAfu2/rJlkScfVMpc4fL31bGQq9hagdM9w9y1ld98AaKyaZC78IP96NTZbSLwSY=
X-Received: by 2002:a02:cc6c:: with SMTP id j12mr12111505jaq.102.1560984514733;
 Wed, 19 Jun 2019 15:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190615040210.GA9112@hari-Inspiron-1545> <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 19 Jun 2019 15:48:23 -0700
Message-ID: <CACdnJuudmE-MNuO7z87Mm65VaXbRzhOrBEpU5F=yC67uSLytGQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        tpmdd-devel@lists.sourceforge.net,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 2:55 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> (+ Jarkko, tpmdd, Matthew)
>
> On Sat, 15 Jun 2019 at 06:02, Hariprasad Kelam
> <hariprasad.kelam@gmail.com> wrote:
> >
> > This patch fixes below warning
> >
> > drivers/firmware/efi/tpm.c:78:38: warning: passing argument 1 of
> > =E2=80=98tpm2_calc_event_log_size=E2=80=99 makes pointer from integer w=
ithout a cast
> > [-Wint-conversion]
> >
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>
> I think we already have a fix queued for this, no?

It looks like I fixed this in "Don't duplicate events from the final
event log in the TCG2 log" rather than a separate patch - I'm fine
merging this, based on Jarkko's preferences.
