Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F3FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D0220674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5YNkYk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfKHTSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:18:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39078 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbfKHTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id a11so8240967wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q0460TgzgnaZLvm1IV8VLVUyZ7xHs8aC72SXVYWvcVU=;
        b=K5YNkYk1UQ4vtj9aLjQOleIjNFwGE4P2DPtHyOJKrm0VgEBuu1FvF13NT7V6HiWCsP
         2u7A8KRacDJqAIeW1V9A/AKGyW3tacYFM4tF+E8y+VrHe1LrIeGifRm2kZvDP9ShD1xk
         MSn9TeRoGe9QjWqJAovsmJOxKrpscIvIuP7pHGloR+7Ewb9aGj8swRsEYVzKKcV+0Qk7
         h7QbtOR1ZxrblMnDQ+DR2f8eSTdXOl9q2CoIfpnLlQ4yMKNtrjw4W4+F28N0cwvSfgwf
         zO/DiJFBfOQjQzmDvNzJq6tnQqw/F5wbcJLgqLPncsZZvPU5Llar08p05tequHk9kSyr
         Yrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q0460TgzgnaZLvm1IV8VLVUyZ7xHs8aC72SXVYWvcVU=;
        b=FJNLaIYmSAi/9xH7CvLLhZevm5mi9MewI+7crxfoq/JEeGpaVC3ZahOmIle/aADHj3
         9tO6B00l3D3YIXfV+J21GQMmRJgpSSglaLvyYw9xRK3SEmEG0B9qrrhJp3fONBDgfI7/
         rJ3GIUZ4ywsk7jNevHdwaUik1tBlI1Vo5f5nmSFA6gZ0oAB2/lmcApj35bg9SkkNcR1S
         knv/CyFKxiYFD/dmrrY24SawDhchloieVmFGsKyGZ9kF92uT3yDw5NfI6TJY5gribOq7
         oxBf84MKOjHykqOe/cCgC9ia6eUTfoGVniJqw6xyuah/O+yf7eSXtwrUkQ7srNoONG3b
         TPdQ==
X-Gm-Message-State: APjAAAWwZYL8oq+Kx6tG8Y4G3RnSyVfTGCYv/wOcz74FUvCx7a3szjGc
        m4dXcJ9qRw3nHy5fqYfrvApYMgsGgcBjvlFulCecNg==
X-Google-Smtp-Source: APXvYqxjvSn3tePuyqDvQ6GTaS29yRgNed6/yx0spNQiJlJgU2nkcHKd2TvCuJggSLkyrxxhA+C8KKXP8Qjt6n+6A/g=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr2543917wra.246.1573239611844;
 Fri, 08 Nov 2019 11:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20191107132755.8517-1-jonas@norrbonn.se> <CAF2d9jjteagJGmt64mNFH-pFmGg_eM8_NNBrDtROcaVKhcNkRQ@mail.gmail.com>
 <d34174c2-a4d4-b3da-ded5-dcb97a89c80c@gmail.com> <229cdce6-f510-5d9f-401b-69bad4af0722@norrbonn.se>
In-Reply-To: <229cdce6-f510-5d9f-401b-69bad4af0722@norrbonn.se>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Fri, 8 Nov 2019 10:59:55 -0800
Message-ID: <CAF2d9jg01+AjBHJtMMpzdqV1iyGd-vZzVS96nmGmcVJLK82D3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add namespace awareness to Netlink methods
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     David Ahern <dsahern@gmail.com>, nicolas.dichtel@6wind.com,
        linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:36 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>
>
>
> On 07/11/2019 22:11, David Ahern wrote:
> > On 11/7/19 1:40 PM, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=E0=A4=
=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0) wrote:
> >> On Thu, Nov 7, 2019 at 5:30 AM Jonas Bonn <jonas@norrbonn.se> wrote:
> >>>
> >>> Changed in v3:
> >>> - added patch 6 for setting IPv6 address outside current namespace
> >>> - address checkpatch warnings
> >>> - address comment from Nicolas
> >>>
> >>> Changed in v2:
> >>> - address comment from Nicolas
> >>> - add accumulated ACK's
> >>>
> >>> Currently, Netlink has partial support for acting outside of the curr=
ent
> >>> namespace.  It appears that the intention was to extend this to all t=
he
> >>> methods eventually, but it hasn't been done to date.
> >>>
> >>> With this series RTM_SETLINK, RTM_NEWLINK, RTM_NEWADDR, and RTM_NEWNS=
ID
> >>> are extended to respect the selection of the namespace to work in.
> >>>
> >> This is nice, is there a plan to update userspace commands using this?
> >
> > I'm hoping for an iproute2 update and test cases to validate the change=
s.
> >
>
> I'm looking into it.  The change to iproute2 to support
> (namespace,index) pairs instead of just (index) to identify interfaces
> looks to be invasive.  The rest of it looks like trivial changes.
>
> I've got all these kernel patches tested against my own "namespace aware
> network manager" that I'm writing for a customer with a particular use
> case.  iproute2 wasn't actually in play here.
>
I'll echo David's comment for iproute2 as well as tests to ensure this
new behavior is usable and healthy.

> /Jonas
