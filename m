Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5694CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244572067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYYEoLWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfLLOag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:30:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34623 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfLLOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:30:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id cx19so1991890edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gju3EUlngyusbKeS6vFaR/4XTTpuzfrnNm7m53rjtdE=;
        b=dYYEoLWjGK9W8p+yiUutI7BGeeIKV0/RdjN3Gt84kx/qrI6+quYm+R4q7R8KgzYRfH
         1YYFyXMrK/6dBqERMsYUHg8Mj8/T7gZ0o6JWCPYKsSGitnJjbJnrhF3FkGY7JKqBleNX
         0i0MJ98ZFiAN8IHuTzkUOindwOq78aDHnU5mHGQMKRjpIJwnH3XB4yCiNfz8qhLNzZfq
         +g9FZKv0XXtcdb4V7dPsHAbg6duaE1XAOuZy4Kwqg2s26QSvBnk84uvdkK7GmDvMf6rR
         a3Wo6xPBGcQWrizvKDoM8qRe8u3DFM3ZjVAY40JirvimWtuJ0NNiv8pif5P34SQ0NPtk
         lJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gju3EUlngyusbKeS6vFaR/4XTTpuzfrnNm7m53rjtdE=;
        b=gyaC3gSUc4mhsJG2JL5Tj2+3DhRHZMa47FlK98U7YTnDwFnyfWjWiW3R0emxtRb0YD
         ieMVEydh30Z7n1+1wvcvilQMdIWlbPaz7jEkgo0TadBC9LLIt7TqcSS5nSO2Xi2/gFEM
         7HX/Nsp1tSfT24X5Ps/oRs046BNzZCf/OqL/KHwD3Od3Q40G3YFNpA8cDvXptRtawYvZ
         Irhpj8pPWIn81uTJij8cohf9nR6yk/xz+QmbaSw+1BE/F8wnNMaAj8uTv91TxQWRh6PC
         PCZhoyOGnvfUNV3MgCA19s0l1jRWKQIdF3Ui7FLHbjJVkOeunxTcdvAca/vFJIHqiFdK
         wL+g==
X-Gm-Message-State: APjAAAVBw7vw6qZj4VwUreUO6qENowVl+AoWzFa5e8ftINl9KsDELn/Z
        TAy2WgA/V19VFAxNzXIDlVxJ7Tmey3tl7YheCM8=
X-Google-Smtp-Source: APXvYqyDquDIo8nbaHLUJu1exvNn+kbIwh+mgg1HZJLsQFgkicoo5nX7ziPVSDABLQOaC+QsFVSUBhIfu0aJymKr07s=
X-Received: by 2002:a05:6402:28d:: with SMTP id l13mr9402518edv.236.1576161034659;
 Thu, 12 Dec 2019 06:30:34 -0800 (PST)
MIME-Version: 1.0
References: <CAFqpmVJ90bAV4vasH1Z0DcTUjT7asCJFPeJBxtxGZwAhTVP7=w@mail.gmail.com>
 <b02d053f-1b07-bd4f-20fc-9a26106145d1@suse.com> <CAFqpmVLnHPUZEpvmw1-f=2LoPkfUHO67ETdwtnsPA7DsXRSRSA@mail.gmail.com>
 <7feb44ef-0957-3df1-3411-2a7b971d8931@suse.com>
In-Reply-To: <7feb44ef-0957-3df1-3411-2a7b971d8931@suse.com>
From:   Nicholas Tsirakis <niko.tsirakis@gmail.com>
Date:   Thu, 12 Dec 2019 09:30:23 -0500
Message-ID: <CAFqpmV+UZo91+TXD+wqnZ88bn5km3uPoBf0rz=56aSCp9a3iBA@mail.gmail.com>
Subject: Re: [BUG] Xen-ballooned memory never returned to domain after partial-free
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        boris.ostrovsky@oracle.com
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Do you happen to know the answer to my second question? It's not as impo=
rtant,
>> but it does confuse me as I wouldn't expect the total memory to be
>> balloon-able at
>> all with the hotplugging configs disabled.

> Ballooning !=3D hotplugging memory
>
> With memory hotplug you can add (or - in theory - remove) memory to the
> kernel it didn't know about before.
>
> With ballooning you just give some memory back to the hypervisor, but
> kernel still has some knowledge about it (e.g. keeps struct page for
> each ballooned memory page).

Got it, thanks for that clarification and for all your help!

--Niko

On Thu, Dec 12, 2019 at 9:21 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wro=
te:
>
> On 12.12.19 15:10, Nicholas Tsirakis wrote:
> >> And I think this is the problem. We want here:
> >>
> >>      balloon_stats.target_pages =3D balloon_stats.current_pages +
> >>                                   balloon_stats.target_unpopulated;
> >
> > Ahh I knew I was missing something. Tested the patch, works great! "Rep=
orted by"
> > is fine with me.
>
> Thanks.
>
> >
> > Do you happen to know the answer to my second question? It's not as imp=
ortant,
> > but it does confuse me as I wouldn't expect the total memory to be
> > balloon-able at
> > all with the hotplugging configs disabled.
>
> Ballooning !=3D hotplugging memory
>
> With memory hotplug you can add (or - in theory - remove) memory to the
> kernel it didn't know about before.
>
> With ballooning you just give some memory back to the hypervisor, but
> kernel still has some knowledge about it (e.g. keeps struct page for
> each ballooned memory page).
>
> HTH, Juergen
