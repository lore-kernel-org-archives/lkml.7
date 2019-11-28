Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA03C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6332176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bQeVibLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1N4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:56:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33642 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1N4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:56:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id c124so18380368qkg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=GPF1IwzBdQ5yidrnlKXQMZUft0/1YjCBcLLbgUMkwSA=;
        b=bQeVibLNv0W4Ge31ScS1b7LxH775Dv26sXTe3gm5YcEVqKour6+GxwH+VaEtW0AlSQ
         JlXrLLr6h2l8wIZJKhCuN80AcLS6nbmNTUhVyXi7bUAAXGgenJtESggHdX1NmWCfMVUa
         Qex01RzxAowI7SzDsRKZpVEL/LcMsaf+g4hSdIlHAU7VHwKJRuQj1RUsjNd2JhjXslls
         x71FVamwhCwffjJBOcSfpv9oMSLMYek9WyoErTtgjjDjPzCWRBYd+UK9NwH/PfARd7Nv
         7jkOg8yXE9Km5UII4P/RzC9zdJi8dWkEG29I8NRct028QPKIeukjcwIaLiaOCbHPIB5Z
         2AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=GPF1IwzBdQ5yidrnlKXQMZUft0/1YjCBcLLbgUMkwSA=;
        b=ttd7aHLwDmC53pYmsxLtcznxBkJyc0Zj0bitLqFW5gd/RxRJ61rLh7vLuN8HHOPPlE
         6faxC8fejVDvcGg+HYGuagokaf0HmklM7ChFV01xRDZlBYqvPlYmnknJDhQ6RAgX7x/2
         HUq5aaizbDGxL/9sCz8DvfaZreRNjkMaUoMDDWBeHpGTp3GJi73mviBYhWBA9KOmxxU+
         /PLKtBGX/j1disxyf44Rb8k49mh0rRed6S5SCI+DkSH93qo0haDZP4UA1n2yEJofqyYY
         MmsAnoMTWQLFsj7uAu0WSbbtlcHzvaQdvA96Qf5xfJOXhPmKmic21PGQoGWogxB+G/5T
         uXbQ==
X-Gm-Message-State: APjAAAU3uL3+OFB5JU6DicRJilxBb4r6xRuDI9Ju4Bysr/rT+XhvZVkq
        ZItO1Vl3Wl2vjww+xftUO357lw==
X-Google-Smtp-Source: APXvYqwvpwZ1lBshgaHtwnnPvGdUJcF04QWGaWBn5/C3LdQ96sZe3+t4RvAbJfA5kkwn9wAUwIal0w==
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr10482225qko.204.1574949378602;
        Thu, 28 Nov 2019 05:56:18 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v143sm8609685qka.3.2019.11.28.05.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:56:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Thu, 28 Nov 2019 08:56:17 -0500
Message-Id: <F768F9E2-6413-437A-827F-6105D6DDCD94@lca.pw>
References: <4cfadccf-d77e-0cff-f870-0ff069d41271@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <4cfadccf-d77e-0cff-f870-0ff069d41271@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2019, at 3:46 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> I'm sorry to say but one of the main reasons we have linux-next for is
> to find BUGs early, before they go upstream. It is a way of giving
> patches *more* testing. Yes, you are doing to dirty work (which is
> highly appreciated btw) by debugging all that crap, and I can understand
> how that can be frustrating.

It is already an expensive development practice if developers need to rely o=
n someone else to figure out their own bugs in linux-next. linux-next is for=
 integration testing, but majority of those regressions I had to deal with n=
owadays have nothing to do with integration, i.e., interaction with other su=
bsystems.

>=20
> But believe me, the world won't end if your on vacation for a couple of
> weeks, even though some BUGs could sneak in ... e.g., lately I try to
> review as much as I can on the MM list (and Michal is steadily watching
> out as well).

Sure, the world will still be running, but good luck on solely rely on revie=
wing with bare eyes before merging.

>=20
> The solution to your problem is more review and testing, really. E.g.,
> I'd be very happy if other developers would test their patches more
> thoroughly and if there would be more review activity on the MM list in
> general (my patches barely get any review ... and I sent a lot of fixes
> lately).

Of course, that helps but it is a culture that very difficult to change now.=
 How many times I saw even high-profile developers proudly sent out patches l=
abeled =E2=80=9Cno testing=E2=80=9D explicitly and implicitly ?

>=20
> As soon as we stop touching our code because we are afraid of BUGs, we
> lost the battle against an unmaintainable code base.

Your generalizations of things make me sorrow.

>=20
> BTW: [1] mentions "unbalanced software development culture with regard
> to quality vs quantity that supplies an endless stream of bugs". I don't
> agree to this statement. There will *always* be an endless stream of
> BUGs - and most of them come from new features and performance
> improvements IMHO. To me, cleanups and refactorings are important tools
> to improve the software quality (and reduce the code size). All we can
> do is try to minimize the number of BUGs - e.g., via more code review,
> manual testing, automatic testing, and by actually understanding the
> code. Cleanups/refactorings can even fix undiscovered BUGs (e.g., latest
> example is [2])

Surely, most of people probably don=E2=80=99t care about those endless bugs b=
ecause Linux is a monopoly in data center and open source and it is always l=
ike this since Linux was born as a hobby project.=
