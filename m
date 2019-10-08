Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748AEC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476B220673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MkG19wPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJHKEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:04:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44841 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfJHKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:04:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so24292682qth.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=UHzh8Nd1pry2iT/DrbwRzV6vQa+dEjtAAEofF/MEC0w=;
        b=MkG19wPiUYEy/cwH4FWAdJFeOjxTx/ih3bRy9Ft9HUqflgmrO8W2P9pWqLKz1W1Wpo
         4zCmrzjYfRzNZDjPMBjwwFbFQfUrBq/Lm/ioydz+tHPfFO671FqVrp8VT2kjhoOxP3kP
         j4COp8ThvUM1npokOcngJl8xj2iMg9P+Y+iI73OIqWpixBThtqR/uRWjyrWqxclnDhF4
         DMdlK61gyjF41qEAfYtulkO1jWJAoqkOwpfRSJ3OAHgsoibpeTPqwXTkfk+LqLkMjVwm
         m19jghQDsgEo87ss6InPPapN9RqVbvm1QdD+vopuB+KnT1eS/j0iAaf35z7eLBC+ljI8
         oZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=UHzh8Nd1pry2iT/DrbwRzV6vQa+dEjtAAEofF/MEC0w=;
        b=C+57EL3vWwFI4CETIL9x/2caHpIgob5tklkcwx6cQVCs0YZ757ED6TRdS21t9U+ap4
         coaiwSFmKitOuLWmk6AKfTtwDU+TBUeVorJzJDlOfa/t4Sq9DI5WSFOBupWKZ9nylvfK
         NMpQxcMcnzmj6KWwQwg+DBPLphC0xMXrU5AC36IYM5M44gCqgHY66AlxR2nv/uMbFNKU
         pQaR+iGiQKtOIsB2Ebl1kkNlWheElDiY95D6UlQH45/+EOpRbuPsOMAWbEWwcCQ7/NmC
         zjblF7kdLpaybmxk+/u7ehm0sMtJJR37yDvFBwFZCJFAAEfBTz6go5DxffoE8ijrxF7Z
         kwwg==
X-Gm-Message-State: APjAAAUOdZWGFZv7Z99htE9rcdK9SAzLzV8sxuWk6qSXV04vdpmt++UV
        dm+eg4z/Kj/VoViQmxix6AuAWg==
X-Google-Smtp-Source: APXvYqw7c8QA+yozBt0uCvf/tfkuKfaIVAYplJEsYi/GpUQdwiDTaqs8uL3JR7XJ6WvUkOaVZ6eLnw==
X-Received: by 2002:ac8:b41:: with SMTP id m1mr34691601qti.382.1570529074168;
        Tue, 08 Oct 2019 03:04:34 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a36sm9356107qtk.21.2019.10.08.03.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:04:33 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Date:   Tue, 8 Oct 2019 06:04:32 -0400
Message-Id: <298970BD-529E-4095-8D87-61470ADBDD32@lca.pw>
References: <20191008084031.GC6681@dhcp22.suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191008084031.GC6681@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 8, 2019, at 4:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Does this tip point to a real deadlock or merely a class of lockdep
> false dependencies?

I lean towards it is a real deadlock given how trivial to generate those loc=
k orders everywhere. On the other hand, it make a little different to spend t=
oo much time arguing the authentic of those reproducible locdep splats, as e=
ven false positives could be as bad for developers where it would disable th=
e whole lockdep and mask off other true deadlock could happen later.=
