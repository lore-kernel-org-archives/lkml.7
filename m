Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF06C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436D720673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ7PQjew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392929AbfFMQmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:42:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45321 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFMGsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:48:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so17351568lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lv9nqSLtCZiZ8ahiodoBv8WyJCmSbiyt0thoq18zE4o=;
        b=nZ7PQjewhkNFLJJFS9CWkoOR/2SEzVmnFe8JrDQZP9WGcZpfUm4TWzaVR34kqgOkM6
         PSejsxPi0NXyf4QlD5sX4JIbnQfXedVnig36j74X1SFYqDWGSabvXNjxjGVLIXkawcuU
         FLxHCMmbItnJk/+HFhcv2buBYqTCBeda6PFTmID1zVJDHxvH+2FvmDkY//qUdtytA1rY
         XAU372/eZO1vArF8Nvb3ESlmzJwhIz6vNWOMU+IhBUUih36nYQRORDh23Fhe5qPHSqz9
         W5zZSLTxbnEjMPo5VqL3HJlKMAhbO5g/ZW2HDfLWl0duR2ldpc2FeL0NApW675/Lripg
         kkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lv9nqSLtCZiZ8ahiodoBv8WyJCmSbiyt0thoq18zE4o=;
        b=FzuLvKCG9ECr7y2LfWAZZPa7TCXF9BUM4Zpq2CCzwpuymtVAui3ql/Hj7HGTsqZi7I
         SWRqJl/VOOfvnkaOSD0XeajS+8tbfjoJ/xqCa24fWpMezHVMZDYg0J0ruzFC7W3gaeyf
         gSWCXgt29xIRYAUMFA5tMtbjyssD9SK6pr8PwhguGr0Z/9ZY54dEyCDzTN3ODiAO8084
         vSpLfgkGMM72Zx6/wkiGtTyUFCCIKoAXDXl+d2GDtgnj6wf6AXu7cz7h039SAjciQ0MA
         uyLG4H4UiUe8DJPBa08dRpDaDN6lTUCZUtAcxXAlJcPpqfxIF6pMZ2U3taELr9c7o/8t
         TQYw==
X-Gm-Message-State: APjAAAWdEWfqq8SluT/OPYpfTbOtxDhhXF5tl2vL49uk915qaocVKwF3
        tIiuqD1zF9qyBLT09tEXQr8=
X-Google-Smtp-Source: APXvYqy6FpZw7RE8ERzs0oPq21ly6eN+8mWADKZTvCK7LLigk9bmBzrjxoFEZnOBRpHWrUPHGL4mfA==
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr6057511ljs.44.1560408498002;
        Wed, 12 Jun 2019 23:48:18 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id y18sm396934ljh.1.2019.06.12.23.48.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 23:48:17 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id D702646019C; Thu, 13 Jun 2019 09:48:16 +0300 (MSK)
Date:   Thu, 13 Jun 2019 09:48:16 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Roman Gushchin <guro@fb.com>, Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v2 5/6] proc: use down_read_killable mmap_sem for
 /proc/pid/map_files
Message-ID: <20190613064816.GF23535@uranus.lan>
References: <156007465229.3335.10259979070641486905.stgit@buzz>
 <156007493995.3335.9595044802115356911.stgit@buzz>
 <20190612231426.GA3639@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612231426.GA3639@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 04:14:28PM -0700, Andrei Vagin wrote:
> On Sun, Jun 09, 2019 at 01:09:00PM +0300, Konstantin Khlebnikov wrote:
> > Do not stuck forever if something wrong.
> > Killable lock allows to cleanup stuck tasks and simplifies investigation.
> 
> This patch breaks the CRIU project, because stat() returns EINTR instead
> of ENOENT:
> 
> [root@fc24 criu]# stat /proc/self/map_files/0-0
> stat: cannot stat '/proc/self/map_files/0-0': Interrupted system call
> 
> Here is one inline comment with the fix for this issue.
> 
> > 
> > It seems ->d_revalidate() could return any error (except ECHILD) to
> > abort validation and pass error as result of lookup sequence.
> > 
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > Reviewed-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> It was nice to see all four of you in one place :).

Holymoly ;) And we all managed to miss this error code.
Thanks, Andrew!
