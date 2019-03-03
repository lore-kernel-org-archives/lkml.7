Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543C6C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DF420838
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wftHYMj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfCCBJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 20:09:29 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45358 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCCBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 20:09:29 -0500
Received: by mail-wr1-f48.google.com with SMTP id w17so1679995wrn.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 17:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8N5Lg6WDE/cWWhEqN+3n6NHgJ52VHWCkUAP2LW0fow=;
        b=wftHYMj6cLycRmVmXSpdNZyw66JvGP0j5P5dAmeoDamcQ62aJCO05YDWMtRUbsafDL
         qtmDwX7zWf+VE/Vvfe982DcqogQCzEbp8qddaWahenvgiMKFOM2twGP6JdmWgupJowri
         2gOM2GMW1OPzHTuiVw5UzMGBH//16G1iRp38TZx4XRLPKAwesybGNoqHkD+7LPs0VyJx
         CYMFjTEnBuRD2cBawWBWKu6InogcmnHuQG6Ps2EN+x6aS7mC56bCY8wxwGn/INW3P6jt
         3xxj6EWnly6m0Dj4+U/d2usQqjLtO6fLwIj45Zb+akRA4XOkUFSrkFrbF7lZet8Fqr/D
         0rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8N5Lg6WDE/cWWhEqN+3n6NHgJ52VHWCkUAP2LW0fow=;
        b=b+kcSdDIhE/hki5tkzrn9hHTR2ZPASfCbutOx5hmcHEdf9GYEpZnBoaK1CmtIhgWtL
         4+Xg5qIYSF5pWGw8wY/cTiGnXiuy7hMln4j6BxEJE8yhVCGbOlvkVQD9BOLz17dLyhdK
         gnb+HFzE3R+9Oc3nurQZOuhzdDD+rFdxCPOnu6xNlhb8nFqr9KDrCNq6FkVjSAfNxMSJ
         WXaPhvMpcI4e8dzASMsA0xm7dpY4fHxryc02e2qftDHuM/KJ678mFga6A5l1LorNWLEf
         IFLIJTPAD0NKteo07P2V2Rs0ePMQKBLeDkiY1hx7BwLc6R3PICORS6olRaqAWA39FCan
         sfkg==
X-Gm-Message-State: APjAAAWuRDMQ5MEDC6uU9iHY2tvR3WMHJ+/NbWEz5FxmBX+rBwq6o6km
        kWuwh06Ve0MPx15af0jK/YduzYKJOopPgKcUeA6h7g==
X-Google-Smtp-Source: APXvYqz9ULINXXWmXt0pLStdSP2eDXcWegSFNbu8/qgzAekf8Yk75+AG/marQYdFiQB5NqOxVEwAcYT+jL8wfcsV6Qw=
X-Received: by 2002:adf:8061:: with SMTP id 88mr7681066wrk.77.1551575367415;
 Sat, 02 Mar 2019 17:09:27 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
In-Reply-To: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 2 Mar 2019 17:09:16 -0800
Message-ID: <CALCETrVJaYADYGswWgba=bysFEOP5jKuV3MxcZx5WFQEmxnGfg@mail.gmail.com>
Subject: Re: a.out coredumping: fix or delete?
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 3:57 PM Jann Horn <jannh@google.com> wrote:
>
> In theory, Linux can dump cores for a.out binaries. In practice, that
> code is pretty bitrotten and buggy. Does anyone want that code so much
> that they'd like to fix it, or can we just delete it?

I would propose just deleting it.
