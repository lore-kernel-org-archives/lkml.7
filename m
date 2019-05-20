Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5625C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3C120656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTLFErxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbfETHaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:30:09 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:36711 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:30:09 -0400
Received: by mail-pl1-f181.google.com with SMTP id d21so6307861plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=M9gF003sey4m6ZmXpEUbjfnhDsoOFBA4gIaS9I0d8bE=;
        b=CTLFErxQnOfqsBVxHwCquDeLPv1gabZlcjpr0Eg9qF6kBjUePHbkS9Lqfxw7Tww4tp
         OCQXX8wgdu7jug44fnqGHp4P8VgF5iHlERldi04fy1ihJH9Ome48FAeD7rAR5Rk2XSTW
         RoLng7/fPRmMMmbKFRN3qnDb614IysnQ/K9vxZO6rt8KtQXn+Rhsi7QLDw8P7IWIJcdV
         a+XEuQe/wRS55VGZsav7g8vtVrpPyJuXfzkEgU1bW8IIfBzZXOzsuXaq26AjFu19zHpP
         VI23HhREN+SXrBFY5sn1GgC7bZ9fJ+pFIXnfTf9FB4TM2aFwmwh3t0mC9IhqYzSrm4lt
         P4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=M9gF003sey4m6ZmXpEUbjfnhDsoOFBA4gIaS9I0d8bE=;
        b=bstnmWYN8TATfbuwdDlrNjVkvTCIxGsWBXN5/c6LP3hZU+RVo4cHUQG+CFLmPMHrfz
         liT7TD87cGWmZX8clcQaGxQAJ/Q9aSCVC44wms8H2nkYzZMoyN5N3hlY1RCklAE9rL1x
         hpvo0yjqC+9zwy5kQ4qY8JV0IRtQuD5xC5IKeSUjPvCfomnSt6u0rFnw0B+8Pj+Uass3
         5ip9+OZ8JeoxBXNr7QKsrdwHi/RY5Uh+hP1S6pyCuzi7FV3ZnMUJZxcr1aWt3a6a5+BV
         1N9IWd/0l9yHekTGyyy26zvItJELL1le2aisMaPBbSY6Y1agAbEBvZT++AXq39U6XjUY
         Wbrg==
X-Gm-Message-State: APjAAAVgu6/k1duYo1GzgMwEBD+AzyrGWcR8qgPE51LiNXfoMlnHibuM
        Dzffe2P1vX8j9o1Y8Jygxl/dZTxxfJILK7q3eKP37Q==
X-Google-Smtp-Source: APXvYqxLzd5aHV9JceB9D3o3SozeFECT3yTJWSN1dEzwVmeId+k3X6eTVdkFIJ2Ij6Z30N9L5Gxz/rZKpn1D8bfr3T0=
X-Received: by 2002:a17:902:8c85:: with SMTP id t5mr74423655plo.23.1558337408257;
 Mon, 20 May 2019 00:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJ=MEdS4+5Un77MU7dPxkOjA7-yAv-1tbt0vbUaZ8n4R_rrBQ@mail.gmail.com>
In-Reply-To: <CAMJ=MEdS4+5Un77MU7dPxkOjA7-yAv-1tbt0vbUaZ8n4R_rrBQ@mail.gmail.com>
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Mon, 20 May 2019 09:29:57 +0200
Message-ID: <CAMJ=MEcTP1Y_ZE6iqxX-MANGnzGrbzkFUs0TzBHc+KB62aEyqw@mail.gmail.com>
Subject: Re: fs/pstore question
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op do 9 mei 2019 10:05 schreef Ronny Meeus <ronny.meeus@gmail.com>:
>
> Hello
>
> I'm using the pstore feature to log kernel crashes.
>
> What I observe is that after reboot, always 2 entries are present in the pstore:
>
> ls -l /mnt/pstore
> total 0
> -r--r--r--    1 root     root         16372 Jan  1 00:00 dmesg-ramoops-0
> -r--r--r--    1 root     root         16372 Jan  1 00:00 dmesg-ramoops-1
>
> If I do not delete the entries and force a new crash, only 2 new
> entries are available
> after the system is online again and the older entries are overwritten.
>
> The reason for this is that the write index is always initialized to 0
> during init.
> Is this intentional? I would expect that existing entries are kept
> until they are explicitly
> deleted or the storage is full. In the latter case the oldest entries
> can be replaced.
>
> Best regards,
> Ronny


Any feedback is appreciated.
Thanks
