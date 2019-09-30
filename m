Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CD1C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87586224EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntj8348g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfI3VCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:02:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34516 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3VCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:02:08 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so42146530ion.1;
        Mon, 30 Sep 2019 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QID0cXkDC0BLzvC7FuY4xqFhqxUaDG93KA1HjGWVRXo=;
        b=ntj8348gujOTmuFADRO1GV31lND4EsLCcz7M/3IOCfDQ2Rsd7yd9l3ft9xUJYv2+Os
         SUDiAaUmZl2mQ3Sf2OfxfDaH5FpBtALUTi8Ach7ECOhSpArMITikuaG1ePWPKXRiaW0E
         ggGt6uuTp4AR637HvRe5HXgz4q6MVm4EJU4B9mYzatq0zk5ZxkCjsPiNm7pPsE7783Mw
         +VdofVnoj0VhUt4Qf2M2QUIxJs5Za/KRy03sz6wNRLjBjdYrfVWbLOTP/7vt2Z6ubvOX
         QR00ulbLQA8Hq1h9LbevAc+jNVa5UhM8RZKOrufNEUWZJnWvLO5I9WE/VKXaPba3fWE2
         6GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QID0cXkDC0BLzvC7FuY4xqFhqxUaDG93KA1HjGWVRXo=;
        b=cAuTBclivpd4Xp6ioB9RD5FFOUTTf/qgmE4jE4dDqOJ2DcoB5ZQ3ki5YKYWRwDWo3k
         CU4azPBYHQ5YID1iRP2mlDOrpidTo+MI+vnYVL2VpfgCaxqX/uk/+NTpJoOSN7zgzyKY
         TRzrjVnhF6BQ3CAkc4vz+0QH8xdltMoaurvm8TMonMDnw/QX+NghuuPI0BSGDquM9kmc
         8Xg3ftFyQqKNtFo7M6wihD/s/+6s4oWtGAfYoo1h6joNG+iNtHUtsDtw8eJfEhvZH93w
         KYYiBFhWrGJD3LYN2wa6HdTMuJCXJ06REJtPMk59n1WkckitVR71tkFGoLQAvTJujh+m
         AJoA==
X-Gm-Message-State: APjAAAXr/mK0OPkp0W3MwgHKMGRTaHwc1Gp180zjsklGz9pM0DiFyoeK
        IPWusKWGtov/2513AjXm1Neh3xA+uS/14tm+R04=
X-Google-Smtp-Source: APXvYqzS0f8N/FieGtG3rTSPNh7QsFdEKePLZRUnyEQsF7wLUfUQlddL2fv5FSx+xQeb0uvdhImlu+/YmpGMfh4eHgM=
X-Received: by 2002:a6b:c9d7:: with SMTP id z206mr6395754iof.172.1569877326927;
 Mon, 30 Sep 2019 14:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190930032200.30474-1-navid.emamdoost@gmail.com> <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de>
In-Reply-To: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 30 Sep 2019 16:01:55 -0500
Message-ID: <CAEkB2EQwfCZk9e=MKx-U0g_e9Dgjr_RV0n6JrVaxwUP5Z=cY+w@mail.gmail.com>
Subject: Re: [PATCH] fs: affs: fix a memory leak in affs_remount
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the issues in v2.

Thanks,
Navid.

On Mon, Sep 30, 2019 at 1:03 AM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> * Please avoid typos in the commit message.
>
> * I would prefer an other wording for the change description.
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3D97f9a3c4eee55b0178b518ae=
7114a6a53372913d#n151
>
>
> > But this is not actually used later!
>
> Can this information trigger the deletion of questionable source code
> instead of adding a missing function call =E2=80=9Ckfree(new_opts)=E2=80=
=9D?
>
>
> How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?
>
> Regards,
> Markus



--=20
Navid.
