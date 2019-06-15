Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8062C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07A1217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560558271;
	bh=ZrjXvva/bN7qY/TtGrD3uJbt5+dfSCyoL0fdmHhv7t0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PQN9TFVPW9J9MTf3iAvKeTdHcEhWG2DCv+SWFM05m2zsXvMiy5JPCV0tiWqjALkTG
	 PoyOydTEJykH+LAlsINe5LavKNCOzgTvPRSoOp10La/xLbE5cxsP0toLSLC2p8lV8/
	 ts5hkwmfMsygdZqv28DpRyENcXbLdZTRTjdDuc6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfFOAYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 20:24:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42152 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFOAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 20:24:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so4006800lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aK7lUvYVYd4MHzc03gl18he+PgV3Hkk9KuzGz+vIyo4=;
        b=e5ZS2eb2pZskGk1t2DAfftIR2H6ohKVnchU3giQkQVAHGxWxwBW20eLh5ZsUiCGGME
         6sw8frLd89Po3z4XAfZ9MbD/TJit973JCdkHd51Y1T1Uq4vgc81VpJT6f+zyKtfC0mDs
         rLEOUzr6pgcKa2PubqoFxZV/FYtmA1r3D0rKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aK7lUvYVYd4MHzc03gl18he+PgV3Hkk9KuzGz+vIyo4=;
        b=eS9bWkRYfcxf3lQ40eoFwPt2ImmOVpMEZ/xg/tBvRxEKgVolQaQAgemdQyN+YY71B0
         6tvz3SOiEnS1DwqnzLjU6hlt0DHRToKfUBXZHVb7vwr1KsgMSCl3lL2y6CbUMDXqDBaS
         Soql2n5sF2E0lTJ3a4XLCe6x7e1iRgJ8j3mDIF3LeQD/s20r9Ker/DA27BFuMY1HLBS3
         Mz61pyZHaDX+MKvdqHZ69pyqN3drTaLggA+rSCvNqqUkQQ3Nz09rA8HrwvoVoLviYk5G
         3wjmXX0oryDQmQw3agVPE3nknjNuxymUWLdYIOT04rF8KsuyUigOKteO8/IzBxuUxzTx
         aGOg==
X-Gm-Message-State: APjAAAUIPr5lgjirwTNDnh62V3fLX2+rDMzpo0+Mc3yXQBxzdznNKkK+
        Jwcm4zoIkS9VFkd+p9dCyWwQwxlh75U=
X-Google-Smtp-Source: APXvYqz+emNKnZHMGCsdk8bKFVVPGa88IOU9udwEW5jscLxci6F34urTKXhkDuMMJOK2sbNBLGBwRQ==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr12515253lja.87.1560558266698;
        Fri, 14 Jun 2019 17:24:26 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m10sm683305lfd.32.2019.06.14.17.24.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 17:24:25 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 136so2833036lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 17:24:25 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr45739644lfm.170.1560558265318;
 Fri, 14 Jun 2019 17:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <155930001303.17253.2447519598157285098.stgit@warthog.procyon.org.uk>
 <17467.1559300202@warthog.procyon.org.uk> <alpine.LRH.2.21.1906040842110.13657@namei.org>
 <6cfd5113-8473-f962-dee7-e490e6f76f9c@schaufler-ca.com> <cb3749a6-e45b-3e07-27f9-841adf6f4640@schaufler-ca.com>
In-Reply-To: <cb3749a6-e45b-3e07-27f9-841adf6f4640@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jun 2019 14:24:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj8VCxjwyd_BDgRtDigik5UdizCZP7PU4wUtj4vHsEWNw@mail.gmail.com>
Message-ID: <CAHk-=wj8VCxjwyd_BDgRtDigik5UdizCZP7PU4wUtj4vHsEWNw@mail.gmail.com>
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option and add
 missing prefixes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        stable <stable@vger.kernel.org>, Jose Bollo <jose.bollo@iot.bzh>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 1:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Al, are you going to take this, or should I find another way
> to get it in for 5.2?

I guess I can take it directly.

I was assuming it would come through either Al (which is how I got the
commit it fixes) or Casey (as smack maintainer), so I ignored the
patch.

                 Linus
