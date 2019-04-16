Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5602521900
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSBsnJzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfDPNyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:54:40 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40526 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:54:39 -0400
Received: by mail-vs1-f54.google.com with SMTP id f22so11560688vso.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PUEimrDkDNjafWQNoeSSGu0JOmhZ7XGlyAON9WIKy9c=;
        b=fSBsnJzcu8yFjp0TO0gh6UZqnpxN7tTfPVZKCI8ZbNVlCUDn+4kPvckitE1ZZV2MVt
         7lg6id8SXC4kIrf27XzbGa9IP25HlKfVs4h900FATMyfgmW5C6KIknKH50QcVvAualbz
         SmPYFkVauvdvaEFAeUA+zsmDr30a8//WU4B4uLBRz79tQk2ziyg0u5r+ve4QLzbjHNT6
         6FrtaZk4AGv+H6KVtOeC496RTPMUDvASPowWl1/vzLsph51PRYRGgVfKFOVfP4Vr5nIX
         A38ihMmYe+TztWS8xJKbc/5Dz/a2TpLzMb9wwKBZcCdIEPxP1XA7QPBf93IoicrCfGXt
         HZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PUEimrDkDNjafWQNoeSSGu0JOmhZ7XGlyAON9WIKy9c=;
        b=C13RJYOTmf0iI6c6g6V9xkIuW8MFzOKFSAJljWtUSmwRenTN7ZKnj79I2QeeHHVnMm
         6pWXnv9nT6MAkDR+AGWo7F/yQ2JwkGo70oAXtjHVspa4E0Q67q3MNl53I5dV+gwBdJSB
         aa/H1/9ogcrqG82cJs4wyce5ilwrsEzRJAvnWBHifqTzxPdKLrALssbL50H/ITnQ/Aol
         eLI+czklx1rO4DS0/jrlnu8HbhT/gJcFZ6EW5vl3oqkzml4NlKgYwoO1iWdFk+GVqAuS
         KDr7WAWI2SUpFwAxF1MhK1mKRkdYHmTCDxYNpCnRbC6XOMM6d/38MsJs1GO60I+041EX
         ZxvQ==
X-Gm-Message-State: APjAAAVvGARdWiqTsitE3qm85c9cOdT76jrcYkIBxC+1GoLL1aUdK8by
        GxeUwPPd9oVW8ADdqCywU2SAvuCqHDlhRxvhZE0Zcg==
X-Google-Smtp-Source: APXvYqy8swZwdXobQHAkgqvc6SHW7uhKiH9Lx2ebYuVg/bOiZX5wyLc4vA8VoIBY6RTagkp1pLkDpRIMNgQZUvu2mX4=
X-Received: by 2002:a67:76c7:: with SMTP id r190mr13842839vsc.196.1555422878707;
 Tue, 16 Apr 2019 06:54:38 -0700 (PDT)
MIME-Version: 1.0
From:   Kees Cook <keescook@google.com>
Date:   Tue, 16 Apr 2019 08:54:27 -0500
Message-ID: <CAGXu5jL6LVU7KyUvwaEHWE6t2TaVBs5TWNayB5cW2=PWzSMyEw@mail.gmail.com>
Subject: BPF RNG
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In looking at prandom_u32() users, I noticed that BPF uses its own
state variable with bpf_user_rnd_u32(). It appears that this state is
never reseeded like regular prandom_u32(). (See __prandom_timer().) Is
this intentional, or should reseeding be happening?

-Kees

-- 
Kees Cook
