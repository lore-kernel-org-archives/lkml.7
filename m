Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E8BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312512075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxutZQVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfD3NYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:24:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34804 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3NYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:24:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id 3so226279lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qnpMUYkMmL9pa1NwW2JEoP1ItjcZEv+YmAjkVOUYqyQ=;
        b=PxutZQVnmGiTrO83tBry4NYVOaB4lJN09Oxip41bc355LYSr1LYeo1lMf41kY1dbPT
         Az2YTmBmBe5x538dT+JRe1+JYJCz1FoZpsDQi9caft0FfB24tBWxwTJv5idXE3tCj309
         ndFGbbBo2539UPe3H3O748UbjUEB5fXovu/9xWmEfhXYjNsDa8MGUA7FNgzTEwcV2NYx
         BzUCxvrUpvXfcEOn53rFrUqaBy+pwlNLr7oHR8TPl+xrEZ1Otp/fmWcn5hIPL8+9gurK
         qq05lb0/OOuJZi6nG1tjGqZ27/O0Si7Z+rZrnHkVNiZ1eEaLz2uJksbogv7Sccdikqvu
         +sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qnpMUYkMmL9pa1NwW2JEoP1ItjcZEv+YmAjkVOUYqyQ=;
        b=pzJiAuxAkNC9GyWmiTtIN8PV0HNmLU+C3W6ASp0HOGb3AKLyGzM/ELNOq6nbTe7Pjl
         3RMYhZJcbnNeYo0YEL2pXg3pbUiDsT6K0RZtLB/BmF67YLUK945bQj0SgD1YxT2lxKrH
         YV73lBQgZ8XWdIA24YQFO5185EOgN5epwKQMlpd64x5AoEvQYLpPUHhSM3NCYbmgySC0
         91RRBUUIaRBOJ+HkbHkjCKrKsD7kGPtUn0tQVpL5MBGKh+8Opbkxw/spApihWFJu9ME9
         4IDGVdGYioNJ/BaBAxhuueYcYHPRnQ7p8ujpE8wXpJfaikP+kTFwRQLkYB2E5s6133JT
         jbkg==
X-Gm-Message-State: APjAAAVjlkk0vcZiUbS3mmDJQrd5+aMZBw1aG1mfvf/2I130TvYWoexB
        fy7azHJj5GgByNcKk5zy1TQ=
X-Google-Smtp-Source: APXvYqxY66JUV3S/EHKt8chK3vxOG3tpmuDiZ0EEFbAfPD2vCxwBJVAqoqvpolQPE+tgSK7CerPsJg==
X-Received: by 2002:a19:5507:: with SMTP id n7mr15109749lfe.140.1556630645642;
        Tue, 30 Apr 2019 06:24:05 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id s24sm7499626ljs.30.2019.04.30.06.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 06:24:04 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 7333A46019C; Tue, 30 Apr 2019 16:24:03 +0300 (MSK)
Date:   Tue, 30 Apr 2019 16:24:03 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, brgl@bgdev.pl,
        arunks@codeaurora.org, geert+renesas@glider.be, mhocko@kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        ldufour@linux.ibm.com, rppt@linux.ibm.com, mguzik@redhat.com,
        mkoutny@suse.cz, vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: get_cmdline use arg_lock instead of mmap_sem
Message-ID: <20190430132403.GG2673@uranus.lan>
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-2-mkoutny@suse.com>
 <4c79fb09-c310-4426-68f7-8b268100359a@virtuozzo.com>
 <20190430093808.GD2673@uranus.lan>
 <1a7265fa-610b-1f2a-e55f-b3a307a39bf2@virtuozzo.com>
 <20190430104517.GF2673@uranus.lan>
 <20190430105609.GA23779@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190430105609.GA23779@blackbody.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:56:10PM +0200, Michal Koutný wrote:
> On Tue, Apr 30, 2019 at 01:45:17PM +0300, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > It setups these parameters unconditionally. I need to revisit
> > this moment. Technically (if only I'm not missing something
> > obvious) we might have a race here with prctl setting up new
> > params, but this should be harmless since most of them (except
> > stack setup) are purely informative data.
>
> FTR, when I reviewed that usage, I noticed it was missing the
> synchronization. My understanding was that the mm_struct isn't yet
> shared at this moment. I can see some of the operations take place after
> flush_old_exec (where current->mm = mm_struct), so potentially it is
> shared since then. OTOH, I guess there aren't concurrent parties that
> could access the field at this stage of exec.

Just revisited this code -- we're either executing prctl, either execve.
Since both operates with current task we're safe.
