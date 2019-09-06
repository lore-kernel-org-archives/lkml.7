Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F206C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AD720842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YXvpaoqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394886AbfIFPmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:42:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37864 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390317AbfIFPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:42:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id i1so6713494edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7CpqJIrowSUHG+Dch68wvi3kLH0yuCv0IJ23idpZx0=;
        b=YXvpaoqMtouskhiUthoVXPDwKUE0Kz84re4KCST1uCTAdZjSEPNsCxH3wZatPhfpAw
         CglvxirjKsFI5Yaogq+8Ur9COKORkUDCdZBoiH2khsNLfib9n6ch/6NaZBqtk841aAnl
         ozo71ho8eyrOMjQ8i2QLUDxeMChNm4iPTNqqGriW7BgshzdhNnDzVrR9LB77Vlua9nQa
         fSy1556Hyav/y2lp862IG9hXSaRGsJvWVxnFEpaev+aNCrLuZV8Oi+N9IY/txQmMvXPy
         ncjCg4DJh1LDJlanwQwRvadO7ctDS66Q74Yg250aQFjMHJ5ZldxRx3JoU2pkerbWZTki
         DhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7CpqJIrowSUHG+Dch68wvi3kLH0yuCv0IJ23idpZx0=;
        b=cL4NbWp9A7zsi9T4N+5D2wZFw4oMEZU8j+3vdyrI1s5fUuUKZf3GnVyIQzP5W14yQ6
         2TqETVvMAPxUfM99n/ymtbMA/7BBYrC/DGoA2Z9kfKlQvVROdDyvhnJYKn+yMmrsB0L6
         K1XpWRZrQCzav1rA6h9iQVqKAQH3PVSKHcMYeqWCME7WGnXOAKg2wdbEELXqkYIRfc4K
         MIxS8Inm91T3EZp7GWjQgmLMIvjSjPLz9ktySuzVIGrdIGAAR4xL5AHoQ85rXV74kZBW
         vTG0EZED/tq7h2xhYekO7AA/lAwjHRShKMUfPZuR9NcB3rL58hg7PNlaeJdaYSD1WYdz
         sFEw==
X-Gm-Message-State: APjAAAUShtZ3FDoeTSltRAjrsZezPkQhQ+y9AFVeb0jnkiaCs9u5UZSO
        2AYUFTT4oFvMXCNqat2kzSBxY6smPVCE9DNyGnT+lA==
X-Google-Smtp-Source: APXvYqxdjX49MkF9aNw2e1jsftF5aJXCE4yDWZCKUgUZ6wavoi1VTf853eLT2XTzHK8gYqwDuQeOUszbmnukR+qEv0k=
X-Received: by 2002:a05:6402:17ae:: with SMTP id j14mr10239541edy.219.1567784527097;
 Fri, 06 Sep 2019 08:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-4-pasha.tatashin@soleen.com> <99aba737-a959-e352-74d8-a2aff3ae5a88@arm.com>
In-Reply-To: <99aba737-a959-e352-74d8-a2aff3ae5a88@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 11:41:56 -0400
Message-ID: <CA+CK2bDj18EkjznFg7rbSSEtDDRpTioyrWfu+EWChH=8zktrNw@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] arm64, hibernate: remove gotos in create_safe_exec_page
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:17 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Usually, gotos are used to handle cleanup after exception, but
> > in case of create_safe_exec_page there are no clean-ups. So,
> > simply return the errors directly.
>
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you.

Pasha
