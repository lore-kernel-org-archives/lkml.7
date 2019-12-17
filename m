Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CBAC2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94004207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3iCn4RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLQIpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:45:30 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36413 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfLQIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:45:30 -0500
Received: by mail-lj1-f182.google.com with SMTP id r19so9979661ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 00:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LykOI4XNhK/sQW2UChERBgIdICJXupMlzh8i1Tv8Stc=;
        b=b3iCn4RURmQj6PPCPhzYYxZRsDz1FINgsVgCHcL4IGU8cc59LPnJ82s0rjDI7mp3d2
         PqxDXvgAxljXnh3r5aRXndS9EKY1PJ60dcCTMfwaqHr5qc9IIGOTovgzE0hIsKwVXZaK
         aYyNvZ01tQTEmSJZbxbz4iNg+MPmbz3uCugLOtsiERcmm986j5azGio0MJMmmm69081f
         +/kisIo7Nd94sXCW2U80WkVFYulCdge+9FDOw35eYQgEi6dOLoOXNXckAqzuDs5KjwNq
         c0riNSIP7h37/usMqH0ZqxQ8KqzX+Lx8nwkqy7TpZV0B0g70CVPQU67SmdpXZRHtww9i
         gfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LykOI4XNhK/sQW2UChERBgIdICJXupMlzh8i1Tv8Stc=;
        b=rbssQEd6Va1WEKu28KL45z8NWWSsdp/+nUwGfcLFXPCboVZHeIF+jXB8HMt6Ivs7Cf
         FvH3upQMA4IzOI7q+p48Kfd8ibsBr4cW2FsgbDQQgwyi1IhAsjLkk0HGLiRWsm7zgeDx
         dtSwnC446FRNi3usqaOAoOY2+N0wL/5WziJIbGaif0CrfaNJGhNxeYJ2So4VG143uyEU
         QTedpXQUpORdxX5/Fe7fZ5MqqpN7v6CnEmwSrALLiTWm6/LVe+lwvYw9fRAoN4AO+iXz
         j31VzR+SPuWIopH3yDABQWpdAVo2N6S52F5mKRk41xs0Tf27Y51XH17MySwSwS1wNF8E
         jzMw==
X-Gm-Message-State: APjAAAVOcXgXP7bN/uDWz/uk4bZfcHNyH1ucy9WXHXITcGK5litE4w9w
        Hg7tVLpWO0pKZEmfa04W37ts65ie6IyIWoWv5x9/eg==
X-Google-Smtp-Source: APXvYqym0PivuPM62o0QLwn+0VSnXSGoVVToM7YTyjq2gl+Aps3zWsb1+UqirctTEnH8eEld8pGvuMs/RMRLJILLoCU=
X-Received: by 2002:a2e:868c:: with SMTP id l12mr2137258lji.194.1576572327686;
 Tue, 17 Dec 2019 00:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20191216174848.701533383@linuxfoundation.org> <CA+G9fYta8SH1EhzTSLshp1xx=MqmbSKPM2oXdV1qMSx=o2Tqsw@mail.gmail.com>
 <20191217075322.GE2474507@kroah.com>
In-Reply-To: <20191217075322.GE2474507@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Dec 2019 14:15:16 +0530
Message-ID: <CA+G9fYupS7hBtYPauO3A_QM-NQTPgxrOSLF=vu=dfHfdeG01Eg@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/267] 4.14.159-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        william.kucharski@oracle.com, bepvte@gmail.com, rppt@linux.ibm.com,
        Jan Kara <jack@suse.cz>, rientjes@google.com,
        dan.j.williams@intel.com, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 >   ltp-fs-tests:
> >     * proc01
>
> What does all of this mean?
>
> Can you bisect to find the offending patch?

Here is the offending patch,

Michal Hocko <mhocko@suse.com>
    mm, thp, proc: report THP eligibility for each vma

FYI,
Reverted this patch and re-validated ltp-fs-tests proc01 and now
getting PASS on arm.

- Naresh
