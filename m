Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F1C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FE2208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKkKok/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfFGK5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:57:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39819 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfFGK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:57:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so1437984otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nZtXhGBqaTeK0ex+tV5ZPTRvdYhipd9n+MwuTcXxmGs=;
        b=nKkKok/jeVcWwcqdre1a0heiZf1GhwPQAu6C8UHMnw9skJJyaskFX1qC+cncR6c+kg
         HXBzjw6mvzpkTXgqouzElB6HMRHa6v2q72sBpXgEdwNE/1ea2njrVomF0iAY2q963j0m
         gyCsy0ojE6nkpVS0vWb7ZugV4m/JcbUjNh4wv3D15dAyKvc5YRYP2SLzoze51KP6/xSo
         /6uwIxxRCQBbE3r4HWYaZ4JXL3cthjIvN+aAb73i28v1zaqAWMJvfia/nBiBhqZmHhyw
         A8klQ57vnh5Slw1fNu56BBizC354vLB6UgypFHHyG/lOaQa4DpzUvTPFgf8e6ujZSjMc
         Wz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nZtXhGBqaTeK0ex+tV5ZPTRvdYhipd9n+MwuTcXxmGs=;
        b=VUH5uaLr70mmItblJN3hKlKgXPeAwSUjiE+tEO8ivAyDu/KqW4UP6cGxQfNjWORlYV
         W3xA4z15igN+aA01gmSLA+momrRG4mniFXSglzePJP3559oJDniVb++CffO/U+zbTtp2
         KgLOfiH5ZhMrKBhCfuet1pZiyE89XEJ45E/U7bognxX3sF9XkWwb2qcM9n9zFQH89nKk
         6glehdbHSaVC82jrym0Xkb+GTYgCAA2ACS52uOY8Fxml0r8NSWkxlAdaWOgalD8scoYE
         xZV/8BCB2QXuHOFejkniKcLCwvblPyaGrw38TAZZiHTP2UhtUc9Hq8IvdHxW2vc0bXCp
         oVtg==
X-Gm-Message-State: APjAAAWkHAtRaGE/StjQDhcuYW2gMH39ZHUJ++Tvv/IiZzh1WM+PZRun
        HdqAn0qL+4Xgpiw0xAsz8sOeJA==
X-Google-Smtp-Source: APXvYqxPk+UMLB9t/XJJd8uehJ/KPBjRKrSeAd7mnu2jASpdYaOAsw3Lv+6bsMoFLb8fW1iPOw547g==
X-Received: by 2002:a9d:191:: with SMTP id e17mr19782280ote.315.1559905056539;
        Fri, 07 Jun 2019 03:57:36 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h2sm632392otk.25.2019.06.07.03.57.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 03:57:35 -0700 (PDT)
Date:   Fri, 7 Jun 2019 03:57:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, rientjes@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
In-Reply-To: <217fc290-5800-31de-7d46-aa5c0f7b1c75@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1906070314001.1938@eggly.anvils>
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com> <20190423175252.GP25106@dhcp22.suse.cz> <5a571d64-bfce-aa04-312a-8e3547e0459a@linux.alibaba.com> <859fec1f-4b66-8c2c-98ee-2aee9358a81a@linux.alibaba.com> <20190507104709.GP31017@dhcp22.suse.cz>
 <ec8a65c7-9b0b-9342-4854-46c732c99390@linux.alibaba.com> <217fc290-5800-31de-7d46-aa5c0f7b1c75@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1586778359-1559905055=:1938"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1586778359-1559905055=:1938
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Jun 2019, Yang Shi wrote:
> On 5/7/19 10:10 AM, Yang Shi wrote:
> > On 5/7/19 3:47 AM, Michal Hocko wrote:
> > > [Hmm, I thought, Hugh was CCed]
> > >=20
> > > On Mon 06-05-19 16:37:42, Yang Shi wrote:
> > > >=20
> > > > On 4/28/19 12:13 PM, Yang Shi wrote:
> > > > >=20
> > > > > On 4/23/19 10:52 AM, Michal Hocko wrote:
> > > > > > On Wed 24-04-19 00:43:01, Yang Shi wrote:
> > > > > > > The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibili=
ty
> > > > > > > for each
> > > > > > > vma") introduced THPeligible bit for processes' smaps. But, w=
hen
> > > > > > > checking
> > > > > > > the eligibility for shmem vma, __transparent_hugepage_enabled=
()
> > > > > > > is
> > > > > > > called to override the result from shmem_huge_enabled().=C2=
=A0 It may
> > > > > > > result
> > > > > > > in the anonymous vma's THP flag override shmem's.=C2=A0 For e=
xample,
> > > > > > > running a
> > > > > > > simple test which create THP for shmem, but with anonymous TH=
P
> > > > > > > disabled,
> > > > > > > when reading the process's smaps, it may show:
> > > > > > >=20
> > > > > > > 7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/=
test
> > > > > > > Size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096 kB
> > > > > > > ...
> > > > > > > [snip]
> > > > > > > ...
> > > > > > > ShmemPmdMapped:=C2=A0=C2=A0=C2=A0=C2=A0 4096 kB
> > > > > > > ...
> > > > > > > [snip]
> > > > > > > ...
> > > > > > > THPeligible:=C2=A0=C2=A0=C2=A0 0
> > > > > > >=20
> > > > > > > And, /proc/meminfo does show THP allocated and PMD mapped too=
:
> > > > > > >=20
> > > > > > > ShmemHugePages:=C2=A0=C2=A0=C2=A0=C2=A0 4096 kB
> > > > > > > ShmemPmdMapped:=C2=A0=C2=A0=C2=A0=C2=A0 4096 kB
> > > > > > >=20
> > > > > > > This doesn't make too much sense.=C2=A0 The anonymous THP fla=
g should
> > > > > > > not
> > > > > > > intervene shmem THP.=C2=A0 Calling shmem_huge_enabled() with =
checking
> > > > > > > MMF_DISABLE_THP sounds good enough.=C2=A0 And, we could skip =
stack and
> > > > > > > dax vma check since we already checked if the vma is shmem
> > > > > > > already.
> > > > > > Kirill, can we get a confirmation that this is really intended
> > > > > > behavior
> > > > > > rather than an omission please? Is this documented? What is a
> > > > > > global
> > > > > > knob to simply disable THP system wise?
> > > > > Hi Kirill,
> > > > >=20
> > > > > Ping. Any comment?
> > > > Talked with Kirill at LSFMM, it sounds this is kind of intended
> > > > behavior
> > > > according to him. But, we all agree it looks inconsistent.
> > > >=20
> > > > So, we may have two options:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 - Just fix the false negative issue as wha=
t the patch does
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 - Change the behavior to make it more cons=
istent
> > > >=20
> > > > I'm not sure whether anyone relies on the behavior explicitly or
> > > > implicitly
> > > > or not.
> > > Well, I would be certainly more happy with a more consistent behavior=
=2E
> > > Talked to Hugh at LSFMM about this and he finds treating shmem object=
s
> > > separately from the anonymous memory. And that is already the case
> > > partially when each mount point might have its own setup. So the prim=
ary
> > > question is whether we need a one global knob to controll all THP
> > > allocations. One argument to have that is that it might be helpful to
> > > for an admin to simply disable source of THP at a single place rather
> > > than crawling over all shmem mount points and remount them. Especiall=
y
> > > in environments where shmem points are mounted in a container by a
> > > non-root. Why would somebody wanted something like that? One example
> > > would be to temporarily workaround high order allocations issues whic=
h
> > > we have seen non trivial amount of in the past and we are likely not =
at
> > > the end of the tunel.
> >=20
> > Shmem has a global control for such use. Setting shmem_enabled to "forc=
e"
> > or "deny" would enable or disable THP for shmem globally, including non=
-fs
> > objects, i.e. memfd, SYS V shmem, etc.
> >=20
> > >=20
> > > That being said I would be in favor of treating the global sysfs knob=
 to
> > > be global for all THP allocations. I will not push back on that if th=
ere
> > > is a general consensus that shmem and fs in general are a different
> > > class of objects and a single global control is not desirable for
> > > whatever reasons.
> >=20
> > OK, we need more inputs from Kirill, Hugh and other folks.
>=20
> [Forgot cc to mailing lists]
>=20
> Hi guys,
>=20
> How should we move forward for this one? Make the sysfs knob
> (/sys/kernel/mm/transparent_hugepage/enabled) to be global for both anony=
mous
> and tmpfs? Or just treat shmem objects separately from anon memory then f=
ix
> the false-negative of THP eligibility by this patch?

Sorry for not getting back to you sooner on this.

I don't like to drive design by smaps. I agree with the word "mess" used
several times of THP tunings in this thread, but it's too easy to make
that mess worse by unnecessary changes, so I'm very cautious here.

The addition of "THPeligible" without an "Anon" in its name was
unfortunate. I suppose we're two releases too late to change that.

Applying process (PR_SET_THP_DISABLE) and mm (MADV_*HUGEPAGE)
limitations to shared filesystem objects doesn't work all that well.

I recommend that you continue to treat shmem objects separately from
anon memory, and just make the smaps "THPeligible" more often accurate.

Is your v2 patch earlier in this thread the best for that?
No answer tonight, I'll re-examine later in the day.

Hugh
--0-1586778359-1559905055=:1938--
