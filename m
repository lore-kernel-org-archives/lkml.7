Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C11C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844632082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558024489;
	bh=izY+l2CD6SU1vbBh1/uJxrtHdUXDvZHRNoX5WAAdtAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pZYp5+8W4E6VsPsohdvomAyKMaaQodqaqNsqfNQKNT47g8wmi2NHAvXY2pXp1FOXj
	 n++aUD1jkdE0/x53pNofMY4+oIVX3DmF7MbeF42g+9TNCmjKfPgPrvZI8RUWUviMMd
	 WF7CDFqfBR/9lUhbtCOPvDSy9a84x1NA7l1fcMnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfEPQes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:34:48 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:37435 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfEPQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:34:48 -0400
Received: by mail-lf1-f43.google.com with SMTP id q17so3161310lfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2G+ucNXk+a8RoYT1Q6cNvma1OaS/tE8RkAEZ52Ybr0=;
        b=RHvocOwMezWRuwXjkeQyqPOz7V85LuU4kf4GZIcx3YDeanv2gC5xc/YWHPDppP3mMK
         0o8f77KTwbYj1ez/Dv3hX7PwNwxA4Re2Ar8kXNUWBg9Qztvw/IYBGP9KPP2vmFVDTgQA
         Yn+09uK8xNOkI08IbEt2zgWt62ZgyojL/3l/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2G+ucNXk+a8RoYT1Q6cNvma1OaS/tE8RkAEZ52Ybr0=;
        b=AG4vEM450No23XMeHVOsARvWekfGAMPmu4L2Q6HClCqg9GesfQi4QEKp/sVIz8h8+Y
         F4Eji5tgkou9JDQ44LkR1K41ypOqUoFKi2NcvPTPY8Yn5PvzjLdk4WTb5sqmVwkSu+l3
         5dCnqIpaztq31mSYkdYKn1nD7auxdXNzOy3DCugc0b4E+d0LJFVpXXS9yv0MpjNrAgTP
         Fss5y6x1nXJ/y9OY95fyF2uTgu6zJx7M1PM8Ii3VTsBPoA64PxjkyzjLB76IDcr5UCSx
         2+nvHpVu+uPMRrPWMngj5phefoKb3t5XtlDrYOQVp4DvMbLZCDDMy+ocVAY8tXnmaaYT
         lUuw==
X-Gm-Message-State: APjAAAUotmdFGImICxjx/YCwh83YpKeoI4Krk1B3KZGRQ+PNZ+F6uiPT
        6nHxsFDQxUbAJK3vTEGs3NmA8p/NWZk=
X-Google-Smtp-Source: APXvYqyLl7+6XXHSH+Q/QuePC1eNU3pFTcsg5647MEDRV9Wq+ByOvumrjG8uf2SX16nzOogtI5oMPA==
X-Received: by 2002:ac2:424b:: with SMTP id m11mr10567335lfl.71.1558024485620;
        Thu, 16 May 2019 09:34:45 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d18sm1025719lfl.95.2019.05.16.09.34.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:34:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id n134so3119805lfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:34:44 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr24250454lfg.88.1558024484401;
 Thu, 16 May 2019 09:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190516064304.24057-1-olof@lixom.net> <20190516064304.24057-2-olof@lixom.net>
 <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com> <aad06de6-b85c-b549-5653-45f9c4ebb384@free.fr>
In-Reply-To: <aad06de6-b85c-b549-5653-45f9c4ebb384@free.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 09:34:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZFNMJCgs5a2hG=6gZxs0+xc_A7jXsS+EJfAi8h9W6Rw@mail.gmail.com>
Message-ID: <CAHk-=wgZFNMJCgs5a2hG=6gZxs0+xc_A7jXsS+EJfAi8h9W6Rw@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm-soc <arm@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:00 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> Your email client did something strange by changing
>
>         linux-arm-kernel@lists.infradead.org
> to
>         "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
>
> which is odd  ;-)

Heh. Indeed.

What seems to have happened is that somebody long ago sent an email
with a missing comma (so "linux-alpha@vger.kernel.org
<linux-arm-kernel@lists.infradead.org>" - *intending* to send to both,
but ending up with the linux-alpha list being the "name" for the
linux-arm one).

And then I replied to that email, and it got picked up as my automatic
contact. So when I replied to linux-arm-kernel@lists.infradead.org,
and it had no name, my automatic contacts helpfully filled in that
bogus name for that list ;)

I will fix.

I note that because *you* had added the right name for the list, this
reply didn't even try to use that bogus contact name.

                 Linus
