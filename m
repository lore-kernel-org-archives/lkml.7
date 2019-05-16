Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A68C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C74D2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfEPQ3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:29:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35799 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfEPQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:29:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so4138276wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmJ3oGbhkIfE+oGMXz0i/1fqw7BH4scbuPzlcTLdX0o=;
        b=LqiV9D6Ghpb4aXnQor+QWgNaddHzAVkuW/6LpF+d4LvRNoQL6uujnn6+eV4DoVWMs4
         Rh+QQZDwGK9eFp1H4RUOobWq14ylZcgktFfiLU8YNDzJwgDA1tmQBZQTTo055yZUlZZh
         PrpsvOstihWpMH/SGhjYTLh3Pmrre5SbjcqFjX3AageSqO64CJNauz1DgzA/2dNS/avz
         hKWDgyFtm1RvgfofWNgasScifHoer2bEs+Q0CFHKKvHDlgPj3ZkdzQY81ufj/o4xGTtR
         fBvT5a7+Qsm8zZTIIbjAiTt4YaKFETs2RnJv/hbmK1X59d4W4f1XVongAAd+Kvx/lA4B
         BNhw==
X-Gm-Message-State: APjAAAUjlKbm7YaG1DdB/AM22tebYLRaP3CFVlVm3NJ0Ket46/8699C5
        y0GrimIptKWXn9767I0dT465
X-Google-Smtp-Source: APXvYqw4xzsO/ZHDRK8RT2D9NZpnGvFVdO15DLWHiBOzYw0vUAqtOT7NkS6GGg4mfAYLcWMR8bMLaA==
X-Received: by 2002:a1c:e714:: with SMTP id e20mr18848944wmh.143.1558024187943;
        Thu, 16 May 2019 09:29:47 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id l8sm7695747wrw.56.2019.05.16.09.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:29:47 -0700 (PDT)
Date:   Thu, 16 May 2019 17:29:46 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
Message-ID: <20190516162946.zwzhxkft342b25pd@atomlin.usersys.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
 <20190516094234.9116-5-oleksandr@redhat.com>
 <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
User-Agent: NeoMutt/20180716-1637-ee8449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-05-16 12:00 +0200, Jann Horn wrote:
> On Thu, May 16, 2019 at 11:43 AM Oleksandr Natalenko
> <oleksandr@redhat.com> wrote:
[ ... ]
> > +       }
> > +
> > +       down_write(&mm->mmap_sem);
> 
> Should a check for mmget_still_valid(mm) be inserted here? See commit
> 04f5866e41fb70690e28397487d8bd8eea7d712a.

Yes - I'd say this is required here.

Thanks,

-- 
Aaron Tomlin
