Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E68C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD209208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HwzQ0rH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbfFMPsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:48:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34632 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbfFMPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:48:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id y198so15500074lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MhxG2VWV0PUqNmkC6UYengHNix8YULmmoQX86iMuI1Q=;
        b=HwzQ0rH3HntP0X1Ut+3aziFTUNyu7eZWshFffAcbuEQadz4P6sC2snoDJGp4KSyvu2
         Kig7hRqtroYC7jNl67KKgqHxE423RPSnEeZfbHsd+gLto0eo7V3yt/GGwc+21qgO0c3A
         GIH+62EGfN0eHFV/TMnqz5oJqV2MDDVZaYpN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MhxG2VWV0PUqNmkC6UYengHNix8YULmmoQX86iMuI1Q=;
        b=gDBrR19XXVYiDcu/XfU1lSeFb+vmaNE5v85NVkD4sAarO0quEWGv2OIyUFGhVRsMoB
         R7XG03HqwE+fAtAwXma9i5HgRAatx4xRpie9kpgaiUNQeGo/quOanj8YMwzDIV+jMoOa
         evaawVB6DkSAdX5U9lxgsPAmMJP65ScxNOkQ3+jQ3mRiEACfH/s/x+M0sqS7D3WRwa3o
         toy+91tHFTk5BGVyHWGE3rFuaFHq4hmW5x7LTrg4uZp7nOULOIFSg/eB8v/zeiyJHDff
         qd1qEomaEsHisYAd0Ab3kD4sOMHkoh5JJzClwILxLgIqiBNFbomxk8O8cEm1G9QHgfrO
         7OmQ==
X-Gm-Message-State: APjAAAXWCQ5fsc0m3s/3tQ+Z3SdffuJy+oiLmcSJLlmgQ7ON92PGl9Lu
        MD3PDL0YmjCMVUeKNMR8latoGTVghoJX20glTsXd+g==
X-Google-Smtp-Source: APXvYqzrRigc/QwtHv0h+SK0yPrIqLoP/sTRt4T7cb0mR/3kmBMhY1s0fNVfrmh2vHW4vI1uCiYqipwR2/fMUdkpn8I=
X-Received: by 2002:a19:c383:: with SMTP id t125mr38852030lff.89.1560440880394;
 Thu, 13 Jun 2019 08:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190613112709.7215-1-afabre@cloudflare.com> <20190613154152.GA9636@mini-arch>
In-Reply-To: <20190613154152.GA9636@mini-arch>
From:   Arthur Fabre <afabre@cloudflare.com>
Date:   Thu, 13 Jun 2019 16:47:49 +0100
Message-ID: <CAOn4ftu8dv4rOei=Janw8bRMGLM5bganNGjp3nLUof82Z9vSiQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: selftests: Fix warning in flow_dissector
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah yes good catch. I guess it hasn't made it into bpf-next yet.

On Thu, Jun 13, 2019 at 4:41 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 06/13, Arthur Fabre wrote:
> > Building the userspace part of the flow_dissector resulted in:
> >
> > prog_tests/flow_dissector.c: In function =E2=80=98tx_tap=E2=80=99:
> > prog_tests/flow_dissector.c:176:9: warning: implicit declaration
> > of function =E2=80=98writev=E2=80=99; did you mean =E2=80=98write=E2=80=
=99? [-Wimplicit-function-declaration]
> >   return writev(fd, iov, ARRAY_SIZE(iov));
> >          ^~~~~~
> >          write
> >
> > Include <sys/uio.h> to fix this.
> Wasn't it fixed already?
>
> See
> https://lore.kernel.org/netdev/20190528190218.GA6950@ip-172-31-44-144.us-=
west-2.compute.internal/
>
> > Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/=
tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > index fbd1d88a6095..c938283ac232 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > @@ -3,6 +3,7 @@
> >  #include <error.h>
> >  #include <linux/if.h>
> >  #include <linux/if_tun.h>
> > +#include <sys/uio.h>
> >
> >  #define CHECK_FLOW_KEYS(desc, got, expected)                         \
> >       CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) !=3D 0,          =
 \
> > --
> > 2.20.1
> >
