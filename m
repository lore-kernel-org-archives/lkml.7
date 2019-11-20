Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FC5C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBF3208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSorraur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfKTRRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:17:19 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:33791 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfKTRRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:17:19 -0500
Received: by mail-lj1-f175.google.com with SMTP id t5so31818ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSyXlJi6K2335/Bgez7VUxEtGRE+HAza7pceyBB8j1U=;
        b=QSorraurrun2yAOywBEFGjKY5bMnmpZ80LO0pSraxkXWig5mvLULXIyk3uuI9+BQQv
         o4FK24D5wDNyBLCVuFjRk2c0iP15f0ChW375TzsYZDejfzdKFH7ONTgLbiIKDks6VOCA
         e7+wMhSX3C3uGyl/hXxrLALy4lTQ7CQ6IzInlsN0ZvQsknb0T7dsYgbtufolDsnCkNTX
         HiuNOnwDakvrgXyU9lXQEQ2ECcwAB79O48FBp1fWldGgwmtc6xUXpvX2b7P+LrLfJi8O
         xRVY2Qmxn7XJzD5gPaI2qmqiGPSQz0fOFiDiTGA0/IBqadXplFMf//c9+qMHl3qC5CTT
         Ebqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSyXlJi6K2335/Bgez7VUxEtGRE+HAza7pceyBB8j1U=;
        b=sFkRtCo6pSHw1ulFzGWBR4bfxnSfCV3+OkLgQXeK+ChMFtXaI3rCzMNqXpxxURQXFZ
         lhcEblwkV9ARwMXBNQd5VYkDQobqMx5DmcuVupMx4hGFz4E54410DRcHrnNQfclUKHhT
         CbPSM9zBOg6d41XhS1W4DMXqcdJUD7bVVIOi+o8/zhwvfzuVOsMlarpukV9+Kfq9SnzN
         LUYbwAhKYFxlvmplhG/ZzEAvs4VcpyfFfIO34a20ZjPKkQ+Qj+FoP5JyipD2eYEXcHY5
         cjFtFD5sRhdeC/z3KGOLqqOcT/25nzANYpDHwz5lsaP5tfoKOuufsLXuMZN/VesyCOoN
         5T5Q==
X-Gm-Message-State: APjAAAVE4ARTFXdN9mGV3xaI1fCbccCXzp1YfsymMVH1eOHutihm/MdO
        vZJ0Jkcl/is4oOLteQbK9yeV3hgUQ2Ywl4rajL8=
X-Google-Smtp-Source: APXvYqzxHdnld/ZlrUqKdpv4WuKrIK70iueq4D4crj1Nm2Jc6n5N8iRYTSKAZsJW68TD+xFkMjvTYreR/ZFvEBI/BLg=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr3876513ljo.143.1574270235724;
 Wed, 20 Nov 2019 09:17:15 -0800 (PST)
MIME-Version: 1.0
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
 <20191104142459.GC2552@lahna.fi.intel.com> <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com> <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de> <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de> <20191120105048.GY11621@lahna.fi.intel.com>
 <ccfa5f1a1b5e475aa4ddcbed2297b9c4@AUSX13MPC105.AMER.DELL.COM>
 <20191120152351.GJ11621@lahna.fi.intel.com> <90daf5669f064057b3d0da5fc110b3a4@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <90daf5669f064057b3d0da5fc110b3a4@AUSX13MPC105.AMER.DELL.COM>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Wed, 20 Nov 2019 19:16:58 +0200
Message-ID: <CA+CmpXubOwsradq=ObUF-h6WBpRF3tDx9TqaUO8TeJDqvdeGPg@mail.gmail.com>
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        pmenzel@molgen.mpg.de, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>, ck@xatom.net,
        LKML <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 7:06 PM <Mario.Limonciello@dell.com> wrote:
>
>
> But I mean this is generally an unsafe (but convenient) option, it means that you
> throw out security pre-boot, and all someone needs to do is turn off your machine,
> plug in a malicious device, turn it on and then they have malicious device all the way
> into OS.

Only if the attacker found how to forge the device UUID (and knew what UUIDs
are allowed), isn't it? Unless you take into account things like
external GPU box,
where it's pretty easy to replace the card installed inside it.
