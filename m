Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D123C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFBC20673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0RVeHL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfFKLmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 07:42:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42457 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfFKLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:42:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so14025111qtk.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vjOFdAaYDNmN3A5HT5pM3yHGhYnwl0N9Oc3jefh1rW8=;
        b=j0RVeHL8Khr0VlnuhcwdE+nOiCX1mQmd+StNdZEDBY8zoM8siTM15NLmIqnGoq0BS9
         o57ljDhdsozst5Nsd2nvSvCCF+Lrmqe2Ma7mb7oFFjhr3YR/IVqIHkk19zhD8iFSXM5U
         D1U4gng45f/WObLDk3TqJWH0lh77UMzGs0GRkDHNoJoYYONO8a726f/X8xB8tatszpu8
         O7Q0FPE1uMJl39ybF22UNV1YvvuXKBXYXjSwdCk2Z6jqqy3McW1C8pcXi0KGWJ9Jo2HR
         kBVIesagSyMrHP8WEO/Zn9/YlrGVbK3NlZGaWjnPwvnIw1MnVOpUDhx4G6gvNCk7gvQ3
         qq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vjOFdAaYDNmN3A5HT5pM3yHGhYnwl0N9Oc3jefh1rW8=;
        b=t4YRZ8PXwz7unmGuNX6bRkbdpSCfRLvT2htQGPYolJlkTpW4OM89Z/tw4fESlFhKE1
         et1GV5Iih3NKnGazVaWbCavLxJNzVE2zD92SqfLzFSgzd1eUDT7UFx3c8OUuH4YtXTsD
         PQwQjPp+GWRypiZi+5SwpkyOydGmKuVWlRJbZNdsgzPdOmtdLDbW8e5ESQh9eZcI1Md0
         /ezR1GPb1jwjzpfSdtxQejwm1zmlbxuiLQniBIPt3Z5u1odryed6pb86AahprJU8AjT/
         IG71yNGOuzFMRN91HhAiq6iBt5IWgi/cRwy+x+oKjNV2oTs+D5MLLCzw6M4eiRdWoBio
         s5/Q==
X-Gm-Message-State: APjAAAUv/idZmfetGTSjeTiGW1DEvXcxoPGZekq/xJS0/OCJ1/D0d919
        p05Ca8vXGLEf9BqbhIOJK5V+lX1OduHf/GUaE0Xszw==
X-Google-Smtp-Source: APXvYqyePZUiQGFy/pxLEHepqbJXYI67xMab3BFWslPBOL+viW6ZLRa45QU0Y62Q1TG83XbVR5WcaY3e7jRmywXQYW4=
X-Received: by 2002:ac8:395b:: with SMTP id t27mr65198889qtb.115.1560253366125;
 Tue, 11 Jun 2019 04:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
 <e25b2626-231b-28d7-93b0-004a21a3685e@st.com> <CAOMZO5A6A2sYzfPgjsqQxWcc4Z0YW9-sENW21KumO_XkN3WBYQ@mail.gmail.com>
 <CA+M3ks7LPEpEfOEqiOZ4q2-We-8BjK0FZfeKts4hBzL7GRRHSw@mail.gmail.com>
In-Reply-To: <CA+M3ks7LPEpEfOEqiOZ4q2-We-8BjK0FZfeKts4hBzL7GRRHSw@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 11 Jun 2019 13:42:34 +0200
Message-ID: <CA+M3ks5UE8VSa1iHVHWw8NfQWU-v_MRYffVPBMLhy53PD9SJxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ARM errata 814220
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Hui Liu <jason.hui.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 24 avr. 2019 =C3=A0 09:25, Benjamin Gaignard
<benjamin.gaignard@linaro.org> a =C3=A9crit :
>
> Le mar. 23 avr. 2019 =C3=A0 19:46, Fabio Estevam <festevam@gmail.com> a =
=C3=A9crit :
> >
> > On Wed, Feb 27, 2019 at 1:21 PM Alexandre Torgue
> > <alexandre.torgue@st.com> wrote:
> > >
> > >
> > > On 2/14/19 9:31 AM, Benjamin Gaignard wrote:
> > > > Implement ARM errata 814220 for Cortex A7.
> > > >
> > > > This patch has been wroten by Jason Liu years ago but never send up=
stream.
> > > > I have tried to contact the author on multiple email addresses but =
I haven't
> > > > found any valid one...
> > > > I have keep Jason's sign-off and just rebase the patch on to v5-rc6=
.
> >
> > Adding Jason's NXP e-mail address.
> Thanks !
>
> Russell, can Alexandre push this series in stm32 tree or you prefer to
> merge it yourself ?
>

Hello Russell,

I have push this series in your patch system weeks ago, but nothing happens=
.
Do I miss something in your process ?

Regards,
Benjamin

> Regards,
> Benjamin
> >
> > Thanks
