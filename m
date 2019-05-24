Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A43EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FC92133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBAlcfSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfEXEWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:22:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45367 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEXEWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:22:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id r76so1946677lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGL1sUb7/SuZO1SlzbuvddIsg4e01QlpVj8IoIDWPcU=;
        b=UBAlcfSjXrc1BmmoSl/BpT7znIVVgca/OTtGj7uFEdWgWKXisgB5nm9kbAq2ev+bZJ
         PU19mTIMTQuBToniOp0HTiX47NFpuXj43WH3JPO9xS7koRQELufUSr0/Hn7MUgWS9y9s
         lkERyikOGn5C+ckUL3VyjYoTWnD/Yj6f60gk91Htjll6kz1cQsSOnqM8V1M+CzFZEA0Z
         Wf+BJ25vuJaBVQqALcerHH4xfNRzT7yX/4jOSXEqPzCY8DSya4JS97r09w10GcFu4xUC
         m/r+80h5rjYoLoXOQdxdYj9GxUAs6XkgPIRZdBU1OZ/jqB0CBAyZoj3W3S389Z0dPEOT
         uJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGL1sUb7/SuZO1SlzbuvddIsg4e01QlpVj8IoIDWPcU=;
        b=ZwdKYqQ1NTVJd49/Fo+dl01+UxhSfETQTewP2/je7bQFINM1MW38qjCqgmP9Hc5OVp
         TyrgBBvB9UetGOqrFcoweZOYmZPWGvVVxabnOh9pbgVZAZIVDoOQasE3favwidAotxdJ
         4PO03LWOjmVsCA40ogXBcwToYrTyUKlixqP7UngI8Qxld5ugQjKOi2ZOug9V0xXFknaw
         Q6ySB0xiK3wLAnio1BlKJs8m2N2Lg2CeSjHJTlAEFMSgOO1+I9IEsXqOEK6Ew3skaRVQ
         O7fTZBG5u98npylSvDj0TD6uwMOsSpchbbc8iCQ70pnXP95CmjdTk1HnBTxoeUR+xCD+
         fvTQ==
X-Gm-Message-State: APjAAAVPWspYmQbt1prAaiYv3XPEDc3pL/yYLdG6mzbUN1xkwi9/TJS9
        a8wa2B77I9TdGz3m+xXUS0oVjyWU+yjMJDGfeVk=
X-Google-Smtp-Source: APXvYqwzDLRRRE2P7KD7yqq6nNT8Ce6dupM5dCxFDJQ85kS/YOIjPuAbTC6ICOLmTpwNLfYRgOR20lJinQ6CkvwHi+s=
X-Received: by 2002:a2e:1412:: with SMTP id u18mr16589988ljd.197.1558671733368;
 Thu, 23 May 2019 21:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
 <20190521085547.58e1650c@erd987> <CAFqt6zZA32QA-6VtaKcrEtq=qkoGLHpirSvXb5wt7-wd_-74hQ@mail.gmail.com>
 <CANiq72nd5i4ADU1GbEt1Dkhp-5YkC9ip-h4a0G64oN+b95wAXA@mail.gmail.com>
In-Reply-To: <CANiq72nd5i4ADU1GbEt1Dkhp-5YkC9ip-h4a0G64oN+b95wAXA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 24 May 2019 06:22:02 +0200
Message-ID: <CANiq72=zCD7AAE-OBzDYm5GXenoF48SdzwO1LunWSfexqBuH7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 2:58 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Taking a quick look now, by the way, why does vm_map_pages_zero() (and
> __vm_map_pages() etc.) get a pointer to an array instead of a pointer
> to the first element?

Also, in __vm_map_pages(), semantically w.r.t. to the comment,
shouldn't the first check test for equality too? (i.e. for vm_pgoff ==
num)? (even if such case fails in the second test anyway).

Cheers,
Miguel
