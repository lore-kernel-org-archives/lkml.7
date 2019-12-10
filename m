Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C08DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C3C20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyRCRyjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfLJWki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:40:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41242 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfLJWkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:40:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id s18so568683pfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WhKcV9MhcHZ+rIDrMbDQc0mCzV2/LXUFgnxbFQ0koe4=;
        b=fyRCRyjbRw/ahnal1DJZEhKbTukOYXWTOelfdC8IxlZgyJU+E3zpokgvCb1OZDcZX0
         jEDUuL8VcXF5Zb0x26s2whsrtlzlfAyiWCiOvfgIznuT7lnviKisWYSUAGwUkKWKtvsR
         6C4zCpSjJYjo6TgSp3Vp5idWbKVS57L/XUoJFEAYFjul+FGbzK1aeXcoHpFpcbMZZTSu
         6KxjbQZLq3putByW3nDo65b5EQUTK5bPAVPk9vdsixG1I13zhNmCBAq6cd9QjUVlAOFd
         FwIHkUCTi73L9mmgrYXepJZs6Ni9rfM56GzZ+SAjWh58R5h9IzpU7QSmtnmb68XxAyDh
         jY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WhKcV9MhcHZ+rIDrMbDQc0mCzV2/LXUFgnxbFQ0koe4=;
        b=P7hzUV3NoV9BU9mF3afT4c3wS497Cgn1wjJP4FOAwV+nzF4KSHojOno4q4bRLTXARj
         nGm/GExO8Mxr5rR9QMCuM2b8nBf7+Nj+IM8nXIcs+Z5t4ZIqhoCQnC6proRJrw4L5hrx
         26Yq2v/uhhwV/ky7iTTbZFL+cZl95tgtxuW6VQbHCz7NpniQGb7Mkcq1/eG9fPNsMQpX
         PE57U2vthDGpCy0ptnhC7/By3Hr47eDGHbNWBpUJ76ACTPLiAEWqyrxrACYwajWIBzPE
         vOAcyiegeXYhCDgsARzEc6kANAFmg4x+wU1TjdpteTYCCSwMsB4eSUmYvzU9el8+KMrF
         V41w==
X-Gm-Message-State: APjAAAWH9Selxzqr869QqkqCjEh24IAaM68LKGV1dbhIw/PHgMn5QLLi
        mUY+JREtVorRIJ2NyrYMajMELhZUOr82uvq1zNpx8g==
X-Google-Smtp-Source: APXvYqziJWsPEGOvugy3+CzJsahNAxfE/CC9fJFp4r9R7cQDicZqjz0W5POh7mTSbWDdnZwsIhgGNBtzww4m99wZcsc=
X-Received: by 2002:a63:480f:: with SMTP id v15mr481015pga.201.1576017635129;
 Tue, 10 Dec 2019 14:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com> <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
 <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
 <20191207012108.GA220741@google.com> <15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com>
 <CAFd5g448yZ5nSVLnN0gvsv3jLnhWG+dzJgvH1jdV+s2eTq4wxg@mail.gmail.com>
 <1785498655.111829.1575936178298.JavaMail.zimbra@nod.at> <87f182c6-82a3-d696-72e4-ddaa781a655b@cambridgegreys.com>
In-Reply-To: <87f182c6-82a3-d696-72e4-ddaa781a655b@cambridgegreys.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Dec 2019 14:40:24 -0800
Message-ID: <CAFd5g46osmFBka0X60A+_mmetpreG+abnh_+GQmVrr+PPxrqxg@mail.gmail.com>
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Richard Weinberger <richard@nod.at>,
        davidgow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 11:14 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 10/12/2019 00:02, Richard Weinberger wrote:
> > ----- Urspr=C3=BCngliche Mail -----
> >> Von: "Brendan Higgins" <brendanhiggins@google.com>
> >>> IMHO we should at least mark them as "obsolete" and start preparing t=
o
> >>> remove them.
> >>
> >> Alright, I will send a patch out which marks the other network drivers
> >> as "obsolete".
> >>
> >> Clarification: Should I mark all UML network devices as "obsolete"
> >> except for NET_VECTOR? Daemon and MCAST looked to me (I am not a
> >> networking expert), like they might not be covered by vector.
> >
> > No. Why?
> >
> > Thanks,
> > //richard
> >
> > _______________________________________________
> > linux-um mailing list
> > linux-um@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-um
> >
> At least pcap and vde are maintenance issues. They do not even build toda=
y.
>
> Off the top of my head, daemon needs fixes to the switch - it has an
> O(n) performance hit for n=3D"number of ports" as well as a few other iss=
ues.
>
> Tap has a fully functional replacement
>
> Pcap has a fully functional replacement
>
> mcast for 2 instances is functionally equivalent to running l2tp or gre
> back-to-back.
>
> IMHO we can start marking some of them as obsolete.

It looked to me like this discussion is ongoing; however, it seemed
like the discussion might be boiling down to *which* drivers should be
marked obsolete, so I decided to go ahead and send a patch which marks
everything as deprecated. I figured it would make it easier to focus
the conversation on what, if anything, should be marked obsolete:

https://lore.kernel.org/lkml/20191210223403.244842-1-brendanhiggins@google.=
com/T/#u

Also, Anton, I flat out stole a bunch of your comments on this thread
to make my commit message. Just respond with the appropriate tags
(co-developed-by, etc) if you want to be credited for them. As it is,
I marked you as "suggested-by".

Cheers!
