Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1828FC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2252084D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="p+86rH9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgABPmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:42:55 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38387 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgABPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:42:55 -0500
Received: by mail-qv1-f65.google.com with SMTP id t6so15148215qvs.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/GofTnRieVo7Se55xZXvosCoW678rKKW+UyvSeUYxZw=;
        b=p+86rH9k6Cjlc/Aysp01slC1VScUWBEjtKJopY4HO2egElyWa3mf9mzS2iO39k7B9R
         U2T310sMDgeRsHTQbl6aNAsnAZZU4t0t1gKOBqaB0nkvt3mgZ9GEMr++D9KOIvM4RVGd
         KOs717TJk7DzDx+XNgf5GagiVeRfbHK0PSlPw+cxPuobx+he95TKbFwurUDr/v32S1MD
         AEbfI9uMYlBn7SEDhsbtdUQmnyMjoWaWUlsJz5gCoEUCjfpyYSosmxX0HitoOOBeh093
         w5bEbpBs03c2bTYNT+NHGJbIjlgPR2wDga9/rEdwRYkZvIHtLdQw9ignrw/NOjMitTkW
         r+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/GofTnRieVo7Se55xZXvosCoW678rKKW+UyvSeUYxZw=;
        b=Zm6ebd54274Om1oOEe0WoQA8KnhiUgfCNYlnMTmu4GU44zN+XnaQo5u64kDpClu3Nk
         BJY4b5BeYR8tBPamAplONodaXg/b3vkClgA21d3MaqmiBHBygXvZAshVZme6cEEYTRvb
         grUl8g0TmM2yuWJodepoSCAGSTMp5LhO8MbuGga1j6TMgoGwBMzNOjWIbNQQbjl/dQxn
         OZzpygxi5n1jWlz1/B2lALm/8spStcDHmdM+6c7kDzEU8f4qMNqbDKgWpl9x06WdJh1U
         XebknBx5JfhgGO/VYp3W9YKgE2zGjGe5C4W33hkwIFlkBnQ5gjudK2aGdSrjel5nt0ig
         04Zw==
X-Gm-Message-State: APjAAAVnI2fg4cS9ONadx2Gd4kBS9YdyVrcpOQlJtFD+xBfFsKRUq2ku
        LVg18H/vF4OXFO+WTq2mwtiNlg==
X-Google-Smtp-Source: APXvYqxUP9jY3pW3f0vEZHK4X4fxOCufKe3EA8A+xLXLeSvr6QXOhuy0LOfgASlFcyOSfvxfyZx36g==
X-Received: by 2002:ad4:4d91:: with SMTP id cv17mr54284401qvb.101.1577979774191;
        Thu, 02 Jan 2020 07:42:54 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z4sm15110820qkz.62.2020.01.02.07.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2020 07:42:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] char/random: silence a lockdep splat with printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <4F9E9335-334B-4600-8BC3-4AF91510D113@lca.pw>
Date:   Thu, 2 Jan 2020 10:42:51 -0500
Cc:     tytso@mit.edu, Arnd Bergmann <arnd@arndb.de>,
        gregkh@linuxfoundation.org, pmladek@suse.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dan.j.williams@intel.com,
        Peter Zijlstra <peterz@infradead.org>, longman@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CA39814-DE67-4112-8F97-D62B9F47FF9D@lca.pw>
References: <20191205010055.GO93017@google.com>
 <4F9E9335-334B-4600-8BC3-4AF91510D113@lca.pw>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 16, 2019, at 8:52 PM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On Dec 4, 2019, at 8:00 PM, Sergey Senozhatsky =
<sergey.senozhatsky.work@gmail.com> wrote:
>>=20
>> A 'Reviewed-by' will suffice.
>>=20
>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>=20
> Ted, could you take a look at this trivial patch?

Not sure if Ted is still interested in maintaining this file as he had =
no feedback for more
than a month. The problem is that this will render the lockdep useless =
for a general
debugging tool as it will disable the lockdep early in the process.

Could Andrew (since the free page shuffle will call get_random) or Linus =
pick this up
directly with the approval from one of the printk() maintainers above?

=
https://lore.kernel.org/lkml/1573679785-21068-1-git-send-email-cai@lca.pw/=
