Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3142187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DTe6RNke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbfKGIIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:08:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:37451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKGIIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573114088;
        bh=b0EBzYCqFZrZPd2jfMXEPGSoyVe1C2IkaISedX7n3PY=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=DTe6RNke47tg6kbqhOZx5eGxOd/F3TrxlSLuTIcjoMaGdozaubKil9/W6eaWcMNjS
         JO3xrS/yb2lDrd0zUrPchScTitV0e4m/3p7HEu/6vEAMhLSImwfzLDRkTRoCfeTRJa
         r4UnMHS6cUjeqLb3ENGe6NtwtVXQB9JUBX3xb++w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1hhwGn0lCr-00xrAb; Thu, 07
 Nov 2019 09:08:08 +0100
Message-ID: <bb7bac8adfce085cdcc080f8f26cbaae2fe916e0.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Jan Kara <jack@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Thu, 07 Nov 2019 09:08:04 +0100
In-Reply-To: <20191106172520.GF12685@quack2.suse.cz>
References: <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
         <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
         <20191105182211.GA33242@cmpxchg.org>
         <20191106120315.GF16085@quack2.suse.cz>
         <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
         <20191106145608.ucvuwsuyijvkxz22@macbook-pro-91.dhcp.thefacebook.com>
         <20191106150524.GL16085@quack2.suse.cz>
         <20191106151429.swqtq2dt4uelhjzn@macbook-pro-91.dhcp.thefacebook.com>
         <9f6b707c69ceb34e3916b1d47f2e2fa6a4f025ab.camel@gmx.de>
         <94c71621a0245db763db9e289286b79056cc9bc5.camel@gmx.de>
         <20191106172520.GF12685@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1WBHVNmEH131k4Ss9ghBIkrLGUmstaaz1CeQYEPL+YbdzNrloyt
 rFmbCXeRz/nCv/dIXXv/S0zXYaewSY3fHsc3BDT0QGBYL1Tzg7a7YHlziMZ908ZUPAtQFEh
 lxUp08wM4ID7XHoKMN0dMs4KoRorxKQEQ5lnyK7aqlVZAc6PViTnlrkIUcpN1FDx1yuSF3A
 C4gZ5FvIONybFw5H1lENg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yVt/y5aAGJY=:mqEzPo5CPNozh0ZMFNvbsd
 +Nf24ypMJfIYAJkUCqNjMFjAVgE8xngNHytSFjA0tacg57yO6QWge0HXvZ6n/0usuekeMaYaW
 BIZRZDqLeoUeLvw1ApujuH80rqHjmV9+jULgyXWYeoIahzpOpAsAuKj8gtDEZ3feo2UBza7q9
 mteydbUu74zdvU9ISeOttVhMAVNVY/1J/qtuvvhz6wGzLlCSHSkVQ0Lb3L8kNudJIKdwCmwy3
 ewnSvXGRCjKFETK6pYaRMGMHDPRPeqljvWzwXTyc/TN2AthHOchkei7PyZNtTkVU8QN7qKflF
 JMDyOuIxSrWXfLX9x8ZYGjw5R5W1ZWp3MoKPgH2t1A867u5mxWhmq3MB3yCCECadpV7ofMetz
 urIhHSALyrjrBJEewofzfjzZlquMIC3AfE/ltivOU6UilKrMLpw7zfqXypvUF45AgQWES+t/p
 b3MmCWHFUU5alKV66hIrBRcqhyuhiJ7jR+8JYGQ7ZgGpOo17KkbEV9gLbaBCyHZFfxYNVDs4W
 QXJiJlGJ2FeP2dheOGYHjz9onQB6xknyO/gQzVRW1+JN/fgR2dV+F8NxwJBrVe7imNcu1QjgG
 uW4G91zyjWBiuFMC4uWV99cjOrqO1mi7M2kwy+eqMawHV6BVuweFlgwohq8fCqSkjQU/K7q4x
 MIEbA2WNwOsn3melpu4HDKokwqBmKqP1yDYGmf4cOghEGOPCY9Bn4FlrwIRbGX6j+VvT/yum0
 lQcJPIX93gJr5dOHFFBtCnStPnTo9hvVH8VwilozxnyugrBzZWb1iXAxwlLiCDTRoDpAyVRC4
 bQ6yTcgUSUKWu7qLlJmrn4KcwAd91/sI1EosaIrvcnYsUHlG7R3c964bic0Q0+mFqIg311+I5
 HKIDzs02mrcFPyhUnLhcQHN/G9F1T2slFmo5iAP53bax8qbf1UqQw8kqPGkktDPTkmgnZNfa1
 KCa4fXCsLObl2glJgxVtwo7CIdbG+OMfAcAsaM1HMj8sm4t3JHlZysArNsrjpjNVxK/ERq80c
 x5KKFGNE58VQRIoZZUZ0RxitqyRiJkDSsZgP7UXFBsIWVVvtDFtSI8ivs4bacjx9+AXGBNgJl
 cCo+IpPAZxOFcffxpBRV+C9s0X+DJP14wtvh4zooT9NyCkhNI4J1cVWQcQMegY5JE3dR9plh/
 pilSlHmpu733V62Dk3z7GVHGuEsbxF64kKyJc2uzEzTT1YSBb9T3rO81rjAK1+dUE765MUcZy
 7afVYKpQ+moEmpP3rKamxjApuqD14BlcCWKtLbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 18:25 +0100, Jan Kara wrote:
> On Wed 06-11-19 18:03:10, Robert Stupp wrote:
> > Oh, and I just realized, that I have two custom settings in my
> > /etc/rc.local - guess, I configured that when I installed that
> > machine
> > years ago. Sorry, that I haven't mentioned that earlier.
> >
> > echo 0 > /sys/block/nvme0n1/queue/read_ahead_kb
> > echo never >
> > /sys/kernel/mm/transparent_hugepage/defrag
> >
> > That setting is probably not quite standard, but I assume there are
> > some database server setups out there, that set RA=3D0 as well.
>
> Ok, yes, that explains ra_pages =3D=3D 0. Thanks for the details.

Ah! And with these settings, a fresh & clean installation of Ubuntu
eoan (5.3.x kernel), hangs during reboot.
And if the VM's booted with these settings in /etc/rc.local, the
mlockall(MCL_CURRENT) is reproducible as well.


