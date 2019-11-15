Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2119C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324520728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUbG1FRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfKORO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:14:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727548AbfKORO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573838098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i//VdLznyJQ1f9EYHUzbZrmnX/uwUJtCHfRMoEiRRFM=;
        b=QUbG1FRkgiruETIr+rJqo4Q7IA89FwWUFX0oGpDRZiyB0khjdgglhnEOBOTF/xUDiikFTS
        fkFl4TfdPeOPXPUqP3E8XNN+eO1qE/x3zz+s92U6BpKfeOzCUcsg+Gw+W1HQYPeeB7Kv4S
        uIDRGj3uuq5B9ogg5xILALUQ2O8jcas=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-bn7BejAKOU--lJSVYPquaA-1; Fri, 15 Nov 2019 12:14:55 -0500
Received: by mail-wm1-f69.google.com with SMTP id h191so7301474wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fkKZc7EVVIK/btwaEMMtK6umsKN2KQyJVj0fen7NWM4=;
        b=KnuLg+GIbDkXHQByTygxYXvHguSZaLsYVEXJ42dZn2pwclIuKV23/9yBZYrux25fWQ
         h1oTWtFgspEdUwYa3UI20EExT5289gSLh14xY1npmv6CYYnbsUDRA105EqTBAR50d4N5
         gzX5a2/GD/7HoW3c2h/ALKfuHUFQftfnXRz0BUhia8OyrsCMjcJqzeD2jyMF8me2/t4V
         mtQ/YqCkSV6xHAKmDV1DanBdQCIbTXvQShLg5caiUXtecI8i5CAVN2m7EVQySMz5SSQS
         QB4c13YBPD7f0fX/wmEFiDDMlH3/sIlwoGej8qiW4SYsxTY5W4nrKSKo4DvE81NcAASx
         A1Aw==
X-Gm-Message-State: APjAAAUtb3FSZgpko1o+lEbjyhbfjfAdYdInUNtD3QY9ViohZPzT/5ju
        /EX/OW/NQKKuwRC0E0tvhj/NB0AdjzPsrv6zMYvZ9yd4O37Wyah1SdTbcm4yEq4aW6H6Lee6XK5
        44QGBSvCiMcg766cCBYWRGBLq
X-Received: by 2002:a1c:7709:: with SMTP id t9mr15737398wmi.80.1573838093812;
        Fri, 15 Nov 2019 09:14:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFYsvAwIE6O5TRg5h8L4op6aHWHNgR4Qnu7Nap2afcKOa3ebQhqU+/jSY5LlHI0javOU1nhQ==
X-Received: by 2002:a1c:7709:: with SMTP id t9mr15737362wmi.80.1573838093545;
        Fri, 15 Nov 2019 09:14:53 -0800 (PST)
Received: from localhost.localdomain ([151.29.177.194])
        by smtp.gmail.com with ESMTPSA id a6sm13758352wrh.69.2019.11.15.09.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 09:14:52 -0800 (PST)
Date:   Fri, 15 Nov 2019 18:14:50 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH 0/5] locking: Percpu-rwsem rewrite
Message-ID: <20191115171450.GJ19129@localhost.localdomain>
References: <20191113102115.116470462@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20191113102115.116470462@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-MC-Unique: bn7BejAKOU--lJSVYPquaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/11/19 11:21, Peter Zijlstra wrote:
> Yet another version of the percpu-rwsem rewrite..
>=20
> This one (ab)uses the waitqueue in an entirely different and unique way, =
but no
> longer shares it like it did. It retains the use of rcuwait for the
> writer-waiting-for-readers-to-complete condition.
>=20
> This one should be FIFO fair with writer-stealing.
>=20
> It seems to pass locktorture torture_type=3Dpercpu_rwsem_lock. But as alw=
ays,
> this stuff is tricky, please look carefully.

Backported this series to v5.2.21-rt13.

locktorture looks good (running for several hours) and DEBUG_LOCKS splat
[1] not reproducible anymore.

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

Juri

1 - https://lore.kernel.org/lkml/20190326093421.GA29508@localhost.localdoma=
in/

