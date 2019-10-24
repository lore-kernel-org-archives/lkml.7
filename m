Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E95CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA3820684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XZ9wsRP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408022AbfJXLLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:11:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43061 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405717AbfJXLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:11:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id t20so37215585qtr.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=H1HIMvQo084DWDOeY/DGgNuXCfSIuehJ6e/cH8aaOG8=;
        b=XZ9wsRP/Dl6l54rJvN8yPLeGOEt11uClg9G8Z0iKoz6QWoGVBSu80PdjKncPdbPj/y
         2yxif1tG1j76a5xxi9/ystVvHRYzKGS9KpJyBdFMqQzPJFG/ynai7YP1K8bFMUBw/e8C
         irxxug7zGAo8pi9yBevnun3bcCikXaTWoB85np9sZwUyUNnvu/b+DeddVGK0NgmbrjPa
         PBReT2xpph3CsJTKiFxqPPYYW1QftuxbkSHiIGq5JHqwtbcLHCNg3D9cnO+enDUEFeND
         QffNVfJvi7e9T+VWNSx4aMubmaq+vsMZL7R947sDVVJrWoxUZ/7TgDyhYl2KgmxCGu5/
         xwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=H1HIMvQo084DWDOeY/DGgNuXCfSIuehJ6e/cH8aaOG8=;
        b=n3VxFa9gVC2EzBuQkntkXmZIRaLoXXCOPSTkvubSCdOB9w9T9VfdgvswEaueq7kFXb
         ZGjZjo4afvkc264JGZm56hgSoGPCoqA1xlAylR5byhTlrMsK+Ltd5aVmky7NSx+Og/Be
         yhduZTPI8ahB4OBc2SB3p+Qf8Uvlax/9T3WonJkBTwMFMqYD3qHwbgFplhzL2IslvvS9
         V9hnscZaizCSG00BTnbEkeJHUF84Rf20h9eue684oJCGQTF07ydcG5j3b/g0XSb9Dgng
         vMmhk7hASr1iefZ3PI1ERgBvQHYcuReYsda+b0K4LOA/2e1PTPMyDKnaWGsAZPDm+1xo
         zqmA==
X-Gm-Message-State: APjAAAXgydf2Zhz06MxmqF2MfZ+LKSad7rkHJQa/xmNi/pD3GI+G/90P
        vmD7yVhXND+wtMIrvd/3IuWJwQ==
X-Google-Smtp-Source: APXvYqx1iWO9FW2xJmIoqvQkfPCsPC02I6Y7manmJCmQaxBy/7+dt2O23rxk0UpI6ciMzisK/xS+Dw==
X-Received: by 2002:ac8:72d4:: with SMTP id o20mr3439086qtp.366.1571915513799;
        Thu, 24 Oct 2019 04:11:53 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d23sm13393985qkc.127.2019.10.24.04.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 04:11:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading /proc/pagetypeinfo
Date:   Thu, 24 Oct 2019 07:11:52 -0400
Message-Id: <B292E9D2-D619-4A57-BBE3-A4D10826AA60@lca.pw>
References: <20191024074205.GQ17610@dhcp22.suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
In-Reply-To: <20191024074205.GQ17610@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 24, 2019, at 3:42 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> It's been useful for debugging memory fragmentation problems and we do
> not have anything that would provide a similar information. Considering

Actually, zoneinfo and buddyinfo are somewhat similar to it. Why the extra i=
nformation in pagetypeinfo is still useful in debugging today=E2=80=99s real=
-world scenarios?

> that making it root only is trivial and reducing the lock hold times
> likewise I do not really see any strong reason to dump it at this
> moment.

There is no need to hurry this, and clearly this is rather a good opportunit=
y to discuss the consolidation of memory fragmentation debugging to ease the=
 maintenance in long term.=
