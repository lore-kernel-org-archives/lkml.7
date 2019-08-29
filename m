Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD877C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D31522CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=volatile.bz header.i=@volatile.bz header.b="aFzze3pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfH2U4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:56:45 -0400
Received: from mx1.volatile.bz ([185.163.46.97]:42356 "EHLO mx1.volatile.bz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfH2U4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:56:43 -0400
Received: from TheDarkness (unknown [IPv6:2600:6c5d:4200:1e2a:5ae6:e27c:4008:d85e])
        by mx1.volatile.bz (Postfix) with ESMTPSA id 203A82F34;
        Thu, 29 Aug 2019 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=volatile.bz;
        s=default; t=1567112200;
        bh=2Cld8ITONmQhx82iPM0yzzpBzpBAbtt/czPoBPirKMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=aFzze3ptOfzWszyUPz+6uGkAVoHyMSUavzNLXeh1pd4LmEMBUIpFn9xHO2c2gOyOn
         sF3vk6HyTrqXS65SOVum52FbkHZv/3in+Ru0AElUUaPb6IButNawbwpsxSNTBa6eSp
         KYvA+A2ErD3rpOjyMuVQREIwtU6Wzg+/ynioCNx0=
Date:   Thu, 29 Aug 2019 16:56:35 -0400
From:   Alexander Neville <dark@volatile.bz>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] um: Rewrite host RNG driver.
Message-ID: <20190829165442.3a3425ad@TheDarkness>
In-Reply-To: <899887272.76523.1567104513068.JavaMail.zimbra@nod.at>
References: <20190829135001.6a5ff940@TheDarkness.local>
        <899887272.76523.1567104513068.JavaMail.zimbra@nod.at>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 20:48:33 +0200 (CEST), Richard Weinberger <richard@nod.=
at> wrote:

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Dark" <dark@volatile.bz>
> > +	// Returning -EAGAIN to userspace is not nice.
> > +	if (err =3D=3D -EAGAIN)
> > +		return 0; =20
>=20
> Hmm, doesn't this result in a short read?
> The current drives sets the calling task to sleep and wakes
> it up as soon data is available again. I'd assumes ti have the
> same behavior for the new driver.
>=20
> Thanks,
> //richard

Clearly this patch needs a lot more work before I submit it. I'll=20
take some time to polish it up and then resubmit it if that's fine.
